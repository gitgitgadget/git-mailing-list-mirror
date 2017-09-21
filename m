Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBCB20281
	for <e@80x24.org>; Thu, 21 Sep 2017 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdIUCZC (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 22:25:02 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:54527 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdIUCZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 22:25:01 -0400
Received: by mail-qt0-f181.google.com with SMTP id i13so4662988qtc.11
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 19:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zEC5oaXT9B+rPilfNH1k63ATMm/5vnkmFhaozX7WbIY=;
        b=ecujmCNuVOfKoUoeYNDrg8o+ty6WIvKc/I2f3+E6JIpQITnektRSHjMmlEoaTY+tFa
         ACagpasW5Cxhty+JI5FBvFrz55txgFMcQ2yre9MFRlffx4EQZwPeTXHVMgOo4F6jusnr
         ehuYfGETDa0JN9hHkTB35vRR2D89pR4NKDt6/PY5SAsbBCZ4ULFbEQL2tCsfex4tTMdr
         STOlTn5dLSpZINeVRlSNH51T0Cv+0yR4GrnUgC4Gz340ek+SmvETgDYD195C0XdJDuNm
         +GgtrYVMfmP9TBf6agtVo/8aLmaYSMSiuqENSCC1PqGjPbZ9LlASGzR36UJHFwcIlNuj
         jvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zEC5oaXT9B+rPilfNH1k63ATMm/5vnkmFhaozX7WbIY=;
        b=EnVJFqcJX8jEewnlalzBiK/xR2CyPNfEv58cW70BWL7Q9xuM5VQACK/xbfh5bbEL4J
         QArccHoHoXrFRl82ETnaUy5WiRBQg0xqbVAQVhvG/OtKj93ku3C+i1uOScVLi2tEGI6s
         cJXzF7Fi2uk6Xkd9INuz222G9Aayf5P1tn85TyFVNr4cUxRQkp+0agYt6u//FWXM+fr+
         B8DMRPqqy1RDFifinm2y1G5qz3IA2l414DbWQSNIPJg2eSCpBzcUunibZ7Ppwv8A4cg+
         qAUM1s5OkPasvCcy2qfGrbDv2UnR4QDtkr1iSAwze0Wf2nhothEoA99MWFVcDw0/EP5S
         TY+Q==
X-Gm-Message-State: AHPjjUiK47mld5zjE/Lq50IKaXvCV+rvK6PoSpCeF95PBw95EWHMbk7T
        pFmGW+tQl0Jx7uy9ywntroU=
X-Google-Smtp-Source: AOwi7QBENjvTJ8Z6rp0CW7g8Ic3I6WH1asq0OkWANPyAroEc1b9gbg8jAXCgcSYtCHYcBXoImErHUQ==
X-Received: by 10.237.48.75 with SMTP id 69mr1102222qte.26.1505960700618;
        Wed, 20 Sep 2017 19:25:00 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w134sm282024qkw.38.2017.09.20.19.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 19:24:59 -0700 (PDT)
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-5-benpeart@microsoft.com>
 <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
 <3311de8b-f9df-07e0-6c5d-7f491e9bcaa8@gmail.com>
 <xmqq377gn74p.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a4ab4766-0367-ff18-a3a9-e48ed49ccd80@gmail.com>
Date:   Wed, 20 Sep 2017 22:24:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq377gn74p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 10:00 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> Pretty much the same places you would also use CE_MATCH_IGNORE_VALID
>> and CE_MATCH_IGNORE_SKIP_WORKTREE which serve the same role for those
>> features.  That is generally when you are about to overwrite data so
>> want to be *really* sure you have what you think you have.
> 
> Now that makes me worried gravely.
> 
> IGNORE_VALID is ignored in these places because we have been burned
> by end-users lying to us.  IGNORE_SKIP_WORKTREE must be ignored
> because we know that the working tree state does not match the
> "reality" the index wants to have.  The fact that the code treats
> the status reported and kept up to date by fsmonitor the same way as
> these two implies that it is merely advisory and cannot be trusted?
> Is that the reason why we tell the codepath with IGNORE_FSMONITOR to
> ignore the state fsmonitor reported and check the state ourselves?
> 

Sorry for causing unnecessary worry.  The fsmonitor data can be trusted 
(as much as you can trust that Watchman or your file system monitor is 
not buggy).  I wasn't 100% sure *why* these places passed the various 
IGNORE_VALID and IGNORE_SKIP_WORKTREE flags.  When I looked at them, 
that lack of trust seemed to be the reason.

Adding IGNORE_FSMONITOR in those same places was simply an abundance of 
caution on my part.  The only down side of passing the flag for 
fsmonitor is that we will end up calling lstat() on a file where we 
technically didn't need too.  That seemed safer than potentially missing 
a change if I had misunderstood the code.

I'd much rather return correct results (and fall back to the old 
performance) than potentially be incorrect.  I followed that same 
principal in the entire design of fsmonitor - if anything doesn't look 
right, fall back to the old code path just in case...

> Oh, wait...
> 
> 
>> The other place I used it was in preload_index(). In that case, I
>> didn't want to trigger the call to refresh_fsmonitor() as
>> preload_index() is about trying to do a fast precompute of state for
>> the bulk of the index entries but is not required for correctness as
>> refresh_cache_ent() will ensure any "missed" by preload_index() are
>> up-to-date if/when that is needed.
> 
> That is a very valid design decision.  So IGNORE_FSMONITOR is,
> unlike IGNORE_VALID and IGNORE_SKIP_WORKTREE, to tell us "do not
> bother asking fsmonitor to refresh the state of this entry--it is OK
> for us to use a slightly stale information"?  That would make sense
> as an optimization, but that does not mesh well with the previous
> "we need to be really really sure" usecase.  That one wants "we do
> not trust fsmonitor, so do not bother asking to refresh; we will do
> so ourselves", which would not help the "we can use slightly stale
> one and that is OK" usecase.
> 
> Puzzled...
> 
