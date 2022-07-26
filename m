Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B8C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 06:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGZGy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 02:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGZGyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 02:54:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F324F38
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 23:54:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p5so5590285edi.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2UhWOrOMQUPfhpMnaH5epfiWo4E9QmIHUJhHRMo53oY=;
        b=ln/D3FHrHMBSRmXyeLn1+W1TZJIUfFlIMPlRLvw5ePFYmLOWwkqINVtOcI6XD19NJH
         w4JKznwxcCtkuS6tnExUZF2yjDQDinLtCeKJ0299kbcVRawRsARAi7i+wg9s2HnaNr91
         m8LUKDq0GU8N5+GsxWZxpvhC4X2ymsS1hph4AbeXr/0HOdSUzmXn40hCOMmF34bz63LT
         Az+P9eqw1oA9ppP8w9aMBk1kOrCDLbbksi40vX80Gp7iPCPYQ+maMCg5BSF4tEuF0vbu
         mvoFQG3brK0yc4SkqzinFbS6c9zaqLdX8uIkqZraFCvc6L6xutgNbnnvtCuomIPMx6Nq
         8XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2UhWOrOMQUPfhpMnaH5epfiWo4E9QmIHUJhHRMo53oY=;
        b=ZEMu6mhqKap3kHJBXtudeEtc+HkWwJ7nslwjRPiVBWhZdpq6gtngpSdTjcECC3cjPt
         hX/jxTSftWZ1Nzaa2rdsDdXcEqL2789ZSVZhkKM71i8rvdFrw0b0cHnjGkE5Vhk9kjBY
         JZvZlpFImFU8XfLqYy2Vamcgz3mZT0FlmPcfcVG377F2eVkECkWH3tmR5Nn/XJswLyGS
         /Feq5NgmakS5PPdOIoGIDwCLOUZN7duhGTkd3cS1pSlYn9j2Odlrk9E3f8YPuTpalfaA
         QSg0GDIvNG7zekP3jp3zAYv9XQGOJQJKbR0VdfkvBp0BmBiKSVTbhwO6PfS8oK8MdZeK
         dLVw==
X-Gm-Message-State: AJIora8WnybUn0A5yp/yx5/Lx3gwa8H866fS8HAI9c5sFx9aUPxNEmLg
        Zdo85yQ/a+8AlksYaTfGWy5iVp4Q+M0=
X-Google-Smtp-Source: AGRyM1uyetyYGRsIjtytOBBA3kIHWzePVecPqhCwmTbWMsIKLj1qH4zbM/W1URxb0Hw1MQqPinQ6QA==
X-Received: by 2002:a05:6402:254b:b0:43b:d6c3:dd96 with SMTP id l11-20020a056402254b00b0043bd6c3dd96mr16326594edb.406.1658818457923;
        Mon, 25 Jul 2022 23:54:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709063e4300b0072b4e4cd346sm6123511eji.188.2022.07.25.23.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 23:54:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGESO-005xKm-DF;
        Tue, 26 Jul 2022 08:54:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
Date:   Tue, 26 Jul 2022 08:35:36 +0200
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
 <220722.86sfmts9vr.gmgdl@evledraar.gmail.com>
 <CABPp-BHToEDv=8W9nf4XDC8b+5=EVuc=OnoT6xCRGWxB9CKWfw@mail.gmail.com>
 <220723.86h738qsr9.gmgdl@evledraar.gmail.com>
 <CABPp-BE99NVBKRn9Uh3HMcgzV-egtmgnuVJdvT1Rk5VrEKnd4w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BE99NVBKRn9Uh3HMcgzV-egtmgnuVJdvT1Rk5VrEKnd4w@mail.gmail.com>
Message-ID: <220726.86k080nz3b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Elijah Newren wrote:

> On Fri, Jul 22, 2022 at 10:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Jul 22 2022, Elijah Newren wrote:
>>
> [...]
>> > So, ignoring the return code from diff-index is correct behavior here.
>> >
>> > Were you thinking this was a test script or something?
>>
>> We can leave this for now.
>>
>> But no. Whatever the merge driver is documenting as its normal return
>> values we really should be ferrying up abort() and segfault, per the
>> "why do we miss..." in:
>> https://lore.kernel.org/git/patch-v2-11.14-8cc6ab390db-20220720T211221Z-=
avarab@gmail.com/
>>
>> I.e. this is one of the cases in the test suite where we haven't closed
>> that gap, and could hide segfaults as a "normal" exit 2.
>>
>> So I think your v5 is fine as-is, but in general I'd be really
>> interested if you want to double-down on this view for the merge drivers
>> for some reason, because my current plan for addressing these blindspots
>> outlined in the above wouldn't work then...
>
> Quoting from there:
>
>> * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
>>   git commands, they'll usually return their own exit codes on "git"
>>   failure, rather then ferrying up segfault or abort() exit code.
>>
>>   E.g. these invocations in git-merge-one-file.sh leak, but aren't
>>   reflected in the "git merge" exit code:
>>
>>src1=3D$(git unpack-file $2)
>>src2=3D$(git unpack-file $3)
>>
>>   That case would be easily "fixed" by adding a line like this after
>>   each assignment:
>>
>>test $? -ne 0 && exit $?
>>
>>   But we'd then in e.g. "t6407-merge-binary.sh" run into
>>   write_tree_trivial() in "builtin/merge.c" calling die() instead of
>>   ferrying up the relevant exit code.
>
> Sidenote, but I don't think t6407-merge-binary.sh calls into
> write_tree_trivial().  Doesn't in my testing, anyway.

