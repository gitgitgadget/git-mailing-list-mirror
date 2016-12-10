Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9B81FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbcLJT4d (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 14:56:33 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34583 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcLJT43 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 14:56:29 -0500
Received: by mail-lf0-f65.google.com with SMTP id x143so2820869lfd.1
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c21UlODUyJCkFwHcV2uoZH+lV9MOiLRoRLrLPnGYD6c=;
        b=J8xT+TI45SIZl5PUDizCDYfPqfNbuROWSPExQBOOHJ/i0V1C8QwhvskDXLezFdbfgw
         Ggws9jiRm2KloesDgDiyS46Y+AKANpwPgKGzoSyrhPqoUetM1p8cwuaRkQTpqs7jXfQr
         y9ZQCgsFfHbm+I38etC0MRej27eNn6/9U0Dfnc+n8JEQNMutLzqZ59GK/QTVrsw8tsB9
         /vEr6aijwkmBl/g4YrbctZk40HnqPN+ARXblBu/Z0EBmwNcC4tOKEGE0yn0OcympzQla
         oIjHrPW089oMo/Ze3LMFtGngvaURi/A8ULmMceV4IR1NF8ofMcJi+68XLTzjLzeE61lV
         dJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c21UlODUyJCkFwHcV2uoZH+lV9MOiLRoRLrLPnGYD6c=;
        b=XHsN2ziGlemUqWEMJtG3k5Gw/UwlKP/bvk3AHc1GnL/rI7vG9VQPLKIw3aaLZDJDJd
         SyvL7lB9zgmNqV+D9JBgO9aZihwMYEURN6rpfG1f3NOQdkape7vHMW4JYy8/BAE46yFr
         A/4nXvWGFwYJ1OVGHwquWFviGoU88kODCIvpOPuAoKR567gbCdrSY1dqOchErYtNdGhz
         sbxP6S9jEo5aSb8Mzu+mSSGElLX2ozzi/7wNz8cmvIHE18dvpUyfU2bCo3JGCaOXYguT
         9HR9RDFie2TQkyUspRmJIPHuTO4q+3SqgiQSTlA3MT4cFoCWN/EOPbUkUY/1rg8ds139
         0YdQ==
X-Gm-Message-State: AKaTC009F8ajJXznvegL/O97XdeClNPzSNxlJQOqePz6zcSS0wBBhCJANJakvP7ZZ2ce20nsfYNEM73kdlgYBQ==
X-Received: by 10.46.7.10 with SMTP id 10mr37947801ljh.60.1481399787299; Sat,
 10 Dec 2016 11:56:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Sat, 10 Dec 2016 11:56:26 -0800 (PST)
In-Reply-To: <20161209190111.9571-4-s-beyer@gmx.net>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com> <20161209190111.9571-1-s-beyer@gmx.net>
 <20161209190111.9571-4-s-beyer@gmx.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 10 Dec 2016 20:56:26 +0100
Message-ID: <CAP8UFD0hCke_W6C=gOHinpj+G3WCFKf7Cji6zREDer4RUBxKxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Make sequencer abort safer
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 8:01 PM, Stephan Beyer <s-beyer@gmx.net> wrote:

[...]

> +static int rollback_is_safe(void)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       struct object_id expected_head, actual_head;
> +
> +       if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
> +               strbuf_trim(&sb);
> +               if (get_oid_hex(sb.buf, &expected_head)) {
> +                       strbuf_release(&sb);
> +                       die(_("could not parse %s"), git_path_abort_safety_file());
> +               }
> +               strbuf_release(&sb);
> +       }

Maybe the following is a bit simpler:

       if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
               int res;
               strbuf_trim(&sb);
               res = get_oid_hex(sb.buf, &expected_head);
               strbuf_release(&sb);
               if (res)
                   die(_("could not parse %s"), git_path_abort_safety_file());
       }

Thanks,
Christian.
