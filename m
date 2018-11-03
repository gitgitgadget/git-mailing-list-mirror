Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699601F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeKDAyk (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:54:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40009 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDAyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:54:40 -0400
Received: by mail-it1-f194.google.com with SMTP id e11so3822238itl.5
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VWHTlejzjVTr49TfVXlz/hSVn1buBSjohe+0jU+/l4A=;
        b=ZjgYvA5q5zLjAvncNRMWpvuQ0HsInkBqQadMF7OUZqYfhP+VYXKURgcS+ADIExqAKr
         1C7C50pkL/M8nT5MZ59VeoHJDxKtpix7tJCok2NH40juB7324OvO4uv4XcO+bKZE343n
         WndDWLepotNjogjC9Gcc3PoqrDxFABQ3H4qndOwXorzIhTKwfPu5R3kVvBJxilndQIFX
         +f7zUxGarGJQJasr8cQW2EienqkKwjL9k4/t4og77EkH2KXbVq2f5Z2rc5xPgCbfLXre
         uBG077Jq15Ha8BuGI4/K9FWsy7wTsCDeynxj+AMh6T5O+9l6UWhDmhdgRo5r0gxhN1v+
         SwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VWHTlejzjVTr49TfVXlz/hSVn1buBSjohe+0jU+/l4A=;
        b=fGoEiVQCZyQqIVcZNedOAk7FW1YF43L/aDwHPHEC8APqQyhkOkTgpHMTyBPSR8rHMs
         yidU2Iq4CnD3wdXRjftTbhSAqRWCXhroMTOKvnDXJBL5wIKL3NyrpBq3EKb3Jbl5+1rD
         0B5de0W5XiSKUhtexIRrhnnqgvJM5SzRiBhwFNecKq5nVr+8oZFtNxvvnbbYFNaKxZA4
         qXBSZr/TtOEu//cCUJULdKn4TPJmZWsmHEYPF+IAcDsfTml6E1ZC0+3aB5K6v+kohVlW
         Kmv+0WTeUFzHTULCy92qdzxBvS/aZpEwthDTnugvVGy5Qb2qoZv/e+Bk+kMZEyomBh0M
         L/Hg==
X-Gm-Message-State: AGRZ1gLbPHpSPvHOT/Zpf9ggKb1G+4LBczwkkOJOI5vFy0qtTYRjC9UF
        6r23+kryJrvwvUaljuyosOVRNh8YKVZm1NZHEigz8Q==
X-Google-Smtp-Source: AJdET5e3/K0BEeYANiuE/R3C7wnqjwYEAjJXtIZSCRMKRvJJGZ1vYcyl/STW+ZdpBinZDhb/uV/JcrcdFlUIKB1gdzc=
X-Received: by 2002:a02:9795:: with SMTP id s21-v6mr14203524jaj.92.1541259780237;
 Sat, 03 Nov 2018 08:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181020193020.28517-1-mgorny@gentoo.org> <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
 <1541259137.1028.12.camel@gentoo.org>
In-Reply-To: <1541259137.1028.12.camel@gentoo.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 16:42:34 +0100
Message-ID: <CACsJy8AU5fbb2JgRNj9NVvJ9OsmO03LjX4x1rKe-Ls8V9xVK0w@mail.gmail.com>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures
 on commits
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 4:32 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> w=
rote:
> Perhaps this is indeed specific to this version of GnuPG.  The tests
> pass for me with both 1.4.21 and 2.2.10.  We don't have 2.1* in Gentoo
> anymore.

Updated to 2.2.8 and the test is passed.
--=20
Duy
