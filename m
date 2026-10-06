Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9643859DE
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280686; cv=none; b=qF3AT30OvmfLvXmlWLrueXHXuiCDoeQAbrmuU6MFUTCPeEbOz2bgPdh1J7MUIu/09eyuE4PGgKSmlKEFKWVzHzb3JMxTkAN1ajCYAFHc2Xxf6tcZeiMx1I/hIEvLjsNpRuKKlPuTDYdIrOqng3xg0k8aDayLmb5YYPy/hDUMh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280686; c=relaxed/simple;
	bh=gSQsd2MueSlZZ+YFEOhsh9vOlD+VsphHzILPg3rDD7I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ggbhG8ZvoDdKQy/p0w2thAw5LyN51eML/68OlPd/3bNqT88unBFaKBiiO85EyASaaoAYpP8yBnePs++a+fi48nSrTBQIMjk7d9F40NVReJlzvMpKECuWbMAWvcKykv0GyiWp982laspCvvwfqUjzavb735fet/wKkU7wUDVJCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzjo1TV8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzjo1TV8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso17533745e9.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791280683; x=1791885483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+fZrUhXRDJ3xUfQA4hhGWj+GbGuWqAxL65lRpq8a6Bw=;
        b=lzjo1TV8HxM3HJHLSY4k/qElVL4mBtE2QjHwODmV9VGetj+CgW/9a48jJF6m/8AY2M
         WTZ6Nl58VhXGxehtj35zMEZg95TGEmt8kxBZgtO0JfPAli9fSmPfo2UzpPdzSw+oNYLn
         vFx2ycHs5PWzh+gbOiNDC9NP1h6F8fD0p5B0+ep0PzV2AT8yNl4E0qK/MwJmt/Hp64Gx
         UZ8YwDTV0BkHH9MPI9EQa2Asv5Nt/YMwvEADvGzoXUnyUQPrDIPB/3f6GWdAysNKLs6v
         HE/PcrJzVB/pJLldoOn+m98G7GhXMQsnw2A9+J0IMQPWurv7tOHAepXZgwvbMVuB3rNk
         Y5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280683; x=1791885483;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fZrUhXRDJ3xUfQA4hhGWj+GbGuWqAxL65lRpq8a6Bw=;
        b=tnJ8rZeKm+rSzpG/R/njMQ84c4AEUC0COnHl5RfzqnEhyPSrN/hq37iZtTaqYitSt4
         9DModPJY7o0rqCErCujwICLjHtmPlocXW+XAzXc18kkKEVy8lx8YWx1ijAY/4S1ikCZx
         rC+paVQP0a6n4vUbIP1AZsoA/MxeLivg+wuIyvWmwCgLzYHsLaXoqSk70pTVDX5Mh+rz
         HYOp6Hho7lWGG7oVuUhGYJDJOqVBXg6uhn+1ZkoVa+lLkPEQSfpmQQleHXCvdm/IOBMy
         CROnghiACGr4uAsimx4m2hMO0AnbiOw0DFPj7hPjsG56SQ+IcQ89suoKWP8+u3pJ78Mi
         NyDg==
X-Gm-Message-State: AFuF++mUSfQOOCtElNNGPniS3YPwjKQb9si2POb7OoA2GeoM8WHZQaVY
	JD8YcYvj9xJ5iEdqEwezRnIxAw2eH0lW/Gv+MOigDGz8qNFzOzi9nt+BT+pErr0G
X-Gm-Gg: AYBFou2K2oAO1LdsJl8fa1bunRsNZnVcLlDws5lxrxirKfbLys+gi8MOdDN6sMvJePw
	KktDFKgLED3/bhGu+D3fMLFr7qB5tpyMJ3dzENc2jWlEIsMMEzhRUIFAqQuIlxJn81HjuJSGBTn
	cRnqPAZWpPEy2WwtCjjDnRTp0NftPMLlKNn29WyGb0QddSnKogVxG43YSAiIjeuH9RmswvDYdba
	LxqO/0L0ge6dZKRNbRJjkLTtxYImfmubDRbxRzc9xDIaDUvAhfMFafyU9pkix1eLXz0HvNbuSR/
	n1rpJu8/MJ9g2axf2MyvpSoBkAQsHslUAVbRU1o6yuKUjwrWoIIgTF68Je8JjXMPoypd8GaBHHY
	mpncQksVubFBaCYmJ61K+goGN7Xftc6ihKuyLOdCMsMfNVZj+I8kZ+d63WWuHjlx9M2s79e1I/X
	BHTbY+7gC9/RC5qiiQSsw1ykyNKQCQhtsDDI+22uGRdxR0vqL3lkk0oB4dNSn3IAzpP/AuTkVww
	qGiNd3Cr4Q2D3Jm9/WFIgTBVeAN5O0qNTRSg8IVp6uqZOY4viwH
