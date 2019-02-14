Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7921F453
	for <e@80x24.org>; Thu, 14 Feb 2019 10:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393605AbfBNKC4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 05:02:56 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43300 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbfBNKC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 05:02:56 -0500
Received: by mail-wr1-f47.google.com with SMTP id r2so5734670wrv.10
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VPNxCr0yLl6ZXX3XSWZou2qUWN+4GQJDTej0r5VNk80=;
        b=OPwQiZfJJ+KfWeENbBjEflx8bMyT8kibXkDVK+yUK5jb9j3BUZQmhNSGRT94mg6/Za
         KfUYPl+3yRSpaJNVY4+9K4mC5FieZ4Wo6xhY+ZmUZg6oL6B2jPA6Tck3P2NYayM23NJH
         1VvhK3yl/MhwWbFg8ZKVCy/up3dkP6AquzY/glZkux2Gg0dcbzwITjnBy1W157fcljoZ
         F6T6R7uzNzJInilqD8U/wwh1NST43wJI3EfnDrBARj952hKv6FJLDlsP/AGN0nDnafSa
         YuL40IQvX78BEu6+i61wFS9IF7EbdRFcQNOI6obj4Iv6RQ86ctH3efOJl1xf4FWHIUO7
         B3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VPNxCr0yLl6ZXX3XSWZou2qUWN+4GQJDTej0r5VNk80=;
        b=JFg4+h2BjwhqN2gbxtATMATW+UxyLiK3CQ4zwYVpvR9g3931GdsQZkl+mC35jceq//
         gZiSkDGOdDPlkwqCj/3ldURsjWmFS5KjbBm6bMg7Rv4GKbhhUznC/MJGcM386fcHVF8e
         tydU858z3KqxpQwjCVQCgslNVL1gxRuY1OzXrAwJSkorZ0jpcppnocdvxGFHxY2HVyll
         eW49qUPBNg+8xPA134XAJPgY8nZNg7VWXH7s7buJq+naFPbhkgUtQZwntui7bgS8+HOV
         vgNioco8JjWhshutrNBXwFrXZyZ/OKmfDnnAqY9gWDRUkJQanQgd1j4DJIesipZUSRsx
         ztOw==
X-Gm-Message-State: AHQUAuYeaF4vfxb8bdHT/VKPJ2DT8hEXp23Y4YL/U90uYqP3au17av9a
        QqLNeuB2zUr6zRX71e9joIFXb1V/OOo=
X-Google-Smtp-Source: AHgI3IbLvu6zzjwvVJMrQB80SmlAoTzNPyMdvMSyKc72chiXbHBtC+o7xcfPuwxHJoKBnWbVyON70Q==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr2108536wrs.3.1550138574305;
        Thu, 14 Feb 2019 02:02:54 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w21sm1143411wmi.31.2019.02.14.02.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 02:02:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] read-cache.c: index format v5 -- 30% smaller/faster than v4
References: <20190213120807.25326-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190213120807.25326-1-pclouds@gmail.com>
Date:   Thu, 14 Feb 2019 11:02:52 +0100
Message-ID: <87bm3ek7qr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Index file size more or less translates to write time because we hash
> the entire file every time we update the index. And we update the index
> quite often (automatically index refresh is done everywhere). This means
> smaller index files are faster, especially true for very large
> worktrees.
>
> Index v4 attempts to reduce file size by "prefix compressing"
> paths. This reduces file size from 17% (git.git) to 41% (webkit.git,
> deep hierarchy).
>
> Index v5 takes the same idea to the next level. Instead of compressing
> just paths, based on the previous entry, we "compress" a lot more
> fields.
>
> Take a look at stat data, st_dev, st_uid, st_gid and st_mode are the
> same most of the time. ctime should often be the same (or differs just
> slightly). And sometimes mtime is the same as well. st_ino is also
> always zero on Windows. We're storing a lot of duplicate values.
>
> Index v5 handles this

This looks really promising.

>  - by adding a "same mask" per entry. If st_dev is the same as previous
>    entry, for instance, we set "st_dev is the same" flag and will not
>    store it at all, saving 31 bits per entry.
>
>  - even when we store it, "varint" encoding is used. We should rarely
>    need to write out 4 bytes
>
>  - for ctime and mtime, even if we have to store it, we store the offset
>    instead of absolute numbers. This often leads to smaller numbers,
>    which also means fewer bytes to encode.

Sounds good. I wonder if you've thought about/considered a couple of
optimizations on top of this, or if they're possible. Both share the
same theme:

* Instead of adding a "same as last mask" adding "same as Nth
  mask". Something similar exists in the Sereal format (which also has
  other techniques you use, e.g. varint
  https://github.com/Sereal/Sereal/blob/master/sereal_spec.pod#the-copy-tag)

  So instead of:

      <mask1><same><mask2><same><mask1><same> etc.

   You'd have:

      <mask1 (mark1)><same><mask2 (mark2)><same><insert: mark1><same> etc.

   I.e. when you have data that flip-flops a lot you can save space by
   saying "it's the same as existing earlier value at offset N". Maybe
   it doesn't make sense for this data, I don't know...

* For ctime/mtime presumably for dir paths, are these paths tolerant to
  or already out of glob() order? Then perhaps they can be pre-sorted so
  the compression or ctime/mtime offset compression is more effective.

> As a result of this, v5 reduces file size from 30% (git.git) to
> 36% (webkit.git) compared to v4. Comparing to v2, webkit.git index file
> size is reduced by 63%! A 8.4MB index file is _almost_ acceptable.
>
> Of course we trade off storage with cpu. We now need to spend more
> cycles writing or even reading (but still plenty fast compared to
> zlib). For reading, I'm counting on multi thread to hide away all this
> even if it becomes significant.

This would be a bigger change, but have we/you ever done a POC
experiment to see how much of this time is eaten up by zlib that
wouldn't be eaten up with some of the newer "fast but good enough"
compression algorithms, e.g. Snappy and Zstandard?
