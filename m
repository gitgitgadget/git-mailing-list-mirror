Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396073B42CD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278718; cv=pass; b=drwcX/FDlQN5ef5la4L1oGSxQU9EcdI1lXoAqJS5HadFe6I8ldFZr2ef1NgJhP9ww5bF73sO82Ex4pXGGNUMgnI4ZFE/Bh7Lp08DR75rLrD2TK/DSix9/Gl0ryulUe3gmt7NO84mAoY+J9AUYzyfpu4K/xUoBB9aPZo/XUDpnk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278718; c=relaxed/simple;
	bh=VQk3tgZ6/hWcCeOKK6yWBgJhn6lGoyXLZMkzUSwP4oA=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyHRG2ravfO7fimjrbUXu6ZlhaTQPWwGhA+5np/W4LsF2SQKhfo9dj1GP+6Szmi6BchdbyKS3sqL72MJB6Le/FydtZbamIJOnjKPMA5zwiAMEuZLpxtHVunS0Hsi/snzzNplrwfet1/L8cEwaqp3+1NulAQtCjrQi4SUbg/gARw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=DJGl5To4; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="DJGl5To4"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3513b110f86so440226eec.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791278715; cv=none;
        d=google.com; s=arc-20260327;
        b=Bl/tOudeS/SYFFm2jakvKWEQvJOjE0AWQSJq53+MzjMYQb/KOffVH0JLaJmDi6ZqcD
         TzLbRWM9XvBqWhOB7CVRnkXoDI/3Z3TGLU7mivKxegUCF7d8VzLOvB7FDwnkAoW6YWgp
         cF7H+XbAjmfRc8p6ayVLeRRSWCCouYfdLsjgLf72XMFKosDHk524fH4o7TayLqF6N1Rl
         0KBKGhcXqbFrjfv0p8zxhcSFdK31/6OaNJSBGOUi07xP7G6oCZ7bY6pvps7Xr1nEnSKG
         d4xgmHcyC196UfzlUnaxwmtSuOUCmosTfXL9n6Ne55yVP7mE5l3OAbGqeoqb1y9KUgpC
         sOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=VQk3tgZ6/hWcCeOKK6yWBgJhn6lGoyXLZMkzUSwP4oA=;
        fh=tPyxWr1b4qmDfe3/MrJtqB0b/oV6NaKMlcOLDv86QcY=;
        b=k1f+tfEl+0u5tv7WhGHdAvGPCy//6Y/QQcLtLEXB/6wVLENlqAexsnovr2AR0s0Fvt
         WghlJdkD+r0O9OTPo2Gwa6c7ddT1koKlFmqzS67p0Lg5pPzmeCJuYg7GWHy0iaBpGwDQ
         bmCwiii8HtagR9G/lqQe6lOE7MEp+DCGn0vqJ4JYOp7sdAvpyHTtyemszO1ArApRhEkt
         IJN5zGxPGBZ3D5iV504nZdKlhtFSdYtXZEfTLxcEHn65etdeLi2lJOV5fFYwhsJzQtAx
         QZaoq1BbJNCtrAHXZLVzLZd41V30rJhzsqva/V/efaeGQZbl/81gNlq21wJUQtyfSYFp
         K//w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1791278715; x=1791883515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQk3tgZ6/hWcCeOKK6yWBgJhn6lGoyXLZMkzUSwP4oA=;
        b=DJGl5To4VhxWvK8CIqHQdWYONbPuxUEuvsJYLPYz5VOorJJEYtt+ni/sx3sTKYObzI
         g4EZ5QZj4Aut2cxW1GLs4qCVFyapkezMug93BIVumgmM8s2jNs3I+wmf5vAdfN3jPSaq
         +OLAVCiB1kff148/GpxODyCyf8eSDREx4o15u2wxlnLMtuEuQzgNivA3ZTtziyVJhzLq
         AeXhp70P0nvaZgF3r+7BDl9DmUgbZ3BkciPCVT+dR6bB4sIV/0EVa4dl0xPdzNbU8lZo
         nhgPkEWhDwELwDdVBZCQjN0yq9LydqC6mUCplmZ1huBT4PIJgqj2p7+x7SzZaj8Bx7tU
         9FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278715; x=1791883515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQk3tgZ6/hWcCeOKK6yWBgJhn6lGoyXLZMkzUSwP4oA=;
        b=j5GCsS9LOKOaaZ/H7IuMcLMN1V++jazfUYNzy0xjYbrVXLinuuupoDUBhlPKhRB/Ey
         Ps3UlUmzYdWvbYmvqglS5Hn/fngmveW0u4udjxz1GIsSTB5OtzSQkOkkLoEFqYkMLN6g
         gmx9kzhFQWGLwOdKHvLAUtjzX+Uy/vT4fcpoRe2uyoP37O+P2MVqY4d3ego4aJsjRH+j
         75ZLnpVVXvLKk5ZFqKklyVp/WIe5Fr9rpNLD8o2xYas+fDC1GDjWeUThGaCAgOGNg+88
         meDIRuAb1NWhWQfY7byH8j4w3KjjxDsE64m+L1/vSICIs5OON84c4P30QZhEC8wSXqg7
         latQ==
