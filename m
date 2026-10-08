Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A726158B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431004; cv=pass; b=E3c4E7MUcuetQIbPZuqMi+1h2hQ/28B+WgiwGoDnu7J+a+sGNjhplyW1k8zgnjiuMqRFqGX2vJzdgToVVDw1Dy3CwlzuEd5PeRmim38P2nnCggNvh7p/sd/Kahk53KwhMHb9PeZfy20sJLAQVLFcyuRkydteKBLN+gepvlI1Hfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431004; c=relaxed/simple;
	bh=pwPh4m4KKnucKacl6RTVQw+1UCVkzLlXKJZT4JKuolA=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suYuQJoAqYUJDAZB9ms2KEzLcH9xD05gB1l0Q+jHJ7jETHTuL/MxX0nPzhA/W3Mvjoh7Cm+uJkUCvMe604IcRjI4oYlWgstx9KXhnSZYXghxcfhDXoVWREutWxQL2B2ORA9noryX9pOoPPVfw1ZaWIuvyc39VgyYE2bJFGnHOnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=Kc/cE01P; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="Kc/cE01P"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1123125eec.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 20:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791431001; cv=none;
        d=google.com; s=arc-20260327;
        b=F7o9wY2aRvqM2kPwdOKdYWaMihq9TRhsKU47DC3I3LsdR6t+5MpauDCX6okq/Vq2/u
         loXH4mTArT1kPhqMfGbxOzSVYkd+lr70sRjpQZWNt0iRZjpJVLcJRxhhvNqakjH6A5c5
         XAcvdqZHeas+R/PDEWQA+dgB1F0FtXMSU6FQwefpx+EGudv9HcaipKva7MUswWDPf6Kt
         wjm8iUdFGG/irng6ShGg9pQeiY1yR/aHMDExe61q2EcgIyAQ/wvmu1Xc7aOW2USMvH9R
         6vyB6enM5WD64414KUycWt6aOvZcjsRFl7fpFove8mSiMIER1WXld08CbgaShSZOtVrx
         cngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=pwPh4m4KKnucKacl6RTVQw+1UCVkzLlXKJZT4JKuolA=;
        fh=tPyxWr1b4qmDfe3/MrJtqB0b/oV6NaKMlcOLDv86QcY=;
        b=edNcvqmpQCM6F308pI5PSSQb+BCRNkXr+juBKmfDo76OSjEoBmXybb8Ix5Fbu8Bg1C
         bcrqMPphYbODFRrO8XrHYB91xukl109Q8JkrjrzVJKPIwjbafgNbY+z2T4SKxq9awt7U
         llp9HOGUMWHM/Ltg0DL33mVEhhhdO0cu9eN4RvGTR+8ZVBU2RlP4KYQJrKLpZbkHVyDi
         nudJOl/S1qxbGA/qaHSNXxDu+vgY8Wutl8gTRWQ3eExhAGufGMdu9iLj4J8c2tEcyUGD
         AHQnIQT2X5KfJ7TdU6cIBwhR5J5RgHOTIjsgu55b6isRvskJu8n4o43i5R8nwk8s8hk9
         9IGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1791431001; x=1792035801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwPh4m4KKnucKacl6RTVQw+1UCVkzLlXKJZT4JKuolA=;
        b=Kc/cE01PHJWE32FPVBU1a+DYCWsx3Rormom+hdzpJbwejllmnumyb5/bbdjQxUQ3dI
         4SB92fAM4F+5nq07vhym6aqH1q6vyVtjImFcuoWb/rBTKyQBVelJtZbJnBuieVzM2syk
         o7xVhoLFlGLX5SCm0R54AX/pDsju5JgBV53jNICXtHRHz5SHlayPznSLC31zO3DedebS
         gCjf3OnPQTzk5Pku/EKE1fwrqOesEWdav1dYt9LlIRe4+/iSBTvEK6z10z81GqaO/Zud
         R9dnVXcTDIQIl7lB+0ds7BETAw+6Mf+r+8z10BwIZbVytVkEmz60M1q9OW9ORq61BLWP
         cLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431001; x=1792035801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwPh4m4KKnucKacl6RTVQw+1UCVkzLlXKJZT4JKuolA=;
        b=zZwwI231rah41Hytzp97w500WiAmOcwHbrHz383aeq57T5i1DF1NTnIMVy8QSfDU/V
         BfWRWA1/Y5Os8+ZR80SI8dkxveS2gYYSmJ1HIcDvDJyb6PLb2z9YKvjvHryyeX3DpBiv
         hnoremy7wwHe0nPQkKJVajCkJQt3dbf/qz3RT/tIlNfZd9Ch3ffjR9Yp9IUnDijpenuM
         3CisAxTLBqvGUYPwdEMhK1LfC/hU/sHBT6sjnWhoCBpsVSs3BarLyYGyyOZRWs5HmeSr
         ivh61deN5s5TCwb72OQlZnV5+/ytvzLvk0Scw9RJ0/3SI1xDnPBOpcTAcyntF1YJh+9r
         Dmeg==
