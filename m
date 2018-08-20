Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BED1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeHTW5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:57:06 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36491 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTW5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:57:06 -0400
Received: by mail-yw1-f68.google.com with SMTP id w202-v6so1165329yww.3
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEMbjcjyKAOedixRdc1vz0RCluZ0TPPc1DxP7CkjrW8=;
        b=lM3vaUF5jR91KwwEnhUwi3sDvS+ryIAvj+vbBbFSbotKUc/dWRaAzunaTCG9mZXleh
         O1t1Q8+UNvnBhQCLm/+lQwv3eKgqsmMQOTa9UpDAWIETt/fo0FJNvI0KH6fR8ovFCfOV
         +EN9tWk69Z/ZA5W5cdxK+l3NPgjb0KWIZl3KzWTTQuTp19K7ZpHOsWc7wAtgGSc1i/Iv
         yBIOVmqeoiQhN/6X50V5LwoMUOI9NH12bpzXKtL/LkrflPOr2NU1vo/dscxNS++2JYf6
         EbkVkXJqdi9HZ3KHyg3kI3/mUTiB6AtJ1ALs/TobfZhtpyZ2N0xdl0nS4BoqhOa879Zr
         xRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEMbjcjyKAOedixRdc1vz0RCluZ0TPPc1DxP7CkjrW8=;
        b=t9PUmGrOAeshOzO/NDNSsPflxIVW70erG7AbNoi0pfALlzlgRaQd8aNgjpTbkdz/Xc
         +4nrnbXOSDStn6xffvF7GNFfbrVYy1kF59zJ87VKVibE7cn4sSHlhhETJAKuDUjXFoLI
         K2iWTdPpmHhS68qbKaDhjjJmAPs+HOOkFQBQivJhNGCVatqJf6QAt3uUc5CtJ0GB0bNZ
         ORId0TOVXPfgSSTVwGI2H6Qudzqn6buPZw1rT7FQ+JyLOLYtaSddSe54JMfTNwf9oAaM
         92XrNn9VflOUDrkhpRttJEdprVfbUjLAf1ghpnykr5cm8IhvviU4uD+8UdSRPG5tiYDQ
         vxMA==
X-Gm-Message-State: AOUpUlG7SJ6/rnugSOMOLvno4BuBoScYhL8iqc9GtY3ZxU9lrtmlrZ16
        /hx0fWxeqLq4k9S4ynyN3gPeb08JyKi8uZ38cCd5P7P9
X-Google-Smtp-Source: AA+uWPyQQZQV9qla4yIGrj4WHn3ebGHnJx2bdLlrsHBrHaEwBSY1RwV0adnCcT1fw6SxUQhK5K9x5oXVYHrgbcMneUM=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr24935318ywh.238.1534794010439;
 Mon, 20 Aug 2018 12:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet>
 <20180817204354.108625-1-sbeller@google.com> <20180817204354.108625-2-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808202129420.73@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808202129420.73@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 12:39:59 -0700
Message-ID: <CAGZ79kY8oadQ2nKWr7znMa8QJgLcidb0FefPDBaba+q2J=nfPg@mail.gmail.com>
Subject: Re: [PATCH 1/3] diff.c: add --output-indicator-{new, old, context}
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 12:31 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Fri, 17 Aug 2018, Stefan Beller wrote:
>
> > This will prove useful in range-diff in a later patch as we will be able
> > to differentiate between adding a new file (that line is starting with
> > +++ and then the file name) and regular new lines.
> >
> > It could also be useful for experimentation in new patch formats, i.e.
> > we could teach git to emit moved lines with lines other than +/-.
>
> Thanks.
>
> > diff --git a/diff.c b/diff.c
> > index c5c7739ce34..03486c35b75 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1281,7 +1281,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> >                       else if (c == '-')
> >                               set = diff_get_color_opt(o, DIFF_FILE_OLD);
> >               }
> > -             emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
>                                     ^
> Here we already pass `o`... so...
>
> > +             emit_line_ws_markup(o, set_sign, set, reset,
> > +                                 o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ... here, we could simply pass `OUTPUT_INDICATOR_CONTEXT` and let the
> callee look it up in`o->output_indicators[]`...
>
> I read all three patches and did not see a reason why we could not
> simplify the code that way.
>
> Other than that: great!

Thanks!

I considered it, but was put off by the (small) effort of yet another
diff refactoring.

I'll include it in a resend if a resend is needed, otherwise
I would suggest to make it a patch on top?

Thanks,
Stefan
