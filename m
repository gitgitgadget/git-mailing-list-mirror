Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1758D2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 22:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbcKOWUl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 17:20:41 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34577 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933444AbcKOWUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 17:20:40 -0500
Received: by mail-qk0-f181.google.com with SMTP id q130so153868881qke.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RFe+MZtrJJ2q7McmYiBwKOfGJg3KKUBAbrEw8P6Q9Dc=;
        b=ljKnDuE11TxBSFWcog9dOe80Yly9u7yodM/Y3VGZ+9tTxMTj+wMwXeN3IGFNy4YIzK
         t2WOXl2tSKpLduZWuYFtkgJfHL6ckFNE4S+P5T6scCD8mqO7kLLeS6eKlzRVwMC8yxvC
         3oPJKIdUAsIhoffSLIcGqvr29Vl2NwUqsif7wL/oghp72h3cO+KH/yAplKc+1E0zZSQS
         TPrIDpCatuUqy62DprVCkO7u0xCZbyKbDXC50mEN9a8hTOuYOWOaKUUvQw/8eSNvEEK7
         eufMMczdIETXHCVc5UrwwA11/MZKMUPfUYkWJPNTEleW//AuYaJZLrHpfqUVqkoFUtGL
         s1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RFe+MZtrJJ2q7McmYiBwKOfGJg3KKUBAbrEw8P6Q9Dc=;
        b=jzNc/GG+LcqRz/1GYrQAKNGUTv3vdieFnKqZck2Y8Gp43+rPlVDG4/rCUDbMBHmmSP
         BEONZAx3ynDEW3/UB0GH4/RyCcVxLJsw+rc1gBocoqyXLdlD1YnkfhFAsj7FxnuJWtVj
         b463iIWoabSOpFKhthoSzFzE4As3VxTH1KaKjkhEAZnZVRUXLicQw7YvJQ/hK2aRYxGM
         +w+d4DZPESd/waES9HAiIAt5KhuMvk1AkaYMfuLPxUg8X5oK77XpSGN39bymB9UZVmzW
         cnwwGEoLErGVfpLGnJ85PtyCZzRzR78vxSCPIWhQ0rphXED016UoEccAzAxGWSs6P/nc
         2Ihg==
X-Gm-Message-State: ABUngvei3qdmujMOYyqMGGqUcHMskOF/SwHo1y3pA59RWCl1GOLbVYax4CMAPQKSNQipOUPeKhS6Xw6azK5/pmqb
X-Received: by 10.233.216.196 with SMTP id u187mr9102312qkf.220.1479248439437;
 Tue, 15 Nov 2016 14:20:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 14:20:39 -0800 (PST)
In-Reply-To: <616038c9b59cfcccce180de480c2a168921b9a63.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net> <616038c9b59cfcccce180de480c2a168921b9a63.1479221071.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 14:20:39 -0800
Message-ID: <CAGZ79kY4aA-vx+qfiACd9NOtao4q02PxZgw-Yq+JMuAz_cqLvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] serialize collection of refs that contain
 submodule changes
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> +++ b/submodule.c
> @@ -500,6 +500,13 @@ static int has_remote(const char *refname, const struct object_id *oid,
>         return 1;
>  }
>
> +static int append_sha1_to_argv(const unsigned char sha1[20], void *data)
> +{
> +       struct argv_array *argv = (struct argv_array *) data;

nit: no explicit cast needed when coming from a void pointer.