X-Gm-Message-State: AFq9FYIWq8S/FCbbtcxj+P6rl2EH1O62C+uqoy/QHuTSuASP5UhN7KuA
	CNSJwXOr+9i9rurt2nVZjeKYaepjVGWNovPwq621Od/M++svfPbltMJGpN4gUa8FMCuiW1AESDZ
	KETlayTDtn4dlAGvUvR72lBMOdF0LBiq7E5KvLPri0g==
X-Gm-Gg: AYBFou39nrrO5FL8eJD1eN4+jn4EDktsZDlG0Hj/6P19J95shJ0tRNDl/cg8TfgLVPz
	2ZxMODjNgK3Q44DBPS3yyiiUO8X0nd67ZQ40VjT3Ict3QMOlWRfqIoctV7rmCdf4igqWGlw+D3e
	ZjnoZHVFkFbR59kNhoH43WEJIenojph46e8kK82LiFIoupFl0PLxUkPP2tRjPOWc6+8fyM7AKkt
	JXA/FHFwOg6EQ+cEwaPS1FLSnKjpn2DzzK4tYss6Mw5FQqJhIoec0RuxUwR49BXnSG1lRVB3fwD
	DJqELKK2q6joG5+WhT+ITz3ySEe8vOEXzmFrjYNKK0QVJGYgcPMwzFpP5l5d7y/5
X-Received: by 2002:a05:693c:80d0:b0:34b:529d:6263 with SMTP id
 5a478bee46e88-3514e33fdd1mr929873eec.33.1791278715038; Tue, 06 Oct 2026
 02:25:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 6 Oct 2026 02:25:13 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 6 Oct 2026 02:25:13 -0700
In-Reply-To: <1d1d2c76-9981-44ec-8ea9-8f886d49a742@gmail.com>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com> <1d1d2c76-9981-44ec-8ea9-8f886d49a742@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Tue, 6 Oct 2026 02:25:13 -0700
X-Gm-Features: AclHuK8d6Tz15J-vkfQjN8AqHZeAJR6RXYgdabWglvlP8AjuVUtCSZMDtBzjZo4
Message-ID: <CANUHOw2OMHFJLKWkDkyDm7WtLDcYxMnNfkD8uV96GZdWBS53RA@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: phillip.wood123@gmail.com, gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

Thanks for the two patches removing the duplicate changes checks. I'll
wait for those to settle before revisiting the exit-status and no-change
handling.

> I can see a script wanting to stash untracked files, but it may not make
> sense to add interactive options like "--patch" which sometimes [1]
> fails to clear the stashed changes from the worktree, that would be
> problematic for scripts.

For `stash create`, I don't think the issue in [1] should apply, since
it does not remove the selected changes from the worktree. I still need
to think about whether `--patch` is worth supporting for `stash create`,
even though it is primarily aimed at scripts.

> I wonder if we really need pathspec support, or if we do is
> "--pathspec-from-file" sufficient?

I agree that positional pathspec support probably isn't necessary.
Since `create` is primarily aimed at scripts, `--pathspec-from-file`
seems sufficient. It also avoids giving positional arguments another
meaning while we are already dealing with the message ambiguity.

> I think it is fairly unlikely that the message is going to start with
> '-' so using PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way
> forward to me. Adding "-m/--message" to match other commands that take
> a message would certainly make sense.

Thanks for confirming those points.

Thanks,
Kazumasa

