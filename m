Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F4C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1FF2467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEIlRQ3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfLSUXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:23:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46009 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLSUXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 15:23:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so8686943otp.12
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 12:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRA+oj98+TjQe6JgF0CpG71+dMjvGNFdpEBZhK8RjTk=;
        b=VEIlRQ3m9GPFbpROR4uYQ3yZDCQY2wdARBtxG/ocmbarGzGXcf2RZsddWHwooZNgAm
         KkSKdEWXKD2/GTBjtxuBwvNCOoqTU8CMBCSCfi6G8kpF4LV383iOI1cNbKxmCD98HCBe
         MlF9kvpcIoaQVPbzVuAQMeqnjx/1fOxy3276rvm5/bITN1oCAJCUoODgDmS2paVp/bgf
         gsw0wMJKXkH5QwVi7Q9gzKrYXG05nnotCYAP/WalyZjVesUo95c3VXcfe/LaIlDZtZfA
         5ZRqC6aM6usiuPAWQP/5MOY+43FiUDVZZuSeQL5DQdU+HfRxEJyzz5HtuZmkqo6ZBZNw
         8tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRA+oj98+TjQe6JgF0CpG71+dMjvGNFdpEBZhK8RjTk=;
        b=V9w84iCOxx8AukEst+hQqRAECgK2ND+i8AQL57s494TaXPEVeBKyhXSHYBC/3Ogyio
         U+x6u2M7iAhlfd6LrgbA1bJZN1J4hPr7rQ2RqzAdMD+ZJ3nbON5D2RUm4lGnIUxkU1m6
         RdbNTShmCOkVVpaw/MYyh9wXl9a7uvSPwc9uk4tzAXy2aq9J3q9lJYoluUY1ylmDWD9k
         zohBx3t8OgEpDBYQX9S9V3/TDKpY3mqtJxRYEfQ/2OPLv52iXcGQp61sDWciv8OucjkD
         xg59VBhjfk/n1kDoOTGZU+38pfasRMM0wImKnGzZajLDPtQ8y/G4QdDErHgbIJZZgZOi
         NWJA==
X-Gm-Message-State: APjAAAVVyZ823erNgnoMkFHKjdN+/iujuSKSgEHvT7nEj9tCI9Ut175p
        SrQPYmHrGmgxuVlcqO3/njbZKgyCvxR2qW88/Vo=
X-Google-Smtp-Source: APXvYqyDAxjnQl64jNJvhpa6fOVhfn8uNyjBnXKdEQW+5oGbIz5M/q1SWF/lVOzcz6/F8/rShzLXvje2Y5WHxO0Ycu4=
X-Received: by 2002:a9d:24ea:: with SMTP id z97mr11094033ota.345.1576787020500;
 Thu, 19 Dec 2019 12:23:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
 <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com> <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
 <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Dec 2019 12:23:29 -0800
Message-ID: <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 1:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
...
> >       while (len && path[len - 1] == '/')
> >               len--;
> >       if (!len)
> >               return 1;
> > +
> > +     de = xcalloc(1, sizeof(struct dirent)+len+1);
>
> That "+len+1" may deserve a comment?

Good point, I'll add one and send a re-roll.

>  If we wanted to shoot for the
> minimum memory consumption (and we do not), we would probably
> allocate
>
>         (sizeof(struct dirent) - sizeof(de->d_name)) +
>                 max(sizeof(de->d_name), len + 1)
>
> bytes, but unconditionally adding len+1 is simpler and easier to
> understand.  Either way, we *are* relying on the assumption that
> either:
>
>  (1) the "struct dirent" would have d_name[] array at the end of the
>      struct, and by over-allocating, we can safely fit and carry a
>      name that is much longer than sizeof(.d_name[]); OR
>
>  (2) the "struct dirent" has d_name[] that is large enough to hold len+1
>      bytes, if the assumption (1) does not hold.
>
> is true.
>
> > +     memset(&cdir, 0, sizeof(cdir));
> > +     cdir.de = de;
> > +#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> > +     de->d_type = DT_DIR;
> > +#endif
> >       baselen = 0;
> > +     prevlen = 0;
> >       while (1) {
> > -             cp = path + baselen + !!baselen;
> > +             prevlen = baselen + !!baselen;
> > +             cp = path + prevlen;
> >               cp = memchr(cp, '/', path + len - cp);
> >               if (!cp)
> >                       baselen = len;
> >               else
> >                       baselen = cp - path;
> > -             strbuf_setlen(&sb, 0);
> > +             strbuf_reset(&sb);
> >               strbuf_add(&sb, path, baselen);
> >               if (!is_directory(sb.buf))
> >                       break;
>
>
>
> > -             if (simplify_away(sb.buf, sb.len, pathspec))
> > -                     break;
> > -             if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
> > -                                DT_DIR, NULL) == path_none)
> > +             strbuf_reset(&sb);
> > +             strbuf_add(&sb, path, prevlen);
> > +             memcpy(de->d_name, path+prevlen, baselen-prevlen);
> > +             de->d_name[baselen-prevlen] = '\0';
> > +             state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
> > +                                 pathspec);
>
> So this is the crux fo the fix---instead of doing a (poor) imitation
> of what treat_path() does by calling simplify_away() and
> treat_one_path() ourselves, we make a call to the real thing.
>
> Looking good.  Thanks.
