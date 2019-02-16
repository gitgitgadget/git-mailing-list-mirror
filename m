Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1991F453
	for <e@80x24.org>; Sat, 16 Feb 2019 06:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfBPGlw (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 01:41:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38978 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBPGlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 01:41:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id p27so2113059edc.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 22:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRj+/7oGtqJ+AHfMRMCO2aJrjo1BrTidNj0NrEoTahA=;
        b=rOQGBrZ5yhr9+L80vGcAbqpYP8XTv8pr1NScKw++QYI4SotBVZJh7KPBWrJDQIZ+0n
         GqYoAXjovyT2hwVqqvfYvBIrrOZwoOEcnNcYmYp8WsoUA3fmpmyCmeveodvoUuPraIez
         R2PaC+rk2I5SYUVrqWa6n6TqrMTJ8RJhWyMzE+Wce3sHLJfcgDRafVxF58s08cRfdqWx
         +a4UgxGjVaGprV8025W9keNaBIoyAxKOwkzeV9lMaUyBHbx4glHw2yp5IulPvQVEa2Qp
         vtxr9LzVNk5YVtMy2TLDnZB1rFHRHEohOBCrU9XbIks8nYikP1WYFAUJB4A6DHuAXjfG
         nKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRj+/7oGtqJ+AHfMRMCO2aJrjo1BrTidNj0NrEoTahA=;
        b=F7n8nrmOS5nbctpDx7l/Hz8BwiC0Nha/kWqmCnT368lxhAJVsxWDpBQUo560Xa1MDk
         hibFpBQ8EgBQDcwI7/gMISys/ETcvEdlm7bWNm6Gnn0Cr0k03C+kh2HVLhinva3hcrO6
         ZGdCYPwZIHMjQsd039ji+GscCTI58pg3YiyZwG6M6JPYCY0uG7LXo6V2u8CuT+2laM77
         YBER22rUu8hsKmgy7lTDJ/HtR9/m3hpZdx36gd8IsXjHANk0TsrTxCsbtrggLqlJBs4d
         cPBHUXp/Ra61x93ZeuS9F1l0l/RQydRATLPDp43F9HFRDpFtNq23/AmZtI+ZEROPHnEr
         +E1Q==
X-Gm-Message-State: AHQUAua6BhciOyA96nmm27Rp1nHAyvj4uvJP87B/lABrXqkLqG6ts3YO
        SPrU5+dMvvJtB9/eITkPi6x82TA+Y/rHUcPdjwmLhga/uZ4=
X-Google-Smtp-Source: AHgI3IYHUHYxsNF8qHti02KYPvbdAZadKpYXJ52sMeMXEEBpMtAz4dV8sqUtm2aANE/0tj8itXWJf8XMRcQ/Q59rei8=
X-Received: by 2002:a17:906:4988:: with SMTP id p8mr9175575eju.75.1550299310550;
 Fri, 15 Feb 2019 22:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br> <20190215154913.18800-3-matheus.bernardino@usp.br>
In-Reply-To: <20190215154913.18800-3-matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 16 Feb 2019 07:41:38 +0100
Message-ID: <CAP8UFD3BvcdfbmYTsAprx0Au_AN2VUbuQd3LA0i9TBz0N4kfYQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 5:39 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API.

You may want to add that this simplifies the code and avoid recursive
calls of copy_or_link_directory().

Otherwise the patch looks good to me. Thanks.
