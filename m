Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E5C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK0B2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0B2A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:28:00 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1554412AE2
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:28:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b21so7103808plc.9
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZC+m3d9e8JXAW1yWanM69clGnDlry0zcAZci0kjylU=;
        b=ScPuEPZKVHWQ7eulTa1NnBjalvDX96obhMvO8RvvCdADjKuWdM+TrlEHaKgz1kTxz1
         /1U29Ug8zwS91nMZpJvj5H0Nc33mWRs4d4sJzLoHjNRZEu7dKtDLynQG9AyLogCdZKZo
         ie82F5IYPGS/0r8k9/Yg9sqm2JvQngGCQ5JbJWiWsJTj7+h4cB0mAxgQnhZ2+BybGGK8
         eTChc4lbMSbzJi7KDaFVR0UI/Z6jdCmrwrxecEtyZKs+5IsAz5OSi6DJHdLgY4oxdd2I
         4QT15SPoFQAx+8NvNS+ulM0RzbF4twYUqhdTNXsoJ35F5n/bc/D0VYpoYmvwQe5ev46k
         jEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZC+m3d9e8JXAW1yWanM69clGnDlry0zcAZci0kjylU=;
        b=GnjBHvxlOnPjzAF9KEae8xUrruX8Pjm6T+almH3r874ztB8/nWJBL9ViP5+mQPrxVq
         EtlhOSmg/hSwfqOykEDjzvPh/tNDakf4t7KAdbAdrJODU79dFnNQSWcOrUJeNDFu2OxT
         UjD5WBSrx7t87Qc2qBBqspaHIbK5m0HGzzdyix5QGBgr8lrhJk2AXJcvIT6Q9XEAcnSL
         W+/mnNzRJyXyt8N1g/9OH+2IqnHcXyPGzSeuRN3RVhX9vsBTTSBhEgcsqrnWXri+Ifwn
         /H509fC+s/SL8PD+PtM3XRa9OWp7n2DmPtrfBRZSkmqPLD6orr6iTvtwHaTB09Z+Fdcy
         O+8w==
X-Gm-Message-State: ANoB5pnIbxmZ71lVQ4VzfBrAeqdg42Ju92HLaWe/irDTFt+XdvzoJJ0W
        0PP7nmK1bpvawYs3eaQaSic=
X-Google-Smtp-Source: AA0mqf6kxDK/egG9bSjPXaby/fi3sYFLpJBpSflMncC7CL+RxR9XWs5QolE+k8QPWn3WTseomKE0kQ==
X-Received: by 2002:a17:902:eb42:b0:189:1368:de88 with SMTP id i2-20020a170902eb4200b001891368de88mr25445302pli.67.1669512479508;
        Sat, 26 Nov 2022 17:27:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b0017f5ad327casm5969934plb.103.2022.11.26.17.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:27:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: fix command template placeholder format
References: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
Date:   Sun, 27 Nov 2022 10:27:58 +0900
In-Reply-To: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila via GitGitGadget"'s message of "Sat, 26 Nov 2022 17:24:02
        +0000")
Message-ID: <xmqqr0xp9of5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-Noël Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

>     i18n: fix command template placeholder format
>     
>     This patch applies to the revision 2.39 rc0 during the l10n process.

Thanks, will queue.
