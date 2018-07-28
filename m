Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7371D1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeG1FSE (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 01:18:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43588 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeG1FSE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 01:18:04 -0400
Received: by mail-yw0-f193.google.com with SMTP id l189-v6so2599783ywb.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vw/Uww19wiQF9ZYEtueV2rZDjiKbzgiQ/kUdwyJLRV4=;
        b=h56ccKDJZO5X350xAh2T8hkcJ8rjHj30wojjKU1/Wtz2Yo+UpcH0VaX2f2TI2eQ3Yy
         2VuP93stT2ykvMXZ7uKTC47dg6LQ1kTu5T9iweUQbHOGFbc8rwk6hfy2RQJrNC0Y+6ty
         J50yD4oVYW/rHblcUknVLtxR52JoRiwR9shQJ+ynflqams/DIDGpykwH+/Xu6VGyeK8w
         YLtd7CdtLZ2AJLje0go5kdpWMz4COqbNmJpz4+9GzF4ru82WzwYikCOSR8X8ZJ2j30Pp
         4pnSSYhhGGjNOXpqK7ceGlJz4T1nde0GPE6J6bWPZ0eMPHU3FN2Y/aEnzYGi/10B/Eq4
         rNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vw/Uww19wiQF9ZYEtueV2rZDjiKbzgiQ/kUdwyJLRV4=;
        b=XThRUlKAhlomZdiytcg7Tn/ZWpzQl8bAmbmcpUVbjikWrqlTev1/tkcoCUqiz/VUkT
         v1BHgnuPjZ6IsLOhr8b4yRxZQeNRRsXNsu3oOUEB9Nf0Oqnlh14RbPjkGSFYGwiX+K/x
         eEqPyoYNYPnhHKlbozq+jjN5zWimlnHh1jg2XaJD/3wPlgzdfgVfecJQVtfaPoZSi8hS
         tZK9cni3n+14chIJ0Rm7mFomzt0RPUt0vUkz3PzoSQAFZ7IBldpO1K4al8ESfQVrADUT
         P9Twxu2XmYyW573/zrGLnmjQn/nsUePflSUBwg0O6cTxM9pNnBM/ugWrW1hyYvirrMPJ
         wRqg==
X-Gm-Message-State: AOUpUlHlg+Lr8nrmPpyaeNY/WxkNy9RtWflYiuGOVnneWPnvD8oHw44D
        9o5CYAHHxHeNeKVCc/X4z3/Hph/a5kgpJs+K+w7MfSH2PBHoYQ==
X-Google-Smtp-Source: AAOMgpcAkS5HS94U6OIXOTfdde9mCSmvcnvIfNlEOQSARcR9E6JwcQdjN2o8tkfdaaOrfwRSA8t8rQFAUatiWDYEFmo=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr4622904ywj.33.1532749990285;
 Fri, 27 Jul 2018 20:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
 <20180727233606.179965-1-sbeller@google.com> <xmqqlg9wjhq7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg9wjhq7.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jul 2018 20:52:59 -0700
Message-ID: <CAGZ79ka2yRv5+EaBoHx_TWdM1Qgt9F7YZiW=X35MyOehfcdQBg@mail.gmail.com>
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        peff <peff@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 6:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > A use reported a submodule issue regarding strange case indentation
>
> s/use/&r/;  Is this "indentation" issue?

eh case sensitivity*

> > +     q_to_tab >testConfig_expect <<-EOF &&
> > +             # insensitive:
> > +             [V.A]
> > +             Qr = value2
> > +     EOF
>
> It is unfortunate that we hardcode the exact indentation
> in the test to make it care.  Perhaps a wrapper around test_cmp that
> is used locally in this file to first strip the leading HT from both
> sides of the comparison would make it more robust?

I think this is valuable for the second test to see where it was replaced.

>
> > +     for key in "v.a.r" "V.A.r" "v.A.r" "V.a.r"
> > +     do
> > +             cp testConfig testConfig_actual &&
> > +             git config -f testConfig_actual v.a.r value2 &&
> > +             test_cmp testConfig_expect testConfig_actual
> > +     done
> > +'
>
> I think you meant to use "$key" when setting the variable to value2.
>
> When the test_cmp fails with "v.a.r" but later succeeds and most
> importantly succeeds with "V.a.r" (i.e. the last one), wouldn't the
> whole thing suceed?  I think the common trick people use is to end
> the last one with "|| return 1" in a loop inside test_expect_success.
>

Hah, of course this patch is not as easy.

The problem is in git_parse_source (config.c, line 755) when we call
get_base_var it normalizes both styles, (and lower cases the dot style).

So in case of dot style, the strncasecmp is correct, but for the new
extended style we need to strncmp.

So this is correct for extended but not any more for the former dot style.

I wonder if we want to either (a) add another CONFIG_EVENT_SECTION
that indicates the difference between the two, or have a flag in 'cf' that
tells us what kind of section style we have, such that we can check
appropriately for the case.
Or we could encode it in the 'cf->var' value to distinguish the old
and new style.

Thanks,
Stefan
