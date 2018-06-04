Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2681F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeFDOoj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:44:39 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35881 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDOoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:44:38 -0400
Received: by mail-ot0-f193.google.com with SMTP id m11-v6so37921549otf.3
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hYzcPy+6BVlBdV+/Pzpgz/FVCYKJ08guOFM2XiGlaUI=;
        b=f7aTs/7tzrnynEO2vPnTRrYWmgLyHnvb5gi5RBqBPB9/8aOA5awhzpwhLE4pGsSTSH
         R55UHKyMx8fqHX8I2umWcVydEGD/2MPAIZW8WUGm2+geCa4uj1G3f6m0DG+TwuD6GPBl
         SyEDrxDml2buuDVpW/a+froTiNBqd4PZBVsIzI6kcmVIgqKJl4/z+7oJg6V/D1gOaDCM
         ehNmMNGyyRLS9SUpWx+HEn9TLLecYw6+LgQvLnAXro94Z1rDbr7jaGuV7+xS/FdqV7+T
         Qi8pfH85diCZX1GOOiT4pmYqN9pJ6rs4FQ5J1fwHNveUwFPs/cXO/lWE6BnQHqQ0Xi0h
         hq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hYzcPy+6BVlBdV+/Pzpgz/FVCYKJ08guOFM2XiGlaUI=;
        b=rKPn3bXeg/eyEroKaP8xF7LUPhMXP2WAeaqVP34qHb5u5QWU1sLKJJWDuoZm1NaAUd
         2bfj1wtmB7GjNHZovhGiQoWlD+cetfU7gnYQ64JsvvX2naOJzbQVbOXwpt4wDIMyYu77
         c0xs8fjMV5Kn4e3Guk99bWCBZpBYpLq8hlnaE8McBcb3sek8oJOObzgIcLP4RCXKJjqj
         ZrLF5ik93QuelumrHbY9yvJZwvad+plyZIa9juUxPgtwBiDQjdQZV3+iT29ea2OSijH8
         nGPRn9FeSrxkU81u6v6tPBMr8Md8VSO+VCwH7+IW1P6VEXEsa+Az+dfwiH2Rgwo6lMtF
         QFxA==
X-Gm-Message-State: ALKqPwciE4Dxmcfl7coa2SS8yOSGoNKMZ08CciwMP4NBWTApGp+XtWYl
        R9tFvS+wNAHo7W9CMvS+Bkwv8IGVHCTm3aBAYZQ=
X-Google-Smtp-Source: ADUXVKINxzCkEu4eVGyR+AVyqi32i88fdZ4oybrANnVeaGcv6AVhJb3SKNzRBTZ0s3ZJGjkKf0LHV/IORGSAga7sHqE=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr15634424oth.75.1528123477722;
 Mon, 04 Jun 2018 07:44:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 07:44:07 -0700 (PDT)
In-Reply-To: <xmqq602y6d8c.fsf@gitster-ct.c.googlers.com>
References: <20180522194854.GA29564@inner.h.apk.li> <20180526113518.22403-1-pclouds@gmail.com>
 <xmqq602y6d8c.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Jun 2018 16:44:07 +0200
Message-ID: <CACsJy8D5105r0=_pzfz8fTciQeXWCBe-qhsobR+_TJvfz7cv4Q@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: reject shallow requests that would return nothing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> Shallow clones with --shallow-since or --shalow-exclude work by
>> running rev-list to get all reachable commits, then draw a boundary
>> between reachable and unreachable and send "shallow" requests based on
>> that.
>>
>> The code does miss one corner case: if rev-list returns nothing, we'll
>> have no border and we'll send no shallow requests back to the client
>> (i.e. no history cuts). This essentially means a full clone (or a full
>> branch if the client requests just one branch). One example is the
>> oldest commit is older than what is specified by --shallow-since.
>
> "the newest commit is older than", isn't it?  That is, the cutoff
> point specified is newer than the existing history.

Yes. As a result, the entirely history is cut, including the tip.
--shallow-exclude could also lead to this situation if the user
accidentally excludes everything.
--=20
Duy
