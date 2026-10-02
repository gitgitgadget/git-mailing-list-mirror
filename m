Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE99443AB9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931872; cv=pass; b=cee0Ck8VCb2Fux84EsHAeqLQMxxrzbKdU8ADdDxlseok12rwRdXdraDHAAuzPEZ5Drou73LzJkm4DrMQmBcKY/jKEXIY3CvAK69aB/WALpGwalcmNhRLRD5N/YglrRYfTFxrw6rrg+wYyhY34rWAcmi3ABnqFnX6ATILApdOIxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931872; c=relaxed/simple;
	bh=Fpwgf5FI5pm6nud5VYqV6aZqMNFuCKjuU13Uqh56iYk=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdP+tsgfT+X2XzVvpOgA2p0oZxZbGBpdozNEhsb3rcIHeZRhiyy5SKK+auQ6O/Iw67XrpRKkI47x7a9HWfn8eFcjXwinL66LK8DA1ZuyIvjwFIeq9G8vdtmTgdUel/5B3CkVQhs4GaL+9DA2n8aNck4yfqLbMzcSw4kfxaXgWWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=N74ZA6+E; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="N74ZA6+E"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so4239232eec.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 02:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790931869; cv=none;
        d=google.com; s=arc-20260327;
        b=bA0M4KmN811+A6XXExbVxMVtTmgK4aoQi7KOJoHtHTHFbi2q/V5wy/hOue2Lg0G7xZ
         UsWcLCdp5x/Fdfo5sw+C08L7GWBy1hXDiuPrYxu3OaWIA1drHs0uPMPQxu7QzYCiRgT7
         FrHuJJRtuxe/Yyz640tIIhEaBo2r9aiZtgojsHDyXN3vs1g+ORUMWFMMgwxT7LjbPfdk
         N4hY3Pq6HnYM1goqvFR9NEeHlzKptNnC4uxTtIrJBh/Fl76dIDQciyVawRKC/3324/be
         Hecfr3WUTGfsAf7EcSeldLnQPLCAbVQXTPTTrkaqQM6vWSM2sq83EZKkRI5Z23/hVA4L
         ao2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=Fpwgf5FI5pm6nud5VYqV6aZqMNFuCKjuU13Uqh56iYk=;
        fh=wj/qsr0mPslKs5ls5jocKEMICsDU7NgisQsyKhWhtzQ=;
        b=kv97upVOcqchQ3yrSQ+8focEbrPuaR0lt4l4Jf9jb5aOygM3NVILdg5FjjcljMiOPV
         hcSFXQ8DT9/aikJsFONXd8lniDkZbNFK8Rv7Z1gcnbh92KBToFzPwY8QyFsrvQeNZbsk
         dB8PSYWqJzwy+7d4KnaUOy/NSkfJfmSa3hyPqu8+PjsnBXhu4KHEA0gbwtxweSxrW4+c
         vx9UjYG6IPQlEqi7CGImc8y/5ilgspTdKIUJTHGPvbEwavahms1aIEPsq6kCNx1lgpxQ
         B15hF4xjIPChjN+pmksWlCaq4KskqZ9NUle/qvozn6ZFXUCj2gLYkxcwoAB5PdcFGPFQ
         cpkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790931869; x=1791536669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fpwgf5FI5pm6nud5VYqV6aZqMNFuCKjuU13Uqh56iYk=;
        b=N74ZA6+ES7awIo7hKHIyIo87uSXhn3ugbqmQhr5RDryUhp0BfbiTLXEBibaW1x0BM5
         kiPP1A9E68mgufPuyo/OaeBbTl9k74cfPgBSh2x14Z8wN9wkmqa/Jw3LI3t/2RrBq7t6
         KAIQp76SaAcSvGZ79C4FhtqP7BX9/AzOIO+c0YKW8KX0pbGOpMr3xerRkfIKDK2oBUbC
         NTVcTvU8/BC4UL8ZpDkPjCueazpYmZvbXeocEqBxUDSMSg2tFunWwefr2invTyfonfWK
         zbSlk/J+kFV5KByfDJ5E7b6EhAxskcMB6qc0zOO//eDTWzeAdxU7Gs8VqY/Mz+le45pm
         2MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931869; x=1791536669;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fpwgf5FI5pm6nud5VYqV6aZqMNFuCKjuU13Uqh56iYk=;
        b=ePwTGbyyx4QUh0xVlJMEJO+knZuQ+W+g1opnG7MbFYSOPKBBpvcflx52VNam/qwH8K
         e28aiikAdhumYeDaKvcWUF4bMd5Uu98/AO9ScdbOpX/INmgp2O74pFD504ovf0tSVri/
         na2p4lDqMr4sFD0bVhALw70qVa9vaqXXyu4pqt/Zy4S+bAmNSnuoI/xAoiLgChk6th3/
         pa9MH1VLV8+W8GiZe5gwrL4K0YifjvAWbV/i0DPLduRhVx7LjO1CNA+xdoH3+ul4ufmx
         a9JI6OsoDwxZRshEdn/CXwLLrrblyDsiq9bpDmosSV+fqPCWklcV+7ui57NGUrCIFRqa
         VFLw==
