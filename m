Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E29C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiEXTjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiEXTjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:39:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B975214
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:39:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 31so17119722pgp.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y7NY1584eyDUNyutFmaE2ZD5XnCZwesmsRVxRbOHAYs=;
        b=i9Ut3njT+VzlnkxoZrJ/hWjL/Awph3hoQkf59BvWN0rI+P/55ta0T6i/3ldAmtS2CQ
         0hcIq6qRJ3JeDDW2wH95H0BBFA0K2h6ro63cPJreX1vyrnK54iAe/p47HurObUVVUnqB
         6B8LIVMiWkPLKtdiZFEAeK0lC+Z3W2HofoeLkHzKJHh04xQEfVEWZEieoOf8d/tiDiim
         c8CjXp9Wj6dohVA4DqZQy5WFFtYVBjj6kphuttW7uhSzcaPp7O5uOB5rsDPk9yAtszzV
         Y0BxkIVFaDWxqhjZ+rfHo6M787LN/Uc6eJylTyBaQ2GMno+fPII7uzUM46/kaSaiAyxX
         eI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y7NY1584eyDUNyutFmaE2ZD5XnCZwesmsRVxRbOHAYs=;
        b=zebmtob22vXyPAq0fmmi+SXPpOhISjVMi+e3Z2vQop/BsxZOJqNepqiUVX6m5xIC7R
         S6VBAJCG8BTPxQCw4E0R97yFmpqMnfb4orEgkZhyWYig+c6c2LPA4ODzDFRGOTDFtkQx
         ZKOVoyKlmsLqGn940+BKlALpU8TI1FF+wkbBnUyFbj3evV2pYvOOkjeo4PCevjC201e5
         aciqnfiuV+iEboZQLBUJjKc6B5dIYQkyPF1dqcvvL6b2IvyIU9NxPr2+B+9csNU69I7b
         Nehb5VWlvW7j4SERD/BvaGCafX8Fc8vxX1AFeJKSKMWciubAUWKowCztG0CY+b56YJpj
         EDWQ==
X-Gm-Message-State: AOAM533vhSlDmtTw7R4JZrGi9aPjKLIsualuLjiBDNt0uy56oMfmcoy2
        b/MKQOM38Z9S+2mfJjxOogg=
X-Google-Smtp-Source: ABdhPJwcpLHHdFo+ANboPYJtNJUwOMCp2dycNwgTg6N/xVUOYseMOe+VBAN+VDT8TloomR9JRBSqsA==
X-Received: by 2002:a63:6c0a:0:b0:3ab:8716:3d04 with SMTP id h10-20020a636c0a000000b003ab87163d04mr25106302pgc.507.1653421153825;
        Tue, 24 May 2022 12:39:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:40e4:8614:8b45:ee10])
        by smtp.gmail.com with ESMTPSA id o66-20020a62cd45000000b0050dc76281b3sm9930945pfg.141.2022.05.24.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:39:13 -0700 (PDT)
Date:   Tue, 24 May 2022 12:39:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Message-ID: <Yo00X0NEu8N0MnZV@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Fri, May 20 2022, Taylor Blau wrote:
> 	On Mon, Nov 29 2021, Taylor Blau wrote:

> 	> +static void write_mtimes_header(struct hashfile *f)
> 	> +{
> 	> +	hashwrite_be32(f, MTIMES_SIGNATURE);
> 	> +	hashwrite_be32(f, MTIMES_VERSION);
> 	> +	hashwrite_be32(f, oid_version(the_hash_algo));
> 	> +}
[...]
> 	But since this is a new format I think it's worth considering not using
> 	the 1 or 2 you get from oid_version(), but the "format_id",
> 	i.e. GIT_SHA1_FORMAT_ID or GIT_SHA256_FORMAT_ID.
>
> 	You'll use the same space in the format for it, but we'll end up with
> 	something more obvious (as the integer encodes the sha1 or sha256 name).

Agreed.

[...]
> Other than that the only question I have (I think) on this series is if
> Jonathan Nieder is happy with it. I looked back in my logs and there was
> an extensive on-IRC discussion about it at the end of March, which ended
> in you sending: https://lore.kernel.org/git/YkICkpttOujOKeT3@nand.local/
>
> But it seems Jonathan didn't chime in since then, and he had some major
> issues with the approach here. I think those should have been addressed
> by that discussion, but it would be nice to get a confirmation.

I would still prefer if this used a repository format extension, but
that preference is not strong enough that I'd say "this must not go in
without one".  What I think would help would be some information in
the user-facing documentation for commands that create and work with
cruft packs.  In other words, if our take on people sharing
repositories between implementations that understand and don't
understand cruft packs and get objects moving back and forth between
packed and loose objects is "you should have known you were doing
something strange", the least we can do is to warn them.

I don't see a config to enable PACK_CRUFT by default yet in this
series.  I'd like one, so that people can turn it on and get the good
new behavior. :)

Thanks,
Jonathan
