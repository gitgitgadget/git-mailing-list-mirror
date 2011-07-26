From: =?UTF-8?B?UMOpdGVyIEFuZHLDoXMgRmVsdsOpZ2k=?= <petschy@gmail.com>
Subject: Re: Surprise at git stash pop
Date: Tue, 26 Jul 2011 11:26:06 +0200
Message-ID: <CAG3eYYR3PnGYJohAwTfDD24QKqgsaoW_i7v5FS0vqyXS6udF_w@mail.gmail.com>
References: <CAG3eYYRdvi-JdPfZmH_1EhEpjdweZFc6NS54btEz0nWy=O3+vA@mail.gmail.com>
	<5fuhYLPOf07EnF5c5gyqAvbP3UZl6m72FicTS5tZnr3K8vTH5UoLkA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 11:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qldu2-0003eo-NG
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 11:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab1GZJ0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 05:26:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45939 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1GZJ0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 05:26:07 -0400
Received: by ywe9 with SMTP id 9so113014ywe.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IM54mZQA/Uu5LaAcnmRGCfqWK3dHBIIbCPogxVSCa6w=;
        b=g0CdrC1VnatUB/H8Adf+shmuDuFvTZotcFTVvvfciDLcTXnetAytgXXUhJTHHnsdnX
         4z4Do/jqNVArvOKNnWu2M8gScqpbiqQKn6HfmbRNvK090iGLzn/3eLeoUZ503Ev+qN77
         1wu5OeIbv0ZCzZU+Ub/RlkWCDgjNyyp70AQEo=
Received: by 10.236.181.169 with SMTP id l29mr7065720yhm.447.1311672366233;
 Tue, 26 Jul 2011 02:26:06 -0700 (PDT)
Received: by 10.147.34.14 with HTTP; Tue, 26 Jul 2011 02:26:06 -0700 (PDT)
In-Reply-To: <5fuhYLPOf07EnF5c5gyqAvbP3UZl6m72FicTS5tZnr3K8vTH5UoLkA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177848>

Hello,

2011/7/25 Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>:
> On 07/25/2011 10:45 AM, P=C3=A9ter Andr=C3=A1s Felv=C3=A9gi wrote:
>> Hello,
>>
>> 'git stash pop' erased my local modifications, but not all of them.
>
> Hi,
>
> I cannot reproduce this. =C2=A0What version of git are you using?

git 1.7.5.4 on Debian Wheezy AMD64

>
> Can you produce a test case? =C2=A0This could be a test repo that
> you can share or a sequence of commands to produce such a
> repo like:

Not likely, but I will try. My repo started as CVS, then converted to
SVN, and about a year ago, I switched to GIT. It has 5+ years of
history, 9k+ commits, multiple branches, merges.

What I checked so far is that:
- the stash on 089709b I was popping is of 2011.03.01
- since then, a lot of commits and fast forward merges were done on the=
 branch
- there were some rebase -i's to squash commits together, but I was
careful not to alter commits already pushed to the central repo

Since yesterday, I found out that my branch diverged:

# Your branch and 'origin/20110207-oracle' have diverged,
# and have 11 and 9 different commit(s) each, respectively.

I don't know how can this happen, because I only pull/push to/from the
central repo, and noone else is using it.

When I pulled, there were merge conflicts, earlier versions of the
files showing up. There were 3 files, SQLQueryCache cpp/hpp and
AdsPlugin.cpp. I resolved the commits by keeping the HEAD versions.

What is interesting is that the stash item that caused the problems is
still there, despite that it was popped:

$ git stash list
stash@{0}: WIP on 20110207-oracle: 089709b Merge branch
'20110207-oracle' of ssh://... into 20110207-oracle

$ git stash show
 build-configs.def |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

I made a copy of my local repo, and the central one, too, but I don't
really know what to do now. The state of the repo before the pop is
lost, unfortunately.

Is there some option for git to log its actions, so that in cases like
this one could check on the inner workings?

Regards, Peter
