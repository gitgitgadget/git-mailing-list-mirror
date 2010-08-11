From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Wed, 11 Aug 2010 13:02:53 +1000
Message-ID: <AANLkTinwQhD-b0-6uQYwBa3r7psNvPp5LMcjqHVKLF+c@mail.gmail.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 05:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj1az-0005QY-LP
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 05:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab0HKDCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 23:02:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57002 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab0HKDCy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 23:02:54 -0400
Received: by qwh6 with SMTP id 6so8948316qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wTlheISqZ/oWraRQ9gXWG7NdOm3O6fBMwBp2KBo0e2U=;
        b=BniGQSsxt6iBABoOzFK3wEUOCThqtQQxMHBEt0lA2gtXz9KOnohUD08CmiwFSncXT6
         pywNnbVjGDy9VkZ2Kl+tGmiuaJ6beoQ2lFPWhg3y8Er09e53bCAvlDnELs/hcxKqasjw
         REId71hM57RAYyQmFiPcBRiZmJ+WXXjIrZrnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CLeV2sgREH5qSMgwZcIKN3YxfvMgGxy8Lxrk8AJ4kIZdrtRDcbUU9aC2jprajsiGIt
         znu5VYv1T4IcaPDJjSVDXLeVB/oOc0i159+DwuTd1pAj0K1g4JIjA8WhjWc5btArAGCq
         rRB1AV1APF+eweOyQcLbJZeN9htQOg/fVQIeI=
Received: by 10.229.224.67 with SMTP id in3mr9154460qcb.91.1281495773792; Tue, 
	10 Aug 2010 20:02:53 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Tue, 10 Aug 2010 20:02:53 -0700 (PDT)
In-Reply-To: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153185>

On Wed, Aug 11, 2010 at 5:02 AM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I realize there are a lot of different Git workflows but I'm wonderin=
g
> how others in this community do it.
>
> We're using our "master" branch from our central repo (Beanstalk) as =
a
> dev branch and we have stable branches for various release versions o=
f
> our software.
>
> We've not made as heavy use of feature branches yet as we should have=
=2E
> Once we do start using them more regularly, what kind of stuff is eve=
r
> committed directly to "master" or is master typically the place where
> things are merged into from other stable/features branches?
>
> Is "master" really even unstable at that point?
>
> Thanks in advance! I realize this question is pretty open-ended.

The project I am on is in test/fix mode at the moment.

In our workflow, we tend not to even bother with a shared master
branch. The build team maintains one, but it is for their own sanity,
not for sharing with the rest of the development team.

We do at least two team builds a day, the AM build ends with 10, the
PM build with 5 and patch builds, if required with the next available
unused number which is not 5 or 10. Each build is tagged with the
build number [ providing most of the convenience of an SVN commit id
].

Our developers tend to base their work on the latest released build
tag, except if it is a fix required to patch a build that has already
been delivered to a higher test environment, in which case the patch
is based on the build number of the code deployed into that
environment. This patch can usually then be trivially merged into
builds in lower environments as required.

Personally, I maintain several topic branches which are merged with
the upstream only in the event of the requirement to resolve a merge
conflict. Otherwise, I keep them clean and merge them into the base of
my working branch (as described into an earlier note).  By always
merging into the base of my working branch (and never the tip) I can
keep my working tree stable and my patches clean.

In my view, tag-based (rather than branch-based) sharing is a better
way to work when you have a large team. In a large team, the shared
branch is necessarily going to be highly unstable. The tags issued by
the build team help create a measure of stability and point of
reference in what would otherwise be a somewhat chaotic environment.

The single biggest mistake we made with git was to attempt to share
work throughout the team by having developers keep in sync by merging
with a shared master branch. Extracting a developers history from such
a tangle is a complete nightmare.

jon.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
