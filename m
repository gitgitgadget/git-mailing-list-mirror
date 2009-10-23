From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bisect Vs branch
Date: Fri, 23 Oct 2009 12:31:07 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910231137290.14365@iabervon.org>
References: <4AE07EEB.2010101@maxim-ic.com> <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com> <4AE156A9.9060809@maxim-ic.com> <4AE16A82.1010103@viscovery.net> <4AE17645.2000408@maxim-ic.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-421231465-1256315467=:14365"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: =?ISO-8859-15?Q?Gr=E9gory_Rom=E9?= <gregory.rome@maxim-ic.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 18:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1N2p-0007af-3n
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 18:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbZJWQbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbZJWQbE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 12:31:04 -0400
Received: from iabervon.org ([66.92.72.58]:38846 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbZJWQbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 12:31:03 -0400
Received: (qmail 28982 invoked by uid 1000); 23 Oct 2009 16:31:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Oct 2009 16:31:07 -0000
In-Reply-To: <4AE17645.2000408@maxim-ic.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131111>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-421231465-1256315467=:14365
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 23 Oct 2009, Grégory Romé wrote:

> Thanks even if that's what scared me :)
> The draw is very simple comparing to the reality (much more merge points) and
> rebase will require lot of conflicts resolutions but now I'm sure that's what
> I have to do.

Alternatively, you could say that your testing procedure is to merge with 
your branch and check for the regression. Instead of bisecting U''-C'', 
bisect U'-C', but merge master (or rather, the first parent of the merge 
that started not working) before testing each commit. Pose the problem as 
upstream having a regression in that it doesn't work when merged with your 
code, and solve that problem with bisect.

But, before you start, verify that merging U'' and origin/master doesn't 
work; if it does work, you recently introduced the change that doesn't 
work with upstream, and it's probably a lot easier to find what you did 
that's not okay any more than what made it not okay upstream. That is, 
make C*; if it works, rebase your recent changes on it and debug that. 
This should have fewer conflicts and be easier than the full rebase, if C* 
actually turns out to work:

U'--o-o--C'
 \       |\
  U''-y-y--C''
   \     |
    -----C*--y-y

	-Daniel
*This .sig left intentionally blank*
--1547844168-421231465-1256315467=:14365--
