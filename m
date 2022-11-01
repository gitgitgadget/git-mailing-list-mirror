Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B9FC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKAXqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAXqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:46:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191A1DA59
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:46:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 11so13784006iou.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/O8/RO2NPd5J+ZOcXUe3BOzG7UHnxSGkp9vbZ+1Wig=;
        b=v6bFxZM+BjtGg+xilZszYqUmfk0X0o93jEpJjhpES74Q2yv5f88dXoBRXT7ZzlbqtW
         PROlrAFbxt9DsMBLZhhu131i18UEfqJ2AH7NU++0PmJBJXquBXC74NJ01g+QfzJ3Yhqd
         AV8LWg5Bv8ndIrZAiuv0hrfMXGl7qme5cVHhdHZJk39++OlFkR6bWMgupogyb3Z/V40O
         GCy8sKwrPP5Y3ripLnRR76Hj+QXXJacGZIDGJzjL/0xrJVWs+2vP6+8TSPWMQUKnWKxY
         wkaEo4E1BpLILxYFDMVg7S31v2T/9b5pNK765tS0xNWUgW9iGAZEIpB6Pke118MaI2Ag
         2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/O8/RO2NPd5J+ZOcXUe3BOzG7UHnxSGkp9vbZ+1Wig=;
        b=ynGtD5LSqJmrQifeRaHcRc9A5sWpOapKSX1Y63812QCXWQ4M0FCC2MVwbNVNc2mENb
         7RDNrVMywcw2TBZKnNha4VvJe2agWvCQasel/ZOSLTOMdwqPYMwXzoEmw4rbRVZFLn3w
         JQPrCCyL7+davv1Y2d9m0Ym6RPh7+eYpjlUKe2MtmEab9dOIkbSVBqAVhbdMO1znteV/
         Iqab+9huTG4T/DTPI6NS8uI3e6lOtelFkm7bg5DtdJGg6qGjZiYgxE7yzhey3OlKr+6d
         dJou6ISpsWorkD9V8/Z76cUvdd7/MqiQqHfL8jrTqjMh5D0tr8gAfph+u3ymTzJ4okJe
         Rr8g==
X-Gm-Message-State: ACrzQf0byUFUAUnLVwDnA0Gx/EWG+7mL5osd0Ukv7l6FFh4zQW3Drd29
        00F20PeP7rFyz9KhEU9Ri5seFA==
X-Google-Smtp-Source: AMsMyM4tqFto8hmQTEUIx65uXa267akBAoji9XT/+Tz2kFbGm3AtCqZGwuKecmNIB/Cpkuw9pGQwLQ==
X-Received: by 2002:a05:6602:2cc6:b0:6d2:13e9:b80f with SMTP id j6-20020a0566022cc600b006d213e9b80fmr8181299iow.196.1667346381571;
        Tue, 01 Nov 2022 16:46:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7-20020a02a087000000b00372d05cab42sm4442661jah.23.2022.11.01.16.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:46:20 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:46:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of
 bugfixes
Message-ID: <Y2GvyyG3K1OpIqAw@nand.local>
References: <cover.1667260044.git.me@ttaylorr.com>
 <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
 <xmqqo7tqco0y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7tqco0y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 03:23:25PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Why not have a single file with all of the topics, with two "###"
> > markers?
>
> Mostly because jch and seen are built in two distinct steps, and I
> need to be able to rearrange lines in the redo-jch.sh file either in
> the editor or by running "Meta/redo-jch.sh -u", without touching
> what is in redo-seen.sh file (meaning: what comes after your final
> "###" cut lines).

Very helpful. Thank you :-).

Thanks,
Taylor
