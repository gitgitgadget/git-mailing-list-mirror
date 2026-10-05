Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9034A440F
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218293; cv=none; b=eXuddCGciAKhN80gFGrRxVdMPRFbOwq7PlldbqSH8kr7Jm+lfOhjTG42I0LX4j4NQXx8TjZ4Qf2qZR8u9tx+UdalSiW8iqHu12D1m1MdgYEzd2OvFKoARpq1yWVMMYkJUxxjJOCecUZkmidqmU3avCj/9AcalrEwi8gL2wp8rCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218293; c=relaxed/simple;
	bh=wdT9wYsKpspalOo50cizy6YtsJaabeT6TThbC/qZOn0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OokHArcc7MiKYQeWNBb5O4Th1z+DrEE80+KOMYQHXyFWgTyznJ+WNqCWshRZ9urDuWAufob/h5aRWNQOtgSfChYKEwe2lss6zZ4amY2N5bU0N6OCcudZk3v6ozJlubMK5kSadiQR+UMtXYebMFafK7LbZseYxxXRBPKKweUwWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHcwg+k8; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHcwg+k8"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so1035324f8f.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218289; x=1791823089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=140hlu3W8IKRWiLpzc83K5p8JXodx7qHwXjxTz5DB3M=;
        b=qHcwg+k89KTguFYozgN/a0j4ztcOjC6KY1ctgbPueHt14kVNya5Xg6FY2v6bNYq4GM
         fNe+pKVAOzH+w+7YRfCF/JJutEPCyfRCqbcwYNjHGfy26dj39RGhZZ1JM2VtFhwKim4C
         i1Rgybh3fQii5lewtLR0F5xRVAbAK/HvK8gO5cyZ/xmnQ1sBlXDOvQv+6RDeQLfvnQoa
         NU3hzx5Daq7g5ipnVabme90In1JoJhJlQ3JvJ8HNLZE8bWQVsJlVNrMP+v0xEDelnc6z
         ov+4BzeW2sK0iHzkeQBUOrqhDU3+6lgpTaYOBhnb5Ik/DcGMgHtsm88IlwF6+WEEWfRf
         +wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218289; x=1791823089;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=140hlu3W8IKRWiLpzc83K5p8JXodx7qHwXjxTz5DB3M=;
        b=S+bnEm/BuEb+M52wLibtR+iEYFc++ctLh8prJ3wztpSPQ0SMo3JzzrwkL36JdXq9AT
         LCSm7vbpNBNUaVXSKPeryd6xDOAewjbge0PM5sgD4B+Fqt12CRxxCQufjjpe5rQBDW7g
         /YXfV0vozqzBrrwmBiRFxModUueyk2TjY6iUJHYWQzjp6n4sEUDFySb6+YVLMcdXBQh+
         LnsApwfy+ckT6ebJnjiFMZYcYgD9fOGROHq/uLl5VxqJ5nWCrMTOUe5H1KPM22l7Oj/D
         e6vjkxRrrrrCNFw2RyJlE+Ftb+hqjdVv7d4tnk7AGSjp1PTBpEH60rd4sW7WCA05gZ1l
         HDjA==
X-Gm-Message-State: AFq9FYJUXBo9PJBON9WPPFwTdBCjYNk+5AnEC3GrTZAkWhQQVBjVNLzL
	DtUpy4mE4y33CqQhzhqT1Se9PGfr+4BUX0PinhoVosqYL2Lut1CbYEWL
X-Gm-Gg: AYBFou19uHntDFVfP8N3c2/EQ4IiYcMRxrIrvYE09oDqbmpLHI6KDryFDen1D0p5Odq
	oI3QtrNj/bfr8PBnn7JTJty0fOY4u5vP5LEYA5hzhS9dwnpOsIUhpozbV/xsP9uhyt2Owu2KU+i
	3zgyRGjRdDnefUGvESY/iuz2wNfPtYx0Zi3DW3GvK+Hsnw+MUJDpCkyH670eSoZ1XaWd/+IyyNG
	QC/UO2KiybsoSECQZg2YX6R7JnNjo7Rj4hxkxn95nEr8O3HduL99QpEKQj9dTBe+fVjkjeQBWaP
	AV4kVK5WwF/+o35Kqa8WApQKzo7rU0p0JAQUgKa1dK91ND2UQBm2AVj7QTxdQs0zalp2R4pLdHR
	PGc/HN8uMiU91Y8ZMdZJ5xscDSIDoEl7FMe1DpaVtA99+OeE5ewqmHJgWX74r3+mE4gnefk0xPF
	wqeQ+FQurFx6P4X0qPOH5twUaTfe0Bn2OkLqKQlyNnQ8uArfaK4mkeKhd+Ai4d45jg8MATe0ERm
	r544LqoLkofI+n6lSXRH+fQ0NRWSVttBOuON9W1k4r9SP82112G
