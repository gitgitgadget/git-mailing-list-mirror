From: Michael Meeks <michael.meeks@novell.com>
Subject: libreoffice merge issue ...
Date: Mon, 14 Feb 2011 16:07:15 +0000
Organization: Novell, Inc.
Message-ID: <1297699635.31477.253.camel@lenovo-w500>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Norbert Thiebaud <nthiebaud@gmail.com>, kendy <kendy@novell.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 17:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp1HM-0003Rj-AI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab1BNQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 11:27:48 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:44673 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755917Ab1BNQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 11:27:47 -0500
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Feb 2011 11:27:46 EST
Received: from [192.168.0.5] (mmeeks.gotadsl.co.uk [213.208.123.138])
	by nat.nue.novell.com with ESMTP; Mon, 14 Feb 2011 17:07:43 +0100
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166733>

Hi guys,

We are having quite some fun merging git branches with LibreOffice, and
I stumbled over this just now with master git with hash:
00e6ee724640701b32aca27cc930fd6409c87ae2

Setup (some large repos):

	git clone git://anongit.freedesktop.org/libreoffice/libs-core
	git checkout integration/dev300_m98
	git remote add stage git://anongit.freedesktop.org/libreoffice/staging/@REPO@
	git fetch stage

	Test[1]:

	git merge stage/premerge/dev300_m98
	git diff idl/source/cmptools/lex.cxx

	yields:

@@@ -147,11 -147,7 +147,15 @@@ SvToken & SvToken::operator = ( const S
  *************************************************************************/
  void SvTokenStream::InitCtor()
  {
++<<<<<<< HEAD
 +#ifdef DOS
 +    SetCharSet( CHARSET_ANSI );
 +#else
      SetCharSet( gsl_getSystemTextEncoding() );
 +#endif
++=======
++    SetCharSet( gsl_getSystemTextEncoding() );
++>>>>>>> stage/premerge/dev300_m98
      aStrTrue  = "TRUE";
      aStrFalse = "FALSE";
      nLine       = nColumn = 0;

	With the above master hash; whereas with v1.7.3.4 it yields nothing (as
it should IMHO) - we havn't edited things around that chunk in master.

	That is slightly concerning; thoughts much appreciated. Incidentally,
the whole 'make install' installs into ~/bin was extremely unexpected
and yielded 30minutes of pain trying to work out what was installed
where and why, and the interaction with --prefix, and ... now it seems I
should always run rehash; git --version before any command, and sanity
check things ;-)

	Thanks,

		Michael.

[1] - potentially you need:
[merge]
    renamelimit = 20000
in your ~/.gitconfig
-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
