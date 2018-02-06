Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188451F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeBFEa5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:30:57 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42762 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFEa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:30:56 -0500
Received: by mail-qt0-f196.google.com with SMTP id i8so742429qtj.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kH/57ASpY0hVpadwch30OtFHJfIAzyHLpG5HtL1FEF4=;
        b=AMl0Rgy32i+ExPPbbxQZuD45+CbTjePAe+pVP2BLsTL1LkUX0v6F+REvm8LMj6cdAI
         zWe8dQznxGnaq+CLiU3Cwrz2rGIlukp/Tre6WLsJGth37SOb7lIewKjwTCRgx48MUz5L
         YSn+tmDXBzYO8WIabacuV6twoVcLU5m9tA1+29VJl8NfKEb+1AiQyGiBkNSiWXeXhCKB
         exR+IY8C7cIh2Sg84pW4dfaovh4n357FoeQg0tQ7vtpnN5ZdfXSrtYBrg2F8sd7DtvzI
         4Cgeq5GE7PavusjMQqY5uAE3xU5SlC8NX5KJSNnOxql/7gOwnv/GNtYsq73PDSWBD9t6
         rgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kH/57ASpY0hVpadwch30OtFHJfIAzyHLpG5HtL1FEF4=;
        b=tGCqgwWNM2FOe+wWQVDoA34VH2/IC2Er+/PwtzM0+teOP94nH/AU+scdvd78Pmx2aR
         BSyvKR/xE0J7gVcszSrIdTMsKgKu4gFwDki6iHhA05rmPKQVOlJCkxTyoriDYVHgKVsN
         BuTW6Q671OBPoL/1XQ2ETp21blD5xlC8fbkS17VFhO9cqS/WfOPr47WZNuVTuz3RWJ6V
         USMe1HI9f6NZYReyhIYwjDI+Knvstqlz6FAenCpvfR/+tl7Bo8X+yYI9jAYd0EpctZEC
         xO+Uyb+RZ16Uml0gQ/pLLULz1KIdcs0iknWVds8OqN3mFKylEtO+cJ1E4lwbILSc3n2b
         eI7w==
X-Gm-Message-State: APf1xPCoQculPLbc7ZPW5EfkNOZcWfY4Cimo7fmDB81Ue++4xuioV72U
        0giu1LBzqZqwCsRihhox2A453M9IFrawg8T4KRs=
X-Google-Smtp-Source: AH8x224bNBXfqFB5ot22qBKuHIzZ4iNpOnrp+SGdGTqIIHbnk2+OieRwysLkLRVAe8Qa4HduDYjYk1icvBxC/DaFMhA=
X-Received: by 10.200.27.67 with SMTP id p3mr1671301qtk.254.1517891455536;
 Mon, 05 Feb 2018 20:30:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:30:55 -0800 (PST)
In-Reply-To: <20180205235735.216710-30-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-30-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:30:55 -0500
X-Google-Sender-Auth: Otmh0w_yUa2UhZt6fgnfnbI2niQ
Message-ID: <CAPig+cRjQVJ5+ae+7Z=J-Sd_YDj1=L9=CYELbriTMYFkdZ+w+w@mail.gmail.com>
Subject: Re: [PATCH 050/194] replace-object: check_replace_refs is safe in
 multi repo environment
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
> In e1111cef23 (inline lookup_replace_object() calls, 2011-05-15) a shortcut
> for checking the object replacement was added by setting check_replace_refs
> to 0 once the replacements were evaluated to not exist. This works fine in
> with the assumption of only one repository in existence.
>
> The assumption won't hold true any more when we work on multiple instances
> of a repository structs (e.g. one struct per submodule), as the first
> repository to be inspected may have no replacements and would set the
> global variable. Other repositories would then completely omit their
> evaluation of replacements.
>
> This reverts back the meaning of the flag `check_replace_refs` of
> "Do we need to check with the lookup table?" to "Do we need read the

s/need read/need to read/

> replacement definition?", adding the bypassing logic to
> lookup_replace_object after the replacement definition was read.
> As with the original patch, delay the renaming of the global variable
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
