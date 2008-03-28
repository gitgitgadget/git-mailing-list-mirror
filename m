From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Fri, 28 Mar 2008 08:50:37 -0400
Message-ID: <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
References: <1206707716.9819.15.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 13:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfE3n-0003M6-C2
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 13:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbYC1Mul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 08:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbYC1Muk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 08:50:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8825 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbYC1Muj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 08:50:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so267802fgb.17
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CXUUahYN9vtPJy9gsuE94u1TwWHA1qDv4rbLopzMqiw=;
        b=nWLjJxIQ4jSL9ShtH9h914xL9UQiV28HBYrQ4b0SvPCSBpeqZ0p7ylJwPUJX52Gvfd2XzCbx2WBTJxIS39e9ExwgMULmWQRPwN42Uy0qUi/oJS4s5n8BDDOUthjLR6LlKNWpYMerNYVnsyUC/qfqnafu0Ude+IQqtTpcwBQZuME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CyD1/l9bnPXdB23t0ZjIBy6QnDTAwJbtY9iwB3zDUlNeBWh048RtAgbT5bF9HAQlVH3tS6REeypVJWVt+Z+Et0xNH1FtJp1k6T/KyeN1KJB4t0DoZLq2vVPlanUy/PetKokhflX6ScAXIDPBCpNtd6u9scMMTCIQ3CgTbnW4wd4=
Received: by 10.82.154.5 with SMTP id b5mr5505299bue.10.1206708637707;
        Fri, 28 Mar 2008 05:50:37 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Fri, 28 Mar 2008 05:50:37 -0700 (PDT)
In-Reply-To: <1206707716.9819.15.camel@malory>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78400>

On 3/28/08, Alex Bennee <kernel-hacker@bennee.com> wrote:
>  I've succeeded in porting our whole CVS repository into git (with plenty
>  of swap, cvsps is very memory hungry). Now we have a reference
>  historical repository I need to think about creating one we actually use
>  for day to day use (the .git is currently in the order of 650Mb which is
>  a little heavy for pushing around DSL links willy nilly).

You used git-repack and git-gc, right?  If not, the repo will be
bigger than it should be.

>  1. Find the common ancestor point for all the product branches I want to
>  keep in the repo.
>
>  Can anyone point me to the magic invocation that would allow this?
>  git-merge-base can find the common point for two commits, do I just have
>  to iteratively use that?
>
>  I'm currently working over a terminal link so it would be dead handy if
>  there was a visual way of showing what gitk --all does on the command
>  line.

"git show-branch -a" probably does what you want.

>  2. Create a new repo, starting at the common ancestor point
>
>   2(a). I'd need to remove the orphaned old CVS modules which are still
>  around but not referenced any more.
>
>  3. Create the product branches and import ANCESTOR..BRANCH_HEAD into
>  them

You probably want to look at git-filter-branch, particularly the
--parent-filter option.

Note that 2(a) would be easiest if you just did it before importing
from CVS at all, since it's easy to remove old modules from CVS just
by moving the files out of the way.

Have fun,

Avery
