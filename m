Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF921F453
	for <e@80x24.org>; Wed, 19 Sep 2018 21:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITDBx (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 23:01:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbeITDBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 23:01:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so3293224pfd.4
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f3fE9kTOTbOh2yEGkJwQvCU61kfITFbaknz+DWO9bMo=;
        b=dDxmaFk58GmXpah7jOoi24goc0qF56ACTWD7GVBnHBZgenw5xSs9bSPymXrk5A0PQt
         DlJlz6E5a8x8V2fzVSgxk/aIt0jpAZ7Nfc8D1QE99IR4z5kmG/piXnVgEOsvdQY/2jMh
         kSC/mjyGk2sHGYAh0sTvdDgDS/jrjRVglEUXM2ORI5UCpCF0f439e+n80uDyu8ZyHtoY
         DxGzf1vXOQQ5dq9t4dHEadBJQmmEU6rpopYNfi+EHnM+J9wDcorQPwJ0Q+Q/l6L1npG1
         HjrGxGWOZvybGbI8bvsetH8lWPKf+NP5Wc3dQQRsMZA/RvTAng2llX4LcV+lTZHSR6gX
         X+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f3fE9kTOTbOh2yEGkJwQvCU61kfITFbaknz+DWO9bMo=;
        b=VMtR7vbUtf9KTI4ZzUxSk9/H2zZe+3V4YUuk/wfsaVRsVPqg++gC+LXiVa+53JgvW5
         URpucHwA2G26KF6Rps0ffVYq6eF1DTEQiv4pVjYzrNAGs+y43TQd2++8KK5GNYTV1pjj
         2aXkVrVV+Xa3GfHzidJlM1PZcQsRLmfDBIC3aWzMu4VLMyUAuwIufsMIfHufxjbD+4RC
         JKkS7cVhJhnoDD5PGisXyBt6f5jUZ2rLR5k3RSQ6rmemK4YRGdeh7xw+VnZT5eE16dCK
         Hx1U5mSoQZ9vvoIAz3cgFxHXtngD8MdUKmhtKVldTUaCCh9Z5uzee1S+TPjFb5kMbqI2
         nyLw==
X-Gm-Message-State: APzg51BWFqxgbKR1y7MhmvmqYIJanq0+PBqkJozPRlMASz+0CvIWuzk6
        h4q+rXkYqUZ9YuwSal4oFoV0dkjQsgl2L1JfdyA=
X-Google-Smtp-Source: ANB0VdaaeJP4d/eysp7lOcfylLvKuwRFypPZwVyUNt0TpwU18PxTmVIPjTypTSROCj43iHbRI2x/AnCs2n3OK0RG4JY=
X-Received: by 2002:a62:8208:: with SMTP id w8-v6mr37352015pfd.215.1537392125949;
 Wed, 19 Sep 2018 14:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180919210138.31940-1-avarab@gmail.com>
In-Reply-To: <20180919210138.31940-1-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Sep 2018 23:21:54 +0200
Message-ID: <CAN0heSr=upqAVzjm=gQoGVnOjBZcDWhmj3W8gFFa8bcfCgaHTg@mail.gmail.com>
Subject: Re: [PATCH] gc: fix regression in 7b0f229222 impacting --quiet
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Sep 2018 at 23:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> Fix a regression in my recent 7b0f229222 ("commit-graph write: add
> progress output", 2018-09-17), the newly added progress output for
> "commit-graph write" didn't check the --quiet option.

s/, t/. T/, perhaps. Maybe also s/did/does/.

> Do so, and add a test asserting that this works as expected. Since the
> TTY perquisite isn't available everywhere let's add a version of this

s/perq/prereq/

> that both requires and doesn't require that. This test might be overly
> specific and will break if new progress output is added, but I think
> it'll serve as a good reminder to test the undertested progress
> mode(s).

> +test_expect_success 'gc --no-quiet' '
> +       git -c gc.writeCommitGraph=3Dtrue gc --no-quiet >stdout 2>stderr =
&&
> +       ! test -s stdout &&

`test_must_be_empty` for easier debugging?

> +       test_line_count =3D 1 stderr &&
> +       test_i18ngrep "Computing commit graph generation numbers" stderr
> +'
