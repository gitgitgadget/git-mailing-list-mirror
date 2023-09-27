Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024CDE7F14E
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjI0N3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjI0N3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 09:29:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E2F5
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:29:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c62d61dc96so31600895ad.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695821352; x=1696426152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6V8B1wCFeFxLT9M3/vMsfnWvCsHwYRCx5+uFgMNoE=;
        b=kkOGDqTRPKezrPC7cl63PbuagK0p6xNxHEE6aIjuDWNZ3Cv6nfhebDpJ/Xx+ToSoVz
         y7g0kR8VDFDDRu+gyDK3xu1RkvumQbjQwXK6FvVu8UF8EAFMr2S9Rd/uEI4BsgiAb5Ri
         OZ4a4HOLFvKblu2SW7jgmyOv3RPbpNV6GxaQ5cs7CxCZ/CbjXHgjy7skKlHySsFr2HMi
         qlmZUCMOi8TUOVhrUNPqWOyu7mGijtqNoR8sl0VuUooU97UuDCmamo/3LnQ2ZmR68Jr1
         ZgPQAdfACZi8+Bsq0IaoMCG+hSZ1jpcTG606gXpZbAsZwLZkQ1Ukpkb9p+DobDK8fNnm
         Z6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821352; x=1696426152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6V8B1wCFeFxLT9M3/vMsfnWvCsHwYRCx5+uFgMNoE=;
        b=VlRC18UXvn1jI1yAaxSDodVPb5fDJF5QJh+xw3QnutuuYMJjThXDhoaPjHNOrQ7ucn
         qI+4bd3AwBc8N1Z7xOaKtDEWwMMmXRNRPwhFB9xj2mR8Tj9FMqnholPI9ryx2jO3JFe6
         7pVCQHjHHEHM/YQDpvKksFV9GJfScJ444yvRhp8ckcCVc0EH25hTMUusMsnu46tv4J11
         Et8udSatf/5A4unzt9w3UOxbLC/UdZALPzqLIKw7d+mdMSe8E8xy0dY8XbwzPghqxpUs
         ornR41HwBjXO831EbnLgiYjqoe5Nijs0T5Z7lzii9HGSHlsG3UoWxYoFxfkdLqTPufBp
         Ub+A==
X-Gm-Message-State: AOJu0YyR6Vi6g6H2b9NVOWRakerZuBKveuXIWMKOKuwPSe42GilvXP6g
        SpEvSXwJE1/4daCZnUG/3OsRRBgKj43ESQ==
X-Google-Smtp-Source: AGHT+IEI9xOd2VLY9u1hWOsxmahcxcHsYB1+9kTuPG0m0iKHuO58UUi07wZqzxvWfo9tWzYw655uTw==
X-Received: by 2002:a17:902:704c:b0:1c2:eac:b99 with SMTP id h12-20020a170902704c00b001c20eac0b99mr1500278plt.40.1695821352111;
        Wed, 27 Sep 2023 06:29:12 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001c5dea67c26sm12080742pll.233.2023.09.27.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 06:29:11 -0700 (PDT)
Message-ID: <58c0dd77-200f-45d2-837b-89b611ec711b@gmail.com>
Date:   Wed, 27 Sep 2023 20:29:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-retry tool or git.retry config (built-in implementation)?
Content-Language: en-US
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Isaac To <isaac.chun.to@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <ZRMLNyHXoWOj6K-l@bilena> <ZRNv-n_VlIDPX0oi@debian.me>
 <ZRQjKYBLwNg42xAd@bilena>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZRQjKYBLwNg42xAd@bilena>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/2023 19:42, Yaroslav Halchenko wrote:
> 
> On Wed, 27 Sep 2023, Bagas Sanjaya wrote:
> 
>> On Tue, Sep 26, 2023 at 12:47:51PM -0400, Yaroslav Halchenko wrote:
>>> Dear Git Gurus,
> 
>>> In DataLad (https://datalad.org) we are doing lots of automated cloning,
>>> fetching etc as part of our CI etc jobs.  Once in a while git operations
>>> fail [see e.g. 1], and beg us to retry but we need to know when to
>>> do so, and not do it upon every failed git invocation since some
>>> failures could be legit (repository is gone). While looking how others
>>> solve it we found
>>> https://stackoverflow.com/questions/35014012/git-retry-if-http-request-failed
>>> which pointed to tools like git-retry and later part of
>>> https://chromium.googlesource.com/infra/infra/+/HEAD/go/src/infra/tools/git/retry_regexp.go
>>> which serve as a collection of regexes to be on lookout for to retry.
> 
>>> Would that be the "best" strategy currently?  
> 
>> Looking at the actual git_retry.py script [1], it really just wraps
>> actual Git commands. IMO, git-retry(1) shell script as you mentioned
>> only calls the python version, which adds another level of indirection
>> (why not doing it in pure shell?).
> 
> My guess would be that it is just easier to code in Python usually for
> such cases with a "registry" of hits etc.  But why not just to strip .py
> from python script which has shebang already and not require bash
> wrapper at all? ;)
> 
>> AFAIK, to solve the retrying problem, we need to have a way to tell
>> transport backend (curl/ssh) to resume transfer from the faulty point.
> 
> some times it seems not even getting connected (https) entirely and that
> (?) leading to error in the caller above, e.g. from
> https://github.com/datalad/datalad/issues/7485#issuecomment-1735619755
> 
> error: Failed to connect to datasets-tests.datalad.org port 443 after 8291 ms: Couldn't connect to server (curl_result = 28, http_code = 0, sha1 = 3980af8de56946a10ff5c48879e5d6025965d936)\nerror: Unable to find 3980af8de56946a10ff5c48879e5d6025965d936 under ...
> 

Then the question is how can the server cache generated on-the-fly bundles
in hope that future clients can resume the transfer.
 
> 
>>> As regex matching might eventually break whenever `git` changes
>>> anything in the output messages, I wondered if there could be a more
>>> robust internal implementation in git itself?  Similarly git-annex has
>>> annex.retry config setting which sets the count of retries for
>>> "retriable" operations.  
> 
>> Do you use porcelain interfaces instead of plumbing ones?
> 
> I would say -- a "mix". 
> 

Junio, what do you think of above ideas from Yaroslav?

-- 
An old man doll... just what I always wanted! - Clara