On Mon, 5 Oct 2026 17:38:07 +0100, Phillip Wood
<phillip.wood123@gmail.com> wrote:
> Hi Kazumasa
>
> On 05/10/2026 06:55, =E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96 wrote:
> >
> > From that perspective, I can see three possible directions.
> >
> > 1. Keep extending `stash create`.
> >
> > We could expose more of the existing `do_create_stash()`
> > functionality through `stash create`, following the conventions of
> > `stash push` for the creation-related options they have in common.
> >
> > This seems implementable, but even with
> > `PARSE_OPT_STOP_AT_NON_OPTION` it would change the handling of
> > messages that begin with an option-like argument. Those would need
> > explicit disambiguation, such as `--`.
> >
> > There is also the pathspec question. If positional arguments
> > continue to be joined to form the message, pathspecs need some other
> > way to be distinguished from that message.
>
> It is worth thinking about which options from "push" make sense with
> "create" as the latter is really aimed at scripts rather than users. I
> can see a script wanting to stash untracked files, but it may not make
> sense to add interactive options like "--patch" which sometimes [1]
> fails to clear the stashed changes from the worktree, that would be
> problematic for scripts. I wonder if we really need pathspec support, or
> if we do is "--pathspec-from-file" sufficient? I think it is fairly
> unlikely that the message is going to start with '-' so using
> PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way forward to me.
> Adding "-m/--message" to match other commands that take a message would
> certainly make sense.
>
> Thanks
>
> Phillip
>
> [1] This happens when a user edits a hunk that looks like
> @@ -1 +1,4 @@
> -A
> +a
> +b
> +c
> +d
>
> to
>
> @@ -1 +1,3 @@
> -A
> +a
> +b
> +d
>
> To clear the stashed changes, we apply the hunk in reverse, so we
> try to apply
>
> @@ -1,3 +1 @@
> -a
> -b
> -d
> +A
>
> to a file that looks like
>
> a
> b
> c
> d
>
> which fails because the '-' lines do not match the content of the
> file.
>
> >
> > 2. Add a new stash subcommand for the creation functionality.
> >
> > This would leave the existing `stash create <message>` contract
> > unchanged. Because the new command would not inherit `create`'s
> > positional message grammar, its creation-related options and
> > pathspec handling could follow conventions similar to `stash push`.
> >
> > This preserves the existing `create` grammar while avoiding the need
> > to fit additional creation capabilities into it. The trade-off is
> > adding another public stash subcommand and its long-term maintenance
> > cost.
> >
> > 3. Add something like `--create-only` to `git stash push`.
> >
> > This would reuse the existing `push` option grammar without adding
> > another subcommand.
> >
> > I also read the 2019 discussion around `git stash push --snapshot`.
> > One concern there was that approximately the same end state could
> > already be obtained with `git stash push && git stash apply`.
> >
> > I do not think that particular concern carries over directly here.
> > `git stash create` already stops at object creation, but its public
> > interface does not expose more of the creation capabilities already
> > available in `do_create_stash()`. There is currently no public stash
> > command that exposes those capabilities while retaining that
> > create-only boundary.
> >
> > That does not mean a similar result cannot be constructed by other
> > means. The missing piece is a public interface to the existing stash
> > creation machinery at that boundary.
> >
> > Even so, there is still the separate question of whether `push` is
> > the right place for a creation-only operation in the first place.
> > The push-specific work around `do_create_stash()` would also need to
> > be separated carefully.
> >
> > All three seem substantially broader than the original `-u` / `-a`
> > patch.
> >
> > If this is worth pursuing further, which of these directions seems the
> > most plausible? Also, is this the right thread to continue that design
> > discussion, or would it be better to discuss it separately?
> >
> > Thanks again for the guidance,
> > Kazumasa Shigeta
> >
> > On Fri, 2 Oct 2026 05:04:26 -0400, "=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=
=96" <kazumasa.shigeta@kanamei.com> wrote:
> >> Hi Junio,
> >>
> >>> we would prefer to hear what the user visible implication of
> >>> "passing 0" is more than what mechanically is happening inside a
> >>> program.
> >>
> >> The user-visible effect is that stash create cannot currently include
> >> untracked or ignored files in the stash entry. If those are the only
> >> changes, it creates no entry at all, while stash push and save can
> >> include them with -u or -a as appropriate. I should have described tha=
t
> >> difference directly instead of starting from the include_untracked
> >> implementation detail.
> >>
> >>> ... was what you wanted to say, but I am not sure.
> >>
> >> Yes, exactly. I'll explain the backward-compatibility reason rather
> >> than the mechanics of parse_options().
> >>
> >>> You already said that with "does not update, reset, or clean".
> >>
> >> I'll drop that paragraph.
> >>
> >>> if you did not make a breaking change to the established convention,
> >>> is it worth saying?
> >>
> >> I don't think it adds anything here. I'll remove the exit-status
> >> discussion from the commit message as well.
> >>
> >>> adding tests for comprehensive coverage is not something to boast
> >>> about. Is it worth saying?
> >>
> >> I'll remove the test details from the commit message.
> >>
> >>> Why are we singling out only these two?
> >>
> >> I started by looking at the missing -u and -a support in create, and I
> >> think that led me to focus too narrowly on those two when considering
> >> the scope. I need to think more about whether this patch should remain
> >> limited to those two.
> >>
> >> Thanks,
> >> Kazumasa Shigeta
> >>
> >> On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com>=
 wrote:
