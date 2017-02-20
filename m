Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3E6201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdBTMs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:48:27 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36669 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdBTMs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:48:26 -0500
Received: by mail-oi0-f52.google.com with SMTP id u143so51247877oif.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9Dci7d+74l98AUoeNpIFbjVt7CZc4i5npdFZfxbd6w=;
        b=Xu1VU+m7VSl2zjOqIL+0h61CJaWTd403UAkxLlT59AotxlnKpRx+inkcZcohUGcYpN
         pNs1rwk2fjj24vtucPtx8qdyDNxADi3tQYcHh+4PZYA5ABDX5I5P2T0tTlhr0OvIJATB
         JgFZDpZqbvJqXGTLZv8b2HtvSw9ySGU1Y19JVWXEy1cHe2StWFB6d5UPwj++fOktLDrA
         DgZ72wfVatC0mlBj37vseTAnTuZ7h2bsvNo0EE7GcqaR1+BsHlqtT7NtEncjNrk9XZbz
         99/2h+2jqj0tOWMB4rd7LPXwXFDBts4+UTswZzdl9tYxVNq0rjVfiKx4tYByDIW6hP4P
         9dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9Dci7d+74l98AUoeNpIFbjVt7CZc4i5npdFZfxbd6w=;
        b=YGiB7vu5EAt4PhccxuQ/44Ngh96wuVcTImACy8XUAbTNkD8pzuucqWFKhIdmnzZTFA
         GPPzGyqT6+mWj/tGbBpo5Kx+rtdZ40bwJKGIMWW8YExWg9+mh5qPjeQuDXiJOMP3NQtT
         T+2OX5U/4hx3RWE9BR5tDAoU+2IXhFbB07acau5x4UQvajqE5yuF/Jwkk9467RgEaSff
         B7SHcF5+LgUvD59a1kjN9vpvPJWBqGxyeNVGn00POUR/9TtxUbqui/CQJh89zacLrJHo
         AtiqmpSixNpyXtfDXZ6N8Q+MVnV4ppCzviwcb04+ZoR0ZgDXiqcDUyRc5+j0PUi8nBBg
         dqzw==
X-Gm-Message-State: AMke39n+GrtPQBl/+wq1mQITbQ7BhS5IgcFOjbZqNHSb6Pv2pgPlmob/zo9gomXP/sgzzB4Yjpp3Apf41FE5ZQ==
X-Received: by 10.202.60.67 with SMTP id j64mr11721053oia.124.1487594905714;
 Mon, 20 Feb 2017 04:48:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Feb 2017 04:47:55 -0800 (PST)
In-Reply-To: <cdf01f55-f3df-d3ce-149c-0249a03d27bf@alum.mit.edu>
References: <20170217140436.17336-1-pclouds@gmail.com> <20170218133303.3682-1-pclouds@gmail.com>
 <cdf01f55-f3df-d3ce-149c-0249a03d27bf@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Feb 2017 19:47:55 +0700
Message-ID: <CACsJy8CsiB39G36FC1pqjWqmrqSnW2Vf4ooBLzhQ97Dk8tXuFA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Remove submodule from files-backend.c
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 7:42 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/18/2017 02:32 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> v4:
>
> I very much like the direction of this patch series. I reviewed the
> design pretty carefully and left some comments about it, and skimmed
> through the code changes. But I haven't yet reviewed the code in detail.
> I'll wait for your reaction to my design comments before doing so.

Unless there are some mails in transit, thanks for the review. The
comments I haven't replied to usually mean "I agree" (but not writing
unless I could add anything after).
--=20
Duy
