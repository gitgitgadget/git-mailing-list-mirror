Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F732C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 18:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjAWSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjAWSMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 13:12:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB8CC
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:12:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so32749895ejc.7
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1Q3lIe6eeyZLDd/9LiU6hYJTYBq3l2VOw7hVtJHbII=;
        b=k1Ur/SbR4m8j1XtwihUH0nmwH120u68EdRGiU4v7NU2XaExVUMjOPThcvEOm/vAq1K
         U3KsY5dIHbWdaYB/yE0UgulV45H8ZrZdk8nuNgQpfjsC4xb72xamBCpXH9n5mogRMIh8
         J5KW4w3JsKwnBggqrHQZ09J1QeNkTrbEcEFnwMn/X2mq8haV54zGkVIu7x8alDtKpfw5
         nFBRCwCr9qvWnI7w6UHfXh6y+91vLwgYHSdFqemzUUbjTFNAYdVQnSL0I0xdrLAATedf
         eGny9EN+dqXcmR4ugs1H08QvZ36PwVpaOWjKnHC/YYvDddwi1rwfdrxOaBsX/xRQNCMP
         6S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1Q3lIe6eeyZLDd/9LiU6hYJTYBq3l2VOw7hVtJHbII=;
        b=f6NKEe0uBPKWDqlwOCLrBFPmV1hAJI/OX1uDks45Z6tbOPVjCiXs/9LezdLgM2Bw6O
         tXOPS7LORimPZYmh7WkV66NkV4EB8XYfIDObfgBvkU2agk36Px47LJGuNlKPC4tOxOkx
         TVTaVbT7qDKlpOofNfl7wRSS2UgUv460CWg4fNJRMC6vfF9zvE2GlJxmlwYTApEf1Xsm
         Vk9oyPfd3sdnNEz0fDr1bCLYf8XXuyRcDJvc0CYNNNvPcQU3lelZoSRXEccNwVsp1l6t
         iBRsjIA8AsJOq1YTjFrryudZoLSrn6m/VMqdU4c20wc+05U9w2VhmHvBlilFeoZIr6g+
         3LLg==
X-Gm-Message-State: AFqh2kockunpgCwnk2JeUdXhceEFezFurTOx1tUmWkMDGOoR9iehCDoG
        8WetFMgEK8FF0fK9XV2+zog=
X-Google-Smtp-Source: AMrXdXvbLIBjNyWAq3N3WuR/oo6vts0FtGqgBhU4m6eJgQ92PqXmZB4RqDaAcfclg8ziVtq0XcRh0A==
X-Received: by 2002:a17:906:3783:b0:86f:e116:295 with SMTP id n3-20020a170906378300b0086fe1160295mr30421262ejc.4.1674497539079;
        Mon, 23 Jan 2023 10:12:19 -0800 (PST)
Received: from localhost (62-165-236-34.pool.digikabel.hu. [62.165.236.34])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00877696c015asm7611815ejb.134.2023.01.23.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:12:18 -0800 (PST)
Date:   Mon, 23 Jan 2023 19:12:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        edecosta@mathworks.com, git@vger.kernel.org
Subject: Re: [CI]: Is t7527 known to be flakey?
Message-ID: <20230123181216.GB2155@szeder.dev>
References: <xmqqtu0lzzn2.fsf@gitster.g>
 <20230121102355.GA2155@szeder.dev>
 <f7449e73-7f50-67ea-2be4-2037f98a69f3@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7449e73-7f50-67ea-2be4-2037f98a69f3@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2023 at 11:56:53AM -0500, Jeff Hostetler wrote:
> Was this on Linux or MacOS ?

On an average-ish Linux (an Ubuntu LTS variant).  So the issue is not
specific to musl.