> >>> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
> >>>
> >>>> `git stash create` always passes zero for the include_untracked para=
meter
> >>>> of do_create_stash(), even though that helper already supports untra=
cked
> >>>> and ignored files and stash push/save expose those modes as
> >>>> -u/--include-untracked and -a/--all.
> >>>
> >>> There may be no lies in what the above says, but we would prefer to
> >>> hear what the user visible implication of "passing 0" is more than
> >>> what mechanically is happening inside a program. For example:
> >>>
> >>> "git stash create", "git stash push", and "git stash save" are
> >>> commands that create a new stash entry. The latter two are also
> >>> responsible for storing the resulting stash entry to the reflog
> >>> of the "refs/stash" ref, but have options to control what is
> >>> included in the stash entry. Among these options, "create" only
> >>> supports the equivalent of "-m <message." to record in the stash
> >>> entry. Most notably, "-u" and "-a" options are missing.
> >>>
> >>>> Teach create to accept the same options and pass the existing mode
> >>>> through. Unlike push/save, create continues to only create objects: =
it
> >>>> does not update refs/stash, reset the index, or clean the working tr=
ee.
> >>>
> >>> Sure. It is a very concise and good description of what we want to
> >>> do.
> >>>
> >>>> Use parse_options() for the new options and stop parsing at the firs=
t
> >>>> non-option message word. This keeps option-like tokens after the mes=
sage
> >>>> as message text, while leading option-like arguments now follow Git'=
s
> >>>> normal option parsing. In particular, unknown or malformed leading
> >>>> options are rejected instead of silently becoming a message, short
> >>>> options may be combined, and `--` can be used when a message itself
> >>>> begins with a dash.
> >>>
> >>> Why do we need to go into such a detail in the log message? What is
> >>> the above paragraph designed to convey to the reader? Again, it may
> >>> not be telling any lies, but it misses the point by being inconsidera=
te
> >>> to your readers. What you need to tell them is _WHY_ you chose to
> >>> use parse_options() in such a way. What were you trying to achieve?
> >>>
> >>> I am guessing that something along this line ...
> >>>
> >>> "git stash create" traditionally treated the rest of the command
> >>> line as a message. For example,
> >>>
> >>> $ git stash create adding -u option
> >>>
> >>> has always been a request to create a stash entry with the
> >>> string "adding -u option" as its message. We should not make it
> >>> trigger the "-u" (include untracked) behavior for backward
> >>> compatibility, by using parse_options() with stop-at-the-non-option
> >>> mode to forbid it from reordering the command line arguments.
> >>>
> >>> ... was what you wanted to say, but I am not sure.
> >>>
> >>> How much of all these verbiage was written by AI by the way? You'd
> >>> need to spend effort to make it readable to humans.
> >>>
> >>>> Keep create's existing no-change behavior: detect the usual no-chang=
e
> >>>> case before do_create_stash() refreshes and writes the index, and re=
turn
> >>>> success without printing an object name. If do_create_stash() still
> >>>> reports its internal "nothing to create" result, map that to create'=
s
> >>>> public success status.
> >>>
> >>> You already said that with "does not update, reset, or clean".
> >>>
> >>>> This follows the stash subcommand exit-status convention established=
 by
> >>>> 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03=
):
> >>>> subcommands return 0 on success, negative values on failure, and sta=
tus 1
> >>>> when applying a stash results in conflicts. cmd_stash() maps negativ=
e
> >>>> subcommand failures to 128.
> >>>
> >>> Again, there may not be lies in here, but if you did not make a
> >>> breaking change to the established convention, is it worth saying?
> >>>
> >>>> 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> >>>> internal include-untracked path while intentionally leaving the user
> >>>> interface for "git stash create" unchanged. Reuse that machinery and
> >>>> the existing INCLUDE_ALL_FILES mode rather than adding a separate st=
ash
> >>>> creation path.
> >>>>
> >>>> Add coverage for short and long aliases, combined short options, the
> >>>> untracked/ignored boundary including an ignored-only worktree, optio=
n
> >>>> parsing and dash-leading messages, no-change behavior, and preservat=
ion
> >>>> of refs/stash, the index state, and the working tree.
> >>>
> >>> Again, adding tests for comprehensive coverage is not something to
> >>> boast about. Is it worth saying?
> >>>
> >>> Aren't -p/-S/-k/-q and pathspec support all about the creating half
> >>> of "git stash push" that are not available to "git stash create",
> >>> not just "-u" and "-a"? Why are we singling out only these two? It
> >>> may be more worthwhile to explain the rationale behind such a design
> >>> decision.
