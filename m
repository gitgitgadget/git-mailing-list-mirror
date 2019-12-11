Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616DC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E0E214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 14:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exegv8Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfLKO1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:27:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfLKO1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 09:27:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so24262522wrw.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 06:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXGGfbIHzcEo7UnTbMQJPTZCZ+fjPzY3sRahHoV8JpI=;
        b=Exegv8MalkG7I5d6Isq1+MdpbncKFe/ErFPzQL13lq2u7m5Xo1WMRneihVl5VrgYaa
         QUOOtG2s1XcQxq5tiKsrzxayrdqbdEce2HGlwxGKYpf5l7ej+tJtAhSH7ZoerXW18tS0
         iyTN2o8xlJ9lYxlIhFKnZ9D/b+MvQCr1PkCHBRH/nnHmaiSrFivR8i85/p5g2gdkYL4c
         SlYtP5slVjUR/qrmSkoRAIz0WcmttX+AsKYSibMOr2t589ohf400r6E0sOU+oI0p2jE/
         KH6AVZkhpx6jRCYdhYtG9geKFYAzceAk/cVJi45DxMFY79WNbFlXrhVvTBL+n1nZowlu
         wldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qXGGfbIHzcEo7UnTbMQJPTZCZ+fjPzY3sRahHoV8JpI=;
        b=fvhdp1staKoQfVA95SA8pfiJ30rngRBbGO08RXaBfI3G/TkvE/liNE9raEInyEHcLd
         +ogyAH/NrHoRkOwos/Hn/nEPBmZDViutMk8RE5n7CltHM9tnIhsCHWmVdF0dbSUKLll6
         iCM3S9vpCRKdS51Jl8UCSBht0lhuJ4hL4NvDwqb0ZsdoyUgEsudrQB3YRUy5E3ks+9VX
         PIVZT22MY+FuhUvbzAjQaIKV1b5rRzptNTEFbZRaDelAIS1xxUU3i6S1ECl428TlHbnF
         MU/kXQf4zpB8cJkn6TCvimz+9eK9lbNUSuPx646i2bPRewQd1+mFgkuzzdo57M0ry9hO
         36Jw==
X-Gm-Message-State: APjAAAU1v82dFw4Dfypk0MWnBJjDDeLYYGZU5W0N/ODCtwc4NkddnA6F
        uCFEL72VkxlrTyFEUyLAULfGY6s/
X-Google-Smtp-Source: APXvYqz65jhLsg3cI8ll/xzOB46Nn7BdYp3Ncv/2qG9OcGIRvBUWTwBVp2DJpvaOrsRG3q58nDHMyQ==
X-Received: by 2002:adf:93c6:: with SMTP id 64mr83504wrp.212.1576074468103;
        Wed, 11 Dec 2019 06:27:48 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id f1sm2487746wml.11.2019.12.11.06.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:27:47 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
 <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
 <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
 <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
Date:   Wed, 11 Dec 2019 14:27:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

On 11/12/2019 11:43, Alexandr Miloslavskiy wrote:
> On 10.12.2019 11:42, Phillip Wood wrote:
>> I don't think it's so bad if the pathspec is cleaned up just after it 
>> is used,
>> the diff below applies on top of your patch - see what you think. The 
>> diff
>> also adds dies if --all is given with --pathspec-from-file which 
>> (together
>> with a test) would be worth adding to you series I think.
> 
> Unfortunately, your reply came too late, topic was cooking in pu/next 
> for a while and merged into master yesterday: c58ae96f.

Ah I thought it might be a bit late to fix up the patch, there could 
always be a follow patch though.

> 
> I understand that your patch consists of two parts:
> 
> 1) Adding test for --all
> ------------------------
> I must admit that I overlooked that there was a similar test for 
> args-based pathspec. I will add this part in my next topic for 
> --pathspec-from-file. I expect it to appear in the next day or two. I 
> will try to remember to CC you to it.

Thanks, one other thing I forgot to mention yesterday is to ask what the 
expected behavior is if the user passes an empty file to 
--pathspec-from-file. With no pathspecs on the command line commit, 
checkout, reset and restore-files all default to operating on all paths 
but passing --pathspec-from-file implies the user wants to specify 
specific paths so I think it would perhaps be better to error out if no 
paths are given. There is a precedent for this in checkout-index which 
does nothing if no paths are given (though I can't remember if it errors 
out or not).

> 
> 2) Moving parsing/validation into `parse_and_validate_options()`
> ------------------------
> Again, I agree that having parsing/validation outside is suboptimal.
> However, with current code, I find it to be a choice between two evils, 
> and my choice was "outside but clear" to "inside but obscure".
> 
> What I find obscure in your suggestion/patch is that innocently looking 
> `prepare_index()` suddenly clears pathspec as well. It's even harder to 
> see when called through `dry_run_commit()`.

It would be easy enough to clear pathspec in cmd_commit() I just didn't 
bother to do it.

> 
> Now, let me illustrate. There's a similar case in my TODO list, this 
> time involving a real bug in git. In `init_db()`, the bug occurs in 
> `set_git_dir(real_path(git_dir))`, also due to unexpected clearing.
> 
> Now that I pointed my finger at it, please try to find what's wrong. I 
> imagine that it won't be easy at all. And it's way harder when there's 
> no reason to dig deep into a very specific line of code.
> 
> I really try to avoid such type of pitfalls. That's why my choice 
> between two evils is what I did.

If I had to hazard a guess I'd say that either set_git_dir() calls 
real_path() which messes up the path passed to it or it does not copy 
the path passed to it and it is messed up by some other code calling 
real_path() after set_git_dir() has returned. If my guess is correct (I 
wouldn't be surprised if it's wrong) I think that's a bit different to 
the pathspec case as it's about the lifetime of the return value of a 
function rather than a function freeing an argument passed to it.

Best Wishes

Phillip
