Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7608C433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9151960F23
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhJJVbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhJJVbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 17:31:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4EC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:29:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i20so43229634edj.10
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G4m7kWW+okHPY4zuRgzsALW6Inc3Ka52VyM5NwODqEk=;
        b=AlXZ8XbFIbECiCV/P1b4zUf16h0VESYleVLuDu2eBA5y0fyokeyMD+gcsUXiv0NP0x
         ErDYrBNt+uv5ZGTkLXo8ZLnEPskZaG7dOTnFU5tbTepmAnnPFnCoGG6b2iIoDeCqmvoT
         VKYvlq93QNI3ulXZ1VdRMggAwlGrsSEaHf1tsjtg9jxt4O+P3/E67TwuBu7pyu/ykjY7
         GVaZc7p3uGBiBDbrBl0l5zmGP3DW3gg/wy1bs7xQnac8AfcKfX0ulmok/eDZUnDZci51
         5f8ZliVCioKaW77OReEnSrAN9hS+fROjfrGrFbvn4ZJWenDXg+Uh6IbOd/re+MYY4nrp
         /rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G4m7kWW+okHPY4zuRgzsALW6Inc3Ka52VyM5NwODqEk=;
        b=5C1veE44RZn0ynq93vn13UWmO+b17HNaPcHnkG2HhELJhEl2IXBCEwWhO39z9tEGTz
         HSbNpPkk3SQpB0RTXIxCEZWlziNqMAbcngFw3dILNpsY8Xzib271K0EdBj1MPxcZnARy
         /MKlLak6AstjFNFJ9eU31Kk7efdPLsHKYdgMCS2KSXt6SDqnsEsFInUDjdFnb8Z1UY+a
         M6sLdBLEwGC6v6umGLuHArf9f/um2fJy+vft01da6gYFV0qzpNMIKDaXMR9O4sj46cGw
         kEYQEZYHWSmhfdPVNqXFHFoQDg6Mo6vD2KO9/PAcUYU9TIzv2rl7A4mS0re9Mb4p0Q9r
         JhtA==
X-Gm-Message-State: AOAM531Ob7OAoQX+ZN94GXk0aa2BEmmXhct0sLwDRqdsCo/p3JLRk18m
        PYdOVGr2lBpgGzHsWXb3o84=
X-Google-Smtp-Source: ABdhPJwYt+C6r3sJS/eSJqlECLMbW2zuiyZnMptlnHdNZ0pSlvbh6iUS0opgTyCsClG05ky88Ngw7w==
X-Received: by 2002:a50:da42:: with SMTP id a2mr33932227edk.361.1633901391700;
        Sun, 10 Oct 2021 14:29:51 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id r3sm2560965ejr.79.2021.10.10.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:29:51 -0700 (PDT)
Date:   Sun, 10 Oct 2021 23:29:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 7/8] pack-bitmap-write.c: add a missing stop_progress()
Message-ID: <20211010212949.GC571180@szeder.dev>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:28AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function. This will matter in a
> subsequent commit where we BUG(...) out if this happens, and matters
> now e.g. because we don't have a corresponding "region_end" for the
> progress trace2 event.

The stop_progress() is not missing, but rather the start_progress() is
in the wrong place.

  https://public-inbox.org/git/20210917051448.GB2118053@szeder.dev/

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  pack-bitmap-write.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 88d9e696a54..6e110e41ea4 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
>  	if (indexed_commits_nr < 100) {
>  		for (i = 0; i < indexed_commits_nr; ++i)
>  			push_bitmapped_commit(indexed_commits[i]);
> +		stop_progress(&writer.progress);
>  		return;
>  	}
>  
> -- 
> 2.33.0.1098.gf02a64c1a2d
> 
