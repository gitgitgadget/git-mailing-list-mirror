Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D66020281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdJBXUk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:20:40 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:43541 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:20:39 -0400
Received: by mail-qt0-f174.google.com with SMTP id a43so4051600qta.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z8/f/RHsQ6UQDJwVZcQPrwI2e3Gbt+UKDz18sn4NyA0=;
        b=oIO/CLtNRTqEOrxSHnXXEiSoPqaoiKhmtxfHDc0YJ8fiaaMuvyLiC8JPISMokAGJbz
         BRbLv8JPZfBGRBQ9iVK4pPowmxhHPT2qs784rCS8KT3ckgcbpbnMzi1AZ2Y3/+qysMu/
         4AuPw1xgB52RYE/1GaBq2cI6POEWDQS81mgFjxH1uVoAn80Sk7pFVAzoE+OOaX0Zu7qH
         GOE8v84TDCxms0roOdpQzdwju+qKFF28Gp/z/p8j061wOPl+ucnE5BlZqoyc7VuX/HP5
         brXRItu/HC4Xbaf0TfkhcWHhk080ULEu10ne+IEg71ACN5lG1f5G/X88rOW9E7ABCp2B
         EJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z8/f/RHsQ6UQDJwVZcQPrwI2e3Gbt+UKDz18sn4NyA0=;
        b=FHn77s6k7ddQCTHQIzWznQqtMBai2rvxvmbuXsw619FJIjjMZ/khztR+RutshlgdWh
         cz4K7kPsPG9dkWFh5Kl4IPgx8yyqkQokCXcJpEBoPXw3ffo4rM4j4m+ijSqnNCXRJVG8
         GU9lEkW34ApzNC1er0VYWkqSpAo0H2vqyDJ0n3V39MLdiaacRJ0snjO0/96FC6fcbJxT
         kn4dI2EHYIjp57dwX9EfKtvqGhAwkIECRRolRcp77rqV4eYomaJ9E6MhzdX7P8lHPhJL
         0f2Ei0tC/IcRTU4ON0XKMFnOXF/KJ70Vxtc4syZsDvuDbVTvvIeLO3D9mX+iVXnMjOxm
         ax8Q==
X-Gm-Message-State: AMCzsaVr0Xqw6y1rd++ediiKFWFLUSwIvQeYPozGhmJREkXb/LOGE7Fg
        BaY7+yTfpmhad47mcb2GqEBEbMMIYS9gq5YR1GZ0n1PE
X-Google-Smtp-Source: AOwi7QDSa/Dj3NesCz5nHDYZlOPW+OYXW+ZXom58m630XyHobw++l00wSrFD6N0GoplstRWDljGjfcCbwSMXWcKI56E=
X-Received: by 10.200.28.123 with SMTP id j56mr21168327qtk.299.1506986438824;
 Mon, 02 Oct 2017 16:20:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 16:20:38 -0700 (PDT)
In-Reply-To: <20171001220831.214705-14-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net> <20171001220831.214705-14-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 16:20:38 -0700
Message-ID: <CAGZ79kbULxhSAEx6x6+4Q5nCG4pT98AXVfLBMwQHf-Kx4Wzc=Q@mail.gmail.com>
Subject: Re: [PATCH 13/24] builtin/pack-objects: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -2520,17 +2521,17 @@ static void read_object_list_from_stdin(void)
>                         continue;
>                 }
>                 if (line[0] == '-') {
> -                       if (get_sha1_hex(line+1, sha1))
> +                       if (get_oid_hex(line+1, &oid))
>                                 die("expected edge sha1, got garbage:\n %s",
>                                     line);
...

> -               if (get_sha1_hex(line, sha1))
> +               if (parse_oid_hex(line, &oid, &p))
>                         die("expected sha1, got garbage:\n %s", line);

Ideally we do not forget about converting the die() calls, too.
