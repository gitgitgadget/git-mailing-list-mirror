Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30529C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJLWFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJLWE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF425D0C6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o65so14597754iof.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXfxOR/mQrt8fwpa5MNxl1s5+gJi0baYUNg8wPBbuPA=;
        b=dIhnoHoyZGxncoyazx1u2wAwsyBAi6agMfbJW37MEO9fUZTxFd3oUzcO70VLyPaVQP
         UDeQ1cz5ryH/13SQ+WEeYM/B/qqljvrOgd4Iqk9DJVMK12o6sIFQCTnnqRwewE/Rmf8F
         9VxZ9afDZdYBP89wMVV2xUE+Xf1YTBeb8dCF59fx7rjUagoNVwKJwaAHt5OD7qIj19ir
         nMDWsj73JYMrt9xHyu594oHt3Cluq3zBV4Ns3zjVHa3mAwcXOteWOnHbJlEFTbmGLmhv
         MU9mHSkRqq/EIu5WUVxal+1qxAYA6w4y9ScILtB2M35hdqgcAkTovytehuAvcURllVCt
         v80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXfxOR/mQrt8fwpa5MNxl1s5+gJi0baYUNg8wPBbuPA=;
        b=U+oIJeFiVKVQuz88OolpnX0trVFTOS5VhnP7fNngjXE7zLtVPfsjkpvvS3aKvr85Is
         cOd82WsAsvviTUCBE//FCRIdyNsMoi5VhT9Hh70oQF0d8Ro45Dtj0kOfFjCBXyzZHVgu
         JsHaI2lnS9mUb6/u3buFh9KTtBfM24LkHRPRBkms0eRJYlHH1HTyotkpjMh7ufH4D290
         DqL027r0gjC24jGxzkYHh0wwa1nMSr2glxg7If/x1JqgWLecvqXiXYRrOjGJnWABm0ce
         sO7DrOnUx8HBVLxUnSkAuSTWfSUa1RAKIoka1zEc/8kUNerO7bXDCD98EoFtqACszrCq
         pRfQ==
X-Gm-Message-State: ACrzQf3HXfcyhLixYjL1tEwwyvQtHmpOiH3gqEgsFp6DB2wmkpBF5jI5
        C9hO1ZqFMsy/D8h2IBFHxotlgMAAXNtvMtKl
X-Google-Smtp-Source: AMsMyM4Xtenlwve334FtYW1avcqVLSKpTdkkzIXXM2okW7VXaaUQb/OC8c0mwjEfSSkK/hNbmx+x2g==
X-Received: by 2002:a05:6638:134a:b0:363:a76b:5afb with SMTP id u10-20020a056638134a00b00363a76b5afbmr12851730jad.23.1665612107178;
        Wed, 12 Oct 2022 15:01:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m7-20020a0566022e8700b006bba42f7822sm1074838iow.52.2022.10.12.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:46 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:01:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH 0/4] midx: trace2 regions and grab-bag patches
Message-ID: <cover.1665612094.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small handful of MIDX and MIDX bitmap-related patches that
I've been carrying in GitHub's fork for a while now and forgot to send
upstream.

The first is a small typofix, and the second is a legitimate bug fix
which allows us to consider annotated tags as bitmap candidates during
commit selection. The final two are trace2 regions and instrumentation
that I've found helpful when rolling out MIDX bitmaps in a production
setting.

Sorry that these are so disjointed in nature ;-). I figured that it was
better to send a grab-bag series like this than to hold onto these
patches forever!

Thanks in advance for your review.

Taylor Blau (4):
  midx.c: fix whitespace typo
  midx.c: consider annotated tags during bitmap selection
  midx.c: instrument MIDX and bitmap generation with trace2 regions
  pack-bitmap-write.c: instrument number of reused bitmaps

 midx.c                        | 34 +++++++++++++++++++++++++++++++++-
 pack-bitmap-write.c           |  8 +++++++-
 t/t5326-multi-pack-bitmaps.sh | 24 ++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.38.0.16.g393fd4c6db