X-Received: by 2002:a05:600c:4e91:b0:4a1:7811:6cc4 with SMTP id 5b1f17b1804b1-4a178116ce2mr44735195e9.34.1791280682527;
        Tue, 06 Oct 2026 02:58:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c33091sm61610995e9.4.2026.10.06.02.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:58:02 -0700 (PDT)
Message-ID: <7af72eb3-9a61-43c8-a9c0-faaff1817949@gmail.com>
Date: Tue, 6 Oct 2026 10:57:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>,
 gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com,
 phillip.wood@dunelm.org.uk, ps@pks.im
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
 <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
 <1d1d2c76-9981-44ec-8ea9-8f886d49a742@gmail.com>
 <CANUHOw2OMHFJLKWkDkyDm7WtLDcYxMnNfkD8uV96GZdWBS53RA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANUHOw2OMHFJLKWkDkyDm7WtLDcYxMnNfkD8uV96GZdWBS53RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kazumasa

On 06/10/2026 10:25, 重田一聖 wrote:
> Hi Phillip,
> 
> Thanks for the two patches removing the duplicate changes checks. I'll
> wait for those to settle before revisiting the exit-status and no-change
> handling.
> 
>> I can see a script wanting to stash untracked files, but it may not make
>> sense to add interactive options like "--patch" which sometimes [1]
>> fails to clear the stashed changes from the worktree, that would be
>> problematic for scripts.
> 
> For `stash create`, I don't think the issue in [1] should apply, since
> it does not remove the selected changes from the worktree. 

Oh, good point, I'd completely forgotten that when I was writing 
yesterday. If the script wants to remove the changes from the worktree 
it still faces the same problem. As "git stash create" does not remove 
the stashed changes from the worktree it would probably be simplest to 
not support "--patch" or "pathspecs" so that the script can easily 
remove the stashed changes with "git read-tree -m -u HEAD" (together 
with "git clean" if it is stashing untracked files). If someone has a 
use for pathspec support we can think about adding it but "git stash 
create" has existed for 20 years without anyone requesting it.

Thanks

