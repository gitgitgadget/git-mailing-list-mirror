Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8124420248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfCOKGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:06:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43936 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfCOKGK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:06:10 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so7692802ioq.10
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+CndEfNJy65qmpWIyfEj+bysdbeK/wTLvVoKYGyd3Q=;
        b=Y1R+E9FQTIx0Cnz1HU6Rt2zCugU5M6sJU+zmnekLrtV+fAIPjY2529ke16j9lHq4dq
         j7m/+Oe6OHAbpBZWmJM4CJOVlTFPu2A8opXoIawTRTOI/iITgKjOlb+AVbLxR2CV14DD
         nnl6eXDCuhdwTEvPS4VyrTJz7nPD6XIXwrnP4Zq9ThncMQWfh0NCNSB9ngwSKs0EPrun
         Dy8qqNtTaZU8w6LO4rJtl1mf7Hvy+EaZWEKIRr0Z1ZAdEOOs9SJRT8dPsdjucn43qX4y
         27pvdBWDQlnOlu0al0JalLNQLfslApumesGNBbgne8SvJcN85+5ChB2IizZY88kGzc0l
         UGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+CndEfNJy65qmpWIyfEj+bysdbeK/wTLvVoKYGyd3Q=;
        b=i2zCloIwGKBHhdnK+zJBhLo3Q5R0ch9SL+OQ6alRTOSGUF1v6nbJa7O2zfTx2+DxQp
         Y3CdpwtqjFQc8oLkBYB8A6Dq0NeL9wlXnDOWsyawJLbFCFZJBMNqrgB+c5HrEMbk2048
         YaomnN3ojskBYHKbvaeep777X8cVRzCcSNLmsxvLRRrs9mLFSLqQUgBLZ5MmBaRcqM7H
         r9wsxgiP0ZxwEiaq75ZmXyQ6yPvInVDOg/zrM1BbXa1ZETp5vF838uDxWkvzA3IHTj9/
         zyjs3ab7yv71PYl0XiOXiOCc88zMdvqFw0mucllmtO4ImPmyxCLlV+nFISoGNIEglzCC
         +K+g==
X-Gm-Message-State: APjAAAVUaszhCVAAoDk41Z59dhPKDYon5CWdX/P39uou2czd33Wtdw5Y
        +CEJ00SZEeiuoPDrHZ3fNKML1daedMOtCFOevTM=
X-Google-Smtp-Source: APXvYqwTSPR0X6tvASK601D/NR537pgC+7wLT5VNynUL4iEOZS6Ub0kkPP1qfU5R7wD79MvkeeZJUc/7tlkmA9LEZ3U=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr1657009iom.118.1552644369406;
 Fri, 15 Mar 2019 03:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-7-avarab@gmail.com>
In-Reply-To: <20190314123439.4347-7-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 17:05:43 +0700
Message-ID: <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping reflogs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> @@ -127,6 +140,10 @@ static void gc_config(void)
>                         pack_refs =3D git_config_bool("gc.packrefs", valu=
e);
>         }
>
> +       if (gc_config_is_timestamp_never("gc.reflogexpire") &&
> +           gc_config_is_timestamp_never("gc.reflogexpireunreachable"))

Nit. configset api normalizes the key internally, so we can safely
write gc.reflogExpireUnreachable here, which is a bit easier to read.
--=20
Duy
