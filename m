Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A941F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeBAKDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:03:11 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42699 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeBAKDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:03:10 -0500
Received: by mail-ot0-f180.google.com with SMTP id a7so13461439otk.9
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R4soU3CUhAcJHosTFpiTrifW9tEUAwTmLngOajZ55as=;
        b=GjOg1CoCprRTtAAxIL+gQH/hHlwzN7mV1VVLuAFWxZc8yF0lQKz9+FRq1J9hr6F738
         M73KgIiUHK7zLuIU2yQG0pDTSSmHPLJFWmLVvXFjCmh7YKQVPNXb9KeWVu7SzM20nefZ
         VMuGm1Eohx6Hh66iUa8BzYKnvpfWEluFeTg4RUHQcl7xSyW+W5lWc5CwxIk7xEWgrg2N
         5a5U6PXQ+Oy461xV9xgGEAFluEDQMgOmtllLwvEq47m1jMvEXVR+ap5lSewgs6t8JenK
         /6hCY98KeTeOWi9+yLPlaxlZGqGDTMNOQUuKh7S6dEESeIw2ffVagKdoBqM/RzJFdeQs
         +ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4soU3CUhAcJHosTFpiTrifW9tEUAwTmLngOajZ55as=;
        b=szcJTZ1LiwcdraPAWvALE6zt1U+yAXouRTyQmcTybH0iAeOV+eqiNOvceArqT2eF0z
         KHCfbj/YDJJ6q8oz+y8nCLefAjsceP15k00An/mzmex9Dam/8Xva7zqqcYqNqbId+M09
         IyJdKdh1P4xUC6EvJx5D76D1uxE3svJifuVmG7bCvGC6TqVzbrPrhQgQJ7Lszdoj7Vnl
         6MCRkLktsaAUARqDR1zeLEVi/R5MZAW+LEFFRiibpphYbBzljgDuR9bhEDrnSWSqU7LZ
         e5Jdzl/CgVWboIG4pPrXSWmUaKDtQpMh9HHfx94ZjcqkyIAP19C9frN5qx0GeTWQz2cc
         HKMQ==
X-Gm-Message-State: AKwxyte5ytNdkcb35027GadPTAH35u+fDPafkTXBagg5nUX/Sj+CbQPq
        IOKLB/9H4Aek1XjBPh+ttadcidzyrH2jKxoJgxw=
X-Google-Smtp-Source: AH8x227XQ0MwZ5HtZSCdkJWaN0en/KAr91f/ArXNQgkjyw/dtlK/rV0zwFuU5yEasrqu4MaJ9KCGZlFI1re39HJD4eg=
X-Received: by 10.157.47.177 with SMTP id r46mr16711421otb.301.1517479389792;
 Thu, 01 Feb 2018 02:03:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Thu, 1 Feb 2018 02:02:39 -0800 (PST)
In-Reply-To: <xmqqlggdr519.fsf@gitster-ct.c.googlers.com>
References: <20180126095520.919-1-pclouds@gmail.com> <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-5-pclouds@gmail.com> <xmqqlggdr519.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Feb 2018 17:02:39 +0700
Message-ID: <CACsJy8D8PaDR0r+6AKMgPo9UBcWYQC8goaVkVhxMCXCa1E9F9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rebase: introduce and use pseudo-ref ORIG_COMMIT
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tim Landscheidt <tim@tim-landscheidt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> The new command `git rebase --show-current-patch` is useful for seeing
>> the commit related to the current rebase state. Some however may find
>> the "git show" command behind it too limiting. You may want to
>> increase context lines, do a diff that ignores whitespaces...
>>
>> For these advanced use cases, the user can execute any command they
>> want with the new pseudo ref ORIG_COMMIT.
>>
>> This also helps show where the stopped commit is from, which is hard
>> to see from the previous patch which implements --show-current-patch.
>>
>> Helped-by: Tim Landscheidt <tim@tim-landscheidt.de>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>
> Hmph, how is this new file conceptually different from existing ones
> like CHERRY_PICK_HEAD?

Conceptually the same, except that CHERRY_PICK_HEAD can't be reused
because it's specifically tied to git-cherry-pick (there's even code
that delete this ref if cherry-pick is run as part of rebase, and
git-status uses this ref to see if a cherry-pick is in progress).
There's also REVERT_HEAD in sequencer.c, same purpose but for
git-revert. Perhaps I should rename this new ref to REBASE_HEAD to
follow the same naming?
--=20
Duy
