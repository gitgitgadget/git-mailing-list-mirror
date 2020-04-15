Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C7C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A53720768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azGojVcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896088AbgDOKBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895955AbgDOKBO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 06:01:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB9C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:01:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h26so6978272wrb.7
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBQSLceEPG9A4XtI9roe4FqBtBrX5n0SQ0m44AmaaXQ=;
        b=azGojVcdpb6jEUnicc6hly4iadmA8TY5yova+a92kIuZij5BtbP50yttaIXHuX8VFy
         HKdGiTx9q7t7IuzMzksgeDQPDUqo5G3e0y+ChhINzkaOs+i70pemqOOTFjHJg6MJV1+h
         KvMALoWGFinkF4mYQP20EJY9dVIZJpYKCVQeIlx5Ypx4fSJgTJLMk3cTFhG3Qi09zsO+
         p+5KSgM3I64SG0JoV/aAcINaHr6/Z9rgqTzAnYg6tFXj6m2YICP5QQh7ZhyaHIy0iabW
         eWLnw8TUkJCQOVYZEfDHT16jr6zhx15VMaeB11Oq6PuJPTa2Sia1tIp1XXF98dYjNk8E
         DA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBQSLceEPG9A4XtI9roe4FqBtBrX5n0SQ0m44AmaaXQ=;
        b=jSKC3qiXVjXRNXlZBPd62mXWD9hD5Oa+y/dFuAqS/sG5+KLtQfdj8SidEMxJRtMVlr
         42EOi45ji+e6/xz8Nfs6LLn1r+ijXPmutbDoO+aesxZ+Xt02ZMz3FAuI8xlg195mV4TQ
         FfFZO9umWdh6qIsn4X0d95NTPs4ym5u9EawD2ryPJ2sTesG4WZZ0c7U6uu2k5gTLX1th
         fz6VssTsR0DAUkfM21g+ceIjeEDWuUv9vot9cHPikgCL0vXQ8rbX7AzP9OaTsjmtKInU
         ZJ6WQKuLZyPgoNJUiLaBzfQeDg9aQl6vJtMAgKNBe/BDpPGhS69Q3r9JLzrOPtrYRALk
         fKRg==
X-Gm-Message-State: AGi0PuaYcRHzo+ehnDs3Mgr/+eKzK9y4Tsz/2QebESTqI92mgqg8dNk+
        1HDs40Wgsk5ud10fXEsTYqk=
X-Google-Smtp-Source: APiQypIpA/DptpTlur9wrFozXjZqbYpqGXpcu7keG9hZhpWWg//Ir1N3dDHNe7COSpmSLyDqesfZ9w==
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr12755284wrx.9.1586944872845;
        Wed, 15 Apr 2020 03:01:12 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id u15sm21072279wrn.46.2020.04.15.03.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 03:01:12 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
To:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
 <20200414192418.GB5478@google.com>
 <20200414202738.GD1879688@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b4013e48-cd70-ddf1-8800-b239de9b56c3@gmail.com>
Date:   Wed, 15 Apr 2020 11:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414202738.GD1879688@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/2020 21:27, Jeff King wrote:
> On Tue, Apr 14, 2020 at 12:24:18PM -0700, Emily Shaffer wrote:
> 
>>> Without the redirection one could have
>>>   hook.pre-commit.linter.command = my-command
>>>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
>> [...]
>> We'd need to fudge one of these fields to include the extra section, I
>> think. Unfortunate, because I find your example very tidy, but in
>> practice maybe not very neat. The closest thing I can find to a nice way
>> of writing it might be:
>>
>>   [hook.pre-commit "linter"]
>>     command = my-command
>>     before = check-whitespace
>>   [hook.pre-commit "check-whitespace"]
>>     command = 'git diff --check --cached'
> 
> Syntactically the whole section between the outer dots is the
> subsection. So it's:
> 
>   [hook "pre-commit.check-whitespace"]
>   command = ...
> 
> And I don't think we want to change the config syntax at this point.
> Even in the neater dotted notation, we must keep that whole thing as a
> subsection, because existing subsections may contain dots, too.

Thanks for clarifying that, I agree we don't want to change the config
syntax and break existing subsections

Best Wishes

Phillip

>> But this is kind of a lie; the sections aren't "hook", "pre-commit", and
>> "linter" as you'd expect. Whether it's OK to lie like this, though, I
>> don't know - I suspect it might make it awkward for others trying to
>> parse the config. (my Vim syntax highlighter had kind of a hard time.)
> 
> I think we should avoid it if possible. There are some subtleties there,
> like the fact that subsections are case-sensitive, but sections and keys
> are not.> -Peff
> 

