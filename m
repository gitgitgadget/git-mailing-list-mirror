From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 4 Sep 2008 07:37:23 -0700
Message-ID: <20080904143723.GB23708@spearce.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:38:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbFyi-0001Pm-Nj
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 16:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYIDOhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 10:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYIDOhZ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 10:37:25 -0400
Received: from george.spearce.org ([209.20.77.23]:54210 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYIDOhY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 10:37:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6DC1E38353; Thu,  4 Sep 2008 14:37:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94937>

Alexander Gladysh <agladysh@gmail.com> wrote:
> On Thu, Sep 4, 2008 at 3:08 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > Open up lib/diff.tcl and find "proc apply_hunk".  Inside of the
> > catch maybe insert a puts to see the diff, e.g.:
> > <...>
> 
> Header looks well-formed to me:
> 
> diff --git a/path/file.ext b/path/file.ext
> --- a/path/file.ext
> +++ b/path/file.ext
> 
> I have sent you full output privately. I do not see anything unusual
> in it... Anyplace where I may put more logging?

Actually the header you sent me privately wasn't well formed.
It looked something like this:

  diff --git a/path/file.ext b/path/file.ext
  --- a/path/file.ext
  +++ b/path/file.ext
  --- assert(a != b)
  --- assert(a != c)
  @@ -10,1 +10,2 @@

It looks to me like some part of the context became part of the
diff header, with three "-" stuck in front of it.  Which git-apply
then thinks is the pre-image path name.

Can you put in some more puts in that same section of the code
so we can find out which of the puts has these extra asserts?
Is it the first one for $current_diff_header or is it the second
one that is supposed to be pulling in the patch hunk?  Do you see
these extra asserts in the diff viewer like this before you try to
apply the patch?

-- 
Shawn.
