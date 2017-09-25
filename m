Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F509202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbdIYWAC (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:00:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36465 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdIYWAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:00:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so5581978pgt.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQOZ5XJrVDrt0L+39zJ3g066RWWmQoFAxif+gF590t4=;
        b=antknT95OzdHNshoLAWVdPfb/7A6rNfcmY6dmy1iL/sR+U0WBzVkmLm3l3bhgkHfsg
         UWC7AxPWfOgc+qHyDX35v1/uhm723p8yfmn4o86uIHhFVP9FiPGdMM06EqHS9ilsfwEY
         CCN2DknDO5aSXRL0EJ/mchNLTlmGfOtZS3h8S5H0e8wAU7BGG+cftgrD+cTELNMaXAu6
         e1Jo6sZDBO7CC+HIFiYXxIKDXOPKbMQ/BZPVS9xMgZxgSyN5H0l3Xw4ENrBpG6TBrWY2
         hbd5Q+e/CMsmVtSN0UP/s3vcdku0BVs1iw4dIiG+fhprVPuaAkqAN06B0crZYfRTYp/g
         etcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQOZ5XJrVDrt0L+39zJ3g066RWWmQoFAxif+gF590t4=;
        b=XtrJVSa34h24beGw9kwNR64/3ZiLHcoO2Ua9MsUxsPuHrkT8HhDplic8nPMRvAmPe5
         TPQ3X5PYHOQQAaBWywH1Z42vNzP7wnqnV8reyJgEAANG8mQGGiYQwIv77SOkuuEfjB+H
         AuL6xk7j1OS4zdv9d6g5zZVBgmjS+y+RrzKsvlQeF3aaHmxSYRfJpPUvBscq0GlhTHi3
         IC2U7H5pEStTfpu9eI36rLKn/vI1RVBNIBMyo7zc3FAtfQ5atSnfyveUULZ5B4hB6f/B
         ywAyA18yGYxJ7g68gzwfQINayyutln/sJ4giujEyALp3EXHxgo5fUmFys951REOrfO6O
         C76A==
X-Gm-Message-State: AHPjjUi0SW8NH7g0BMHZdMbkplpJtZumCld4eclfP+MmTAgLeNkIpHsc
        KeyJ/RP+BjKPP1pUlZ/lvTY=
X-Google-Smtp-Source: AOwi7QC/6r9VIaCoPUNkQgdG0mHMj/UA9+0VQ7RsqZqp+Hci8y8aSAIY4R0KlcqwbZFF8s+OSFWbtQ==
X-Received: by 10.84.224.66 with SMTP id a2mr8894313plt.207.1506376800680;
        Mon, 25 Sep 2017 15:00:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id y72sm9350048pfa.129.2017.09.25.14.59.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:00:00 -0700 (PDT)
Date:   Mon, 25 Sep 2017 14:59:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] notes-merge: drop dead zero-write code
Message-ID: <20170925215958.GA27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202757.w6eb556kq3ecyks3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925202757.w6eb556kq3ecyks3@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We call write_in_full() with a size that we know is greater
> than zero. The return value can never be zero, then, since
> write_in_full() converts such a failed write() into ENOSPC
> and returns -1.  We can just drop this branch of the error
> handling entirely.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  notes-merge.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for tying up this loose end.
