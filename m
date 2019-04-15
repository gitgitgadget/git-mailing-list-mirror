Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE8620248
	for <e@80x24.org>; Mon, 15 Apr 2019 18:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfDOS5n (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 14:57:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53994 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfDOS5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 14:57:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so21973517wmj.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kMROn2906xpyuT9vaerzAUUDCPLmTUayVg1WVHGJyaE=;
        b=VutxiFsiSwBWcS0SX/iINOZjmDiT5aj0SHenTeLkRmHydacoKWIaVrgI6deBeb1Nka
         4MJJZI84SKB7pErx5/02UtUmX1zZ1dPZlN161mhi7WA7lOSwLCeIm/X1ytkIsucFwAK4
         lefXcktQ8CpDrgAvilbwHM/cD4Y2CYvFwzYs/OlIMwALPn/6hxCr/moH/4uRFh2qEmyD
         3eFzHeZQCfEMthgkOt90Vxd4LwKDf9y4ISSQwYB2IvKGqx0qZ8YZIpzBEj4nIh13fJ/o
         d8xEwwKkrY2Xykbf3Dcmi/TLZBGDcmAV/HPyL/5i2u3Vp0+Urd/k6uNcrGDU7KcABYPj
         fw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMROn2906xpyuT9vaerzAUUDCPLmTUayVg1WVHGJyaE=;
        b=jQQu3OF+LmQc2KaMcRJAyIowDWpgYqtKZyLe9K0FzVLl0kig/7yPcpMwOc9c/lSatE
         5uBgnXT8uhkZDIqXXZ5f/mpHnqEZZSNqwAWCuDi0xrw5H7TAyp5fTBriSX1rNQN2bfGK
         dkbIfqnCscvXuvI0xvHnoKWBqFMOdJqcfujoa1/UPJLfb5syccHA8INvXyIsAxJuL9mf
         K6zW2Sai4kXaoCmrYQ0RdiIAnIO5b5o1aJqnbSUF6ZMPhSW1LoWXUqourdBHKPO0tDby
         5Tup9zavJ/VUys5pPdkWVrA2PYHY1nqXOpoR7KdBNYdqqGr4XMbVsQQkUxo4C446wZ+1
         cxqQ==
X-Gm-Message-State: APjAAAXiTJFqDSQu7ZDaOBcYw8/I0cwg+iUyAx0dRwL4nKxO/21Z4mM3
        of+e4BeesXo4FETXhfIBTI8=
X-Google-Smtp-Source: APXvYqzREyZkJv9BX2qUH/OPOFAbOlfoXiWhdjcgZq3Pk518W+RgDE0qgvN2dqCJsKfIfWlngH0E4Q==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr23266705wma.139.1555354661741;
        Mon, 15 Apr 2019 11:57:41 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id 7sm172473932wrc.81.2019.04.15.11.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:57:40 -0700 (PDT)
Date:   Mon, 15 Apr 2019 19:57:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner diff
Message-ID: <20190415185740.GC1704@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-3-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1904151448530.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904151448530.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Johannes Schindelin wrote:
> Hi Thomas,
> 
> 
> On Sun, 14 Apr 2019, Thomas Gummerer wrote:
> > diff --git a/range-diff.c b/range-diff.c
> > index 9242b8975f..f365141ade 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -102,9 +102,12 @@ static int read_patches(const char *range, struct string_list *list)
> >  				strbuf_addch(&buf, '\n');
> >  			}
> >  			continue;
> > -		} else if (starts_with(line.buf, "@@ "))
> > -			strbuf_addstr(&buf, "@@");
> > -		else if (!line.buf[0] || starts_with(line.buf, "index "))
> > +		} else if (starts_with(line.buf, "@@ ")) {
> > +			char *skip_lineno = strstr(line.buf + 3, "@@");
> 
> Rather than using the magic constant "3", it would probably make sense to
> declare `skip_lineno` outside of the `if` construct, and use
> `skip_prefix(line.buf, "@@ ", &skip_lineno)` instead of
> `starts_with(...)`.

I like this suggestion.

> We *will*, however, want to have a safeguard against `strstr()` not
> finding anything. Maybe re-use the `p` variable that we already have, and
> do this instead:
> 
> 		} else if (skip_prefix(line.buf, "@@ ", &p) &&
> 			   (p = strstr(p, "@@"))) {
> 
> > +			strbuf_remove(&line, 0, skip_lineno - line.buf);
> > +			strbuf_addch(&buf, ' ');
> 
> Shorter:
> 
> 			strbuf_splice(&line, 0, p - line.buf, " ", 1);
> 
> (assuming that you accept my suggestion to use `p` instead of
> `skip_lineno`...)

And this is also much nicer, thanks!

> Thanks,
> Dscho
> 
> > +			strbuf_addbuf(&buf, &line);
> > +		} else if (!line.buf[0] || starts_with(line.buf, "index "))
> >  			/*
> >  			 * A completely blank (not ' \n', which is context)
> >  			 * line is not valid in a diff.  We skip it
> > --
> > 2.21.0.593.g511ec345e1
> >
> >
