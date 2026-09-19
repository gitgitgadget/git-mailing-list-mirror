Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBE2EEE76
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789831427; cv=none; b=AAY0Fecc2lAKiFMtyhSnpceKYAtdXjUxCtgGIqTSRSwKjtowsA0jIudbWODnwNq+Tnix2enoMhnzZz0UUeLwV2Hb29QnFumiGn+7RB+83VjsXrnLYg3amu12LeHHLVcAto+RypQ3v6c8Bh59YKdnPjk8d/YsswTo8prf7pPg0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789831427; c=relaxed/simple;
	bh=CuF+4KlzaeZSMfH4JOKrSJkmk9nQowji1AIK4kgqqn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuoIUdMLkIzMGuysfTQMoZOTAiCtGnSyYo2ATfE6DDI2zmm31Kp2sEVMpzleRK+6xg3F9Ehs9AVcf7lUqD85RwutNqFj4ALrEaxdMhelFeceY/hg3khAYMWMJIsW/YvJ1dnKliOldg1KBmYJhVdCN3eOxeAYvoYcy7Jx6BhIXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTpM/f0o; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTpM/f0o"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso11856085e9.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789831424; x=1790436224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PA+z02DmmZUzoqKhSVrc1opPP3yHeZdvsIfOgHLxeW8=;
        b=bTpM/f0o2eSDNlbRSvo6i1d1FXrCdy2HwbHORAdvTUPtltv410KDpQ9uVoHvf2bz6h
         WVCpUzBqhQ8MJs5prFi9DvCXWjMZOw/jGf+ulNBvTpuNIfCeK7thB3hDyQ1WiNZw+80o
         aUAVb4k3g09h/Qyjxq6zfKdIA7tg/yXT6nG6GK2Bl4Xe+ENF0bGZsHkD2mb80QmA3Dj3
         qWfyVeuegE/+Z6C+i7g12DkEmQIudUYkUF332gxudarVrLItV2DJASNEVsZD/XNl2yMF
         o4LV+RoFDWIj4JgSQi7FTNjvLtD30CtS+Vkz5Gv+Ipa6eS3stGOFBCorR34cbIHdWbi9
         BQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789831424; x=1790436224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PA+z02DmmZUzoqKhSVrc1opPP3yHeZdvsIfOgHLxeW8=;
        b=SMTU7oIMJbmWx0HWE4HiCxxsuHrHq0a5I8WWR+ZUAgvOZs/PdSb+6y1AjRo0P5QXUd
         qNieCwexFClewXWa/JBD2L9SucyNCuLsQ+9DKK01oCh/tT1feSarxtuN23pGWUZaa4Wq
         tbjZaabgUJYPmEcTNhnXuRFloNTEPvhfpJ708Ro9Zh5q4ViDxsBRzTiye+D72EGNpeLi
         fGgjGP7s+d2NjhcEEQFYJGvE6yC8jh7Ir+yGJoyIc/2spjYIKnlH7h6cswwX3vhlSA/2
         Ov4PC7Tcl4yuXgszOdFwBVOVYdmssgRzIfmjPw3SdYqXBzr4kAo0NNvAbwLaGcbmwmgK
         CULQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVUiGN8Xm0inRX36bIUaMbF8Pr2blxIkOWzDXGlCnrWWsbhOdlvgHtjJrEEijPdeV2ybo=@vger.kernel.org
X-Gm-Message-State: AFuF++nphI6ZJsnHZsH+2dJtUIqXFcHGx39QHYce/cLtLERtxk4bbnoD
	ooZyUPjWn1ylNiN43oElSC2DaL4cQxO5qVWbWEcEhoF6j/kspJss7fN1GqgfqEW2
X-Gm-Gg: AYBFou0ahLt8RwIaT4LnrhtjbezrsveI1ZmANm9bNinfDnv7TAZqlzkRYITEqovOjYa
	sF3pD4tBoFt+y+Mn5GZMXfDjOJ15CdFxzelcTA5IBLV/rIpJCxhkQsjAhsQymiQWSAsg66/o/ek
	+LC8brwKwtb3KyErk/CbtZyhx+pm4sKf10DJFt5LL05b9fCWL6Aj3YDA8QenoLKEFqMm4B2Lrpt
	qPXVP0Zt+kpUT9leZXmOKB5x2neHkfTOYyu/lu19FY1pbedeNvBwySZUnijm3KfkIZR+5LXWEj/
	G6sXDfwPhiI8SzINgJ7lNa6wKzp+MZoMans961we7T84Drh1uTt3kINRjBFujOpCyF2HRtviOup
	Q8ZlJPd5iFJasM+Rk0NGDPOq3ZZTyBkKsCrNY07iWgKdS6XczV28FQDm6NV757vqxmQqE9MNxpU
	apu7XXkeKJRf6YWxkBEitJHug2+bJZFJudOBM3NUUObo4fzVTHR7BA6jgNx88FEHrdZve5jQ1T4
	NW1rkI50xo3zfm3jIGsRl2OORf+l46hQEBGZL0nZYOJleFN1x4lF7/0xie+/r+2
X-Received: by 2002:a05:600c:154b:b0:49c:fa21:1c89 with SMTP id 5b1f17b1804b1-49fc5748e61mr84958715e9.30.1789831423595;
        Sat, 19 Sep 2026 08:23:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm315812045e9.4.2026.09.19.08.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 08:23:43 -0700 (PDT)
Message-ID: <9adb1d94-c72b-43f2-aa02-004e3e476eb1@gmail.com>
Date: Sat, 19 Sep 2026 16:23:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] [RFC] Create a 'safe' strbuf API
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net, newren@gmail.com,
 Derrick Stolee <stolee@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stolee