X-Received: by 2002:adf:f705:0:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48b1271f6aemr12670160f8f.37.1791218288926;
        Mon, 05 Oct 2026 09:38:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab7b5sm5190601f8f.37.2026.10.05.09.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:38:08 -0700 (PDT)
Message-ID: <1d1d2c76-9981-44ec-8ea9-8f886d49a742@gmail.com>
Date: Mon, 5 Oct 2026 17:38:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
Reply-To: phillip.wood@dunelm.org.uk
To: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>,
 gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com,
 phillip.wood@dunelm.org.uk, ps@pks.im
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
 <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kazumasa

On 05/10/2026 06:55, 重田一聖 wrote:
> 
>  From that perspective, I can see three possible directions.
> 
> 1. Keep extending `stash create`.
> 
>     We could expose more of the existing `do_create_stash()`
>     functionality through `stash create`, following the conventions of
>     `stash push` for the creation-related options they have in common.
> 
>     This seems implementable, but even with
>     `PARSE_OPT_STOP_AT_NON_OPTION` it would change the handling of
>     messages that begin with an option-like argument. Those would need
>     explicit disambiguation, such as `--`.
> 
>     There is also the pathspec question. If positional arguments
>     continue to be joined to form the message, pathspecs need some other
>     way to be distinguished from that message.

It is worth thinking about which options from "push" make sense with 
"create" as the latter is really aimed at scripts rather than users. I 
can see a script wanting to stash untracked files, but it may not make 
sense to add interactive options like "--patch" which sometimes [1] 
fails to clear the stashed changes from the worktree, that would be 
problematic for scripts. I wonder if we really need pathspec support, or 
if we do is "--pathspec-from-file" sufficient? I think it is fairly 
unlikely that the message is going to start with '-' so using 
PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way forward to me. 
Adding "-m/--message" to match other commands that take a message would 
certainly make sense.

Thanks

Phillip

[1] This happens when a user edits a hunk that looks like
     @@ -1 +1,4 @@
     -A
     +a
     +b
     +c
     +d

     to

     @@ -1 +1,3 @@
     -A
     +a
     +b
     +d

     To clear the stashed changes, we apply the hunk in reverse, so we
     try to apply

     @@ -1,3 +1 @@
     -a
     -b
     -d
     +A

     to a file that looks like

     a
     b
     c
     d

     which fails because the '-' lines do not match the content of the
     file.