X-Gm-Message-State: AFuF++l3Z9JUPayVINRceDEXm2z/PrAXo0qu003lGWicb6ALOymj8ZRr
	qQVaro1U9/jyS/ArLePhR0Q/9o8Emu6QNv3NrUXQvhRImBYmvEnBv9jn37R6trrkMC03Aye1Nwc
	8kcbUL/bzwYWlSGevoH0JxV1dRs4lZP/XN2wrq8KdZg==
X-Gm-Gg: AYBFou3aLK+1D0gQNoghytbb7ZoxjFnzFlhYso4mWCny+WJJxp4XVax3uZSoBdtm+Yq
	5VZWutvXNh5HCzYm44ham8+g5ROVWCp2dltdC/MtyAdqQLJ9J4FKZPHvNoaL9H85BHxvuGa7PMi
	iofWAtJ9eDQXf0uzfMPlP5+1N1sWPAM7btP9UajhZtY+A6DxCX0cX08I/EqT1dF0JVb5cVgfUU5
	0tr31oa5pw4htaPkLZduVVV7THUhVnX7iLvxssfgH1Wqv/BsollGBScyBfv+wLwr638GJtdPL1s
	xPYrgCRL1+BFSGFeOnz16VVPIGcRhf6JxLmRB6AgXM4adVq0G3qMAA==
X-Received: by 2002:a05:693c:20cc:20b0:34e:f948:d7da with SMTP id
 5a478bee46e88-34f150ead1bmr2192366eec.21.1790931868316; Fri, 02 Oct 2026
 02:04:28 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 2 Oct 2026 05:04:26 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 2 Oct 2026 05:04:26 -0400
In-Reply-To: <xmqq7bk173qm.fsf@gitster.g>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Fri, 2 Oct 2026 05:04:26 -0400
X-Gm-Features: AclHuK-HY2r50YO9VHoJhPfQNBIZi71J9H__HKPaZ2p_bUzwXjH9EFQKJn2M2Ao
Message-ID: <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

> we would prefer to hear what the user visible implication of
> "passing 0" is more than what mechanically is happening inside a
> program.

The user-visible effect is that stash create cannot currently include
untracked or ignored files in the stash entry. If those are the only
changes, it creates no entry at all, while stash push and save can
include them with -u or -a as appropriate. I should have described that
difference directly instead of starting from the include_untracked
implementation detail.

> ... was what you wanted to say, but I am not sure.

Yes, exactly. I'll explain the backward-compatibility reason rather
than the mechanics of parse_options().

> You already said that with "does not update, reset, or clean".

I'll drop that paragraph.

> if you did not make a breaking change to the established convention,
> is it worth saying?

I don't think it adds anything here. I'll remove the exit-status
discussion from the commit message as well.

