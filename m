Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98393C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B66128D
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbhDGNyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbhDGNyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:54:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619FC061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 06:54:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x16so19484160iob.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FtnBug3azhNm/kIOR4hsh8PUptQ7I0TzI5XIzX/gZHE=;
        b=TC/E6UCUKsznxOH9mt1xoa48EFPUBHw2awqldqovuV5mkm+IApYAdnCb9vz4M4C70+
         P4L7ELD0PyXNeWkwhHZG64LWMLBQTY6I2XfzvHDGdKOki3XC8T6wAlMpxkkVyy4NfZlz
         amORdgiQ0C+9QX88KHdKPxxUiDsqA2lm7uJKUzCCzqTeZ6nVZqVw4Zkrb31GHCMhZgkY
         2jn+5EqlfPGAMeTwD0oYfH5YMbEaZTQF0lkiHwdafwgT1buqjFSPNDd8G4St48qOhOMA
         G0EJJy1VDm0TwDc5DdhB59exzB0Au9rwQdW5iuYqcVUFL6ztbYl+CzKFTOjCnwULBtp9
         y+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtnBug3azhNm/kIOR4hsh8PUptQ7I0TzI5XIzX/gZHE=;
        b=Ajr+cMr7fbCJalYEZSLqLbWkrdo4/DWvfbGoriE8xfKuyeTk40STBClnk1EO0uPCtb
         ppW3qLQH5eLvWiDtuUJuUDUC3bALH5uM+bhYk1suJsTyn+kQd5DwGvrodYtKwNBWEDHv
         D++A3xWU1b9QoDwDfkqshMt//Y0MvnlEqJsuopLQEfqJD/1ucunofOUUZDPLmmix7m6s
         FMKYHlW8B0SmUUrWEiciHIFUIB1m/IGJnnYFfgQqXowevRli0AQTWO91tgSFTz2/2qoQ
         ErDyNVoyRHayz29gljJRprTtMKbBQUyjRrxeeJmWi/aZ8w3VoOL+i9DfTqnGnBXWtpkJ
         Z+1Q==
X-Gm-Message-State: AOAM5303Ik0T5mdpnUjbjNbYg7JZN2QUMtlV0Xq5X/hxSu+5php8I2dj
        EBTwNdNxg+0ZsjUHBleLgMKU2uQtqe27CiBo
X-Google-Smtp-Source: ABdhPJyw5IMhyueKoz8jdKILrv/Z6ghU0+MLhjISAt0FuaS8DogZPXVv6bUGOmJxgvysaIcehkYBog==
X-Received: by 2002:a5e:a519:: with SMTP id 25mr2536983iog.3.1617803662036;
        Wed, 07 Apr 2021 06:54:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:777d:e152:158e:dffc])
        by smtp.gmail.com with ESMTPSA id q8sm13656192ilv.55.2021.04.07.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:54:21 -0700 (PDT)
Date:   Wed, 7 Apr 2021 09:54:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Subject: Re: signed-off-by not overwritten with GIT_AUTHOR_NAME...?
Message-ID: <YG25jNZH9ATfwlMu@nand.local>
References: <20210407134201.kxijiev5sn346bsy@hoshi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407134201.kxijiev5sn346bsy@hoshi>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 03:42:01PM +0200, Matthias Beyer wrote:
> Hi,
>
> I just found that overwriting the GIT_AUTHOR_EMAIL and GIT_AUTHOR_NAME env
> variables does alter the author when committing, but does not overwrite the
> --signoff entry. Is this intentional?

It is intentional. The identity used for signoff is the committer's, not
the author's. The documentation for `--signoff` in git-commit(1) says
(emphasis mine):

  [...] it typically certifies that *committer* has the rights to submit
  this work

And indeed 'sequencer.c:append_signoff()' calls 'fmt_name()' with
WANT_COMMITTER_IDENT, not WANT_AUTHOR_IDENT.

> To reproduce:
>
>     cd /tmp
>     mkdir foo
>     cd foo
>     git init
>     touch foo
>     git add foo
>     GIT_AUTHOR_EMAIL=nobody@nomail.de GIT_AUTHOR_NAME="Someone Else" git commit -s -m test
>     git show
>

All of the above is to say that if you s/AUTHOR/COMMITTER in your
example above, it will do what you expect.

Thanks,
Taylor
