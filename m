Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3A61F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbeGZU61 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:58:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeGZU60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:58:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so2822456wrt.2
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bLQiQnU7sAgUsbQkEmKSTW9AOmpwueGkq2+Gi7r94hY=;
        b=Chg+2FTMFho5rb4e15WHAVs6qvT7pA9mvHjFU4PO5e9OwbZZn9esk4OM23wsLSUpdJ
         /bFLjDb2sBHSLTsFPqZ9avKaglsxDSvcNWbWejW7W5W8JNBI+4vPvXaYUrKAuh2Z5JTL
         6n58dwweSw8KuhcHa1Vu1eeaEON13fsjKPVCiwjAlf+hVPR4QuSeLcbovqFbK7zQoCg7
         6yzb0lVpv6MeL3VUr1INNRtTW+fnwdQymIqgYjUtqji/2s8jQdXdxsI6XD2SxVFcyvs5
         MA6hA2SKuyRfg/ZiW0Tmw7r/xpnQaEnGKbxX9iuYEwTXoMAF5oIki53qD0GNv6qHNnDF
         vapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bLQiQnU7sAgUsbQkEmKSTW9AOmpwueGkq2+Gi7r94hY=;
        b=MCYBGcUvgIngfhZmLVjUpKBvjcE83Mygk6Bdl86gvajFHcfTmT3RkAFcBwU/+XBadn
         +lsXYFypX8GnvnDqzlk2cuje3wRZuVdOi21YlsaerzsK4hID21a+LA88IvO+x37zKPIE
         2nW4zw9V8a7EpqPCaJ7CI2dN37+mQCWEfNOjd829xaMIa2/UULf+gHHmBSEXwPk6qw9f
         R8tYLvNIwAxjSLJUOwmMhslZsho4TsSSPps/OSFRcpxXSgc7n34MJX7j6k9+o+n3l+vJ
         V6KGI0e3aONtKciDBYXceK04kUspU4usHO5TTtswgzkROg8nFF0MCR03xhkfyTjc6v0b
         FGRw==
X-Gm-Message-State: AOUpUlEijY59vMqT/YLkJk+LrnqWXUokbXhoowQBq6z5/EOSS3I7Yxwm
        g3jyx182C3FWQm9W1/worlXrf0qL
X-Google-Smtp-Source: AAOMgpdPKhe++kv+h3uvW0vHYl2Qtb15tdXSzJ0wKsCPJz4seppnzDQCEGk/MLKhnKdd87SvpJuH9g==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr2671299wre.12.1532634006885;
        Thu, 26 Jul 2018 12:40:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v1-v6sm3951486wrs.34.2018.07.26.12.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:40:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
References: <20180718204458.20936-1-benpeart@microsoft.com>
        <20180718213420.GA17291@sigill.intra.peff.net>
        <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
        <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
        <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
        <20180724042017.GA13248@sigill.intra.peff.net>
        <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
        <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
        <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
        <20180726163049.GA15572@duynguyen.home>
Date:   Thu, 26 Jul 2018 12:40:05 -0700
In-Reply-To: <20180726163049.GA15572@duynguyen.home> (Duy Nguyen's message of
        "Thu, 26 Jul 2018 18:30:49 +0200")
Message-ID: <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I'm excited so I decided to try out anyway. This is what I've come up
> with. Switching trees on git.git shows it could skip plenty entries,
> so promising. It's ugly and it fails at t6020 though, there's still
> work ahead. But I think it'll stop here.

We are extremely shallow compared to projects like the kernel and
stuff from java land, so that is quite an interesting find.

