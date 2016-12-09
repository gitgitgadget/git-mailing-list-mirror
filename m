Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347051FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbcLITmh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:42:37 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33852 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbcLITmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:42:36 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so10860712pgx.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSUJYSYvNO3tiSdcsCpoR9qz82m13JvFOeC0DuhcaKw=;
        b=XC5Ke/C/rgp3TSFONUQClSrVp7CxRJgkVvwWnU0GHIW/S387FmD2MFXx5ZPe78DHHC
         vSaKx9cOWVhAdX0p67WBV2cBo9FUtWkagD2KTD2Epo+45g6rulxrEAHAYeV49grlOcjY
         FSAJ7EICbo+kmQW/XU6tfPXmsdcaNDcO5qwuQMCuGHDh4RsUU/XwtJtwCtiYGQ2w4cHb
         mcu4udlPj5mPborn6yaGn8qKNpvBU2c9dS0tC5H8IHRNzqTCWa/+OQbQu06o3nlk76y4
         Y+tch7G9TWW+FtDxrJ+W3QBnGAQWjHddWgrWdRdkt/1QQMdhx+FRv9YWCiK4VObZ2W+H
         qTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSUJYSYvNO3tiSdcsCpoR9qz82m13JvFOeC0DuhcaKw=;
        b=nFqQfeGIzUUf+vQX7fsTmAueBTe3nAMHT/0p+DLZyyEu7AgFWlkgTEnITiU53hXPGh
         bnYcwU/V75hIGq75buiegli2Tq8s++Vi8BiulWbY4X/BokEsldDxRLpbVDpwtZY5ucme
         nKWlJl6R7sEU6xWhniXi3Ha1dCzqwtnkSFFag8aUYG5XnSIJ74u1RbmfXXTqBAdqELRM
         Gbmwj60Z31Qn96RSlck3/ONAB2MWXTqCLu2bkY9Ttl3t8tEdaQ4rbMRn76oLdErynHFv
         Ly7h6Jh5egdvoml85gJc2TJ84VeUfu/xqcjxCGqk2REZpXRtJ0bK7TUADSc13eMTdmZ2
         /E8w==
X-Gm-Message-State: AKaTC006OYllqY6c1OuQz3ag8mCfEb+N24V5iOm8bx615DoxaF8PYhgoUuuLjRFgC1L3JmHx
X-Received: by 10.98.138.72 with SMTP id y69mr86432880pfd.52.1481312555217;
        Fri, 09 Dec 2016 11:42:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id n24sm59513999pfb.0.2016.12.09.11.42.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 11:42:33 -0800 (PST)
Date:   Fri, 9 Dec 2016 11:42:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] road to reentrant real_path
Message-ID: <20161209194232.GC88637@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
 <CACsJy8A2M_G34MeHh6vGsrf5ePOOduM6u=n17_EZLtu31uDAYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A2M_G34MeHh6vGsrf5ePOOduM6u=n17_EZLtu31uDAYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Duy Nguyen wrote:
> On Fri, Dec 9, 2016 at 6:58 AM, Brandon Williams <bmwill@google.com> wrote:
> > diff --git a/setup.c b/setup.c
> > index fe572b8..0d9fdd0 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -254,10 +254,12 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
> >                 if (!is_absolute_path(data.buf))
> >                         strbuf_addf(&path, "%s/", gitdir);
> >                 strbuf_addbuf(&path, &data);
> > -               strbuf_addstr(sb, real_path(path.buf));
> > +               strbuf_realpath(sb, path.buf, 1);
> 
> This is not the same because of this hunk in strbuf_realpath()

Then perhaps I shouldn't make this change (and just leave it as is)
since the way real_path_internal/strbuf_realpath is written requires
that the strbuf being used for the resolved path only contains the
resolved path (see the lstat(resolved->buf &st) call).  Sidenote it
looks like strbuf_getcwd() also does a reset, though more subtlety,
since it just passes its buffer to getcwd().

> 
> > @@ -81,17 +73,18 @@ static const char *real_path_internal(const char *path, int die_on_error)
> >                         goto error_out;
> >         }
> >
> > -       strbuf_reset(&resolved);
> > +       strbuf_reset(resolved);
> >
> >         if (is_absolute_path(path)) {
> 
> But if you you remove that, then all (old) callers of
> strbuf_realpath() must do a strbuf_reset() in advance if needed
> (probably just real_path does) which sounds reasonable to me. You're
> probably want to be careful about the strbuf_reset() at the end of the
> function too.
> 
> Other than that, I think this diff looks nice.
> -- 
> Duy

-- 
Brandon Williams
