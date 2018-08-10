Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6E91F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeHJXrX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:47:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52891 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeHJXrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:47:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so3196786wmh.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKjjSn6tK8rxzaC1VHoGN94iSIOhDC9ULvqWJHT/jyg=;
        b=EZVnHqB+6qQ0oU8oHXLar2HEwnYYCjRdYB+S7pZxmGT2gewQr2Sxb7+4uwuzOomBrk
         ytYVNm4lYAYDtq725aYhvkQUJ0TEglzMh5DuJZmSNV+O1gtBy/bMEkXOpH2OpEF7WmkY
         leze+mdQs2LofPBKJJB0aa4y+rt9xXBLgjj59LQdjzSGZYSrH9WP0vY140QvmVHZIYqM
         HZ0YKMMmD2MzPmVQDIF8aUGquku96dQYtTFe+XSH9/GyqJejzLWcb1rWpz787r8UcEPk
         9bIK1KdsTZhOGBrcKrcFH+gjPxjH9OP5HA6J9exrtHJy3kpBv8yT7H5c/oUb2zfKLrOf
         3sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKjjSn6tK8rxzaC1VHoGN94iSIOhDC9ULvqWJHT/jyg=;
        b=atoU41E3RmNYfx1gX0Cl6uW6KGWDlsvko2y1qwKbyO8WaBOczJvY0TazeJbETuicmL
         zZQlrOQiOkoTSKQVVntdWDUy6ZEvyTcBMBQadl9DeQFvkDy+eqZibxncadlfIE2kBtLf
         tgnOqbTCGrRP2tCO7FzwseQJ6e+wA380Mmkgg6cHiyVFtHME7Ks4hiqSRTpEfwVoB7pH
         bnRimzEJelgrHc4ndpcIOP8r+gsgtOF+QNV4WXeQTavKO7r3k5eq91RYXe3QIoz4TbtG
         QTh6rDBwz+TGvtoAXO0zuHkHxV0MQ24L4AZtR80AQtGC0O2wciXPMRlohQ5jNkoCX6hw
         v29Q==
X-Gm-Message-State: AOUpUlE2Gu6nPtKOcBfYqNNHcz5xP19crPFSCdfx6ZeBzwcAJ9Okg/4Z
        PcBeUF4PHFg1j85OdyCfyUI=
X-Google-Smtp-Source: AA+uWPw6ghrwDp94y/VQll1Ao9ZWBWWEkVynYEoKjhDZyPFFnwmt63DDcYsaYwWG9iMy44IHehT14g==
X-Received: by 2002:a1c:8b86:: with SMTP id n128-v6mr912627wmd.42.1533935748936;
        Fri, 10 Aug 2018 14:15:48 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.gmail.com with ESMTPSA id s10-v6sm5031126wmd.22.2018.08.10.14.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 14:15:47 -0700 (PDT)
Subject: Re: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180810165147.4779-12-alban.gruin@gmail.com>
 <xmqq4lg281ms.fsf@gitster-ct.c.googlers.com>
 <453e3f0c-6c68-71e1-0338-185f129bb778@gmail.com>
 <xmqqva8i6k7b.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d26636f9-8cf9-3bfd-0fd5-1ab9ea3da169@gmail.com>
Date:   Fri, 10 Aug 2018 23:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqva8i6k7b.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 10/08/2018 à 22:27, Junio C Hamano a écrit :
> If we are planning to make all the backend responsible for stashing
> away before they run and applying the stash after they are done,
> then it might make sense to have the application side on the backend
> as the first step.  But if what you need to do to stash away local
> changes and what you need to do to reapply the stash is the same for
> all backends, wouldn't it make more sense to have the logic in the
> caller side?
> 
> 

Yes.

