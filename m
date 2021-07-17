Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C1C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067A361156
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhGQSbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhGQSbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:31:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BAC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:28:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w188so15127561oif.10
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6fA+F4YG9UM/IKFTRuo2eIQrca5iHnNzLOtbayAM6jU=;
        b=uVDjAx6nJJ7mn76b1rJ/izO9WUD7fDsbB0bMO59MqRrlaP7jktWT4BpT8G/UQX83HX
         vB5Pyn9bqUZgaY2eN4THsTf/z8w2uWaIN0k5NBmw2EHuWD3nLxHMSiLNHwaw25Z8mW5a
         UkU/5rGaCqhJGVI0V3aTr44mUKUan0rqoGoQfzuecZ/szOXdX9RDI0KRAgUdzAv6K5xc
         gx3OzK2jwWuDooX2I4HOqiwfQj80qb54RV1c8jejNnoZdA0qulIJjeKIG5wffurF3ayA
         neZPo+EjDlbvpjg7agGB3VNuYIHa1NyipomqBgH0JEB0L+tNqUnSEzevg27aE0S1y7Lg
         x/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6fA+F4YG9UM/IKFTRuo2eIQrca5iHnNzLOtbayAM6jU=;
        b=YEYiQA6SZIKn9UICrH4I8woNHHtyNd2BgDn1Be/jV32BBer4Q193ka2g/tpotVsXCw
         MtjioW8hzxnsk2KD9JDCVt6RtJ0qG5LPZBS363+hYOGVMM6yT1scD3ury57omOCxMa9m
         HE+LvAahoiONS5eiKF1HbDlobUnm7t7lnu5/mhrOb8+f1/CEBbzoIkf2itX3ZiV75+9h
         Q6PtcaG4k8lfGOb/9kd/nWmr7952OruGh5tE0cJ59OsyffrNNNYMwkdpvq6Er6KtyGfC
         tnH3/UFRRtB6rnr8foiXfZiOD6nDxwGysYiTjCDlpX3anultJnWUelUhMQBQQ6qMEK6H
         ZDGA==
X-Gm-Message-State: AOAM532cLVzECCFY1TuMF4ZcrYoTGm9peYVER0ivbOQ5lPzdYVutaSjp
        wFaPwPaSwuI+9bYqjWxNiEc=
X-Google-Smtp-Source: ABdhPJzODe1/cpBwhvf+cZEiPCMK49ldf3e+21sDYLfJGyZEq3MT9z1wxmYTCsvp5RHgz2NRyQXI2A==
X-Received: by 2002:a05:6808:b27:: with SMTP id t7mr16743933oij.117.1626546526225;
        Sat, 17 Jul 2021 11:28:46 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id q186sm2919502oif.40.2021.07.17.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:28:45 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:28:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f3215c9f3ce_25f22081c@natae.notmuch>
In-Reply-To: <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 6/9] pull: make --rebase and --no-rebase override
 pull.ff=only
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Fix the last few precedence tests failing in t7601 by now implementing
> the logic to have --[no-]rebase override a pull.ff=only config setting.

This is a semantic change that breaks current behavior.

Now this does something different:

  git -c pull.ff=only pull --merge

*And* the new behavior is not documented anywhere.

-- 
Felipe Contreras
