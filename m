Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33222C7EE2F
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjFBN3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjFBN3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:29:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A5F2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:29:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30af56f5f52so1934013f8f.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685712550; x=1688304550;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmRV8K8QqwZ5qBU04sUxgJPgMNw9pKfTp9+YfKsyUZU=;
        b=AxPf1uUnkAY00auueOSui2Ngmu4yG5LVB7L9ccac3qnZQivGl+dG3P8FClcBY3vDSv
         rKRpSlRWrt9xE+41/4a9CeJwUFWEKio6caO0Zt93v+V2+KHF3dvFaMI2t8CBYkPVCQqm
         BitotwUX4dPBZQwTa/bFqt12Lze1rSl8ibMf93SpYMRQLb91TfFS2x24vRyhCTwP6UJn
         TwgX5OY0s5EsZt4clVREgOeJWkQ6SvTvzz9N7sYBBjEG9KXx4ZPBl/FpKWDtBtSc96F/
         lO5f1BYJbnyFeNt1TKYu+kk2iEU1g/ruB8rfjC6Nw2nhygzg/AoAJRuD7KGMMA3hsdfe
         KhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712550; x=1688304550;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmRV8K8QqwZ5qBU04sUxgJPgMNw9pKfTp9+YfKsyUZU=;
        b=ZFzfT4D/peyL1/3LEl7N/bT3GRBzPkrP20qPBmvSXUVWT0Zi29OW2MuEnc4rDCop6/
         GLZ0nlJauvoCKCW7AQUrTp6FsxsmLVkr6BSmh9H8a+n9qEsYswa0Inazf6ozDBwsW1Uq
         RRDjs/WV4xDAeoSa39J41M+GVF7IcJyXrrSJwFaJZRixXAu8rEnOZ5STzFVzF59HblXh
         peCutY6K0eOkPs4GzYlMS1QhjqajImoQADJ3XFkAC0wL5aq7YwJICfqZfyUQh04zcN7o
         3RctayAHA0jU+UVIzHWgB3EtgJvabk915S7p3RL3DkMR3KgjgGaRspQpqhCnM2WvpZ4n
         AEaw==
X-Gm-Message-State: AC+VfDx0V9z88e5tqZcRdTqOBE8NZJe7rupNV8ksGslzDPylqmVpl7ko
        3fNosz4g1WcCxZ7eD7S1wKK5zdcVBko=
X-Google-Smtp-Source: ACHHUZ4nEkjaINQEZlVto3qbu/sGSdWh57xPAY1SJhYlmURPDOWlO5VPhXQfVbyjqLLS8/1J3QAknw==
X-Received: by 2002:adf:f9cd:0:b0:309:4289:91c9 with SMTP id w13-20020adff9cd000000b00309428991c9mr8121wrr.17.1685712549727;
        Fri, 02 Jun 2023 06:29:09 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d5144000000b003062b2c5255sm1716209wrt.40.2023.06.02.06.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:29:09 -0700 (PDT)
Message-ID: <5b83dba0-e900-ebae-2ad8-f036a40a15c5@gmail.com>
Date:   Fri, 2 Jun 2023 14:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
Reply-To: phillip.wood@dunelm.org.uk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <xmqqilfhctrr.fsf@gitster.g>
 <20230510190116.795641-1-toon@iotcl.com>
 <20230510190116.795641-2-toon@iotcl.com> <xmqqpm782be6.fsf@gitster.g>
 <87h6sh6f81.fsf@iotcl.com> <xmqqy1ltqygb.fsf@gitster.g>
 <ec139b78-1d36-f894-e39f-f29877a67b18@gmail.com> <xmqqmt25a4uk.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqmt25a4uk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Sorry for the slow reply, I had intended to reply before but got 
distracted and forgot about it.

On 15/05/2023 18:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 12/05/2023 17:57, Junio C Hamano wrote:
>>> Toon Claes <toon@iotcl.com> writes:
>>> Stepping back a bit, how big a problem is this in real life?  It
>>> certainly is possible to create a pathname with funny byte values in
>>> it, and in some environments,letters like single-quote that are
>>> considered cumbersome to handle by those who are used to CLI
>>> programs may be commonplace.  But a path with newline?  Or any
>>> control character for that matter?  And this is not even the primary
>>> output from the program but is an error message for consumption by
>>> humans, no?
>>> I am wondering if it is simpler to just declare that the paths
>>> output in error messages have certain bytes, probably all control
>>> characters other than HT, replaced with a dot, and tell the users
>>> not to rely on the pathnames being intact if they contain funny
>>> bytes in them.
>>
>> We could only c-quote the name when it contains a control character
>> other that HT. That way names containing double quotes and backslashes
>> are unchanged but it will still be possible to parse the path from the
>> error message. If we're going to munge the name we might as well use
>> our standard quoting rather than some ad-hoc scheme.
> 
> In the above suggestion, I gave up and no longer aim to do
> "quoting".  A more appropriate word for the approach is "redacting".
> The message essentially is: If you use truly problematic bytes in
> your path, they are redacted (so do not use them if it hurts).
> 
> This is because I am not sure how "names containing dq and bs are
> unchanged" can be done without ambiguity.

D'oh, I should have thought of that. You're right it ends up being 
ambiguous. Anyway Patrick has just posted a patch to add NUL terminated 
output which looks like a cleaner approach.

Best Wishes

Phillip

>  If I see a message that
> comes out of this:
> 
> 	printf("%s missing\n", obj_name);
> 
> and it looks like
> 
> 	"a\nb" missing
> 
> how do I tell if it is complaining about the object the user named
> with a three-byte string (i.e. lowercase-A, newline, lowercase-B),
> or a six-byte string (i.e. dq, lowercase-A, bs, lowercase-N,
> lowercase-B, dq)?
> 
> If we were forbidding '"' to appear in a refname, then we could take
> advantage of the fact that the name of an object inside a tree at a
> funny path would not start with '"', to disambiguate.  For the
> three- and six-byte string cases above, the formatting function will
> give these messages (referred to as "sample output" below):
> 
> 	"master:a\nb" missing
> 	master:"a\nb" missing
> 
> because of your "we do not exactly do our standard c-quote; we
> exempt dq and bs from the bytes to be quoted" rule.
> 
> But it still feels a bit misleading.  This codepath may have the
> whole objectname as a single string so that c-quoting the entire
> "<commit> <colon> <path>" inside a single c-quoted string that
> begins with a dq is easy, but not all codepaths are lucky and some
> may have to show <commit> and <path> separately, concatenated with
> <colon> at the outermost output layer, which means that the second
> one from the sample output may still mean the path with three-byte
> name in the tree of 'master' commit.
> 
> And worse yet, because
> 
> 	git branch '"master'
> 
> is possible (even though nobody sane would do that), so "treat the
> string as c-quoted only if the object name as a whole begins with a
> dq", this disambiguation idea would not work.  The first one from
> the sample output could be the blob at the path with a five-byte
> string name (i.e. lowercase-A, bs, lowercase-N, lowercase-B, dq)
> in the tree of the commit at the tip of branch with seven-byte
> string name (i.e. dq followed by 'master').
> 
> So, I dunno.

