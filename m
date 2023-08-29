Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D518C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjH2QDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjH2QDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:03:41 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C512F
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:03:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4121788397fso14569821cf.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693325016; x=1693929816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rGSwLHeaK+kAli4Glsx8dpdp6SHXLmuLwHrbRiNHL0=;
        b=a7G6/Y3N6T9DWuiIB1/LoO8OSIA/jDxrzPxEoIYobonuM5bzUbVO7d2Paevul9XiRp
         IK2t+mpPpZhDiEA5WhtJm77PCL22DkhcB9v+MrrT+sEq7+ukuc+bI4YjkpkqU1cecIeG
         z+nCrKl/J2M7lUa3qiUi7dalevs38yNxqjN5o3oEV+3TE04juiRvW57UfHXfxBXV81cd
         ZN7LKg6o2WTwIw+j5IpZr+gvI0HL3ob/Bvd00BeAebd5SJl/RErQ3fy3HLXFXvDpAQWh
         IMmtoLU5ZRg8Lm/1lQvFGkQ41pf6NaicndMO5lwWnYjE2k45bxH8UJFZBydwCKtpWgd6
         cRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693325016; x=1693929816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rGSwLHeaK+kAli4Glsx8dpdp6SHXLmuLwHrbRiNHL0=;
        b=RDg8jfAVwqhIaYoQcT6nUcV3EW3KpjCgqpI8/8kK96h/QJh+P/dSGkbVQW1UWbUV/I
         cM6RDhw0EJkkD3s+ee4Z2XRAtSVGdhqk4fVtDlHDO42peCuR0BPrlJxb8KvJx41RDmPK
         eycpNsqeEz0ck2k6JabuqvrWvnNMyojFMZ/Scmw2Y83tlsP+EsXaEZhOo46PEUmO3U8G
         Zx4h/c8fgxOYqBPf2PxJNDVCQuxP5uCPYTpn67cFYW8tvS02dU+Q03K1f3QL9pJGmRon
         k841PL5csUxuMS2lN+HDtq/JU0DPRNij/bjz6OrngwyxSxLakhfW08XcVhvHgBLYkDLo
         jnuQ==
X-Gm-Message-State: AOJu0YyWBLaO8uRlo5TfxteA/V+b+4/ngj652UG4bBZ4udPsmlh9FDSF
        FmIeE7tCoBowqRWcgwNoCRdwSodaGpK0NA==
X-Google-Smtp-Source: AGHT+IES/Hv8QPLjV/oay0gChgF5iy8sPhnOl1nfJ9fFpdpKqeuqmEXlcjxDHZaYnwCQsD7EgcdvBg==
X-Received: by 2002:a05:622a:15cd:b0:412:1ae0:e127 with SMTP id d13-20020a05622a15cd00b004121ae0e127mr3717812qty.31.1693325016497;
        Tue, 29 Aug 2023 09:03:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id hz9-20020a05622a678900b0040fd47985e6sm3036269qtb.97.2023.08.29.09.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:03:36 -0700 (PDT)
Message-ID: <a1e256cd-072d-a3a0-cdbe-ed65ed21bfd3@gmail.com>
Date:   Tue, 29 Aug 2023 12:03:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com> <xmqq4jmsiyhw.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqq4jmsiyhw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/27/23 13:52, Junio C Hamano wrote:
> OK, Dscho says v1 looks good, and I have no further comments.
>
> Pratyush, can I expect that you take further comments and usher
> these patches to your tree, and eventually tell me to pull from your
> repository?
>
> Thanks, all.

Junio,

I see you merged latest git-gui from Pratyush onto next. As git-gui has 
no test facility I merged your py/git-gui-updates (a7935203) into your 
master (5dc72c0f), built on both Linux and Cygwin. git-gui works as 
expected on both. Looks good to me.

Mark

