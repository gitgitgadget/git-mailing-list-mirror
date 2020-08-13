Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F99AC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0AE20855
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9uLv6cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMTvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHMTvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 15:51:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A33C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 12:51:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so6344167wrh.10
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Obg/BmTtGsn9dH78Ddsnq414aFyn2P5SsEVXJB9lOY0=;
        b=b9uLv6cZxDiQriMglX1/60NF8TSlkdlUGqBK/kwQfMuYg6yh7YfP2H6etbrEz2CCEm
         1PqnUQt5Jn1aFuGOHx7cVYOednLonyXLuCFdL0MObp81I56kthR/Y25VpJVJoVmXAEXi
         pDkhKAa5xFcK36JlO+5E2SDtEQuPzjRAhg2aCBKoA+gVuyyMccvrsr00yHILdQuO2UHw
         u9WNQssGYm7T2xzawBbxfxMSelsVu3/HWEQVUx4O5UptKUod61nSYZkBi055VxE27vIH
         r503YzeRzFctHYseloC19sMY//3N6Ii98Bv1hyHE6QRon5TLLixKtJEk0Oaaf1eL2kFx
         qDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Obg/BmTtGsn9dH78Ddsnq414aFyn2P5SsEVXJB9lOY0=;
        b=Fi3JX0QonGtJG18vcVTBipHcBcl2K8ZvapXfu3i2SQEMcPJcIJFAQUxmE8oaU81oDY
         kVEX8E9St/9h7DV3CCtqOs8ujoVfhXwBj/remSi7s/HBd7TS5yb4QXfsjPcARyPAgUBU
         Oxw5p1Q17rY2iopSRzKGQ1uwLvPP3WyrHRm+tZ2O8OlSWXN85J2Y6lHJMNzgQV59h47d
         /CIrS3oQ1qwY5gDGQUnMFykOY1u2OIbqi4ZboKSwIo5vvIvRyPfSE+0crqjnDz66t0F4
         zx0YfG+YeLpbpeOwqCp9KzO2BiUDyEUG/PVUkscy3taZ6ul4DC9ZCDp+rUHCjI9oOJN5
         X17w==
X-Gm-Message-State: AOAM530SnMB9cBryLF+/BWesOHVV2TKSfT9vIokqCLQBkZ84+5SuCPNJ
        KST8rjrNql+ZARcvQJjJul97MfLW
X-Google-Smtp-Source: ABdhPJygS0S4e1V44uPTw6prN8GRMakvcb+VF2K/tZJh7wf4DpSspXI+7lWYeUCKX+lgJtpNBrhpTQ==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr5911298wrw.105.1597348311653;
        Thu, 13 Aug 2020 12:51:51 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id k1sm12254579wrw.91.2020.08.13.12.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:51:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/5] cleanup ra/rebase-i-more-options
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200716173221.103295-1-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2008131608240.54@tvgsbejvaqbjf.bet>
 <xmqqzh6y30cf.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7874298b-3c48-0849-2ee3-8912a410287d@gmail.com>
Date:   Thu, 13 Aug 2020 20:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh6y30cf.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2020 18:46, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> I offered three small suggestions how I think it could be improved, still,
>> but I would be pretty happy with seeing the patches moving to `next`
>> as-are.
> 
> I tend to agree with those points I saw you mentioned.
> 
> The unconditional exporting of the committer-date without undoing
> looked like a bad pattern waiting to be copied and pasted. 

I think it is copied and pasted from builtin/am.c

> I have not yet fully followed the codepath but I tend to agree with
> your suspicion that commit_tree_extended() might be a better place
> to do this.

It looks like it should be simple enough to do that, I'll reroll

Thanks for your comments dscho

Phillip

> Thanks.
> 
