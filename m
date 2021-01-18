Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA46C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6582F227C3
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394017AbhARTbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437232AbhARTaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:30:30 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3782C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:30:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so5651374pfg.11
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:from:to:subject:date
         :message-id:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ka7VByoyTMvnCYm9ebYExpDfkuk5+6eZSi/N/Uo98zugcmm5K5nRqEcXG1BhrnF0bp
         W/Y3cUrpiRoRgxrOKYSY2wMyxbCHicP4wtJS04Wt+kY5fD0XBf9WCG/LCWFVZZnHrR9V
         c+rig0LggUem5G/TTbW3pPuv6DPPculwpk2grzqk4S6rJT117stqtmx+p3abCOMv7y9m
         jmhd1mQzO7H/Yhc5v2CmsUVtAcD00RWRkoAxnb8Fj6osasbIIqQeWmvk3i01NPiaX7xq
         rGpx+mkiV0zlm8YyWFyh5vh9L3gzxWMkjOf+LkscvYFK0SLh+DoY11eyLMuYi3ENTceB
         kpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:from:to
         :subject:date:message-id:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=DejAJVJ8d8bjdSPi2fMkCkVCFTTydpDdGzQdNPJJirnZz+/6Zn+QHddnhcYAkyqx4m
         d4kGzI4oM6yZr8J8PjBdZpjUmWAR/SAxXP/PbHFKS+NNFdvZ2HZff01KN+B8J0WclCm4
         3aSLu5wVVQOxZpwB/Ahtqa/Elu4p6PDNqTK9hmFtOrfYw2P/owQlyF6ms2MD5o4AkKmg
         Ns7YE/KetRZDPF+wmclUfsmFh3eXl8b3o4k88tw46fqxDVIjwdbqWJ0psBf8zF7X9szr
         YdJDXliJtnrzNcI4kwRhUsYILuKdpOp+fxq0mWz/yYMmq0prH5Sdm8rF33VGXka1KriR
         A+gw==
X-Gm-Message-State: AOAM533Z1X58JoOAw1tUp7WdBAIWtFLYQF/3xJV7BDzqEpdnBQV4H4ud
        b7ewiWoxQpW9gmBHVLa9TMWV74DRTXr+XPVv
X-Google-Smtp-Source: ABdhPJwYhAjJUpFUibGVq9hjV6Qb313coJbXHr3N2/M9sGzYAK7vRhcNGyug+EjkgXNSdNx6QkvMgQ==
X-Received: by 2002:a63:2259:: with SMTP id t25mr1070367pgm.395.1610998214507;
        Mon, 18 Jan 2021 11:30:14 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id d133sm16056857pfd.6.2021.01.18.11.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:30:14 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     "Derrick Stolee" <stolee@gmail.com>
Subject: Re: DEVEL: Help with feature implementation
Date:   Mon, 18 Jan 2021 19:25:45 +0000
Message-Id: <C8MJ3Z9R5UAV.3TJWJSOZBG32V@localhost>
In-Reply-To: <60516c8b-adc0-18a5-ac26-b147b1857016@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

