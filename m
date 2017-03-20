Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507352095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbdCTMnS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:43:18 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35582 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbdCTMnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:43:15 -0400
Received: by mail-ot0-f176.google.com with SMTP id x37so131358175ota.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03SrS2Q4LXRCJEx6+DVaD54e4T2sXk8rHW7E10RFMYA=;
        b=IefGmqE9O5LYlbZbZy93nxB1u3cCONKvnRHuWNJCzVrJ5rursXceB/FrzKEnP8EJph
         lnDa5/8FrrCK4JoxgjAk86Iqaza8WPctAz+TDFhBLA0z7Eq+IWI1tiplpvezotiTvkVW
         yLihISmNsyoNlf1lDjH49m/pc7RfxKE2cEnvhfTD+xeP0deeBpTG36FklifJAeq2Qipi
         jonle0t/8QQzXLNXfXWxTeEb4v152vK/DgNyPhCX9HSRzO5z8zYmdZ1NoPKiAaMdgJ51
         qrVyesPnqQoXgcQyuiFxXjdQoKk1lq5DerUI/RRIJPFppHlmFvpdI0vMBHBBQBFMr5si
         wPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03SrS2Q4LXRCJEx6+DVaD54e4T2sXk8rHW7E10RFMYA=;
        b=QVMAvgTzXrqkTEgkad26A3QauWoPW3+U2DoH0b0EztP3ubKuCQQpsowKoXbr3IzIcj
         vNgCx5MF98cV6ruQZFTBX/PUDGfiGyZFFOZs1QAbr9MHUuzeFIjIJxcuiYh6YNOHcEJ1
         8xZUQLq7HU8xv+ulKEMxGYGg+AnXrjSAMIS2cuA/UCX667C5vPRlMUrppjMZthAy8syP
         VGqJekbysLcIZsDDhslrcDzj5ndG4BCF7tfaV9DlEg/ybpo3tRRWau91zqaGQy5yHgLU
         7PLJmXunju5K/bHTxhVaKTpyUfnttHMzpat9wi6vSsmP6zkWpooALVytAqlAp34mV8F4
         QV5A==
X-Gm-Message-State: AFeK/H1mluVbSZduRr0xe44yaQjeYgB1aPBt8ppvD8p+YDrIcBIRyAHiFDugzVOedOvR1nWbaHKJyK8394Y/Kg==
X-Received: by 10.157.46.137 with SMTP id w9mr15962557ota.225.1490011895526;
 Mon, 20 Mar 2017 05:11:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:11:05 -0700 (PDT)
In-Reply-To: <45b2b743-4eb0-3511-a48f-1a4725d67c36@alum.mit.edu>
References: <20170222140450.30886-1-pclouds@gmail.com> <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-17-pclouds@gmail.com> <45b2b743-4eb0-3511-a48f-1a4725d67c36@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:11:05 +0700
Message-ID: <CACsJy8CC-BDHPLnE8DAXCxpttwgEsrQU9gzzc=PGsmFnh=XNpw@mail.gmail.com>
Subject: Re: [PATCH v6 16/27] path.c: move some code out of strbuf_git_path_submodule()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 3:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 03/18/2017 03:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> refs is learning to avoid path rewriting that is done by
>> strbuf_git_path_submodule(). Factor out this code so it could be reused
>> by refs*
>
> Is the "*" on the previous line is a typo, or did you want to add a
> footnote, or ...?

It's a wildcard for "all refs functions" :D Will rephrase.
--=20
Duy
