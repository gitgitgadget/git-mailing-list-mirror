Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A1C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0363220674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="gci3MGuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgCPRXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:23:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37120 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgCPRXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 13:23:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so19635274ljd.4
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNkGsui3F5rN3oF7Li8q/an1saPm69BQFymGR0buXQo=;
        b=gci3MGuu7FCBckUhoyhq+nOUUPRjbOvEHcjKTMrKDZUos+osSK7VZt4mAUJY48mqyM
         yzRpDjdjxDRLkTl6azhIu9jjN31rkY4sO3zw9aGcr+KnYkfMjcmlQ+Y8IZVSWViQNpcy
         5en9qnENqlsJJ6ogwP4tu5SV0Gpv7IcsqRdLjEwjjvuKYd7CGlS3xcii5gPfXPN03e39
         KRUQ/vkHyvPKZg7RsOecSsjmyLCHrPHfJB6RkONHO+ZvBVFbMd6KXgfS34bld43btt3U
         SNhSi2mQPeWV4AHQN1Zx4KltdtbqiR+FyjSVppJdNdWm4IOa47ITfsKbFRG+Sg3ciuAo
         VihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNkGsui3F5rN3oF7Li8q/an1saPm69BQFymGR0buXQo=;
        b=dFzdSuY1VVCg1e6pn0deGd396Hc7lb4/gjwVVgHJE1dxBdsrc6s0leYjnxawnM5/Kb
         VuQ46UeWJuWb4/YTPI/2wU+yDz6PfiEGDnRWZ2qKbWlTBd9QWsNEEcw+qCxWG33uVAuP
         IkML3urbnRQrH2jIF4mrgDvgacIHcg5RVL292eN3sCh5c/MBh6OfDtaLYJh0O/wHj0z6
         RK6HX7O9ZEKwmkUZm6UhgoLW6tscV+fOeNt/KMETOUc2ebj6vclhBrfjX3OFEwEvr1qn
         fMsaRjhlNmi8CrCWh33ZnRMPyVzLrrpu9e31HE1or9W5WQLSBNfRwvfgk+RJhdD30LxL
         fIPA==
X-Gm-Message-State: ANhLgQ3GvhzmRf5gPipwn/ll0gdaAZbohZ7irtOuNLTgxr1G2Do4g5j8
        6KmF5qx2FJlw+qyynSH1Lue6MhBYC+/xwz8Gn120Mg==
X-Google-Smtp-Source: ADFU+vsR0cv7Wi87dlKz494gDCtew97VA3ApKgJjVWpR10v9rFklJCR8h/B/Fks1aIEyI0/T9NH1WZ4BCIUk6g2TqN0=
X-Received: by 2002:a2e:97d7:: with SMTP id m23mr235249ljj.122.1584379384804;
 Mon, 16 Mar 2020 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584329834.git.matheus.bernardino@usp.br>
 <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
 <xmqq1rpsako1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rpsako1.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Mar 2020 14:22:53 -0300
Message-ID: <CAHd-oW4OpoW0Qbp6_HfFiXRXasLXVnw3hDkzDG3S4WR3yH9Wuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 3:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > Note: I choosed to use "st_*", as naming, for simplicity, and to keep
> > the code lines small. But should we use a more verbose "oidst_*" format,
> > instead, to avoid confusions with "struct stat"?
> > ...
> > @@ -334,8 +334,8 @@ struct dir_struct {
> >
> >       /* Enable untracked file cache if set */
> >       struct untracked_cache *untracked;
> > -     struct oid_stat ss_info_exclude;
> > -     struct oid_stat ss_excludes_file;
> > +     struct oid_stat st_info_exclude;
> > +     struct oid_stat st_excludes_file;
> >       unsigned unmanaged_exclude_files;
> >  };
>
> I tend to agree with you that using prefix "st_" for anything other
> than "struct stat" proper would be confusing.  If "ss" used to stand
> for "sha1 stat", I would expect "oid stat" to abbreviate to "os", at
> least.

Right. I also thought about changing the names to "os_*". But since OS
is so commonly used for "Operating System", I wasn't sure whether that
could also be somehow confusing.

> I also am wondering if we can do without any prefix, i.e. just call
> them "info_exclude" and "excludes_file", because the field names are
> private to each struct and there is no strong reason to have a
> common prefix among fields in a single struct.  Rather, it is more
> important for the fields of the same type in a single struct to have
> distinct names so that the reader can easily tell them apart and the
> reason for their use is straight-forward to understand, and the two
> names without any prefix convey their distinction pretty well, I
> would think.

Yes, I guess removing the prefix wouldn't make the names less
descriptive. However, especially for "ss_excludes_file", I think using
just "excludes_file" might induce the reader to think that the field
refers to a "char *" holding a path. (We also have a "excludes_file"
global variable in environment.c which is used like that). What if we
renamed them to "oidst_info_exclude" and "oidst_excludes_file", would
that be too verbose?
