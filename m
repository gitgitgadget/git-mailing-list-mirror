Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5693C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 19:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiHPTew (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiHPTev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 15:34:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3405F21A
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 12:34:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id z22-20020a056830129600b0063711f456ceso8076930otp.7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ybZK5jSHC4StCBBiZo6iChA6knAj46EGUkcAgC/TZUU=;
        b=Wu8sVDeavyAjBFKXVH4rZ8nCTeG/GbB13JRqxXAf/UVNkjEPl3ntOetDPSaZuJYUXj
         HG9uwHLRnyCKR4DpQoaISpvA+Q9jPOleoXoNqn/NPHA+VdKHrrOiWpQwyyI38RBrXBp4
         Jdn2WKVJxbkbZSjW3Je+FOWErvPz7bzqbnfUmkiPVRYE/9lx9tAU8uxlCds1BLEb0Gxa
         izS77Ygz25/B8e1yRdkqk4tVZhe6kN3cCi2KxkVv/VIZ9+K21KRWfbxbWk0cgf/LHzUq
         /QIifbFRdJDl6vmLWURV5BNoC9CC8EvRb/vERD+lyx6msFdvOdN33qrVoiYa2N+Z70d0
         11Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ybZK5jSHC4StCBBiZo6iChA6knAj46EGUkcAgC/TZUU=;
        b=MB8uR+6sWQfoLjY/F+zNgs4GQAUJka+n1MpUEzGSeAXZlroXI+PSp0JJiSD4L4sUac
         lyMmq7FxiKtnoU/6cy7tSoc2zS0KP1uHHNLdHMkoG97a/E3e+oZCAcUO/H+dEFqvLCp4
         4Me+y/DsehR4YZchfXj7t44eGEZVjSyp1bClqQwNTPbSOgdpY975WLGuP8VxtoBLSijB
         k5Y/29eGrtnA8as6oPs48ET8ZinXeArOQ581gBNHeYjKCiwJ0I/Ebozw5ENnXl7RYzOq
         v2vcK/oTMjVVa+W2yp/hmZgtSVIqW1GHwG51IeXBf2dwNLMx3IGrAuMVVFd3H2KBFrj6
         +yLA==
X-Gm-Message-State: ACgBeo03df9/0lcT6nOc6EzXQOAqu0bgsuD5shA9yTG87QilEA9vs5JT
        83EeY8tAKcenixMquLV22XDKlVnup76NwDLkvHWI2g==
X-Google-Smtp-Source: AA6agR4zEhZJgCqjplcFPePoPNHsCyZmBMua8gP1qhwN01WOGIZa9iU69n8M4HQWRUuxKh/E8C9tv35TIfviv5uA7FA=
X-Received: by 2002:a05:6830:1b7c:b0:637:2583:47fe with SMTP id
 d28-20020a0568301b7c00b00637258347femr8363360ote.231.1660678486329; Tue, 16
 Aug 2022 12:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220728211221.2913928-1-calvinwan@google.com>
 <20220804195105.1303455-1-calvinwan@google.com> <xmqqczd0xjrp.fsf@gitster.g> <xmqqk078t3r6.fsf@gitster.g>
In-Reply-To: <xmqqk078t3r6.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 16 Aug 2022 12:34:35 -0700
Message-ID: <CAFySSZCNVBiSXqvkmGkRoD6-+KL4cac9yZWDx=xyTSmNhhEc-Q@mail.gmail.com>
Subject: Re: [PATCH v8] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Should I re-roll with just that change?

On Tue, Aug 16, 2022 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +                     * languages, the following swap is suggested:
> >> +                     *      "   %s\n" -> "%s   \n"
> >> +                     */
> >> +                    strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
> >> +    }
> >> +    strbuf_reset(msg);
> >> +    strbuf_add(msg, tmp.buf, tmp.len);
> >> +}
> >
> > Here, tmp is not released, and mst_list holds the words split out of msg.
>
> FWIW, with this fixed, the tip of 'seen' passes the linux-leaks CI
> job.
>
> >  merge-ort.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git i/merge-ort.c w/merge-ort.c
> > index 4cb92bdff8..cdb53770be 100644
> > --- i/merge-ort.c
> > +++ w/merge-ort.c
> > @@ -4507,6 +4507,8 @@ static void format_submodule_conflict_suggestion(struct strbuf *msg) {
> >       }
> >       strbuf_reset(msg);
> >       strbuf_add(msg, tmp.buf, tmp.len);
> > +     string_list_clear(&msg_list, 0);
> > +     strbuf_release(&tmp);
> >  }
> >
> >  static void print_submodule_conflict_suggestion(struct string_list *csub) {
