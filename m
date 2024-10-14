Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014B1BF80C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930647; cv=none; b=AI2xYwWQxOKO9zq9F3f8g/2vZhz4MD7e8gem2+610ejUESoJ8IXmtLmg6QZA4a8PTdrJeQamiL/XC4sG/qhqqG1nKbAzdvmgIEQdW1Mfkvh4xVi3SLSBxyHnvasvNwB1tF5Fx76cXlHmiR+UstYtzhuo0FuMOFLyVPtB5Ak/gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930647; c=relaxed/simple;
	bh=egoUrRfVuwzd9fD5wUidU4mCj9y72OdaPtFQMWJefVs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A1yprN/QUb5otYw7yLBhE6q6ZNNqeofNpCa6pHQaKBrWVAg+T7a8O/NMoDGnCxoswGAx7YY5honSyFA0gHYXkoZury/FGZLHflX4+N+uSof4+G3wNe5AzAP7fqJNqmaLsTEgv8oz/7G3LvvETDWvn5xiA8MeQ/9TcytzLk2hQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wei52uc6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wei52uc6"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so845710e87.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930643; x=1729535443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/aNWpUDqfHJe1ehUymly50biGcbMXhnThEPGxt9yPc=;
        b=Wei52uc6h6UINWYe2mJvw+6x5MrRu6dMsBwd2vo5a4027di7mTYhaVBgkvCOJx3JJl
         1oXYHZRL8CFzxOck2sMho0JO4x757Ir5LKwqrapOTivhbkPbd/YckXHF5h4ZGQjENcVS
         MH0Ys915zqi8ybc5ge6jG2C9eiD9A8prQgR6x4NPzv1zid9PypSI1kjck4/j/QXndYNk
         WpJixjl23GlK9zCXYqFQ82cxBqA7QCyI5MwIKNu5JpLxcd4gO+070viowu+esdjYfbMZ
         RusfuVUEyWsILpdBzb91j9pabQaOdUTs7OfsyOzAegX150nleE+z/kXSncAuurQbB5ZF
         DEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930643; x=1729535443;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/aNWpUDqfHJe1ehUymly50biGcbMXhnThEPGxt9yPc=;
        b=MGiH0QE+jqttmI76xwifL8FO5LrSGPfFaHJkTNRJRGQ4+T6CgpwpRss8xwVvy7BopT
         c5xjsBumxggBvkUiph9AKXA4XfNWCg9/mt+sBcyusOcihb34xfB3hiaO9l3D+qIW3UL+
         NQjvXkRW4CVySgqrAVabkie3dk6F67xim0dZH/qvPzWJs3KvU8m7HPA+iJNrvO8FUCm2
         TR2ckHriOU+IUnACZX9nYevEo8gb3op30Xo4+MVgcC8y0nG71J91eiprGEUsNAyAtn5a
         bYrMe/2Mo0wnzGQ7rC2gpKDPJf98T4mpLtlO71il3/ig7bvkm6v2SUtDkC663HloFEac
         Yt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+0I+vBnO29SM7FDkaFuJErJ4ufJ0M2KEg8P7fJb4LIs5+FIyVv38w42jz90TqupOAzM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOLF/BWMyE0r+V8y2nK1OuxmDDSHIHy51I9EYimpc5q4sGUS2
	5RZZ1N/aDe/YTwkWDCL8gZeAA9VPj1kG+htI27JeWM35K6a/FL3aOL01yw==
X-Google-Smtp-Source: AGHT+IFspctx8jhFbW1dpn6nY2h7WeCm53fKGp+hsd0ZQ7NAMiTojuXfPVYLwvb+XYZYvdgl7wMJnQ==
X-Received: by 2002:a05:6512:308c:b0:539:f754:ae15 with SMTP id 2adb3069b0e04-539f754b050mr2185978e87.41.1728930642851;
        Mon, 14 Oct 2024 11:30:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b42d8sm162922905e9.31.2024.10.14.11.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:30:42 -0700 (PDT)
Message-ID: <c710c45e-5090-446b-961b-ed0820523aad@gmail.com>
Date: Mon, 14 Oct 2024 19:30:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
 <CAPSxiM_+1C3upsEzqj0reMgxT5viw5K9qKQq9=eBgVSO2MK3eA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM_+1C3upsEzqj0reMgxT5viw5K9qKQq9=eBgVSO2MK3eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/10/2024 19:20, Usman Akinyemi wrote:
> On Mon, Oct 14, 2024 at 9:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 13/10/2024 00:09, Usman Akinyemi via GitGitGadget wrote:
>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>>                }
>>>                if (skip_prefix(arg, "--max-connections=", &v)) {
>>> -                     max_connections = atoi(v);
>>> -                     if (max_connections < 0)
>>> -                             max_connections = 0;            /* unlimited */
>>> +                     if (strtol_i(v, 10, &max_connections) != 0 || max_connections < 0) {
>>
>> This is a faithful translation but if the aim of this series is to
>> detect errors then I think we want to do something like
>>
>>          if (strtol_i(v, 10, &max_connections))
>>                  die(...)
> ohh, what I understand in this part of the code is intended to set
> max_connections to 0 if the value it is currently set to is invalid,
> such as containing letters or being negative. Your suggestion implies
> that we should return an error to indicate that letters are not
> accepted.

Yes - I don't think we should be accepting any old rubbish when we 
expect a number

Best Wishes

Phillip

>>          if (max_connections < 0)
>>                  max_connections = 0; /* unlimited */
>>
>>> +                             max_connections = 0;  /* unlimited */
>>> +                     }
>>>                        continue;
>>>                }
>>>                if (!strcmp(arg, "--strict-paths")) {
>>> diff --git a/imap-send.c b/imap-send.c
>>> index ec68a066877..33b74dfded7 100644
>>> --- a/imap-send.c
>>> +++ b/imap-send.c
>>> @@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>>>                return RESP_BAD;
>>>        }
>>>        if (!strcmp("UIDVALIDITY", arg)) {
>>> -             if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
>>> +             if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) != 0) {
>>
>> The original is checking for a zero return from atoi() which indicates
>> an error or that the parsed value was zero. To do that with strtol_i()
>> we need to do
>>
>>          || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity)
>>
>> The IMAP RFC[1] specifies that UIDVALIDITY should be a non-zero,
>> non-negative 32bit integer but I'm not sure we want to start change it's
>> type and using strtoul_ui here.
>>
>> [1] https://www.rfc-editor.org/rfc/rfc3501#section-2.3.1.1
>>
>>>                        fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
>>>                        return RESP_BAD;
>>>                }
>>>        } else if (!strcmp("UIDNEXT", arg)) {
>>> -             if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
>>> +             if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) != 0) {
>>
>> The comments above apply here
>>
>>>                        fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
>>>                        return RESP_BAD;
>>>                }
>>> @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>>>                for (; isspace((unsigned char)*p); p++);
>>>                fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
>>>        } else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
>>> -             if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
>>> -                 !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
>>> +             if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) != 0) ||
>>> +                     !(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) != 0)) {
>>
>> And here
>>
>>>                        fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
>>>                        return RESP_BAD;
>>>                }
>>> @@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>>>                        if (!tcmd)
>>>                                return DRV_OK;
>>>                } else {
>>> -                     tag = atoi(arg);
>>> +                     if (strtol_i(arg, 10, &tag) != 0) {
>>
>> To check for an error just use (strtol_i(arg, 10, &tag))
>>
>>> +                             fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
>>> +                             return RESP_BAD;
>>
>> This matches the error below so I assume it's good.
>>
>>> +                     }
>>>                        for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
>>>                                if (cmdp->tag == tag)
>>>                                        goto gottag;
>>> diff --git a/merge-ll.c b/merge-ll.c
>>> index 8e63071922b..2bfee0f2c6b 100644
>>> --- a/merge-ll.c
>>> +++ b/merge-ll.c
>>> @@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>>>        git_check_attr(istate, path, check);
>>>        ll_driver_name = check->items[0].value;
>>>        if (check->items[1].value) {
>>> -             marker_size = atoi(check->items[1].value);
>>> -             if (marker_size <= 0)
>>> +             if (strtol_i(check->items[1].value, 10, &marker_size) != 0 || marker_size <= 0)
>>
>> Here I think we want to return an error if we cannot parse the marker
>> size and then set the default if the marker size is <= 0 like we do for
>> the max_connections code in daemon.c above.
>>
>>>                        marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>>>        }
>>>        driver = find_ll_merge_driver(ll_driver_name);
>>> @@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
>>>                check = attr_check_initl("conflict-marker-size", NULL);
>>>        git_check_attr(istate, path, check);
>>>        if (check->items[0].value) {
>>> -             marker_size = atoi(check->items[0].value);
>>> -             if (marker_size <= 0)
>>> +             if (strtol_i(check->items[0].value, 10, &marker_size) != 0 || marker_size <= 0)
>>
>> And the same here
>>
>> Thanks for working on this, it will be a useful improvement to our
>> integer parsing. I think you've got the basic idea, it just needs a bit
>> of polish
>>
>> Phillip
>>