I haven't gone back & looked at that, but I vaguely recall that if you
"get past" that one it was returning 128 somewhere, either directly or
indirectly.

In any case, for the purposes of that summary it's a common pattern
elsewhere...

> Are you really planning on auditing every line of git-bisect.sh,
> git-merge*.sh, git-sh-setup.sh, git-submodule.sh, git-web--browse.sh,
> and others, and munging every area that invokes git to check the exit
> status?

Not really, but just for that change explaining why it's required to
have this log-on-the-side to munge the exit code.

Although I think you might have not kept up with just how close we are
to "git rm"-ing most of our non-trivial amounts of
shellscript. git-{submodule,bisect}.sh is going away, hopefully in this
release.

*If* we go for that approach I'd think it would be relatively easy to
 add a helper to git-sh-setup.sh to wrap the various "git" callse.

>   Yuck.  A few points:
>   * Will this really buy you anything?  Don't we have other regression
> tests of all these commands (e.g. "git unpack-file") which ought to
> show the same memory leaks?  This seems like high lift, low value to
> me, and just fixing direct invocations in the regression tests is
> where the value comes.

It's a long-tail problem, and we don't need to fix it all now. I'm just
commenting on it here because there's an *addition* of a hidden exit
code, and more importantly I wanted to clear up if you thought ferrying
up abort() or segfaults wouldn't be desired in those cases.

>  (If direct coverage is lacking in the
> regression tests, shouldn't the solution be to add coverage?)


But how do we find out what we're covering? Yes "make coverage", but
that's just going to give you all C lines we "visit", but you don't know
if those lines were visited by parts of our test suite where we're
checking the exit code.

>   * Won't this be a huge review and support burden to maintain the
> extra checking?

I think the end result mostly makes things easier to deal with &
maintaine, e.g. consistently using &&-chaining, or test_cmp instead of
"test "$(...)" etc.

>   * Some of these scripts, such as git-merge-resolve.sh and
> git-merge-octopus.sh are used as examples of e.g. merge drivers, and
> invasive checks whose sole purpose is memory leak checking seems to
> run counter to the purpose of being a simple example for users

I'm not doing any of this now, but I'd think we could do something like
this (i.e. new helpers in git-sh-setup.sh):
=09
	diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
	index 343fe7bccd0..f23344dfec8 100755
	--- a/git-merge-resolve.sh
	+++ b/git-merge-resolve.sh
	@@ -37,15 +37,16 @@ then
	 	exit 2
	 fi
=09=20
	-git update-index -q --refresh
	-git read-tree -u -m --aggressive $bases $head $remotes || exit 2
	+run_git git update-index -q --refresh
	+run_git --exit-on-failure 2 git read-tree -u -m --aggressive $bases $head=
 $remotes
	 echo "Trying simple merge."
	-if result_tree=3D$(git write-tree 2>/dev/null)
	+result_tree=3D$(git write-tree 2>/dev/null)
	+if check_last_git_cmd $?
	 then
	 	exit 0
	 else
	 	echo "Simple merge failed, trying Automatic merge."
	-	if git merge-index -o git-merge-one-file -a
	+	if run_git git merge-index -o git-merge-one-file -a
	 	then
	 		exit 0
	 	else

>   * Wouldn't using errexit and pipefail be an easier way to accomplish
> checking the exit status (avoiding the problems from the last few
> bullets)?  You'd still have to audit the code and write e.g.
> shutupgrep wrappers (since grep reports whether it found certain
> patterns in the input, rather than whether it was able to perform the
> search on the input, and we often only care about the latter), but it
> at least would automatically check future git invocations.

Somewhat, but unless we're going to depend on "bash" I think we can at
most use those during development to locate various issues, e.g. as I
did in this series:
https://lore.kernel.org/git/20210123130046.21975-1-avarab@gmail.com/

>   * Are we running the risk of overloading special return codes (e.g.
> 125 in git-bisect)

No, we already deal with that as a potential problem in test_must_fail
in the test suite, i.e. we just catch abort(), segfaults & the like. In
bourn shells those are 134.

> I do still think that "2" is the correct return code for the
> shell-script merge strategies here, though I think it's feasible in
> their cases to change the documentation to relax the return code
> requirements in such a way to allow those scripts to utilize errexit
> and pipefail.

I think for any such interface it makes sense to exit with 0, 1 and 2 or
whatever during normal circumstances.

But if the program you just called segfaulted I think it makes sense to
treat that as an exception. I.e. it's not just that the merge failed,
but we should really abort() in the calling program too..

Anyway, this is all quite academic at this point, but since you asked...
