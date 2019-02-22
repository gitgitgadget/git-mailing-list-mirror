Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844FA1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBVJVo (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:21:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50179 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfBVJVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:21:44 -0500
Received: by mail-it1-f195.google.com with SMTP id m137so2066829ita.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4yOuMWzqCnkssT5pK6e0Bz8obcMG4ycf0Zlu0E/dIg=;
        b=Jv54Oi4DnxPpMNUwwV59vjNaMUDFPlbO7n5Ojd55tPcf/bXh6Psy8kMgvgMEtJ0b5B
         lBgirZSVnHxv02PJrfgrIMFob+Gs0v4Yd9UzLkI7IvtZ528Y5vdtN4hMKoPEOXcPgzXm
         FHNBucwK4BnoT5nEsUTloh5VIZBmIp2yIraZs8UmNyQihAkPvqL4f2l+H7+SWCAJkStd
         tvotifhHg/yuDlFwjIrRanCor81923M61uD0+Avumhd32ws1C/CtjoF7daQ084HiXjpQ
         Y9YyXR/j/hFMrpo90vHDIw5dsBSqpQ2wD3kv03Bj0MiQOYOPvbrXrKVhKJTSj2ZIqKcw
         KBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4yOuMWzqCnkssT5pK6e0Bz8obcMG4ycf0Zlu0E/dIg=;
        b=d2FyJiwnHj4vIR5iWs99BE3Isq/i87c2ZMCXc438qO4D9h068lOm5aNyI+MkRKiv6t
         wazukuykICu/69hx5C1WRmqOZlgCsCS8m2opdC246UCjovP2rTIcXWJiIqFYpacElc9a
         7L5lL9QxZrVi4cSlNhFsJNcDrLhE/pvvS9799zGPjqieyuabu1fXX5krx7vtTlwhElYn
         SAZ42vhr6oMtG115Y3T3dmpcn+9ZcywhMDUD3b+EaSoVGL5E2VLjFWL5E2k1EeokmuIQ
         fbSwKcv1uZJOAwwKzaLE3zhYvK4XegG3kAzAh8bugpzRNrmB5GNAMDeG22hguP2B4d/+
         fMBQ==
X-Gm-Message-State: AHQUAuY1Vqb7xdZ2JHM61w4QPzs06ZT1k9VChVgp3XRuBRqZ6BYQkvZt
        A6GP7uCHMj06XrM36oZ+WlDDcmZXV/NjYYgkZU4=
X-Google-Smtp-Source: AHgI3IYGWm7RwTUV0Egz30warBdnfRmH4LVCe14xuvBZPEpWIl4SgP9TbNLcd/FkozgZYOEtdaf3RZ/J3iGUDw9jXek=
X-Received: by 2002:a24:7542:: with SMTP id y63mr252023itc.70.1550827302901;
 Fri, 22 Feb 2019 01:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20190221110026.23135-1-pclouds@gmail.com> <20190221121943.19778-1-pclouds@gmail.com>
 <20190221121943.19778-2-pclouds@gmail.com> <6fe399f0-98ad-37e6-f4b1-3a3f6e4bce03@ramsayjones.plus.com>
In-Reply-To: <6fe399f0-98ad-37e6-f4b1-3a3f6e4bce03@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:21:16 +0700
Message-ID: <CACsJy8Dw0y7qX7jgNH4j_e4YOg-vv0OVDQv99AzT-koZ=Fq-TQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] worktree add: sanitize worktree names
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 12:42 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> > +static void sanitize_worktree_name(struct strbuf *name)
> > +{
> > +     char *orig_name = xstrdup(name->buf);
> > +     int i;
> > +
> > +     /*
> > +      * All special chars replaced with dashes. See
> > +      * check_refname_component() for reference.
> > +      * Note that .lock is also turned to -lock, removing its
> > +      * special status.
> > +      */
> > +     for (i = 0; i < name->len; i++) {
> > +             if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
> > +                     name->buf[i] = '-';
> > +     }
> > +
> > +     /* remove consecutive dashes, leading or trailing dashes */
>
> Why? So, '[fred]' will be 'sanitized' to 'fred' (rather than '-fred-'),
> which would increase the chance of a 'collision' with the 'fred'
> worktree (not very likely, but still). Is that useful? How about
> 'x86_64-*-gnu' which now becomes 'x86_64-gnu'?

It is useful when you want to specify HEAD of [fred] for example.
Writing worktrees/fred/HEAD is a bit better than
worktrees/-fred-/HEAD. I haven't done it yet, but these names will be
shown in "git worktree list" too and lots of dashes does not improve
readability. Collision is not a problem because if fred is taken, the
final name would be fred1 or fred<some other number>.

If you're really bothered with this, you will be able to specify the
name you want (you can't, yet). You still have to pass the valid
refname check, but you have a lot more flexibility.

So this code only needs to work mostly ok for the common case and I
could go either way, clean up consecutive dashes or not. I suppose
simpler code would be the tie breaker.
-- 
Duy
