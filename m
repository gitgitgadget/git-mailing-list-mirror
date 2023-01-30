Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D95EC54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjA3TCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TCx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 14:02:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F640FF
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:02:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r8so5811567pls.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=344e+31DW8fBXyio83FE4uNbQu9RwILNH+w1iqC1WNo=;
        b=I0AqnT9H/ro1i2pM1m0jDq+mqY1TjviUY4ygTRbjaEEvzUIkjlFhh9yA1xSLPeD/37
         WBueUAB984JJX8+SyGM/FJcEZLcB8RfAHlfEPVuJp2IOFm2qjhW1OO3Utsm6DHF08c25
         fmJsRNe4j0xk/cPomrn+++uoZVOcFuQ8okIRdiUltVHlyBJ8FkA1R1GkF32HK9eRFDEf
         aEkFCDxm9Gi5ySPQpdeQiR/qHB9SsMK4xKPRve4h5BOU+KmxwW2LOf4p1jG9wrWRENcz
         pRuOZx3Jjkn87zHe+/L7yjW1UdWPXSkMhMD3ILjiQ7t3dpltNp67fToWj/eKSawI1RNW
         BJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=344e+31DW8fBXyio83FE4uNbQu9RwILNH+w1iqC1WNo=;
        b=N0UHIOVDii43nRocZfXO6vvy+Z+jNIHMayvvXfIhI2OHzaMXzqpAPas1swmhbt3+Ox
         czaaTJaYQ6h9Y4GmHvBKKS9cyRoZngYeZSdue3v9B7MzFH8rSuatTK2nmao+SfVuekhg
         7QswtoWgvC/v5p5RO53GwbCdfstAE//tu1oVHSII4PQMujoN/uLlZLTJnUyHh2lP+Nwf
         uQzyxNAcEU//uSSplVtjh1SA0591eNi+f4BHNM/tMVN5MsYAhrrfz/ZzeDHSm0nVex06
         TBe0Lcb0hX0C4jYb47cyovHNoiea4f/0Y6MXnq6m4Lf9S0DAjkVgoO9HZdjNporPDTkO
         M9Xw==
X-Gm-Message-State: AO0yUKXeO2BmFTvO/BvqTc3t0wRknlBNP2rdRmS+/rpCs9oG7L/AML/P
        8RwNso8oW5hj/ysPmGygPHij2sd9oTA=
X-Google-Smtp-Source: AK7set+Q/wTsG3vcHGjnu8u9iPxf5/nvb+rThnkdBdJaZmRYi/Bmt94Vv/cGO65UaI0mWgSxs+kUHw==
X-Received: by 2002:a17:903:3012:b0:196:3853:2926 with SMTP id o18-20020a170903301200b0019638532926mr15996059pla.9.1675105371639;
        Mon, 30 Jan 2023 11:02:51 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b0019309be03e7sm7830875plf.66.2023.01.30.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:02:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2 05/10] bundle-uri: download in creationToken order
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
        <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com>
        <xmqqpmaz93k3.fsf@gitster.g>
        <07c4658e-89dd-0f82-77e9-e7c443f747cd@github.com>
Date:   Mon, 30 Jan 2023 11:02:50 -0800
In-Reply-To: <07c4658e-89dd-0f82-77e9-e7c443f747cd@github.com> (Derrick
        Stolee's message of "Mon, 30 Jan 2023 13:43:07 -0500")
Message-ID: <xmqqtu073kx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I think there are two possible directions we can have when talking
> about interrupted downloads:
>
> 1. The network connection was disconnected, and the client may want
>    to respond to that with a retry and a ranged request.
>
> 2. The client process itself terminates for some reason, and a
>    second process recognizes that some of the data already exists
>    and could be used for a range request of the remainder.
>
> I think both of these would not be handled at this layer, but
> instead further down, inside fetch_bundle_uri_internal()
> (specifically further down in download_https_uri_to_file()).
>
> Any retry logic should happen there, closer to the connection,
> and at the layer of the current patch, we should assume that any
> retry logic that was attempted ended up failing in the end.
>
> Does that satisfy your concerns here?

Mostly.  We probably do not want / need to cater to "I killed it
with ^C and would want to continue".

Thanks.
