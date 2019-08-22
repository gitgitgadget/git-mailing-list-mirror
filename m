Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B201F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbfHVSsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:48:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390392AbfHVSsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:48:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so6400325wrr.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mKCk7ctVoTMF4xUVTctm98Vi0Dnm9wWehmaykQkv4oc=;
        b=Naifa1FjgMXZH8HrNDQ0CcQ+njIaqJrL6XT4+as2zkOAyc++MswlBdEnAIaslN6QcX
         bLkHshm6uoSwmuNDvTvXRfDaCdg0xhzmFtxD9OUVEO+oyj7lphV0LJZOQZdPnMsz+cyb
         BxqpPOpN6u4q0LjKPVm8Fj69zO3eRJNLhfJHN6VyAJ/gYDnAae0y69MNcgQHmrwd/kfK
         ivhdvLVXZYVYZtyvHikBmwUi7VBNEdYVySOqk2ZwCvVfmVt68ZkPKZi7eVPRYaT0Anue
         cURMxriBkLQ+ljjB1HyyBk3A2TRd1t+WjnurIaTWKQO1DRSprL0m35WEjwxRGvaSjr8l
         pO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mKCk7ctVoTMF4xUVTctm98Vi0Dnm9wWehmaykQkv4oc=;
        b=YiNBJIcKyoK41ccRQQrEh1IeVMgqXcLghL+N7SxWoKKEGd1MLsZ5T7k8GFtrjSbu20
         vUI+dxn1SGVZjaXWbFnKBnSrYv+wVK5P6flJv0VjSINj6Idla5TzqKWRT+JFtzW7/HeN
         e2OT5ELEA562x3UV3Ee/n1OVgwH2fH6cm2Wv4X0xVuGDiQckW9SHKQTSvs8PV6v/qJDV
         G2worhQd349ucrfFCY6BsreQv+l64QcsE2oONmygtlDMYbgfKByvhbiiQrQ+bGoQ4OKS
         KE7f0EIx8yFzm6QdFbXmUKkp9xaqCzbF3U6yGyfJxkpCzy18jQ8TbFNY3GEdDcHuOOm4
         K+Kw==
X-Gm-Message-State: APjAAAWO0ZavkBr6S3olBD5aG9FfMWPka7C9CAaftLaAxRhIR40StHBv
        ArINz8oSLnMymOTUf6eq8ec=
X-Google-Smtp-Source: APXvYqx7QCv8SvinZlzEKVHUsOBMs+sJDcAkHR2WW15I37kqPg25NB1NTNw0GddTm/qLTIHk3CmKWQ==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr464347wrv.270.1566499730747;
        Thu, 22 Aug 2019 11:48:50 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-13-95.as13285.net. [92.22.13.95])
        by smtp.gmail.com with ESMTPSA id h23sm396982wml.43.2019.08.22.11.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 11:48:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] sequencer: simplify root commit creation
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.312.git.gitgitgadget@gmail.com>
 <3c3b4599e5a82824fdaa88a76fccd7a57ca3c3b9.1566206300.git.gitgitgadget@gmail.com>
 <CAPig+cS+Wt1Bskhj+3hTw=W56zXfZ8w-G4dXEmQr-BBUMpEicQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b0586e10-1727-3dee-7660-fd66b8ac9ade@gmail.com>
Date:   Thu, 22 Aug 2019 19:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS+Wt1Bskhj+3hTw=W56zXfZ8w-G4dXEmQr-BBUMpEicQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/2019 17:09, Eric Sunshine wrote:
> On Mon, Aug 19, 2019 at 5:18 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Adapt try_to_commit() to create a new root commit rather than special
>> casing this in run_git_commit(). The significantly reduces the amount of
> 
> s/The/This/

Thanks Eric - well spotted as ever. Thanks Junio for fixing this up in pu.

Best Wishes

Phillip

>> special case code for creating the root commit and reduces the number of
>> commit code paths we have to worry about.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
