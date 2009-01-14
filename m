From: skillzero@gmail.com
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Tue, 13 Jan 2009 22:21:23 -0800
Message-ID: <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 07:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMz9N-000871-Uz
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 07:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbZANGV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 01:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbZANGV0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 01:21:26 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:38836 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZANGVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 01:21:25 -0500
Received: by an-out-0708.google.com with SMTP id d40so183880and.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 22:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J3qTxYUCiEMvzyA+2DEg47YsCJ5/NDZzplQPO+zdBRo=;
        b=imHx8uCgfNiRgsXslJF8m88zrHs+LTECizxiT9i4RU5HjJGGcPloDdZOkch7mxJV6z
         LKFsXaTq+6seHhEvPJPuYBFTsz+Km/5G4GWfoJiKb4T8wqJSM69KwWoAW5T7lNNi3vnp
         oO3hgCYbPPo1c/UEmxfLVm8cQMDvAXwawGvIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BQqy9edoDwPPvOeDCw4bh/gC4sTp0HyD2KjefWN/I+143vUjWpddATqtXMbg0vIHvo
         rwk6oJk+kTJc6meXHVJ336MAiKIvDwBxZXvHfYXUJm3r4g8fhVAvfhsxsgdDTUuhJtgE
         c91qFQ/MJI3+byg6gsfkTZVSOTFM9TsXb9+HA=
Received: by 10.65.200.13 with SMTP id c13mr21069788qbq.35.1231914083885;
        Tue, 13 Jan 2009 22:21:23 -0800 (PST)
Received: by 10.64.242.15 with HTTP; Tue, 13 Jan 2009 22:21:23 -0800 (PST)
In-Reply-To: <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105588>

On Tue, Jan 13, 2009 at 9:31 PM, Brian Gernhardt
<benji@silverinsanity.com> wrote:

> After the cherry-picks, the repo looks like this:
>
> o-o-A'-B' (master)
>  \
>  o-A-B-o (branch:2daf23)
>
> A and A' are different commits.  Same with B and B'.  If you check the SHA1
> of master at this point, it will NOT be 702fd... (B).  Cherry pick creates a
> new commit that (as far as git is concerned) is totally unrelated.

That's what I was somewhat disappointed by. Even though the result of
the commit had a different hash, I assumed git would keep some kind of
internal per-commit hash so it could tell later that two commits were
the same and not re-apply them.

> The simplest method is to rebase branch after doing the cherry-picks.  This
> should only be done if your branch has not been published.

The problem is, by the time I wanted to do the cherry-pick, I had
already committed other stuff to the branch. I tried doing 'git rebase
master branch' when on master and it just applied all the stuff from
master to branch.

Is there any way to apply a commit to 2 different branches (which have
diverged) in a way that git will remember so that when the 2 branches
merge later, it won't result in duplicate commits? I find that I often
make changes that days or weeks later find out that some other branch
needs that change and by then, there have been lots of commits to both
branches after the commit I want.
