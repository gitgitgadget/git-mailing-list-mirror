Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99195C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJETe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJETej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:34:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D9CE5
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:34:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so2817780pjo.4
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysvTuIgGUUQeeFQH7tiwVAJE4WOPi4wo+ze9hsZII5w=;
        b=jeja0KDHqYYL084yxQEzkzNjOgOx7IYx7MTZEWLRRL95G37hoUjDMNgn0m5SEA3xei
         2FCx6fseM0ABetalE/p7ifc+SlF6am8Jm5i29MRbAUzUbSUClZe1o/fEai3ht3F1NG16
         ffX1b8/4I1fO1xVI9Y01mJNCrGQTuLbv8S9kSQ9VkhE7e4vktc5k5ktcF740Hha1IYp3
         lwuV4D1OD/FuC4Sap76FtaSNrk/FZf6qAK1RkB/zLLWAWIbcVgRCrHczZOhzrEfrFzMA
         Ym0XQObKGX1q0ognIC9uBZBgCHZR57jL0y/pMsYLyg1YyxVcuNUUiSZqgHDtA/8fK2ph
         7xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysvTuIgGUUQeeFQH7tiwVAJE4WOPi4wo+ze9hsZII5w=;
        b=sH6L6z+qFeddlLBYJccph7xCkt6fcChBRUREuXukNdSY5rrnFmivw9cKSiqzToc3al
         i6lPDHnI2XzH8A/3DTnvyKsXunIt3VpXLp2HKHT4pwMqEgpV+UVLVaMU8uZV2il6qubF
         1tmHl7jmcr8zHS75DFVjw+quo7brz+fgLRpnSptuw5XwcZWUpZsjjINAzGdPkgkswpjI
         KaNvfhb1ZGh8nIm9W1/Z1IkadxiBxSfZr6+GhkcqzNw5zRANj4UHhcIQ9fFBaHiQmt0h
         HBbZhb1o7q9vVvn99fRmMtnmfwKvADU16cbOxRgoBMlMCN7vl9610BM46RIvxbtCKE0b
         FeOw==
X-Gm-Message-State: ACrzQf1K/SuGyVuDZmR1BysO7uOOomB1opyICZTG+zE7B1OEG6hJ0x28
        RvEh+uO77hsjCCQC01oROdg=
X-Google-Smtp-Source: AMsMyM5Q9jgkQOq5MnmBlUXtiAab0QoJlV+Hfw00d5CIjsiJqS/BbqOTrO9JlgJu0Vk0cY3nON2Pmg==
X-Received: by 2002:a17:90b:4d12:b0:20a:6307:54cf with SMTP id mw18-20020a17090b4d1200b0020a630754cfmr6573751pjb.171.1664998474305;
        Wed, 05 Oct 2022 12:34:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b00176acd80f69sm10898601plh.102.2022.10.05.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:34:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     darkdragon <darkdragon-001@web.de>, git@vger.kernel.org
Subject: Re: Install-prefix when building should not be hardcoded
References: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
        <YzvnadnAYce0dIpi@danh.dev>
Date:   Wed, 05 Oct 2022 12:34:33 -0700
In-Reply-To: <YzvnadnAYce0dIpi@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Tue, 4 Oct 2022 14:57:29 +0700")
Message-ID: <xmqqczb6oyie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:

> On 2022-10-04 09:38:24+0200, darkdragon <darkdragon-001@web.de> wrote:
>> Even though in Makefile, it is stated that git will figure out
>> gitexecdir at runtime based on the path to the executable, there are
>> many output files where $(prefix) will be hardcoded. Even git
>> --exec-path will print out $(compile_prefix)/libexec/git-core instead
>> of using run_prefix.
>
> I'm not sure about this part.

Perhaps it is related to the use of RUNTIME_PREFIX (which I don't
use myself)?
