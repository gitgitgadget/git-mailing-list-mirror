From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: Fix build failure of docs.
Date: Tue, 28 Jul 2009 18:02:21 +0200
Message-ID: <200907281802.23171.trast@student.ethz.ch>
References: <4A6F1B89.9080202@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Saikiran Madugula <hummerbliss@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVp8d-0007IY-Ig
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 18:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbZG1QCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 12:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZG1QCd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 12:02:33 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:54555 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbZG1QCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 12:02:33 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 18:02:32 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 18:02:31 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <4A6F1B89.9080202@gmail.com>
X-OriginalArrivalTime: 28 Jul 2009 16:02:31.0925 (UTC) FILETIME=[D067AA50:01CA0F9C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124259>

Saikiran Madugula wrote:
> This patch fixes the build failure due to what seems to be extraneous
> characters, "+++" in the git-filter-branch.txt file.
[...]
> ASCIIDOC git-filter-branch.xml
>     XMLTO git-filter-branch.1
> xmlto: input does not validate (status 1)
> /home/bobthe/git.kernel.org/git/Documentation/git-filter-branch.xml:435:
> parser error : PCDATA invalid Char value 7
> Clone it with <literal>git clone +++0+++</literal>.  The clone

NAK.  Presumably you are using an asciidoc 8.x?  Please check if
saying

  make ASCIIDOC8=Yes man

fixes the problem.  Read the comments in Documentation/Makefile for
advice on what precise combination of options you should use.  Also,
if you do not want to actually work on docs

  make quick-install-man

is a much less painful way to get manpages (in this case, from Junio's
'man' branch that has preformatted manpages for 'master').

I put the +++ in there to stop the version I used at the time from
rendering the closing backtick as part of the URL and garbling the
entire paragraph in the process.  To be precise, with asciidoc 8.2.7
and without the +++ I get

  Clone it with <tt>git clone <a href="file:///path/to/repo</tt">file:///path/to/repo</tt</a>>.

in the HTML output.  Note the nested tags.  (With asciidoc 8.4.5 the
problem appears to be fixed.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
