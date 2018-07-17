Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6771F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeGQTdt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:33:49 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45328 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQTdt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:33:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so836026ybg.12
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CrK17qdOqZfsEioNqF1sQ2bVWuJPvv/e7v0ouFCF+A=;
        b=qi4DFi9HI9jFicFrSxg+HRK2ASf+DOjRt0XOrrasgEB2+1zpMgTJGjTm/OoGt8yHMc
         Sp5jIpa6IYCkq8jD7uobv9TRrXVDGjF9crcpwsDpMPrN5oK4orFDlEKtHeYMSUnvXY6n
         qvvARts/TB+HtAE7OVutVT9XSaCVZlfLPaOAX+rgeHF7TOcrHnDRxkNGhqLeOMAq09s9
         Y8V4/8iT4oTCJIE3vGSQYYeIncK4P04tnJhHEZKko22lW13LaUpmdkPyPbHQ+Gll4dR3
         Sc2RSD2EAwcsxmcmp/FlNTsT9ikoqLtD4H9cBqif0seJf8ui0vEAwNPyGMd+r0GnFnBK
         IGbQ==
X-Gm-Message-State: AOUpUlGifNP5sEYB0XLrrhWCxDOb/+/3evRtE1kppwJxVxjLx0LEe/+q
        e0G3lnP8rDPxAKMFnD9hxW538EvMQSY0qrNK8Zw=
X-Google-Smtp-Source: AAOMgpdCdRJX9O9ivOhKQKWbZBp0IflkmJIamRlZW1aQfG2dFyDjZ5RgnrV34Wy8JrRWUhxcgEetj9ln3SHcMTHL4WQ=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr1581333yba.263.1531853990701;
 Tue, 17 Jul 2018 11:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
In-Reply-To: <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Jul 2018 14:59:39 -0400
Message-ID: <CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=M0cNR3L5UJGGC6vHPDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 2:53 PM Stefan Beller <sbeller@google.com> wrote:
> > A tangent.
> >
> > Because this "-- " is a conventional signature separator, MUAs like
> > Emacs message-mode seems to omit everything below it from the quote
> > while responding, making it cumbersome to comment on the tbdiff.
> >
> > Something to think about if somebody is contemplating on adding more
> > to format-patch's cover letter.
>
> +cc Eric who needs to think about this tangent, then.
> https://public-inbox.org/git/20180530080325.37520-1-sunshine@sunshineco.com/

The "git-format-patch --range-diff" option implemented by that patch
series (and its upcoming re-roll) place the range-diff before the "--
" signature line, so this isn't a problem.

I think Junio's tangent was targeted more at humans blindly plopping
the copy/pasted range-diff at the end of the cover letter without
taking the "-- " signature line into account. (Indeed, Gmail hides
everything below the "-- " line by default, as well.)
