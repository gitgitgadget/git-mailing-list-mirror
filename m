Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F6C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbiERRlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiERRlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 13:41:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9625C55
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:41:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z2so5228410ejj.3
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIM9yGbMANeII40nrPhYeylJxaEZr9NluOmmc4L7cJU=;
        b=GlZgsmUdp773Bm5wO8Ypl1QKHIYDagx7hWBmgZDTCjsWslaxW2241SACzOG384vnDk
         h98tBckyU3v33fMAx0IGtZJdBV24dLu8C4lYmNmMwiGUfxvP1Lw8+Dh/lUAS6k7R+qpf
         c0OLHc6B/GOg9mQM1ZJ3JV/b7LMYZDOtQQ2YsrOcqxgZ/dpE0/Jf8qGbcqsk24Cd2Q6R
         KxDM1JPtnRmZHQ/+cmPnhWfmo21n08cHW6J0TGuR/QSdOB5oCxRrQM3JJBiMQ/r88hyt
         /hL48z6x9YU3CofhzsXmICAXq/2IXTfoh9tVkAflv8MzdptxmbSeo80uEur23qR+FxP4
         R01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIM9yGbMANeII40nrPhYeylJxaEZr9NluOmmc4L7cJU=;
        b=nUA8rxK4jfbOI+KkGYGVIoB3dFgKiYiV3Dac41XROJbOFYEL749pdDj14ftFbGnwEt
         1SAOgems5lFZeaqFkH26eNFZ58fEtxPe3ybBUlKYpjOhfj9SYgzjX7NPLnOofAZzFSdM
         gtoOW6Pc2K9C/yzybGA2tkO+6UDw0V4HaxamK7S+ecvB7qhol4kNZx5O0BlLnjCVadc4
         VdiXaPkFx2R4sLGtq8by8q7fTIZYPJ0eN42LYbGI1jKYYvkfG4NBrpL5Eb0L4ziOEw63
         fD7IzV2jHBEgwEuMMN88oRksTcu7utTsDWUSi/K8nI3DfeDBDD6h2e/CWsHc7PfDfdJR
         BJow==
X-Gm-Message-State: AOAM532GQnUHyw0+XUgdiU+PefY3oT04eGCIVQtQDVwOor8yiudFAhJY
        DxMMbi28bi+46cnudOINmcs=
X-Google-Smtp-Source: ABdhPJy9UGpGBTJzN+1Xi+KDtkznsUYDbY1gvS1IbTxw0JpjOTwXbanKbDBiX9fBIPGTigeqJxNFrw==
X-Received: by 2002:a17:906:9e09:b0:6fe:8a04:2fab with SMTP id fp9-20020a1709069e0900b006fe8a042fabmr699607ejc.102.1652895660913;
        Wed, 18 May 2022 10:41:00 -0700 (PDT)
Received: from localhost ([2a02:2149:8aa1:7500:dc1c:e29b:83a4:b580])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e5dsm1166487ejc.195.2022.05.18.10.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:41:00 -0700 (PDT)
Date:   Wed, 18 May 2022 20:40:52 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2 13/15] dir-iterator: option to iterate dirs in
 pre-order
Message-ID: <20220518173947.4qabalu6mjmzumen@compass>
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-14-kioplato@gmail.com>
 <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/10 02:07PM, Phillip Wood wrote:
> Hi Plato
> 
> On 09/05/2022 18:51, Plato Kiorpelidis wrote:
> > Introduce a new option to dir-iterator, using dir_iterator_begin()
> > flags parameter, allowing to control whether or not directories will
> > be exposed before their contents. In essence, pre-order traversal over
> > file system entries that are directories.
> > 
> > This changes the default behavior of the dir-iterator API. Instead
> > of iterating directories before doing so over their contents, the new
> > default behavior does not expose directories at all. Iteration is still
> > performed, however, within directories, iterating over any other entry.
> > Only directory paths are ignored.
> > 
> > To iterate over directories in pre-order, reproducing the previous
> > default behavior, enable the new flag DIR_ITERATOR_DIRS_BEFORE in the
> > flags parameter of dir_iterator_begin():
> >    * ignore directories by not setting DIR_ITERATOR_DIRS_BEFORE
> >    * iterate directories pre-order by enabling DIR_ITERATOR_DIRS_BEFORE
> > 
> > Adjust existing callers, in refs/files-backend.c and builtin/clone.c
> > to enable DIR_ITERATOR_DIRS_BEFORE since these callers require iteration
> > over directories before doing so over their contents.
> > 
> > Update t/t0066-dir-iterator.sh and t/helper/test-dir-iterator.c to test
> > the new iteration scheme, which is the new default behavior, and the new
> > flag DIR_ITERATOR_DIRS_BEFORE which reproduces the old default behavior.
> 
> It's great that you've split this change out from the next patch. I had not
> realized when I looked at the last round that all the existing callers
> require pre-order traversal. Given that is the case I'm finding it hard to
> see how changing the default behavior to one that no caller is using is an
> improvement.

Changing the default behavior is required to simplify entry.c remove_subtree().
I would have kept dir-iterator's default iteration scheme as is, but how are we
going to deal with remove_subtree()? remove_subtree() requires iterating dirs
after their contents. We need to find a flag encoding that is a good design
choice and serves both existing and remove_subtree(), without limiting future
dir-iterator customers.

This encoding of flags was heavily discussed in the patch series that my work
is based on[1], most notably here[2].

[1]: https://lore.kernel.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/
[2]: https://public-inbox.org/git/1751d788-d1f1-1c97-b33b-f53dab78ef86@alum.mit.edu/

Thanks,
Plato