On 18/09/2026 14:02, Derrick Stolee via GitGitGadget wrote:
> 
> The goal of this short RFC, such as it is, is to get some feedback on
> whether this is a worthwhile direction to pursue or if I should abandon this
> idea of having this definition of "safe" for some APIs. This decision may
> also determine if we should abandon ds/trace2-tolerate-failed-timestamps or
> leave the existing behavior as-is.

I think having APIs that return errors rather than dying on allocation 
failures or overflow is reasonable. The xdiff and reftable code already 
have something similar. I'm not sure "safe" is a good description for 
those APIs though as it does not describe how they differ from the 
existing APIs. Instead of talking about safety I'd rather the 
documentation talked about returning errors on failure and the function 
naming somehow reflected that.

For the strbuf API having to check for failure on every function call 
does not sound attractive, I think having a sticky error bit like the 
stdio functions so that one can build a string and check there have been 
no failures once just before using it would be a nicer approach.

> I had discussed earlier that what we'd really need is a guarantee that we
> can't transitively reach die() from any "safe" API. The eventual goal would
> be to include json-writer.c and the trace2 code files into the "safe"
> bucket, but for now I'm making sure that strbuf-safe.c satisfies this CodeQL
> query:

I don't know enough about CodeQL to comment on this beyond noting that 
the implementation of sstrbuf_grow() in patch 4 contains a call to 
st_add3() which dies on overflow (it should be using st_add_overflows() 
instead) so something isn't right with these checks.

Thanks

Phillip

> import cpp
> 
> class SafeFunction extends Function {
>    SafeFunction() {
>      getFile().getRelativePath() = "strbuf-safe.c"
>    }
> }
> 
> predicate directlyCalls(Function caller, Function callee) {
>    exists(FunctionCall call |
>      call.getEnclosingFunction() = caller and
>      call.getTarget() = callee
>    )
> }
> 
> 
> from SafeFunction source, Function sink
> where
>    (sink.getName() = "die" or sink.getName() = "exit") and
>    directlyCalls+(source, sink)
> select source,
>    "This safe function can transitively reach " + sink.getName() + "()."
> 
> 
> If we went with this approach, then I'd explore how to make this a
> build-time requirement during CI.
> 
> In regards to the structure of this RFC:
> 
>   1. The safe API needs the same structures, but shouldn't import more than
>      necessary. Some movement of structs across headers is done before
>      anything else.
>   2. In order to make even the smallest safe method work, we first need to
>      figure out how to handle GIT_ALLOC_LIMIT, which is an undocumented
>      environment variable. I explain that I think this should be
>      GIT_TEST_ALLOC_LIMIT, but maybe the ship has sailed due to Hyrum's Law.
>      So I make an effort to document it but also to initialize it proactively
>      within the process startup instead of implicitly at the lowest level.
>      This allows us to avoid a die() when checking the environment variable.
>   3. Thus, we get a 'safe' version of a memory allocation size check. This is
>      our first example of creating a safe version that is then called by the
>      non-safe version to prevent repeated code.
>   4. We can then create our first safe strbuf method: sstrbuf_grow(). I
>      explain why I prepend with s instead of appending _gently in the commit.
>   5. Some trace2 code implicitly depends on strbuf.h through json-writer.h,
>      so we drop that in favor of strbuf-safe.h to keep the dependence on the
>      full struct definition without forever having the non-safe methods
>      reachable. The goal eventually is to drop the strbuf.h include from
>      json-writer.c, but that isn't accomplished in this RFC.
>   6. Finally, create safe init and release methods and use them in
>      json-writer.c. This does show some of the "transition risk" where some
>      json-writer methods become "safe" but I haven't done the hard work to
>      make sure the callers of those methods respond to the new return values.
>      If we proceed with the RFC, then I'd split this into a creation of the
>      safe strbuf methods and then the refactoring required to respond
>      correctly to errors in json-writer.c
> 
> Thanks in advance for your thoughts!
> 
> Thanks, -Stolee
> 
> Derrick Stolee (6):
>    strbuf: add header for 'safe' API
>    wrapper: initialize GIT_ALLOC_LIMIT proactively
>    wrapper: create safe_memory_limit_check()
>    strbuf-safe: add sstrbuf_grow()
>    json-writer: include strbuf-safe.h
>    strbuf-safe: add init and release methods
> 
>   Documentation/git.adoc |  6 +++
>   Makefile               |  1 +
>   common-init.c          |  2 +
>   environment.h          |  1 +
>   json-writer.c          | 32 ++++++++------
>   json-writer.h          |  7 +--
>   meson.build            |  1 +
>   strbuf-safe.c          | 52 ++++++++++++++++++++++
>   strbuf-safe.h          | 97 ++++++++++++++++++++++++++++++++++++++++++
>   strbuf.c               | 23 ++++------
>   strbuf.h               | 74 ++------------------------------
>   trace2/tr2_tgt_event.c |  1 +
>   trace2/tr2_tgt_perf.c  |  1 +
>   wrapper.c              | 67 ++++++++++++++++++++---------
>   wrapper.h              |  9 ++++
>   15 files changed, 253 insertions(+), 121 deletions(-)
>   create mode 100644 strbuf-safe.c
>   create mode 100644 strbuf-safe.h
> 
> 
> base-commit: a80c36bda0e5aff1c9945d08f43079a6aa85ccad
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2230%2Fderrickstolee%2Fstrbuf-safe-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2230/derrickstolee/strbuf-safe-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2230

