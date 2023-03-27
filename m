Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC1FC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjC0UJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC0UJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E711B
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 13:09:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so8810575pjk.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679947792;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9Ay2mdGgIqbcEzto8a+VKdBMjdmn3hN5VtT3GWJh/Q=;
        b=WCxZkq+PnpuJSj0whTnR8g5MeOGhom40mJ8/679TJvktxSU/NUk3kHaks7H+3xMiPX
         qOhRUVUFOfl/lqzQH5k4upUbNumXSm6gBii/kWLmdYCYo5Jkp7yUHoPMmy6J3OQsYZ99
         dqmqnAya4dEOShasyRfSeTH8HvYOgzPsbqMLeKYqcpCmYgcqY+rig8UnXIeByzx7cKqy
         vqFivBM9hxc1adXXkh0yQFTzhroI908ZoOrwFfLupy5OQrxHFYHGerkusUgiyMlb5gZn
         3mzwHzBcNlw56sdWPN9kzotRv5db9hKCsxsTWSAg2fPFmed6aTCE8u8V2TB3dUA2Sz5N
         8xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947792;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Ay2mdGgIqbcEzto8a+VKdBMjdmn3hN5VtT3GWJh/Q=;
        b=kBnoCQLHO0ulPtnNfX5PfEdndvm0e/t9NoBO1//qctVmpTlu/Agiw4lYLGWvTqt2Ox
         qvrFwcpEomDMdPO9aStYnP17WQoSZaydD8Nr6wKXq6Q6lYGSq56V3pYGx3FO8v27csE4
         zhAohEhubiGxRLAJgMZg6A0pofUhjXmQnoVU9vFBMKELJNoFiYq//qC42JAtUfC5ZFjp
         QeWaaqHluLNSTacztW5iSRaxDXTtjbnaPZtiNomRiCrKbHAj74Yem5COxt6SYJoVCmZW
         Ph/YaKwz0YxDty4/4ed4FfGSIClV+TG2boVLlgexeSJEh4btsUOxehA3vfytrE6O5jM/
         DOPA==
X-Gm-Message-State: AO0yUKUANNtQNTi2eU2TDdcOL82t9TGQ0h2P33W13PmkhCxjXGzm1ZkF
        ZBEE1NNDtYil4WqkB7XIxtITljcfJdE=
X-Google-Smtp-Source: AK7set+33E5dsqlqmeplDvBKe1on+TJ/Vw6+rhfusloi3RLepLn0zjQ+g1aMXCKDlXG5n357zL2ChQ==
X-Received: by 2002:a05:6a20:21d5:b0:de:247e:d1fe with SMTP id p21-20020a056a2021d500b000de247ed1femr13647395pzb.1.1679947792323;
        Mon, 27 Mar 2023 13:09:52 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b005a79596c795sm19342018pfu.29.2023.03.27.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:09:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: tell the user that we expect an ASCII character
References: <20230327194344.12910-1-code@khaugsbakk.name>
Date:   Mon, 27 Mar 2023 13:09:51 -0700
In-Reply-To: <20230327194344.12910-1-code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Mon, 27 Mar 2023 21:43:44 +0200")
Message-ID: <xmqq355q9cs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Commit 50b54fd72a (config: be strict on core.commentChar, 2014-05-17)
> notes that “multi-byte character encoding could also be misinterpreted”,
> and indeed a multi-byte codepoint (non-ASCII) is not accepted as a valid
> `core.commentChar`.

Makes sense.  Will queue.  Thanks.