Phillip
> I still need
> to think about whether `--patch` is worth supporting for `stash create`,
> even though it is primarily aimed at scripts.
> 
>> I wonder if we really need pathspec support, or if we do is
>> "--pathspec-from-file" sufficient?
> 
> I agree that positional pathspec support probably isn't necessary.
> Since `create` is primarily aimed at scripts, `--pathspec-from-file`
> seems sufficient. It also avoids giving positional arguments another
> meaning while we are already dealing with the message ambiguity.
> 
>> I think it is fairly unlikely that the message is going to start with
>> '-' so using PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way
>> forward to me. Adding "-m/--message" to match other commands that take
>> a message would certainly make sense.
> 
> Thanks for confirming those points.
> 
> Thanks,
> Kazumasa
> 
> On Mon, 5 Oct 2026 17:38:07 +0100, Phillip Wood
> <phillip.wood123@gmail.com> wrote:
>> Hi Kazumasa
>>
>> On 05/10/2026 06:55, 重田一聖 wrote:
>>>
>>>  From that perspective, I can see three possible directions.
>>>
>>> 1. Keep extending `stash create`.
>>>
>>> We could expose more of the existing `do_create_stash()`
>>> functionality through `stash create`, following the conventions of
>>> `stash push` for the creation-related options they have in common.
>>>
>>> This seems implementable, but even with
>>> `PARSE_OPT_STOP_AT_NON_OPTION` it would change the handling of
>>> messages that begin with an option-like argument. Those would need
>>> explicit disambiguation, such as `--`.
>>>
>>> There is also the pathspec question. If positional arguments
>>> continue to be joined to form the message, pathspecs need some other
>>> way to be distinguished from that message.
>>
>> It is worth thinking about which options from "push" make sense with
>> "create" as the latter is really aimed at scripts rather than users. I
>> can see a script wanting to stash untracked files, but it may not make
>> sense to add interactive options like "--patch" which sometimes [1]
>> fails to clear the stashed changes from the worktree, that would be
>> problematic for scripts. I wonder if we really need pathspec support, or
>> if we do is "--pathspec-from-file" sufficient? I think it is fairly
>> unlikely that the message is going to start with '-' so using
>> PARSE_OPT_STOP_AT_NON_OPTION seems like a reasonable way forward to me.
>> Adding "-m/--message" to match other commands that take a message would
>> certainly make sense.
>>
>> Thanks
>>
>> Phillip
>>
>> [1] This happens when a user edits a hunk that looks like
>> @@ -1 +1,4 @@
>> -A
>> +a
>> +b
>> +c
>> +d
>>
>> to
>>
>> @@ -1 +1,3 @@
>> -A
>> +a
>> +b
>> +d
>>
>> To clear the stashed changes, we apply the hunk in reverse, so we
>> try to apply
>>
>> @@ -1,3 +1 @@
>> -a
>> -b
>> -d
>> +A
>>
>> to a file that looks like
>>
>> a
>> b
>> c
>> d
>>
>> which fails because the '-' lines do not match the content of the
>> file.
>>
>>>
>>> 2. Add a new stash subcommand for the creation functionality.
>>>
>>> This would leave the existing `stash create <message>` contract
>>> unchanged. Because the new command would not inherit `create`'s
>>> positional message grammar, its creation-related options and
>>> pathspec handling could follow conventions similar to `stash push`.
>>>
>>> This preserves the existing `create` grammar while avoiding the need
>>> to fit additional creation capabilities into it. The trade-off is
>>> adding another public stash subcommand and its long-term maintenance
>>> cost.
>>>
>>> 3. Add something like `--create-only` to `git stash push`.
>>>
>>> This would reuse the existing `push` option grammar without adding
>>> another subcommand.
>>>
>>> I also read the 2019 discussion around `git stash push --snapshot`.
>>> One concern there was that approximately the same end state could
>>> already be obtained with `git stash push && git stash apply`.
>>>
>>> I do not think that particular concern carries over directly here.
>>> `git stash create` already stops at object creation, but its public
>>> interface does not expose more of the creation capabilities already
>>> available in `do_create_stash()`. There is currently no public stash
>>> command that exposes those capabilities while retaining that
>>> create-only boundary.
>>>
>>> That does not mean a similar result cannot be constructed by other
>>> means. The missing piece is a public interface to the existing stash
>>> creation machinery at that boundary.
>>>
>>> Even so, there is still the separate question of whether `push` is
>>> the right place for a creation-only operation in the first place.
>>> The push-specific work around `do_create_stash()` would also need to
>>> be separated carefully.
>>>
>>> All three seem substantially broader than the original `-u` / `-a`
>>> patch.
>>>
>>> If this is worth pursuing further, which of these directions seems the
>>> most plausible? Also, is this the right thread to continue that design
>>> discussion, or would it be better to discuss it separately?
>>>
>>> Thanks again for the guidance,
>>> Kazumasa Shigeta
>>>
>>> On Fri, 2 Oct 2026 05:04:26 -0400, "重田一聖" <kazumasa.shigeta@kanamei.com> wrote:
>>>> Hi Junio,
>>>>
>>>>> we would prefer to hear what the user visible implication of
>>>>> "passing 0" is more than what mechanically is happening inside a
>>>>> program.
>>>>
>>>> The user-visible effect is that stash create cannot currently include
>>>> untracked or ignored files in the stash entry. If those are the only
>>>> changes, it creates no entry at all, while stash push and save can
>>>> include them with -u or -a as appropriate. I should have described that
>>>> difference directly instead of starting from the include_untracked
>>>> implementation detail.
>>>>
>>>>> ... was what you wanted to say, but I am not sure.
>>>>
>>>> Yes, exactly. I'll explain the backward-compatibility reason rather
>>>> than the mechanics of parse_options().
>>>>
>>>>> You already said that with "does not update, reset, or clean".
>>>>
>>>> I'll drop that paragraph.
>>>>
>>>>> if you did not make a breaking change to the established convention,
>>>>> is it worth saying?
>>>>
>>>> I don't think it adds anything here. I'll remove the exit-status
>>>> discussion from the commit message as well.
>>>>
>>>>> adding tests for comprehensive coverage is not something to boast
>>>>> about. Is it worth saying?
>>>>
>>>> I'll remove the test details from the commit message.
>>>>
>>>>> Why are we singling out only these two?
>>>>
>>>> I started by looking at the missing -u and -a support in create, and I
>>>> think that led me to focus too narrowly on those two when considering
>>>> the scope. I need to think more about whether this patch should remain
>>>> limited to those two.
>>>>
>>>> Thanks,
>>>> Kazumasa Shigeta
>>>>
>>>> On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
>>>>>
>>>>>> `git stash create` always passes zero for the include_untracked parameter
>>>>>> of do_create_stash(), even though that helper already supports untracked
>>>>>> and ignored files and stash push/save expose those modes as
>>>>>> -u/--include-untracked and -a/--all.
>>>>>
>>>>> There may be no lies in what the above says, but we would prefer to
>>>>> hear what the user visible implication of "passing 0" is more than
>>>>> what mechanically is happening inside a program. For example:
>>>>>
>>>>> "git stash create", "git stash push", and "git stash save" are
>>>>> commands that create a new stash entry. The latter two are also
>>>>> responsible for storing the resulting stash entry to the reflog
>>>>> of the "refs/stash" ref, but have options to control what is
>>>>> included in the stash entry. Among these options, "create" only
>>>>> supports the equivalent of "-m <message." to record in the stash
>>>>> entry. Most notably, "-u" and "-a" options are missing.
>>>>>
>>>>>> Teach create to accept the same options and pass the existing mode
>>>>>> through. Unlike push/save, create continues to only create objects: it
>>>>>> does not update refs/stash, reset the index, or clean the working tree.
>>>>>
>>>>> Sure. It is a very concise and good description of what we want to
>>>>> do.
>>>>>
>>>>>> Use parse_options() for the new options and stop parsing at the first
>>>>>> non-option message word. This keeps option-like tokens after the message
>>>>>> as message text, while leading option-like arguments now follow Git's
>>>>>> normal option parsing. In particular, unknown or malformed leading
>>>>>> options are rejected instead of silently becoming a message, short
>>>>>> options may be combined, and `--` can be used when a message itself
>>>>>> begins with a dash.
>>>>>
>>>>> Why do we need to go into such a detail in the log message? What is
>>>>> the above paragraph designed to convey to the reader? Again, it may
>>>>> not be telling any lies, but it misses the point by being inconsiderate
>>>>> to your readers. What you need to tell them is _WHY_ you chose to
>>>>> use parse_options() in such a way. What were you trying to achieve?
>>>>>
>>>>> I am guessing that something along this line ...
>>>>>
>>>>> "git stash create" traditionally treated the rest of the command
>>>>> line as a message. For example,
>>>>>
>>>>> $ git stash create adding -u option
>>>>>
>>>>> has always been a request to create a stash entry with the
>>>>> string "adding -u option" as its message. We should not make it
>>>>> trigger the "-u" (include untracked) behavior for backward
>>>>> compatibility, by using parse_options() with stop-at-the-non-option
>>>>> mode to forbid it from reordering the command line arguments.
>>>>>
>>>>> ... was what you wanted to say, but I am not sure.
>>>>>
>>>>> How much of all these verbiage was written by AI by the way? You'd
>>>>> need to spend effort to make it readable to humans.
>>>>>
>>>>>> Keep create's existing no-change behavior: detect the usual no-change
>>>>>> case before do_create_stash() refreshes and writes the index, and return
>>>>>> success without printing an object name. If do_create_stash() still
>>>>>> reports its internal "nothing to create" result, map that to create's
>>>>>> public success status.
>>>>>
>>>>> You already said that with "does not update, reset, or clean".
>>>>>
>>>>>> This follows the stash subcommand exit-status convention established by
>>>>>> 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
>>>>>> subcommands return 0 on success, negative values on failure, and status 1
>>>>>> when applying a stash results in conflicts. cmd_stash() maps negative
>>>>>> subcommand failures to 128.
>>>>>
>>>>> Again, there may not be lies in here, but if you did not make a
>>>>> breaking change to the established convention, is it worth saying?
>>>>>
>>>>>> 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
>>>>>> internal include-untracked path while intentionally leaving the user
>>>>>> interface for "git stash create" unchanged. Reuse that machinery and
>>>>>> the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
>>>>>> creation path.
>>>>>>
>>>>>> Add coverage for short and long aliases, combined short options, the
>>>>>> untracked/ignored boundary including an ignored-only worktree, option
>>>>>> parsing and dash-leading messages, no-change behavior, and preservation
>>>>>> of refs/stash, the index state, and the working tree.
>>>>>
>>>>> Again, adding tests for comprehensive coverage is not something to
>>>>> boast about. Is it worth saying?
>>>>>
>>>>> Aren't -p/-S/-k/-q and pathspec support all about the creating half
>>>>> of "git stash push" that are not available to "git stash create",
>>>>> not just "-u" and "-a"? Why are we singling out only these two? It
>>>>> may be more worthwhile to explain the rationale behind such a design
>>>>> decision.

