Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036071F461
	for <e@80x24.org>; Thu, 16 May 2019 10:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEPKaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 06:30:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42137 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 06:30:07 -0400
Received: by mail-io1-f67.google.com with SMTP id g16so2138156iom.9
        for <git@vger.kernel.org>; Thu, 16 May 2019 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HP6B7DrIW2uQ06RINvK78B/4Lsy7tqfhAmVw6HSGaoM=;
        b=pT2zZTc2Jj5N/vOt8d90oNc6ghHsGsBv5aiU1zLP6ss3PMFXS/r791aHSxLIUel5y2
         ifIFZ/Iwc2Sr/22PgoG4i9leeKtHgcxrObScm187vOUCDKhPVZJqdExjtj8wrUzXB6KC
         04b0UCiTMIlg5bTgzj0vMe0bmnPFxtqn0ImKgYKLP694yk98XouSsQLqBXIv0vivxQXh
         HXRZZjpqQo1u8cszquizgG1yFBK6EHsbP0mC3ifRtxQsLhuOrZKakJ1k9w6ve4HskQuS
         2RbSVA4C7s7giuTQVZLdFj3qD0KsTMNlpGXwIZYagrZhe/N9UU+et71DP0ubwWGWTFfK
         m0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HP6B7DrIW2uQ06RINvK78B/4Lsy7tqfhAmVw6HSGaoM=;
        b=E9PkqCtq2+3sW8pxCXddggJ8GsNsBUL49HMKCDssJOvyTGQyU6kPjEiSK0Pxx4yXfR
         Kpf903YrsYv9Cs8HNvu/UUrL306uO/1Eczym8Q+G12oPtQcO/DM/OXxlAxcmfnYNUFlJ
         C+wyCnOF/uZUfg0+8Go4RYOaFiKC9WRTmoPK+xP1okFMplEUPINBNoWilsD7SEzJVths
         Mzucq7B8ih0z2+X9mL2roBvh3zNxqS4qthcHmm6SLWVvfFczzgGpi9PVFmQssFDwTLAg
         iBrWHWmhKrtTZuPSsqnhGX5A7Mesev/x364ye2Jm0EYGgxoBVCLor/Pf3rt2u2d7OM63
         4MpQ==
X-Gm-Message-State: APjAAAX1ft/BJZWGC5WT2OwplYEUG9HXrtofYlQsszp8cYSg3GOwNxDv
        oU/WmpuPW/ewIMmiL4Ti0GF4KqtgQIeXfz9U07A=
X-Google-Smtp-Source: APXvYqyTXeAq2TI0r2YR+0ztH0YZkhp059aHA8jlrpy5wTdL3aaArmWtMYuN8xxIQDFImXyLvIIJaVcrabY4VjRJOYY=
X-Received: by 2002:a6b:8e84:: with SMTP id q126mr8847155iod.118.1558002606944;
 Thu, 16 May 2019 03:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-4-sandals@crustytoothpaste.net> <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
 <20190515225537.GL7458@genre.crustytoothpaste.net>
In-Reply-To: <20190515225537.GL7458@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 17:29:40 +0700
Message-ID: <CACsJy8B-PY9eBqGBL4CSVGS184DrgZSQqTfwY9gVctX_WfdDhA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] rebase: add support for multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 5:55 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Tue, May 14, 2019 at 07:56:49PM +0700, Duy Nguyen wrote:
> > On Tue, May 14, 2019 at 7:24 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > -       close(cp.in);
> >
> > In the old code, we close cp.in...
> >
> > > +int post_rewrite_rebase_hook(const char *name, const char *path, void *input)
> > > +{
> > > +       struct child_process child = CHILD_PROCESS_INIT;
> > > +
> > > +       child.in = open(input, O_RDONLY);
> > > +       child.stdout_to_stderr = 1;
> > > +       child.trace2_hook_name = "post-rewrite";
> >
> > maybe use "name" and avoid hard coding "post-rewrite".
> >
> > > +       argv_array_push(&child.args, path);
> > > +       argv_array_push(&child.args, "rebase");
> > > +       return run_command(&child);
> >
> > ... but in the new one we don't. Smells fd leaking to me.
>
> Ah, good point.  Will fix.

Actually I think Johannes is right (in the other mail, same thread)
that the old code is buggy.

The only good thing is, I don't think the old code could actually
result in double close() problem. It would just return EBADF, which we
don't care. So no hurry fixing the old code until you replace it with
a better one.

-- 
Duy
