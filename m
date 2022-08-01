Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0667C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHAO0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiHAO0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 10:26:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398FA2B1A7
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 07:26:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v3so13423496wrp.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vuiy5HmOBHhA/KBmyd7o8/bv30Ngt0dzMnt8G5l13WY=;
        b=GRGUQw1Y+wmFL3+PsWRoRWtYa4NDmMhgkjTgl/7rDJo3gsCLyXYWGyYX/JHYdJmgD0
         p4A/RuwydlQs1n6m8zz3FGk5rAt3E0GP1pP23cIteLkE5bRT+cktwG1CfxrzoD1FSkWQ
         QmHjsKhsyClBZnast7ua/UKGIyl7uzXvx6DqvN1/6ga5wCKnO20cn77k0bkyFdNGgOAZ
         yUemP4PjC0kBrOhjQOhZef5FPpdw34mrbfaXG6VGB8ynrHFq9P3Jhg3dO05eUTtd8xgi
         AuPLJb1UspM970gFIzuBapQyrYAjChr2OD8dQzjwpGU5bUB1+HxSDXD0gYwGeqJEItOV
         oLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vuiy5HmOBHhA/KBmyd7o8/bv30Ngt0dzMnt8G5l13WY=;
        b=OxdaZX8BIIJYbM+UZQkp9prmU6M0QFZLuFViQiZ46xXiMN+FK70Ih7fgwGjJZ9WX9k
         n9+dlsgm/JmJ/CgaV1mtDkrqJWA5k9XftG3VY1hUDmfYeN4mH7AMzyTJYhPYz+vcko9X
         MZIsWFu6xBncl7aznFV6woDX8TgBiYyggWikAAqKSuMxZtcQFciDyxjbLOs5WlbARBaY
         IohIosbjbFn3CzcuM6qnpf/0YPEJj8j96vv2a6RWCAcdG55XlpL4hdd9WRrsZucBk+5V
         Y7Z2a1IMP4qsjBMPBGxeghWbvxizk7c6ZKmZFbXpPsDqf5DARlDUAibh3O00q6v05EFh
         Fpaw==
X-Gm-Message-State: ACgBeo0nrd5sIzNR8d4KfIFHyqIce9EDKDWKVcF2vKjG90bGJ0ozlUgE
        IhFJD2VFdBb3YGdDBtVaiTSu/0RCbN0=
X-Google-Smtp-Source: AA6agR4mef0q+lHJ+Xaj2PNtfhuzV2yLso8vF89iVQ0WN6qqdr32DxafuTcJTuY2ZfWRef2PAdd/Eg==
X-Received: by 2002:a05:6000:2aa:b0:21d:ac4b:95af with SMTP id l10-20020a05600002aa00b0021dac4b95afmr10065688wry.479.1659363992710;
        Mon, 01 Aug 2022 07:26:32 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b003a17ab4e7c8sm20478787wmq.39.2022.08.01.07.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:26:32 -0700 (PDT)
Message-ID: <aef199d2-7c89-1e25-4aae-e1e43a71e04f@gmail.com>
Date:   Mon, 1 Aug 2022 15:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
Content-Language: en-GB-large
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220728230210.2952731-6-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 29/07/2022 00:02, Calvin Wan wrote:
> diff --git a/transport.c b/transport.c
> index 52db7a3cb0..2d503e2fbd 100644
> --- a/transport.c
> +++ b/transport.c

> +	i = 0;
> +	while (packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr) {
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;

I forget to say earlier that this is leaked

Best Wishes

Phillip
