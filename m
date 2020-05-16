Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC25C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9E207C3
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH6rpPFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEPKk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgEPKkZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:40:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A1C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:40:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e20so2190413vsb.5
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPK9H7o3oPcWUPfHrtkx9GrjIr5u8wtCK7GZkJ0RXjA=;
        b=gH6rpPForSx7MJyWVOpTBB6Ryf1BKBbmeNcZcTaWuQAHwW3Yg4UmvlrT3N4K6ePIO4
         t+yEAM3Euep1WOO0DfiW74EvlwP5GUg0e3pBM4eWscxXi99fSfnk1je3JEjp0Kw7OkVi
         HypLJzv7wRNYA7XhM4kOPOLw5is7Ir8+or/Tgol0E/STWAiya/U7zIojBftJ02/du4//
         ktd8lrsbcjK5DLrGZfo8373j1j5IxUcbtOzbsvUlmHaZt3HdxFcenPWmaweMbQLaWW0B
         8MiPmd3dr9/bEFBlqxFJEfWFMDRJSPdABEthM+ngG5W+DHdmKE5/Mp3MMxWsOKHEtSp4
         98kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPK9H7o3oPcWUPfHrtkx9GrjIr5u8wtCK7GZkJ0RXjA=;
        b=SMsgoQT+TuteQxLViH7Q1wLlUBb7No6sTPNZbRGMnvuGLEB3mv62WQcqKI7VAkyqsb
         8Mx1q27G1QEXUIM+Ciw5kq62QUa1Z8E4OZPneYkKnQzGQEj2MieJ8s8ySWXzPaXfrFPu
         n9JsRChVvXKPBpmUwRYyu/W1FjhWxTvItJ5A8o850qy/JQk3HXQYLXFxeL/ZyBgGgyKD
         pxX6qYCHsAGIa2uoGRs3J313JLImV7V2AEbjJhZX/fIAP2+s5k3OiCoTyyP0C3c22EC3
         /IWV9cRlAuyEmowtR+on6l6HSv8muoU9IG2Os2eWxyH6aa+3qpdAWcRKjV8ao7t9MvpK
         w+4w==
X-Gm-Message-State: AOAM530m8dU1mhtsAhOo0ysilMpfwn3jhr+VO887MWMTHRYboAu5m1DO
        9dBEF70tE7mElR0Fn4FHGKgyybBf4Kr4yII9rc8=
X-Google-Smtp-Source: ABdhPJwhIN840MZ0GFOrckrt7jFY4junjbeI1r4Kkx/gfuRdVUYNy/qJz36VhYrd0IuPnRkwY1N5bFzGlrZ6bmqvgFA=
X-Received: by 2002:a67:f4c6:: with SMTP id s6mr5282134vsn.46.1589625623366;
 Sat, 16 May 2020 03:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-15-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-15-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 12:40:11 +0200
Message-ID: <CAN0heSo=xUGwb8FLXYpcFXO+e9dqvpzR=h2Bs+HC_ubQdTQuWw@mail.gmail.com>
Subject: Re: [PATCH 14/44] connect: detect algorithm when fetching refs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:57, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> If we're fetching refs, detect the hash algorithm and parse the refs
> using that algorithm.

As the added documentation from patch 2 says, if there are multiple
"object-format" capabilities, "the first one given is the one used in
the ref advertisement". And that's what you implement below.

Explaining that in this commit message and/or referring to "a recent
commit" (patch 2) and/or adding that documentation here, not back then,
would have avoided some confusion on my part, and perhaps also for
future readers.

I don't have a strong opinion on which of those is better, I just think
you could somehow make that a bit clearer here.

>  static void process_capabilities(struct packet_reader *reader, int *len)
>  {
> +       const char *feat_val;
> +       int feat_len;
> +       int hash_algo;

You could reduce the scope of `hash_algo`.

>         const char *line = reader->line;
>         int nul_location = strlen(line);
>         if (nul_location == *len)
>                 return;
>         server_capabilities_v1 = xstrdup(line + nul_location + 1);
>         *len = nul_location;
> +
> +       feat_val = server_feature_value("object-format", &feat_len);
> +       if (feat_val) {
> +               char *hash_name = xstrndup(feat_val, feat_len);
> +               hash_algo = hash_algo_by_name(hash_name);
> +               if (hash_algo != GIT_HASH_UNKNOWN)
> +                       reader->hash_algo = &hash_algos[hash_algo];
> +               free(hash_name);
> +       }
>  }

xstrndup is needed because we're not guaranteed a terminating NUL. You
remember to call free afterwards. Ok.

If we don't get any "object-format", we do basically nothing here and
`reader->hash_algo` will remain as whatever it already is. The docs from
patch 2 promise that this will be handled as "SHA-1" -- would it be more
robust if we did a similar fallback dance as you do elsewhere?

  feat_val = ...;
  if (!feat_val) {
          feat_val = hash_algos[GIT_HASH_SHA1].name;
          feat_len = strlen(feat_val);
  }
  char *hash_name = ...
  ...

You do initialize `reader->hash_algo` in patch 8, so I don't think this
changes anything now. Maybe it's just premature future-proofing (if such
a thing exists).



Martin
