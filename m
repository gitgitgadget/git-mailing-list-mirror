Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F71A1F97F
	for <e@80x24.org>; Fri, 12 Oct 2018 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeJMHGy (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:06:54 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:44474 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeJMHGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:06:54 -0400
Received: by mail-pg1-f176.google.com with SMTP id g2-v6so6499285pgu.11
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3vMjId5kqkzz+iVsx39MCN/Jahuaw/1Zg0/pZ1t+wI4=;
        b=YlP/4M6bJXrRn7Wzcy/MyxEWDkBkg722pFX3sti5JHUKM5X/MweauWJeoXrfqSN5fu
         J8VAlwbqvs/zeVDlihtMYX+rZFaEbYKUv40t6RoAj+OYtH9ZSpp9x5jismSZSDtymNSi
         4Sifojo6ZSu9e1cPVHd9v2uWo3aZAS/5im7q9hxuTZ16IS/8B17sw/ntPQzUTb1T1v09
         WtK/cE8334lk5ph5fgvzfyLpGc4bz3KZXyXsyM1nz7B/91qMJO3IwIWX0P0SpQwc3+Ts
         9ae8JqoTfjKAzbnMn5+TiXtA+okPBk4Ml8P+kvQPYwlSMAAahtFhespnbBwzoNLlmC03
         kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vMjId5kqkzz+iVsx39MCN/Jahuaw/1Zg0/pZ1t+wI4=;
        b=gGDVct6lxFlnGsPwWelZADvj71GXaIMAhvREM4DA1vTYraK1VWUi0z4Pl91xjT+6aX
         JGEMq4v9CLPjDZ54fPnW6J0x6h0UVciib+0zfwCm9xA+6kY44GpdvHXUpwtavTgjg7BN
         MPk1nTmDlJJA/ylkGuTGHnlg/0egc53UWKp8I502ODbShtH7ubRgapDy30aextFg/hJV
         bgIxfU7sg7A0+TGN4PMjOnIfiusyzgde/p4XNUGfGZYfa+CHR6g7+YpD5HbeT2/y2PvA
         cxL+NvWevx4rhbhbU0Y/ivEEq2bVj/3BEg98XHL+7jRGd9KThURn8ui6+st5OS7j4LF7
         qqSQ==
X-Gm-Message-State: ABuFfoi9wyiIpZCQaiLTpoKxxKn5JQB7u7pQ8oB3n29UJLUKfwZUBjOy
        6WtcvQvv5dpKp4GNaLxUAx9MYUqA
X-Google-Smtp-Source: ACcGV60XvZkFYcTiy9RT7F9j8kLSUoRq81238JIWtowKwWQ2qTG+LwQOVaNiS8Rk+yiIp1Z2FuULFg==
X-Received: by 2002:a63:2f81:: with SMTP id v123-v6mr7034967pgv.223.1539387129900;
        Fri, 12 Oct 2018 16:32:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k86-v6sm3500136pfb.167.2018.10.12.16.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 16:32:09 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:32:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181012233207.GE52080@aiede.svl.corp.google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
 <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
 <20181010235303.GB12177@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010235303.GB12177@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> For now, I'm going to try adding an --allowed_versions flag for the
> remote helpers, but if anyone has a better idea, let me know.

I forgot to mention: the stateless-connect remote helper capability is
still experimental so you're free to change its interface (e.g. to
change the syntax of the stateless-connect command it provides).

Thanks again,
Jonathan