X-Gm-Message-State: AFuF++n5N2plf6Toy6hNVDViSQsMrYJM/Zl7iFzC73RTuRUonk0nn286
	9s/Nr5rDqKVYYmEuxnY6Zjo0MZ4jr80drdKzS/UgBp+cEXIqZLTF/Zzo2vljzKC3zU7gEbRsDqX
	ZMg+c6ZEJs7UN9/j2MTDdwmHCVL5R1QKExsKh3cCWExTZLeE5RU1z
X-Gm-Gg: AYBFou0++A7H+URf7Q+60cysVlWywxKZy8+3AV/DdzYbHsdrG378F9y/aW24HCYq4nb
	yIUYwJTRDsD5wc7I9Wfz/o6zxkPDCqKB12WI+fXizMllW3Q/+55Roqzn9MvtCfiovkAjYIc2Cbk
	mNzCg4gXw8EVwAr5/nVeKe4xPUaLaOoVAAMUlfFfJ5KedM9nl5ETvBUx3Dayf6cCUA31sfco8pV
	ieFA2abQ8jc9RmMPV9Zhpd2lwB0sWFUZ6oy7aWB3dxWgYhUBa8a8zSePzXQhWcsDe8GB0IHCQgW
	P7Su35c2CnA+R2LXJSBMSgLsrkNvzAePxF5g+sOnPUhgjpHZSAilqw==
X-Received: by 2002:a05:7300:51dc:b0:351:6e7e:37bf with SMTP id
 5a478bee46e88-3516e7e3f30mr3293264eec.14.1791431001046; Wed, 07 Oct 2026
 20:43:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 7 Oct 2026 20:43:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 7 Oct 2026 20:43:20 -0700
In-Reply-To: <7af72eb3-9a61-43c8-a9c0-faaff1817949@gmail.com>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
 <1d1d2c76-9981-44ec-8ea9-8f886d49a742@gmail.com> <CANUHOw2OMHFJLKWkDkyDm7WtLDcYxMnNfkD8uV96GZdWBS53RA@mail.gmail.com>
 <7af72eb3-9a61-43c8-a9c0-faaff1817949@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Wed, 7 Oct 2026 20:43:20 -0700
X-Gm-Features: AclHuK-oHBqMiu7cBTi3PFwRnvNySs36xXqQgIMp6Cg21wyVhgvsbVyZ8diPh4E
Message-ID: <CANUHOw3-9q3jNDv03nmntNHQATi03ORUFnhzTdWEiDgYjds_Uw@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: phillip.wood123@gmail.com, gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

> As "git stash create" does not remove the stashed changes from the
> worktree it would probably be simplest to not support "--patch" or
> "pathspecs" so that the script can easily remove the stashed changes
> with "git read-tree -m -u HEAD" (together with "git clean" if it is
> stashing untracked files). If someone has a use for pathspec support
> we can think about adding it but "git stash create" has existed for 20
> years without anyone requesting it.

That makes sense. If nobody has asked for pathspec support in all that
time, maybe I was overthinking it a little.

I had started to think that if we are going to make `stash create`
parse options, it might be better to expose everything that
`do_create_stash()` can already handle at the same time.

But even if we do not expose all the options now, I think introducing
option parsing to `stash create` has a clear benefit on its own. If we
make that change now, adding more script-oriented options later should
not require us to revisit the basic decision to make `stash create`
parse options, or the backward-compatibility discussion around that
change.

So, at least for now, I am thinking of leaving `--patch` and pathspecs
out.

Thanks,
Kazumasa Shigeta

