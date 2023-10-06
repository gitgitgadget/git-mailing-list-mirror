Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77295E81E1F
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjJFSnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjJFSnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:43:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD01C2
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:42:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5043a01ee20so3020644e87.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617777; x=1697222577; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+l+TdR8dBwni8oo0X2RjVa0EPrOeWNoM1UIna814Q=;
        b=lm01nf03Dhze7Yn6OnUJzSucyMX/GM8sOfpXASqvVvOq123nj0sM+pHvOHBxBenV6t
         FM4xuhYHASuEqm1Ck8aMV9+vnGATv8L5/kjBX5fQEUlzil8M+TyG16TaGjcVXWyK04Z4
         qdtXf/wHQST4C1orrxgrxzj2xZ5LwBAdI3vTJt77HtFoMEXbVkQ1rx0RNrzULVHDl/sx
         f1pTEbvCaXr8P7F67ETj23zXDYNJ6Gmfn8qXhd+H0CoO24TKXKaZP44G4rJXiTAXnlZo
         2CJxKa0kGbrDAVObCRQU9I1FjmZimHoQEi7s0ibuzpFtqJI0sSpB7WrQLb/0zzmcXOzC
         Crng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617777; x=1697222577;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z+l+TdR8dBwni8oo0X2RjVa0EPrOeWNoM1UIna814Q=;
        b=hAOUzszkle9dKDKdmQG12hd6A8fqBpApx3UVPWN7cvcQM8RDzt2EApx+ZykEEnHB7q
         YzPxx8fyp0wAze3AnjoGFcsiz/cBU/PWMYE+kYD/YHUTZ4YJ667nyvS0pNNOBZM7Fsqa
         mnqowL6lrBYyUy+5NvnMAYgqtgOwaa9mpjilhmEQTqhypOwURAoyE5aR/k/jS2cjcMWm
         0iV0A+mT9yzGnN9HqfWNYrvlPWK4DhKnEZlgLxlc6rL6eDXRHG0tnpwvEL3ZRtuJZTB7
         MA6F4veTBP3Szahfh0X4bu97cVoEsjgeaSxTZuZZJe+ldpdjL0F1kx3/h51Actl6/MZl
         ZYAQ==
X-Gm-Message-State: AOJu0YyVBAtf2yZw5ppPdntNKC9sWwUDhAo1lG6DiSGStZs2kLO0EmHP
        oTZW7xmosp1k44Ha8EC/0mn/Zu/dm9E=
X-Google-Smtp-Source: AGHT+IH5kqUS94Ml3ZFXVdJIaGx+zkDt35feNGzKdkN0cGVlOd7Gds6KOHwGKp6rT+nVlcRn9vWefw==
X-Received: by 2002:a05:6512:2085:b0:503:1d46:6f29 with SMTP id t5-20020a056512208500b005031d466f29mr6182146lfr.37.1696617776521;
        Fri, 06 Oct 2023 11:42:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24950000000b004ff8e79bc75sm398238lfi.285.2023.10.06.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:42:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 21:42:55 +0300
In-Reply-To: <xmqq34yog3ux.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:24:06 -0700")
Message-ID: <871qe7r3rk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:

[...]

>> +on, m::
>> +	Make diff output for merge commits to be shown in the default
>> +	format. The default format could be changed using
>>  	`log.diffMerges` configuration parameter, which default value
>>  	is `separate`.
>
> The original is already wrong so these are not problems this patch
> introduces, but
>
>  - "configuration variable" is how we refer to these entities.
>  - "which default value" -> "whose default value".

Added this amendment to the patch.

Thanks,
-- Sergey Organov
