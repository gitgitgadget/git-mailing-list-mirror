Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E991F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeKCBIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:08:23 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:39347 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:08:23 -0400
Received: by mail-it1-f179.google.com with SMTP id m15so3813406itl.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IfXfv77iXiIu8iXpca9xREgrH+4T28RgkwzpjRiYZ4=;
        b=AlFOWk/r3B4S0Pd+emegB8jFD0KW0sGDMfvMDzWz/8TkggoulUEl4VsS9rIlFRUZJO
         L+SdpK2rk6+vP8nuxi4DixX5koxOn07yZFB3gejJb+QBFtkXb/iCXiS1tX1Dc0LMUE1U
         MnezDtfB6zdrI2t27MjojgUMPoCk4Cm76iJSt4+2/Hr/41yqs7XZsuvpSFfsZd7SS/lh
         AGYz9vUiufwVqFE4OHPpf73MUmvzcclv1HBMco3LM5QjUMLQF44cFrpYFjUcoJ8xBrcu
         oRecME42srmc/b/AXCi6PiHnyZXugJDC5nZ1c1SRZrELRk4Zn6EkaSkjIGf2FZdzCPN4
         pXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IfXfv77iXiIu8iXpca9xREgrH+4T28RgkwzpjRiYZ4=;
        b=FzeEm9sKyJ6EGxpSX3o7Z9UtbmU7t5xQ6jEkkZtT6Qxb19oGK4JsXUIKugdZUrrSFK
         S8FGkRbHxBGMxqO4ZB6y+50LIXGF4AFcPVFRAJMdVZTXapDggxfrcaYhUErKAQxUGJWD
         do/QbxnqKo2ZhuGrdQH2vrHkLlYkR3ZJEM9hpXc0eKbH5a1Vfpb7Y0Zl4OaQeI2wB0PF
         g1Ve1iSWiMMb5MCJiUtceKtMRulkGhL+Y2wZ7BIN3Hg7mw/ltwvO2hSP/5Z4AAWvWAC8
         HWt2k16KM2qe/T/Kp932Wb/AY95zQQkwGF7lWpM5uXnqICSe5OEGCFoBCPax5usWNzSa
         Hy3w==
X-Gm-Message-State: AGRZ1gKt4kYh8oebYYniwNfmyxwm9N6kY6i2LpEaJUAbFAwpUaU7MR6u
        QAPwLfhR/qEKde2eGRTVwTECw0LrZ93b/4/0yyE=
X-Google-Smtp-Source: AJdET5czR7EvrQxkbYWWsIXDpJKoQPML8RbC2v+T6mrhTBB9JpEjybEFK8R7YF4iBAHan14l+f+/zvYomAtvpMbmXBQ=
X-Received: by 2002:a02:3446:: with SMTP id z6-v6mr2787641jaz.130.1541174448508;
 Fri, 02 Nov 2018 09:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
 <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Nov 2018 17:00:21 +0100
Message-ID: <CACsJy8DFUeEddSa2z4VTSqhaUBJ4+SUf8xvjh6iWY2Phhh96iQ@mail.gmail.com>
Subject: Re: Understanding pack format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     khanzf@gmail.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Farhan Khan <khanzf@gmail.com> writes:
>
> > ...Where is this in the git code? That might
> > serve as a good guide.
>
> There are two major codepaths.  One is used at runtime, giving us
> random access into the packfile with the help with .idx file.  The
> other is used when receiving a new packstream to create an .idx
> file.

The third path is copying/reusing objects in
builtin/pack-objects.c::write_reuse_object(). Since it's mostly
encoding the header of new objects in pack, it could also be a good
starting point. Then you can move to write_no_reuse_object() and get
how the data is encoded, deltified or not (yeah not parsed, but I
think it's more or less the same thing conceptually).
-- 
Duy
