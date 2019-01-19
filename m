Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410EA1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 09:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfASJcv (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 04:32:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33019 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfASJcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 04:32:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so13675111ljd.0
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19LM4JMz0VVvPGvieEMrVgw+j04+hrbDGOTfXqeMlBI=;
        b=g37XIbzzc35nsQ35Nc+Qk3eNY/ShofKi/qreorAriWSGJNeMkjbNa+0qWepFpKO8sS
         mcyOwpdvBHsyZ7cFrSJ6EQ9ffZkQfGdtP6160YWbV7E7X3UkOAv14dfOfnr9djiAbDy3
         lEPXWS7yAv0On+3zrzXueTy8r/J/+zEGdvKQNsjYZcfZEQ7C+W3b6ggO+p2aury1YzJt
         TNXhd/ta76A5AV7hIjsOaaR19OFZoXinS5dcZfJQZ+/+l4vYqEhbN1EY+m9RuzYfvBo6
         mlMoKWjG8g/C9VmAKQ3A1l7DcixwaUs6AGhKrR5il1GUXZNPzAyXmE3azN8J0yvs26Cr
         lUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19LM4JMz0VVvPGvieEMrVgw+j04+hrbDGOTfXqeMlBI=;
        b=uKXxnrnlaRw6LDgapTmHw3zqTO0fRURBpGQhEUGDp3Q0Lg+fiFRer4RzvDI7IDXq98
         aNm2GRAPFMJhzhrpUC8ASo2PhLY/keJbSSDBkXX2AEDbdlk05IUY6GtlEARP65nkyOVU
         1Sg2ANrnGejIv7f5F5NkEQ4Xk/tHYBPZQgCCPivS6pgbmkKA9znMsxAZnpUe6P48kQpC
         xZ6GrWrbh5XOsSF5WgVymUtRCRL9X2SQIUGpJVS/9xcsAJcRY9l9gS3+Bz2JNLoGyKLJ
         ePiughWR8UQ1PJjn7dm2wMjUXZoUDHMekpz0Mjh6NFCtEXFYwQjZkS4nQ/SZvSd5pcbn
         TZZg==
X-Gm-Message-State: AJcUukcHGLycotmzMWIVMycQn9TgIB1jdGMTBZv8UB70u2mnXJUaaJlG
        M8YOc+4yUuEEs1nQJQliikgncTvUaja2sfh391U=
X-Google-Smtp-Source: ALg8bN4ylu+yAuDw3GD7oeRLKWHbH2mw2C37WzjSiZcor3vWHvp9dk6gnnmCV2SnxXCDEzY4Df30q/fjtCEZ06mMAcA=
X-Received: by 2002:a2e:9256:: with SMTP id v22-v6mr15148573ljg.178.1547890368601;
 Sat, 19 Jan 2019 01:32:48 -0800 (PST)
MIME-Version: 1.0
References: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
 <20190118170549.30403-1-szeder.dev@gmail.com> <20190118170549.30403-3-szeder.dev@gmail.com>
In-Reply-To: <20190118170549.30403-3-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 19 Jan 2019 10:32:36 +0100
Message-ID: <CAN0heSrAHGU0OE97XyVVajbNcA+Ed=gRr-3+opF7OPg6_FiBLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] commit-graph: don't call write_graph_chunk_large_edges()
 unnecessarily
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Jan 2019 at 18:23, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
> write_commit_graph() unconditionally invokes
> write_graph_chunk_large_edges(), even when it was decided earlier that
> that chunk won't be written.  Strictly speaking there is no bug here,
> because write_graph_chunk_large_edges() won't write anything if it

> Don't call write_graph_chunk_large_edges() when that chunk won't be
> written to spare an unnecessary iteration over all commits.

This commit message (including the one-line subject) needs some
s/_large_/_extra_/.

> -       write_graph_chunk_extra_edges(f, commits.list, commits.nr);
> +       if (num_extra_edges)
> +               write_graph_chunk_extra_edges(f, commits.list, commits.nr=
);

Martin
