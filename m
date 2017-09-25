Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D04202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbdIYV7b (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 17:59:31 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:43685 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdIYV7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 17:59:30 -0400
Received: by mail-pg0-f44.google.com with SMTP id u18so4785177pgo.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7m1JOEH9dXi/8zjxx5hNGXj6BOuutcp0BumV4U1QxY=;
        b=hBySK7ThD1lzQ3PwSyaqIOMX1rhdWFwdOoTmkESgzBmyen27OucS+An9kDHmuOtyrn
         rNBj6AA42BKWnuy5c7oR75V4nkcKofrv0s7gdHUBGtEDzlj6U92exYZ2aLCqrZnaR3kz
         Ni9Q6kfiWjLAf2zdkosY/+vOvWdiHIAYeurMx3MDy40aTtzc+HchKPTsGjilVTxehabX
         HSHA+iblmA2bgb/8stKz4rbkTj/N31NWFNxWxh+D2SU9pZL3QKcrCU+rusUQWPvz51e6
         bjPGQWP5FuY7EpptF3X2qR29759rlaAGDDxTdp3pzFqF/jY9zMqYmY9YcZtpj9URUNSu
         MhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7m1JOEH9dXi/8zjxx5hNGXj6BOuutcp0BumV4U1QxY=;
        b=caLg/aBV7bmApAIeiWbaOFLs+h2q0srGDicisy161bkF1bGfCQL6r/oeb7QXzL7Yl4
         b4mNW753GSpVeBpCdVcmrX4RGTFxGGVog6Ovw8BuZlXFyGQ1kUogfRLxitRhxKhXAiW7
         LbGgEYPevdFyPSulCjj/LkNcbCB2lSR1E7d07gmsLnFXDPZ4xdeDAvmKXeTO1GA2Gvka
         Hr2uWSILUrZz6hOCFzkMFxkEuXhuGeoSZfA82MU23Y6xCtxdst3oai0QAZYaeEJ5tQHj
         seqjdkrsx3AFrCDvBObtThLtfXJL8NGPeCy5rP/PJUMOmuxvZfwzff2BjcZAwjnCBQny
         WcAw==
X-Gm-Message-State: AHPjjUgkvHiAa2aHpZh1JBXQA5fi8x5mOtV9+XxqXMA9pNeLreIubjxw
        3swiHH+3uaqIMGvccBbb+PrJ/KcV
X-Google-Smtp-Source: AOwi7QBX4Gc8iMWztZ5297X8+F7Abu6gV/qDK8Qrb4jcDF/UdupuUIhAfmfK00kf8NEDsAB4uFbvzw==
X-Received: by 10.84.129.226 with SMTP id b89mr8848211plb.0.1506376769610;
        Mon, 25 Sep 2017 14:59:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id h70sm6931610pfc.51.2017.09.25.14.59.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 14:59:29 -0700 (PDT)
Date:   Mon, 25 Sep 2017 14:59:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] files-backend: prefer "0" for write_in_full() error
 check
Message-ID: <20170925215927.GZ27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202716.g2wph3ensmzerm44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925202716.g2wph3ensmzerm44@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Commit 06f46f237a (avoid "write_in_full(fd, buf, len) !=
> len" pattern, 2017-09-13) converted this callsite from:
>
>   write_in_full(...) != 1
>
> to
>
>   write_in_full(...) < 0
>
> But during the conflict resolution in c50424a6f0 (Merge
> branch 'jk/write-in-full-fix', 2017-09-25), this morphed
> into
>
>   write_in_full(...) < 1
>
> This behaves as we want, but we prefer to avoid modeling the
> "less than length" error-check which can be subtly buggy, as
> shown in efacf609c8 (config: avoid "write_in_full(fd, buf,
> len) < len" pattern, 2017-09-13).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good eyes.  Thanks.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

By the way, the description from that merge commit

    Many codepaths did not diagnose write failures correctly when disks
    go full, due to their misuse of write_in_full() helper function,
    which have been corrected.

does not look accurate to me.  At least the "Many codepaths" part.
All of those changes except for three should be no-ops.  The scariest
one is the 'long ret = write_in_full(fd, buf, size)' in notes-merge.c,
which is about overflowing a "long" on Windows instead of error
handling.

Thanks,
Jonathan
