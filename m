Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A351F404
	for <e@80x24.org>; Mon, 16 Apr 2018 02:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDPCip (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 22:38:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39464 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeDPCip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 22:38:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id q6so9562950wrd.6
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bR9ZCS2CqS2Lt3VwLLVL9n0HdhKwH4e0q/p0pPiJbj8=;
        b=vc7VFfh2thek6/VLJdQb7jaN3xfPLhqQoYVE9Clbr5/dN2kTuLZO857iuQQatozsjG
         d006TgoO12EYAn901e2F9RLeU94oyxM9ewJsGHuYgdPxuIj1p0geuxZyr8OjStKpFkzN
         Nmw+GkaG0QzfIhXEj0kjYtROf47VacQHv7kliQvVioefZTxc88wwEFu/KftQZqKEqx6D
         2T+Yc9mEcyaFGr1bzoHc3aQyUMeSPO6mFdU7Cm1g43TUw40fXFsdZ3o5b6d0k25knPJb
         RG44yCrRMGl5YD7nKyCrXXO7kmpjCVGyRSFMsRTu3F6ireB3RocxDxdFBwlnShO/LMv6
         HEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bR9ZCS2CqS2Lt3VwLLVL9n0HdhKwH4e0q/p0pPiJbj8=;
        b=neyOeiZg7EnDYDJ+73MA63R+1BO36hWB3bupD7N5kJuazhJ58YUy5TWAfD28Xj1C5U
         sy5PXHtpzbnu7o+aQ4ojdmb7DQUsyM+s294YRQWUXqJMK0+bgLo5iNp6vkjnYIDQPneo
         hT97UUSViGrG9KQ7sx0mX10WHfM2zx4h8Rvs1ML1SP1sCTcvixlT6x7rqvLmNFF6Kzsr
         eLE0Q9CGaiCYq3bo7RmwVUWjOS84K+SDQcCPD6SyKOrsSZ76tdkDTO6NhtzpWxk00GTg
         7loPVSNJUuwFFL1s3f1VzaMylnXh3xPL+DmgLxq68pbZigAoXOgYMUS5r3KFz98dPYd2
         hZlg==
X-Gm-Message-State: ALQs6tBV6HakK6amoZQMX4Ro3rShCO6zWlAcydBI3qzf9lgY4uwdEUdq
        L3J7krQzFjFq2kYspywfBrg=
X-Google-Smtp-Source: AIpwx4+KV14jYdGzA9kS5uxCEVVDS56a0PZC6mf7lJiDTxTySlBXRpSdzDH/qz1B+BUik5uBYob/OA==
X-Received: by 10.223.226.205 with SMTP id d13mr9259449wrj.152.1523846323682;
        Sun, 15 Apr 2018 19:38:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r28sm11448521wra.78.2018.04.15.19.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 19:38:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
References: <20180326165520.802-1-pclouds@gmail.com>
        <20180415164238.9107-1-pclouds@gmail.com>
        <20180415164238.9107-4-pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 11:38:42 +0900
In-Reply-To: <20180415164238.9107-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 15 Apr 2018 18:42:35 +0200")
Message-ID: <xmqqr2nfyix9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +category_list () {
> +	command_list "$1" | awk '{print $2;}' | sort | uniq
> +}

Piping output of awk to sort/uniq, instead of processing all inside
awk within the END block of the script, means that we are wasting
two processes---I do not think we care too much about it, but some
people might.
