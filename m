Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B483C2BB85
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B39920709
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ni6P7tYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B39920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDMAtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 20:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgDMAta (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 20:49:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF1C0A3BE0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:49:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so2843818plo.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLr5ISSOS9oY5BjR69OYxySCsvdDdu+8M84hFW0xmo4=;
        b=ni6P7tYPVYEh+Ol4RMz3FYFAufSOHD1FeDPfFvfdFgkaYWdL0kb1gDAV9EVakj0ZyR
         ATnGS61MsTn28/O7k7TKIiyS68yRO8Gn8vB3hJzPQXDQVFMKO2uKJ1q5NEdlViL8eHal
         5f0wKFKZCoF8nXAkqZKi3kYNfqYeSfsVPohmbAblBZqEW/eE47F9lrK9iZ5c6+E6EQGn
         E+RRd3MctS9e5aui5UlvV/tzJRvHnYgTiJiyl+EL2J2eAp+wA1jA9UXJR9dFBQsMiJpN
         iKntUaS3jY46mssnsKzW5sbK5es0tqtF3wugFN9hg41DHTVFYelHrV0La1hRE2y6fM7Q
         EcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLr5ISSOS9oY5BjR69OYxySCsvdDdu+8M84hFW0xmo4=;
        b=VUJ0jUeO7Pw3+Abl0bpRRfyLSiAcxvsFUD1+heVsMS3i66PGQJkTZNPgOcEn7drhn8
         HwKa8qGsgVMFSgXfMp/bP00myPznHtHD8e5hbk6SU4zLynDrq31E5fEq65WM+n7LGns+
         w+Ov/l4C6mQi5RuXC5EAmU19G1vhmjl8XPSoacmHLXqrhoGVQbyE2ipXwjsQVoXkJn53
         KJB35q+68tl8DGsoGdVaF+iZDa2OILQQI3A9K325qxDKq7FG2fA5kTqDlS3O3QWbuH56
         oe7dUlAI41tdvopJTewl6r1zP6yFxxIPOeEK+evvHLz0f08rFLZ5CcXJ2XVX816eAwz/
         CHKA==
X-Gm-Message-State: AGi0PuYP23UrqdZR/Vkb2N008diEngItN2FX99NfHXwRXv0ErfoN4mha
        tpMI2rlPnjqKVbN/En4S15yi7cnB4+dM8A==
X-Google-Smtp-Source: APiQypJSaqPhaqaqG4nyXkRDdlH/eNVxdeuhgsiodMuiFkirsPHmuR7R9SQRBiwT7BJaMQMsmIIIrA==
X-Received: by 2002:a17:90a:890a:: with SMTP id u10mr10770491pjn.154.1586738968489;
        Sun, 12 Apr 2020 17:49:28 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y9sm7378007pfo.135.2020.04.12.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 17:49:27 -0700 (PDT)
Date:   Sun, 12 Apr 2020 18:49:27 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] better handling of gigantic config files
Message-ID: <20200413004927.GC55122@syl.local>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Apr 10, 2020 at 03:42:11PM -0400, Jeff King wrote:
> The fact that parse_config_key() requires its callers to use an "int"
> for a string length has bugged me for a while, and it re-bugged me when
> looking at it today. So I finally decided to do something about it,
> which led to an odyssey of other small fixes and cleanups.
>
> In particular, I was curious what kinds of bad behavior you could
> provoke by having a key name larger than 2GB (especially because we use
> the same parser for .gitmodules files, which might not be trusted). It
> turns out: basically none, because the config parser chokes immediately
> dues to its own int/size_t confusion.
>
> After patch 5, the config system _can_ actually handle stupidly-sized
> config keys, but in the end I decided to explicitly disallow them.
> There's downstream code that would be impossible to fix, and nobody
> actually cares about this case working anyway. See patch 6 for more
> discussion. I do still think the other patches are worth having as a
> cleanup; the more code that is safe from unexpected integer truncation
> the better.
>
>   [1/6]: remote: drop auto-strlen behavior of make_branch() and make_rewrite()
>   [2/6]: parse_config_key(): return subsection len as size_t
>   [3/6]: config: drop useless length variable in write_pair()
>   [4/6]: git_config_parse_key(): return baselen as size_t
>   [5/6]: config: use size_t to store parsed variable baselen
>   [6/6]: config: reject parsing of files over INT_MAX
>
>  archive-tar.c      |  4 ++--
>  builtin/help.c     |  2 +-
>  builtin/reflog.c   |  2 +-
>  config.c           | 42 +++++++++++++++++++++++++++++-------------
>  config.h           |  4 ++--
>  convert.c          |  2 +-
>  fsck.c             |  2 +-
>  ll-merge.c         |  2 +-
>  promisor-remote.c  |  2 +-
>  remote.c           | 37 +++++++++++++------------------------
>  submodule-config.c |  3 ++-
>  userdiff.c         |  4 ++--
>  12 files changed, 56 insertions(+), 50 deletions(-)
>
> -Peff

Thanks for doing this. I knew that it rang a bell for some reason, but
it was because of the upload-pack changes to limit the set of allowed
object filter choices that I'd sent as an RFC somewhere.

I was using 'parse_config_key()', and I think that you noted somewhere
that it was odd that it filled an int and not a size_t. So, thanks very
much for fixing that case.

This series looks very good and straightforward to me. So,

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
