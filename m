Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00CC1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 15:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJTX0U (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 19:26:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37673 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeJTX0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 19:26:20 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so7779655ita.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t4J2K0m11koE49Q7O64b6RnefFQTSzXePwJ0RIloFhg=;
        b=mmk6GNcJHzqtG4xwSGuDzMydbCPomTy42l/ZDcehKURbTn/WGLFoqj0pTJ0c1R3vzV
         AAjuU50xfzQBZ48grobIy72Nn7r4CowVvGMbsLYNAW6TbPiStErLVVM7TSITU29sS8vF
         RHprsknl+5pPCF6xfLv4zJMApcZX78/kQsg5VKGjqFQs7tQytCobfIEL2gYAuSCN6QXo
         7coC+zr9IDbFj2KuNbDFeYhfzite6NraegwyafC98rrtVF3E5yjXtLatGN8EcokLkI7n
         zAnq67pRGZwVdfCgb0Vk9jpKYv2P8t07xo58DxgialxqfNgIONA6xAVbL6Pps27HY2+k
         qEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t4J2K0m11koE49Q7O64b6RnefFQTSzXePwJ0RIloFhg=;
        b=ebm+S/Hwkl571djqo4U1JXf3O4DnSHYK7TNApjdfeggeg48tLmPw7GHKZ/V7iMm/RE
         wOeJOzvz150tcct5fjLh9W6gQ2/VT0lnEzXjlLf9ozXLzOS61Qxtgrx02fhD2cbezGji
         0cHHyJB0DpDbvoGwxt7oy+g2o7aIKhDsO0OuP4chtj+6sReOkmpyuIdBRSM6tNP4yZx4
         Vn2k7Cy18qXUWwiE89Sri7n+gXsID1sE/MaS5UYJ3LgAcvpV/WXNzFSN8aScQQGb90sY
         q1nJNTD2lZ+eSHI55GBTUjyBDC6TKMTT7j+qz2EUaLD99n1yFJ4omOUhtNFJzO/sZSXF
         oCBg==
X-Gm-Message-State: ABuFfoioB/gvT3q94w4+wEh7P15nbRavXiw1RO7tgDwrRYGxzJzTTJfh
        XRaXf0J1BLwVqnlkDteo8W0mFNLPFNrIHaZt848=
X-Google-Smtp-Source: ACcGV61PPVMYjV2gqeoQqlUaX2KeKz17Dc9ZesuWKCLQfax1eVKbTemH1WMaYZEcJQ+hNMhaJXCC6ejEktfrKdzxgyk=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr5878775itc.123.1540048530365;
 Sat, 20 Oct 2018 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181020073334.48348-1-carenas@gmail.com>
In-Reply-To: <20181020073334.48348-1-carenas@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 20 Oct 2018 17:15:01 +0200
Message-ID: <CACsJy8B8q84=AqMvAkc5=oSPBbwMQkdQhRe=RYVKGYmnsGxVGA@mail.gmail.com>
Subject: Re: [PATCH] read-cache: use of memory after it is freed
To:     carenas@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 9:33 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> introduced with c46c406ae1e (trace.h: support nested performance tracing)
> on Aug 18, 2018 but not affecting maint
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 1df5c16dbc..78f47d2f50 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2297,8 +2297,8 @@ int read_index_from(struct index_state *istate, con=
st char *path,
>         freshen_shared_index(base_path, 0);
>         merge_base_index(istate);
>         post_read_index_from(istate);
> -       free(base_path);
>         trace_performance_leave("read cache %s", base_path);
> +       free(base_path);

Oops. Ack.

>         return ret;
>  }
>
> --
> 2.19.1
>


--=20
Duy
