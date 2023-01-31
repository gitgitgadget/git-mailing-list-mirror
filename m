Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB2C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjAaVFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjAaVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 16:05:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDFF2739
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:05:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m2so11394805plg.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 13:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byx9eENnHUvxyMGm6l6Obf0HD6je0+YdTWmEpzhKgSw=;
        b=iUPICnzK63wshMXvzYSr3rsE5e/HYDfGMlat4nuop2v7fNo8g79C3U8L3QeEA9z7Ie
         gl8rIBQ9vAHFdmBj0NQOi6YNsnYLEMIMt41gxhUX9wJ1qco0LoCouzWDJQ4BA/8f4Q9A
         kKQeo+tekHR7qrrZmSNDQ9dpaSEt6OJ+e6MXhP6FjeVfk17LdY7GRL1mB/pRseQg71TV
         1EX4ZjTiRFu+SCx4IpGudOYaD7k+dp8yhSDXy1RrC4sqnbUxDOP5Dph9wQU+UTxS0Huf
         YAKh99q150iT7b2FlDMQuFoJ/088nXIoN50mb6OLj4IFbJTm3R/O6OHTi+/S6JJ4SRYD
         ZehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=byx9eENnHUvxyMGm6l6Obf0HD6je0+YdTWmEpzhKgSw=;
        b=vu5I6uc+jbUfF6i7XGksIa529RpROK8mRDVOUUzwL5JvHhyUofewMkToOzR4dFtA40
         Vsg4JkPqJUnZnOapqAvvYNPOvvwLfjImL+B75LQQomdrVqd9sGJpYmakiJd5Ff1L/3mq
         mtDXWytc7CfW6yckpQgAeHrKPAhuMZZZAsqB++LYaOP7RyYkkLOAtTVdmqTFVywEAWzS
         gTJYw98GorlghJSPIJhFxvs/vGUaWIeUizmd/D957wkRPhKbF8ddBI47sKEnuDLkvYIT
         vUPmwAblM9/knklEOCAivmes8jyj/OdoWT0kXJaf5xfNrxy1N7FZkaLnfjyry4HRlwT5
         zUrg==
X-Gm-Message-State: AO0yUKXDMC/wkDQyloPsTzsZ9cuWOvLj3oEz8GIUzLs481rUDcC7QHPI
        10MctA7g23ehwZGY/TQinuE=
X-Google-Smtp-Source: AK7set8od/1PSaNtmsVjKQ0cTbjJo6BZ6JF7hNQL3NjQ544Sw/LepPuB9dNlpycjudLQmMbks38EHA==
X-Received: by 2002:a17:90a:e7ca:b0:22c:932:2870 with SMTP id kb10-20020a17090ae7ca00b0022c09322870mr26026009pjb.33.1675199114865;
        Tue, 31 Jan 2023 13:05:14 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id mj8-20020a17090b368800b0021900ba8eeesm11535081pjb.2.2023.01.31.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:05:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v3] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20230127154952.485913-1-minipli@grsecurity.net>
        <20230131185611.520311-1-minipli@grsecurity.net>
Date:   Tue, 31 Jan 2023 13:05:13 -0800
In-Reply-To: <20230131185611.520311-1-minipli@grsecurity.net> (Mathias
        Krause's message of "Tue, 31 Jan 2023 19:56:11 +0100")
Message-ID: <xmqqedraxvna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> Mention the possibility to prefix a failing pattern with '(*NO_JIT)' in
> case we run into the JIT's limitations, as per Junio. Also clip the
> printed pattern to ensure the hint actually gets printed.

Looking good.  Will queue.  Thanks.
