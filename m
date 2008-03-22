From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: How to rewrite author history
Date: Sat, 22 Mar 2008 12:06:37 -0700
Message-ID: <216e54900803221206l39d61bcw1c546b9812968ac0@mail.gmail.com>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
	 <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
	 <2008-03-22-10-29-23+trackit+sam@rfc1149.net>
	 <216e54900803220611v5aa5e9d5q86da249480be3c91@mail.gmail.com>
	 <20080322165737.GB7611@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Samuel Tardieu" <sam@rfc1149.net>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd93s-0001Fn-Hu
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbYCVTGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbYCVTGm
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:06:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:6246 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYCVTGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:06:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2384124wah.23
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K3Um0jWHUT1+o3yqxv+IZCWfi2zCr3PV8rQ3O0YS9V4=;
        b=UEQfq154sZHKjQIIvHoTF6mFU5PWx50Wm16MsYSr9/rHRR1qU48X7u4MMYF2susSZOQYA6cttWxi8RTK2qoJSDnDtqBCtaXPDCklcHfMdYDSynJ5wmI36HJjQxkxNooA7M5V8x7+SFWKQKPzC6816PxMtAhJA9bf+YZ1Kn/ZZTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=toqY7iNYP6jwEeg+rZVm6pKb6qidV/HeVHechnCxHMlCpTKpT4VaMnX+bQyAUZv/wS4EPew7CDvqaReIrXpc2Ngq0aH//EekaTkjUfjo4A2pZuKMyFb0G9I4bWFg1GeY9Igy5Bqu3KFCZEa/NLq5pdOm6Q0CGHEmyzuS0vKxWk8=
Received: by 10.115.109.1 with SMTP id l1mr8490158wam.90.1206212797944;
        Sat, 22 Mar 2008 12:06:37 -0700 (PDT)
Received: by 10.114.94.20 with HTTP; Sat, 22 Mar 2008 12:06:37 -0700 (PDT)
In-Reply-To: <20080322165737.GB7611@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77840>

Thanks, Jeff.  That was very helpful.  I have published my repo online
already, but only a couple people (if even that) have cloned it by now
and I am prepared to email the list of interested parties letting them
know.  About this rebasing thing, is there a better way than for them
to just wipe their repo and clone again?  Would a simple git fetch and
git rebase do the trick?

Thanks again, everyone.

On Sat, Mar 22, 2008 at 9:57 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 22, 2008 at 06:11:12AM -0700, Andrew Arnott wrote:
>
>  > git-filter-branch --env-filter '
>  > [...]
>
> > And I did this for master, and my v1 and v0.1 branches.  I'm concerned
>  > though, that since I changed the names of all the objects by doing
>  > this, did I somehow make my branches incompatible with each other?
>  > Will there be any problems in the future sharing commits or merging
>  > across branches as a result?
>
>  There are two concerns, and I'm not sure which you have (I think number
>  1):
>
>   1. Your branches within the repository will not connect anymore. I
>      believe this is a non-issue with your filter, since the generated
>      commit IDs are deterministic. Certainly a toy case worked for me
>      with:
>
>        for i in master branch; do
>          git filter-branch --env-filter=... $i
>        done
>
>      You can also specify both to be done at the same time, which is
>      more efficient:
>
>        git filter-branch --env-filter=... master branch
>
>      You can check the graph structure with "gitk master branch" which
>      should show them connecting.
>
>   2. Your branches are now a different, rewritten history compared to
>      anyone who has cloned or fetched from you. This is unavoidable, and
>      the answer is either "don't use filter-branch" or "tell everyone to
>      rebase their work on the new history." So the best time to
>      filter-branch is right after import, but before you start work.
>
>  -Peff
>



-- 
Andrew Arnott