> 
> 2. Add a new stash subcommand for the creation functionality.
> 
>     This would leave the existing `stash create <message>` contract
>     unchanged. Because the new command would not inherit `create`'s
>     positional message grammar, its creation-related options and
>     pathspec handling could follow conventions similar to `stash push`.
> 
>     This preserves the existing `create` grammar while avoiding the need
>     to fit additional creation capabilities into it. The trade-off is
>     adding another public stash subcommand and its long-term maintenance
>     cost.
> 
> 3. Add something like `--create-only` to `git stash push`.
> 
>     This would reuse the existing `push` option grammar without adding
>     another subcommand.
> 
>     I also read the 2019 discussion around `git stash push --snapshot`.
>     One concern there was that approximately the same end state could
>     already be obtained with `git stash push && git stash apply`.
> 
>     I do not think that particular concern carries over directly here.
>     `git stash create` already stops at object creation, but its public
>     interface does not expose more of the creation capabilities already
>     available in `do_create_stash()`. There is currently no public stash
>     command that exposes those capabilities while retaining that
>     create-only boundary.
> 
>     That does not mean a similar result cannot be constructed by other
>     means. The missing piece is a public interface to the existing stash
>     creation machinery at that boundary.
> 
>     Even so, there is still the separate question of whether `push` is
>     the right place for a creation-only operation in the first place.
>     The push-specific work around `do_create_stash()` would also need to
>     be separated carefully.
> 
> All three seem substantially broader than the original `-u` / `-a`
> patch.
> 
> If this is worth pursuing further, which of these directions seems the
> most plausible? Also, is this the right thread to continue that design
> discussion, or would it be better to discuss it separately?
> 
> Thanks again for the guidance,
> Kazumasa Shigeta
> 
> On Fri, 2 Oct 2026 05:04:26 -0400, "重田一聖" <kazumasa.shigeta@kanamei.com> wrote:
>> Hi Junio,
>>
>>> we would prefer to hear what the user visible implication of
>>> "passing 0" is more than what mechanically is happening inside a
>>> program.
>>
>> The user-visible effect is that stash create cannot currently include
>> untracked or ignored files in the stash entry. If those are the only
>> changes, it creates no entry at all, while stash push and save can
>> include them with -u or -a as appropriate. I should have described that
>> difference directly instead of starting from the include_untracked
>> implementation detail.
>>
>>> ... was what you wanted to say, but I am not sure.
>>
>> Yes, exactly. I'll explain the backward-compatibility reason rather
>> than the mechanics of parse_options().
>>
>>> You already said that with "does not update, reset, or clean".
>>
>> I'll drop that paragraph.
>>
>>> if you did not make a breaking change to the established convention,
>>> is it worth saying?
>>
>> I don't think it adds anything here. I'll remove the exit-status
>> discussion from the commit message as well.
>>
>>> adding tests for comprehensive coverage is not something to boast
>>> about. Is it worth saying?
>>
>> I'll remove the test details from the commit message.
>>
>>> Why are we singling out only these two?
>>
>> I started by looking at the missing -u and -a support in create, and I
>> think that led me to focus too narrowly on those two when considering
>> the scope. I need to think more about whether this patch should remain
>> limited to those two.
>>
>> Thanks,
>> Kazumasa Shigeta
>>
>> On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
>>>
>>>> `git stash create` always passes zero for the include_untracked parameter
>>>> of do_create_stash(), even though that helper already supports untracked
>>>> and ignored files and stash push/save expose those modes as
>>>> -u/--include-untracked and -a/--all.
>>>
>>> There may be no lies in what the above says, but we would prefer to
>>> hear what the user visible implication of "passing 0" is more than
>>> what mechanically is happening inside a program. For example:
>>>
>>> "git stash create", "git stash push", and "git stash save" are
>>> commands that create a new stash entry. The latter two are also
>>> responsible for storing the resulting stash entry to the reflog
>>> of the "refs/stash" ref, but have options to control what is
>>> included in the stash entry. Among these options, "create" only
>>> supports the equivalent of "-m <message." to record in the stash
>>> entry. Most notably, "-u" and "-a" options are missing.
>>>
>>>> Teach create to accept the same options and pass the existing mode
>>>> through. Unlike push/save, create continues to only create objects: it
>>>> does not update refs/stash, reset the index, or clean the working tree.
>>>
>>> Sure. It is a very concise and good description of what we want to
>>> do.
>>>
>>>> Use parse_options() for the new options and stop parsing at the first
>>>> non-option message word. This keeps option-like tokens after the message
>>>> as message text, while leading option-like arguments now follow Git's
>>>> normal option parsing. In particular, unknown or malformed leading
>>>> options are rejected instead of silently becoming a message, short
>>>> options may be combined, and `--` can be used when a message itself
>>>> begins with a dash.
>>>
>>> Why do we need to go into such a detail in the log message? What is
>>> the above paragraph designed to convey to the reader? Again, it may
>>> not be telling any lies, but it misses the point by being inconsiderate
>>> to your readers. What you need to tell them is _WHY_ you chose to
>>> use parse_options() in such a way. What were you trying to achieve?
>>>
>>> I am guessing that something along this line ...
>>>
>>> "git stash create" traditionally treated the rest of the command
>>> line as a message. For example,
>>>
>>> $ git stash create adding -u option
>>>
>>> has always been a request to create a stash entry with the
>>> string "adding -u option" as its message. We should not make it
>>> trigger the "-u" (include untracked) behavior for backward
>>> compatibility, by using parse_options() with stop-at-the-non-option
>>> mode to forbid it from reordering the command line arguments.
>>>
>>> ... was what you wanted to say, but I am not sure.
>>>
>>> How much of all these verbiage was written by AI by the way? You'd
>>> need to spend effort to make it readable to humans.
>>>
>>>> Keep create's existing no-change behavior: detect the usual no-change
>>>> case before do_create_stash() refreshes and writes the index, and return
>>>> success without printing an object name. If do_create_stash() still
>>>> reports its internal "nothing to create" result, map that to create's
>>>> public success status.
>>>
>>> You already said that with "does not update, reset, or clean".
>>>
>>>> This follows the stash subcommand exit-status convention established by
>>>> 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
>>>> subcommands return 0 on success, negative values on failure, and status 1
>>>> when applying a stash results in conflicts. cmd_stash() maps negative
>>>> subcommand failures to 128.
>>>
>>> Again, there may not be lies in here, but if you did not make a
>>> breaking change to the established convention, is it worth saying?
>>>
>>>> 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
>>>> internal include-untracked path while intentionally leaving the user
>>>> interface for "git stash create" unchanged. Reuse that machinery and
>>>> the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
>>>> creation path.
>>>>
>>>> Add coverage for short and long aliases, combined short options, the
>>>> untracked/ignored boundary including an ignored-only worktree, option
>>>> parsing and dash-leading messages, no-change behavior, and preservation
>>>> of refs/stash, the index state, and the working tree.
>>>
>>> Again, adding tests for comprehensive coverage is not something to
>>> boast about. Is it worth saying?
>>>
>>> Aren't -p/-S/-k/-q and pathspec support all about the creating half
>>> of "git stash push" that are not available to "git stash create",
>>> not just "-u" and "-a"? Why are we singling out only these two? It
>>> may be more worthwhile to explain the rationale behind such a design
>>> decision.