> adding tests for comprehensive coverage is not something to boast
> about. Is it worth saying?

I'll remove the test details from the commit message.

> Why are we singling out only these two?

I started by looking at the missing -u and -a support in create, and I
think that led me to focus too narrowly on those two when considering
the scope. I need to think more about whether this patch should remain
limited to those two.

Thanks,
Kazumasa Shigeta

On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
>
> > `git stash create` always passes zero for the include_untracked parameter
> > of do_create_stash(), even though that helper already supports untracked
> > and ignored files and stash push/save expose those modes as
> > -u/--include-untracked and -a/--all.
>
> There may be no lies in what the above says, but we would prefer to
> hear what the user visible implication of "passing 0" is more than
> what mechanically is happening inside a program. For example:
>
> "git stash create", "git stash push", and "git stash save" are
> commands that create a new stash entry. The latter two are also
> responsible for storing the resulting stash entry to the reflog
> of the "refs/stash" ref, but have options to control what is
> included in the stash entry. Among these options, "create" only
> supports the equivalent of "-m <message." to record in the stash
> entry. Most notably, "-u" and "-a" options are missing.
>
> > Teach create to accept the same options and pass the existing mode
> > through. Unlike push/save, create continues to only create objects: it
> > does not update refs/stash, reset the index, or clean the working tree.
>
> Sure. It is a very concise and good description of what we want to
> do.
>
> > Use parse_options() for the new options and stop parsing at the first
> > non-option message word. This keeps option-like tokens after the message
> > as message text, while leading option-like arguments now follow Git's
> > normal option parsing. In particular, unknown or malformed leading
> > options are rejected instead of silently becoming a message, short
> > options may be combined, and `--` can be used when a message itself
> > begins with a dash.
>
> Why do we need to go into such a detail in the log message? What is
> the above paragraph designed to convey to the reader? Again, it may
> not be telling any lies, but it misses the point by being inconsiderate
> to your readers. What you need to tell them is _WHY_ you chose to
> use parse_options() in such a way. What were you trying to achieve?
>
> I am guessing that something along this line ...
>
> "git stash create" traditionally treated the rest of the command
> line as a message. For example,
>
> $ git stash create adding -u option
>
> has always been a request to create a stash entry with the
> string "adding -u option" as its message. We should not make it
> trigger the "-u" (include untracked) behavior for backward
> compatibility, by using parse_options() with stop-at-the-non-option
> mode to forbid it from reordering the command line arguments.
>
> ... was what you wanted to say, but I am not sure.
>
> How much of all these verbiage was written by AI by the way? You'd
> need to spend effort to make it readable to humans.
>
> > Keep create's existing no-change behavior: detect the usual no-change
> > case before do_create_stash() refreshes and writes the index, and return
> > success without printing an object name. If do_create_stash() still
> > reports its internal "nothing to create" result, map that to create's
> > public success status.
>
> You already said that with "does not update, reset, or clean".
>
> > This follows the stash subcommand exit-status convention established by
> > 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
> > subcommands return 0 on success, negative values on failure, and status 1
> > when applying a stash results in conflicts. cmd_stash() maps negative
> > subcommand failures to 128.
>
> Again, there may not be lies in here, but if you did not make a
> breaking change to the established convention, is it worth saying?
>
> > 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> > internal include-untracked path while intentionally leaving the user
> > interface for "git stash create" unchanged. Reuse that machinery and
> > the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
> > creation path.
> >
> > Add coverage for short and long aliases, combined short options, the
> > untracked/ignored boundary including an ignored-only worktree, option
> > parsing and dash-leading messages, no-change behavior, and preservation
> > of refs/stash, the index state, and the working tree.
>
> Again, adding tests for comprehensive coverage is not something to
> boast about. Is it worth saying?
>
> Aren't -p/-S/-k/-q and pathspec support all about the creating half
> of "git stash push" that are not available to "git stash create",
> not just "-u" and "-a"? Why are we singling out only these two? It
> may be more worthwhile to explain the rationale behind such a design
> decision.
