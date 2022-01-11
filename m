Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB05CC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 01:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbiAKBNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 20:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAKBNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 20:13:01 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F7FC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 17:13:01 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s19so16944536qtc.5
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 17:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s77yjuCTXJ3NhQOvemkLT1PlrbzyMsCIGGB3uF4f2xs=;
        b=D9te+S1kcnLk7YBl24P3UvaquVy9PESDmEoOOQw+D4mwfm/abnitupVVmgNRuJk2p4
         XOUwpkvFP9lsU9fAdj7DFJY/pHDHgFdSnRuGFTL9s3m7G6IMdmDps7DTCmCaYT34S8PV
         PVWGcYhu34K3tfJjm3uBQkZh6qbmT0qlk/CYPuI1TUDkVyLW/dXniZ38xi8++I9eyNGF
         uIgJzcI8oo9FKvi40xFppPxWw9fz69tFkdA1VYxefDw9eklygVvFA/3xuVe+OqCrM4KC
         QfL7M7O30W5rCaATPWQ6gHcjAYojD4T/Ki1SUOQr6vFt5SRwR1Uc1m9JvejY5BNNSjak
         YntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s77yjuCTXJ3NhQOvemkLT1PlrbzyMsCIGGB3uF4f2xs=;
        b=MvUrHsVZoJ2DEk/iXK311C/nB7g/7JVB6NReabFDZVW1tql4TnvWvFPOdvSEPvfOvR
         K3HmdSNmE0MCFl0bSYBgF91rek18A2HIqENAlvbe6zaCx9zQ9stiem1h9Jy8q9Z9NCYP
         Jv8fNW9QWbknIcwHg78N0nnXnYRblnufnqBBSOi708gX/aAX6PyMQ7yjptJwI+fWe86D
         B/xXLHXNY0OAfawrXAR6cbdBq68i8hBG96NPsfdGmWtAfiTL7tARXrak0QWC6iFLelca
         lzII4mUzig7qus0nU8ipHx965jHNk0/b+tjB2OAiOcL8AjjiRSUFYmHbTMQQwtl4p3rN
         9kfw==
X-Gm-Message-State: AOAM530OOwi8AL9aqtrP88UQyKCgY03O1RC32gsSx5h0DrPhSwigWsdX
        MLmmCAZX7y3DAyb7owhEELN2ewHDS3zIeg==
X-Google-Smtp-Source: ABdhPJx55jNZ+rP5Y0wO7udKrbwfDZuoIwklxe1+OQII8x8qcyxrfsJKybn0A9/bhIMQbPW49tET3g==
X-Received: by 2002:ac8:57d1:: with SMTP id w17mr2040161qta.453.1641863580018;
        Mon, 10 Jan 2022 17:13:00 -0800 (PST)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id g22sm5823330qtk.23.2022.01.10.17.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 17:12:59 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <976b56f8-00c2-06f8-0145-b5b2dec560b4@sunshineco.com>
Date:   Mon, 10 Jan 2022 20:12:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [ANNOUNCE] Git v2.35.0-rc0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7db7xfgn.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqq7db7xfgn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/22 7:51 PM, Junio C Hamano wrote:
>   * The command line complation for "git send-email" options have been
>     tweaked to make it easier to keep it in sync with the command itself.

s/complation/completion/

