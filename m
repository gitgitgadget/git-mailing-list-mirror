Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5CBC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8504F613DE
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhEMGVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEMGVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:21:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9376C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:19:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso22797665otn.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=37xWJe5rvoCdRNaa0P0lzq9Zh6lMc6qG0JTPa4JrSNs=;
        b=rFhvPFHoR8pWvwlZEE5AUZLmFWhHyP5EsP5QcD18fyFaGQDTYrRC8PPfp+o8u20NMr
         T4OOOcxvIRmQQBoxb3cJ/NJbRolmPJVGuGr/yATBzDdRvRXwYmswgp/QUW9ApURFWk2E
         peX1d/fA/5lbEnO5qMPAX5yoxk49m4VDeeKayiluhzyA5L04yFnmpm4HOh+fnHzXNTNp
         GyYTMsoHMcPFiiI9OCUaRWs5Ir5KYw2eFmg81Fpb3dbeHQimPSKG6D7y+30yNCUNXeCr
         +tOrm4Tr61GjmgpUsBWQEMjq9Cb2kiXzfteoWPMaA+TJHlY9085kLR99X9cj/PjN+cJ0
         /gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=37xWJe5rvoCdRNaa0P0lzq9Zh6lMc6qG0JTPa4JrSNs=;
        b=B+FxTJcNq1bLF40snj6soiGoSmTrq68kA6BIDedyUhxhpPO/eNQztpwDoKtX88Gb2M
         vCAj31iDys6lzvKNQanmo23JcwU8a1ni6EpN134Z/1x32Eoz4Ub6E70NlOnofOPb/MSM
         OevduhJe9Ip65M7ULdcBRT2x4gEplgvFQUh7NSwNsfkcfks5JvKESQpf8ga7YUFFOw0B
         9cq0UxP9HF1TE3ZfIe/0P8caAwqsQjyJBZNZMBf40uec5mF/1e7JYKd9lksvfY1aGMed
         rkTOSJRP0sbSu7so+VtdR1cWEB0KguOVr2jUTygwhqPfBKj4KDgJULcIIoYx8lAAfEV+
         6y4w==
X-Gm-Message-State: AOAM531Zyu0Dfgt6knFiIet/lrEk+pqib9YJJbC1DzHhR8T3CkVtgzy4
        PZv5DnNE1yrbBX+kISNHhSU=
X-Google-Smtp-Source: ABdhPJygwKHYwYL2Qt1g/0N4dFWti9ihac7zcEgIgyXeL1xbJ7zRZGBPQbGcW+mcyuCaUYRm0sMeWA==
X-Received: by 2002:a05:6830:17d5:: with SMTP id p21mr13344403ota.318.1620886777978;
        Wed, 12 May 2021 23:19:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t3sm480988ooa.18.2021.05.12.23.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:19:37 -0700 (PDT)
Date:   Thu, 13 May 2021 01:19:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Varun Varada <varuncvarada@gmail.com>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <609cc4f5d05f_32932089@natae.notmuch>
In-Reply-To: <CAD2i4DB0Zt1snCS_iHZrRJ-woeY5eS-WpWpfdvWo2f5Mk5AY1w@mail.gmail.com>
References: <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <CAD2i4DB0Zt1snCS_iHZrRJ-woeY5eS-WpWpfdvWo2f5Mk5AY1w@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Varada wrote:
> The advantage, fortunately, is that you can like any or all of these
> reasons, and we don't have to agree on which ones are the most
> important or relevant. The end result is the same: a less ambiguous
> code base that makes everyone happy.

Or rather: doesn't make anyone unhappy.

-- 
Felipe Contreras
