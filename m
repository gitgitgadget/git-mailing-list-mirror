Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7AC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 01:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiFJBuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 21:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiFJBuu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 21:50:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F82200B8
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 18:50:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so40626345lfa.6
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 18:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5x98kEQ8fac8hPcFt4nVp3XybIaWh46pUpl5ovRUoo=;
        b=UNLSWJtvms63zZcvCzGOE1PPiEWPF6nU3J0OYUmw1WibL1X/QyKfykX4fugekYd1yz
         m75zKLKFLMr/080il/gdq0MrpxyOFwk9XVogxaJ1HmkR3iWCZxM/08Eb0wyxJZ1TLgNs
         pRa6BQ15se1CXbxkO3ww7pllJ4Lg4fqh4v4h/eU0X/9+YS7vNXi2CsMTEAYNAP1BXBZk
         X9xnzu2654ni/zEms7kfPPBiwWlT0XbbU0bMwq2LfJ2wogFowwMIVcN5DcQmUwM1gloQ
         NsBukykadvojPvZOs++KDAw7xkGi8S5ne4yE7pDg4Ib86QpDo91oHS6pyRlXKhRkKcqB
         azdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5x98kEQ8fac8hPcFt4nVp3XybIaWh46pUpl5ovRUoo=;
        b=nPwGKlIX8LZaWAEEA6S3W9lcRqnnNsniWNZ49hrSFtYyizWsoWFJpaRE5hP0Jtfrfj
         jwZmF4IGNMeAjMq3U+AwuEmW9vgB1lOhQMIIGL9ysB4qdr57JjmP2IixIQ0oFj3QXTti
         ENr8P8Uamunma7bGxUL0nFh5MXU0iCSHXpjOVX1GFaWzv4URmX6CEvc86F8HOouvJov5
         +5sccDuPq2cswDxvKVVMGvG7tvxRVBJ1VTRPh9eV/DTkcnIIJZ4C6BC5i9RzYgs2BiVo
         niuoeD/4HIve3tiT1Kh1euY+bUMNedHkgVKg/NsEJqqGZOIt5zRrQ9TqLa5493A9IYMS
         RndQ==
X-Gm-Message-State: AOAM533lH0DvjzsGEBvzLSl7gtuCINca77z+T43g/PhMoiAddaATIPvn
        0gOdtw3Zzrx6zNeONGnkV/akXuj3c2ZmZfog9YQ25dDkTABNaPHwPl9+hw==
X-Google-Smtp-Source: ABdhPJzUGMJ5njQceszIjb1L0Tf6I1g7K171hYJldRlISBw/qyl53yOz+RCiv0ZJJBa/IJ79iMDYo20TV6J9Nu3aHY4=
X-Received: by 2002:a05:6512:234f:b0:479:100e:1ce9 with SMTP id
 p15-20020a056512234f00b00479100e1ce9mr24415697lfu.192.1654825846583; Thu, 09
 Jun 2022 18:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
 <xmqqpmjl7i7y.fsf@gitster.g> <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
 <xmqqa6allmjl.fsf@gitster.g>
In-Reply-To: <xmqqa6allmjl.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Fri, 10 Jun 2022 09:50:35 +0800
Message-ID: <CAO0brD3tU+v_5dS9En_fTpEyYVmgEMVb7iVGsPk6iuYNGdpYBg@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 2:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han Xin <chiyutianyi@gmail.com> writes:
>
> >> I am not sure if this is not loosening the error checking in the
> >> dry-run case, though.  In the original code, we set the avail_out
> >> to the total expected size so
> >>
> >>  (1) if the caller gives too small a size, git_inflate() would stop
> >>      at stream.total_out with ret that is not STREAM_END nor OK,
> >>      bypassing the "break", and we catch the error.
> >>
> >>  (2) if the caller gives too large a size, git_inflate() would stop
> >>      at the true size of inflated zstream, with STREAM_END and would
> >>      not hit this "break", and we catch the error.
> >>
> >> With the new code, since we keep refreshing avail_out (see below),
> >> git_inflate() does not even learn how many bytes we are _expecting_
> >> to see.  Is the error checking in the loop, with the updated code,
> >> catch the mismatch between expected and actual size (plausibly
> >> caused by a corrupted zstream) the same way as we do in the
> >> non dry-run code path?
> >>
> >
> > Unlike the original implementation, if we get a corrupted zstream, we
> > won't break at Z_BUFFER_ERROR, maybe until we've read all the
> > input. I think it can still catch the mismatch between expected and
> > actual size when "fill(1)" gets an EOF, if it's not too late.
>
> That is only one half of the two possible failure cases, i.e. input
> is shorter than the expected size.  If the caller specified size is
> smaller than what the stream inflates to, I do not see the new code
> to be limiting the .avail_out near the end of the iteration, which
> would be necessary to catch such an error, even if we are not
> interested in using the inflated contents, no?
>

Yes, you are right.

Instead of always using a fixed "bufsize" even if there is not enough
expected output remaining, we can get a more accurate one by comparing
"total_out" to "size", so we can catch problems early by getting
Z_BUFFER_ERROR.

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 64abba8dba..5d59144883 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -139,7 +139,8 @@ static void *get_data(unsigned long size)
                if (dry_run) {
                        /* reuse the buffer in dry_run mode */
                        stream.next_out = buf;
-                       stream.avail_out = bufsize;
+                       stream.avail_out = bufsize > size - stream.total_out ?
+                               size - stream.total_out : bufsize;
                }
        }
        git_inflate_end(&stream);

Thanks
-Han Xin