On Tue, 6 Oct 2026 10:57:58 +0100, Phillip Wood
<phillip.wood123@gmail.com> wrote:
> Hi Kazumasa
>
> On 06/10/2026 10:25, =E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96 wrote:
> > Hi Phillip,
> >
> > Thanks for the two patches removing the duplicate changes checks. I'll
> > wait for those to settle before revisiting the exit-status and no-chang=
e
> > handling.
> >
> >> I can see a script wanting to stash untracked files, but it may not ma=
ke
> >> sense to add interactive options like "--patch" which sometimes [1]
> >> fails to clear the stashed changes from the worktree, that would be
> >> problematic for scripts.
> >
> > For `stash create`, I don't think the issue in [1] should apply, since
> > it does not remove the selected changes from the worktree.
>
> Oh, good point, I'd completely forgotten that when I was writing
> yesterday. If the script wants to remove the changes from the worktree
> it still faces the same problem. As "git stash create" does not remove
> the stashed changes from the worktree it would probably be simplest to
> not support "--patch" or "pathspecs" so that the script can easily
> remove the stashed changes with "git read-tree -m -u HEAD" (together
> with "git clean" if it is stashing untracked files). If someone has a
> use for pathspec support we can think about adding it but "git stash
> create" has existed for 20 years without anyone requesting it.
>
> Thanks
>
> Phillip
> > I still need
> > to think about whether `--patch` is worth supporting for `stash create`=
,
> > even though it is primarily aimed at scripts.
> >
> >> I wonder if we really need pathspec support, or if we do is
> >> "--pathspec-from-file" sufficient?
> >
> > I agree that positional pathspec support probably isn't necessary.
> > Since `create` is primarily aimed at scripts, `--pathspec-from-file`
> > seems sufficient. It also avoids giving positional arguments another
> > meaning while we are already dealing with the message ambiguity.
> >
> >> I think it is fairly unlikely that the message is going to start with
> >> '-' so using PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way
> >> forward to me. Adding "-m/--message" to match other commands that take
> >> a message would certainly make sense.
> >
> > Thanks for confirming those points.
> >
> > Thanks,
> > Kazumasa
> >
> > On Mon, 5 Oct 2026 17:38:07 +0100, Phillip Wood
> > <phillip.wood123@gmail.com> wrote:
> >> Hi Kazumasa
> >>
> >> On 05/10/2026 06:55, =E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96 wrote:
> >>>
> >>> From that perspective, I can see three possible directions.
> >>>
> >>> 1. Keep extending `stash create`.
> >>>
> >>> We could expose more of the existing `do_create_stash()`
> >>> functionality through `stash create`, following the conventions of
> >>> `stash push` for the creation-related options they have in common.
> >>>
> >>> This seems implementable, but even with
> >>> `PARSE_OPT_STOP_AT_NON_OPTION` it would change the handling of
> >>> messages that begin with an option-like argument. Those would need
> >>> explicit disambiguation, such as `--`.
> >>>
> >>> There is also the pathspec question. If positional arguments
> >>> continue to be joined to form the message, pathspecs need some other
> >>> way to be distinguished from that message.
> >>
> >> It is worth thinking about which options from "push" make sense with
> >> "create" as the latter is really aimed at scripts rather than users. I
> >> can see a script wanting to stash untracked files, but it may not make
> >> sense to add interactive options like "--patch" which sometimes [1]
> >> fails to clear the stashed changes from the worktree, that would be
> >> problematic for scripts. I wonder if we really need pathspec support, =
or
> >> if we do is "--pathspec-from-file" sufficient? I think it is fairly
> >> unlikely that the message is going to start with '-' so using
> >> PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way forward to me=
.
> >> Adding "-m/--message" to match other commands that take a message woul=
d
> >> certainly make sense.
> >>
> >> Thanks
> >>
> >> Phillip
> >>
> >> [1] This happens when a user edits a hunk that looks like
> >> @@ -1 +1,4 @@
> >> -A
> >> +a
> >> +b
> >> +c
> >> +d
> >>
> >> to
> >>
> >> @@ -1 +1,3 @@
> >> -A
> >> +a
> >> +b
> >> +d
> >>
> >> To clear the stashed changes, we apply the hunk in reverse, so we
> >> try to apply
> >>
> >> @@ -1,3 +1 @@
> >> -a
> >> -b
> >> -d
> >> +A
> >>
> >> to a file that looks like
> >>
> >> a
> >> b
> >> c
> >> d
> >>
> >> which fails because the '-' lines do not match the content of the
> >> file.
> >>
> >>>
> >>> 2. Add a new stash subcommand for the creation functionality.
> >>>
> >>> This would leave the existing `stash create <message>` contract
> >>> unchanged. Because the new command would not inherit `create`'s
> >>> positional message grammar, its creation-related options and
> >>> pathspec handling could follow conventions similar to `stash push`.
> >>>
> >>> This preserves the existing `create` grammar while avoiding the need
> >>> to fit additional creation capabilities into it. The trade-off is
> >>> adding another public stash subcommand and its long-term maintenance
> >>> cost.
> >>>
> >>> 3. Add something like `--create-only` to `git stash push`.
> >>>
> >>> This would reuse the existing `push` option grammar without adding
> >>> another subcommand.
> >>>
> >>> I also read the 2019 discussion around `git stash push --snapshot`.
> >>> One concern there was that approximately the same end state could
> >>> already be obtained with `git stash push && git stash apply`.
> >>>
> >>> I do not think that particular concern carries over directly here.
> >>> `git stash create` already stops at object creation, but its public
> >>> interface does not expose more of the creation capabilities already
> >>> available in `do_create_stash()`. There is currently no public stash
> >>> command that exposes those capabilities while retaining that
> >>> create-only boundary.
> >>>
> >>> That does not mean a similar result cannot be constructed by other
> >>> means. The missing piece is a public interface to the existing stash
> >>> creation machinery at that boundary.
> >>>
> >>> Even so, there is still the separate question of whether `push` is
> >>> the right place for a creation-only operation in the first place.
> >>> The push-specific work around `do_create_stash()` would also need to
> >>> be separated carefully.
> >>>
> >>> All three seem substantially broader than the original `-u` / `-a`
> >>> patch.
> >>>
> >>> If this is worth pursuing further, which of these directions seems th=
e
> >>> most plausible? Also, is this the right thread to continue that desig=
n
> >>> discussion, or would it be better to discuss it separately?
> >>>
> >>> Thanks again for the guidance,
> >>> Kazumasa Shigeta
> >>>
> >>> On Fri, 2 Oct 2026 05:04:26 -0400, "=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=
=96" <kazumasa.shigeta@kanamei.com> wrote:
> >>>> Hi Junio,
> >>>>
> >>>>> we would prefer to hear what the user visible implication of
> >>>>> "passing 0" is more than what mechanically is happening inside a
> >>>>> program.
> >>>>
> >>>> The user-visible effect is that stash create cannot currently includ=
e
> >>>> untracked or ignored files in the stash entry. If those are the only
> >>>> changes, it creates no entry at all, while stash push and save can
> >>>> include them with -u or -a as appropriate. I should have described t=
hat
> >>>> difference directly instead of starting from the include_untracked
> >>>> implementation detail.
> >>>>
> >>>>> ... was what you wanted to say, but I am not sure.
> >>>>
> >>>> Yes, exactly. I'll explain the backward-compatibility reason rather
> >>>> than the mechanics of parse_options().
> >>>>
> >>>>> You already said that with "does not update, reset, or clean".
> >>>>
> >>>> I'll drop that paragraph.
> >>>>
> >>>>> if you did not make a breaking change to the established convention=
,
> >>>>> is it worth saying?
> >>>>
> >>>> I don't think it adds anything here. I'll remove the exit-status
> >>>> discussion from the commit message as well.
> >>>>
> >>>>> adding tests for comprehensive coverage is not something to boast
> >>>>> about. Is it worth saying?
> >>>>
> >>>> I'll remove the test details from the commit message.
> >>>>
> >>>>> Why are we singling out only these two?
> >>>>
> >>>> I started by looking at the missing -u and -a support in create, and=
 I
