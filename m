Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223101F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeKJPbv (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:31:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55243 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeKJPbv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:31:51 -0500
Received: by mail-it1-f196.google.com with SMTP id a205-v6so450000itd.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPvJGusnZT82T/P2LtSJjV5b47tBh8PlxZTTiHuJcsM=;
        b=BcaMQ15Dbdm2shV8Cd2Ri7jODc+v8Km9vKdHxP3d8bxHVsyh4nKucS7fYKL3Y9hWv0
         Oed1LYRYap5fKYa+uGKfisJvJifZmQmK3M36cHEVbweq7Y4oByU9+UqR2zF1oOxCY+9V
         9CbvhaqSaC+L2XOC0f2lVLnnrqjicG3c08sAYnz2NIMqE48sBYjlTGWBjNDHEAXnl5uQ
         GMJWsOlqHoOtrDS1CRqP1n28YT1AYwK3LolbGOspiV927SktJoqgi1UVKHM+59UgUa1n
         fs4lpeD3/yjy1OdQeVaOw/gcj5k42T9F+oSQi3T6rsJOLGjILtmvoexoiVi+IVHeOS/A
         OjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPvJGusnZT82T/P2LtSJjV5b47tBh8PlxZTTiHuJcsM=;
        b=IQETA7k7TqxVWAzOmzh+GmtAWbgJii2G/aUXxvxpEDWYO+O6QbYyxqLk57MSRroJ3s
         zB7n4i7fYP4vJx8rmnS552QlW0vecVjGHmR1/mgsKem56LHAyKxZMX8oF2jyzLqA0my1
         m4nOVoM9ZAf1+IOxBjpMNzu5NA2uy1h852wa32pw7bPt4KDanAKioyxOBwejeIPv58Oc
         VslEXsQ+3rfxcRL1zXSzGOaGobtw83kxSWQUARlAAfCiJTTvf1xsAz1z2d6DnyQcPcM0
         tl1tmWo1IgcL/NKz1/toFZeyBciCEhgIbXh90ZJDRxBK/xF80mSptF6vR64+NXZp9ftZ
         mGlg==
X-Gm-Message-State: AGRZ1gJ+FeFoX1GBUz6hE66PlxBnYQZ0iWIdnvA1nt8bWsPzhjZ9zRv0
        lLDz0DDlXMmwheJrGizUidEGzvkyQXX2nCvvotc=
X-Google-Smtp-Source: AJdET5eupB/07I5hHJzZYuAV/jap6QxMaMah8N5jba0rYpm23i2eLQex2a/OcNlnqkUuiKNnMsZM7+pp35ngyDxL9sM=
X-Received: by 2002:a24:61c2:: with SMTP id s185-v6mr3178876itc.70.1541825761902;
 Fri, 09 Nov 2018 20:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181105192059.20303-1-pclouds@gmail.com>
 <20181105192059.20303-13-pclouds@gmail.com> <xmqqpnvjexzf.fsf@gitster-ct.c.googlers.com>
 <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
In-Reply-To: <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Nov 2018 05:55:34 +0100
Message-ID: <CACsJy8CM=0Cw1WCamJJe8aapA4-mdr+rMmbjVpYYQCj2++NQbA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] parse-options: replace opterror() with optname()
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 3:07 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> Also, this patch does not replace opterror() calls outside of
> the 'parse-options.c' file with optname(). This tickles my
> static-check.pl script, since optname() is an external function
> which is only called from 'parse-options.c'.
>
> So, at present, optname() could be marked as a local 'static'
> symbol. However, I could also imagine it being used by new callers
> outside of 'parse-options.c' in the future. (maybe) Your call. ;-)

I was making it static, but the compiler complained about undefined
function and I would need to either move optname() up in
parse-options.c or add a forward declaration (but I was going to
_remove_ the declaration!)

Since it could be potentially used by Jeff's series (and I think it
does have potential in parse-options-cb.c), I'll just leave it
exported and caress your static-check.pl script (how did it not catch
optbug() not being used outside parse-options.c either)?
-- 
Duy