> >>>> think that led me to focus too narrowly on those two when considerin=
g
> >>>> the scope. I need to think more about whether this patch should rema=
in
> >>>> limited to those two.
> >>>>
> >>>> Thanks,
> >>>> Kazumasa Shigeta
> >>>>
> >>>> On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>>>> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
> >>>>>
> >>>>>> `git stash create` always passes zero for the include_untracked pa=
rameter
> >>>>>> of do_create_stash(), even though that helper already supports unt=
racked
> >>>>>> and ignored files and stash push/save expose those modes as
> >>>>>> -u/--include-untracked and -a/--all.
> >>>>>
> >>>>> There may be no lies in what the above says, but we would prefer to
> >>>>> hear what the user visible implication of "passing 0" is more than
> >>>>> what mechanically is happening inside a program. For example:
> >>>>>
> >>>>> "git stash create", "git stash push", and "git stash save" are
> >>>>> commands that create a new stash entry. The latter two are also
> >>>>> responsible for storing the resulting stash entry to the reflog
> >>>>> of the "refs/stash" ref, but have options to control what is
> >>>>> included in the stash entry. Among these options, "create" only
> >>>>> supports the equivalent of "-m <message." to record in the stash
> >>>>> entry. Most notably, "-u" and "-a" options are missing.
> >>>>>
> >>>>>> Teach create to accept the same options and pass the existing mode
> >>>>>> through. Unlike push/save, create continues to only create objects=
: it
> >>>>>> does not update refs/stash, reset the index, or clean the working =
tree.
> >>>>>
> >>>>> Sure. It is a very concise and good description of what we want to
> >>>>> do.
> >>>>>
> >>>>>> Use parse_options() for the new options and stop parsing at the fi=
rst
> >>>>>> non-option message word. This keeps option-like tokens after the m=
essage
> >>>>>> as message text, while leading option-like arguments now follow Gi=
t's
> >>>>>> normal option parsing. In particular, unknown or malformed leading
> >>>>>> options are rejected instead of silently becoming a message, short
> >>>>>> options may be combined, and `--` can be used when a message itsel=
f
> >>>>>> begins with a dash.
> >>>>>
> >>>>> Why do we need to go into such a detail in the log message? What is
> >>>>> the above paragraph designed to convey to the reader? Again, it may
> >>>>> not be telling any lies, but it misses the point by being inconside=
rate
> >>>>> to your readers. What you need to tell them is _WHY_ you chose to
> >>>>> use parse_options() in such a way. What were you trying to achieve?
> >>>>>
> >>>>> I am guessing that something along this line ...
> >>>>>
> >>>>> "git stash create" traditionally treated the rest of the command
> >>>>> line as a message. For example,
> >>>>>
> >>>>> $ git stash create adding -u option
> >>>>>
> >>>>> has always been a request to create a stash entry with the
> >>>>> string "adding -u option" as its message. We should not make it
> >>>>> trigger the "-u" (include untracked) behavior for backward
> >>>>> compatibility, by using parse_options() with stop-at-the-non-option
> >>>>> mode to forbid it from reordering the command line arguments.
> >>>>>
> >>>>> ... was what you wanted to say, but I am not sure.
> >>>>>
> >>>>> How much of all these verbiage was written by AI by the way? You'd
> >>>>> need to spend effort to make it readable to humans.
> >>>>>
> >>>>>> Keep create's existing no-change behavior: detect the usual no-cha=
nge
> >>>>>> case before do_create_stash() refreshes and writes the index, and =
return
> >>>>>> success without printing an object name. If do_create_stash() stil=
l
> >>>>>> reports its internal "nothing to create" result, map that to creat=
e's
> >>>>>> public success status.
> >>>>>
> >>>>> You already said that with "does not update, reset, or clean".
> >>>>>
> >>>>>> This follows the stash subcommand exit-status convention establish=
ed by
> >>>>>> 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-=
03):
> >>>>>> subcommands return 0 on success, negative values on failure, and s=
tatus 1
> >>>>>> when applying a stash results in conflicts. cmd_stash() maps negat=
ive
> >>>>>> subcommand failures to 128.
> >>>>>
> >>>>> Again, there may not be lies in here, but if you did not make a
> >>>>> breaking change to the established convention, is it worth saying?
> >>>>>
> >>>>>> 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> >>>>>> internal include-untracked path while intentionally leaving the us=
er
> >>>>>> interface for "git stash create" unchanged. Reuse that machinery a=
nd
> >>>>>> the existing INCLUDE_ALL_FILES mode rather than adding a separate =
stash
> >>>>>> creation path.
> >>>>>>
> >>>>>> Add coverage for short and long aliases, combined short options, t=
he
> >>>>>> untracked/ignored boundary including an ignored-only worktree, opt=
ion
> >>>>>> parsing and dash-leading messages, no-change behavior, and preserv=
ation
> >>>>>> of refs/stash, the index state, and the working tree.
> >>>>>
> >>>>> Again, adding tests for comprehensive coverage is not something to
> >>>>> boast about. Is it worth saying?
> >>>>>
> >>>>> Aren't -p/-S/-k/-q and pathspec support all about the creating half
> >>>>> of "git stash push" that are not available to "git stash create",
> >>>>> not just "-u" and "-a"? Why are we singling out only these two? It
> >>>>> may be more worthwhile to explain the rationale behind such a desig=
n
> >>>>> decision.
