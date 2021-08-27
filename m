Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C64C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B7260FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhH0SEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhH0SEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:04:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F91C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:03:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h29so7851547ila.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4wl6GLQioCWZHXxBSnYPWXrz+OPncezDmPA92xZapqs=;
        b=beZikt1x6Grw07cOJ5tX34AErr9QoJjBIlklFAbe2Cpf7ziriNBDRG2tLwmNC+fgCN
         j7t0XEnyfA2yBEhqVpJhrbciPvdp3tLVy4ncOSqM2ZyquIsf1rLjL1+PsuoIO/BGQU2s
         R5cU8WZ4/ZJcJbijfYG6hGcGIBpFg6+/X5FGaypnraXpF/jy75eKR9D2s61rCyiv2ST1
         tweKjifdaOyZx0yZ60Q38urV8mPqyXoPxW9l2Dy9l29v5Xrd+KuPTzdtRJ4wpmBntGrN
         xeLYM1+XnpDg1oBb3UE9TNYhB+TtlVph4/dTxBvju/Akwk2nWbVrcdG/9dwC4TUVGnAx
         HAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4wl6GLQioCWZHXxBSnYPWXrz+OPncezDmPA92xZapqs=;
        b=CAJ1B+Pld3HHUOfZqv8Y+Gm2zl4mo1LKkszQs74m/e0ggLtbfLbvri00w49+GdZCYs
         UPMxUW0iOmAWyNmXyWrdCzDlC6/xCu1PFs9upPpBWn9E9Qd7t/0Wi0fVUYqC93VETkys
         ehp2vMOJ8YncCNhS9RaqlfZiLVyGBQNkoIP8GtrfhjQxMo8GX6ZGxz1EG0O1oAbIADRD
         QPTUxcTQv0g3lRvQIDZWtyFt4ghAlwphhOk9+5N6NaWPgNbIoN3IF35A7jYVHjoje8vK
         /N3jqNEj5zNlpQW2XX0lzyOUAwcWUrSZkVfFG+dPiht1uua4XqwsbXrg2uJa8fPD/yXU
         E1+A==
X-Gm-Message-State: AOAM530UO0PoITz3VCMXGFRbpmjRrRik+2npcWPYgffBEBtDRq26r2gY
        UI3BdknZZLINEkMqcu+GdegUjA==
X-Google-Smtp-Source: ABdhPJwmruKUMKXeQN4VcV7O9ICFmQC878oV+AOgY9C5CZCnSAzTVpNcPD92xg9lSV6AquchBkctTQ==
X-Received: by 2002:a05:6e02:1288:: with SMTP id y8mr7289919ilq.206.1630087394271;
        Fri, 27 Aug 2021 11:03:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o11sm3760713ilf.86.2021.08.27.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:03:13 -0700 (PDT)
Date:   Fri, 27 Aug 2021 14:03:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSko4OwwPb7MwEMa@nand.local>
References: <cover.1629821743.git.me@ttaylorr.com>
 <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
 <xmqqa6l6oafd.fsf@gitster.g>
 <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo89jbf49.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 11:01:26PM -0700, Junio C Hamano wrote:
> It seems that the *.rev test (probably added by the other topic that
> is a single patch fix) fails under sha256 hash.  I am not going to
> dig it any further myself, but for the interested, CI breakage is
> here:
>
>   https://github.com/git/git/runs/3440068613?check_suite_focus=true#step:5:1219
>
> Thanks.

I saw the same error myself when integrating that patch into my series.
I discussed it more in [1], but the failure is basically caused by the
midx code using the_hash_algo even when operating in a different
repository via --object-dir.

If the_hash_algo doesn't match (as is the case when using `--object-dir`
to point at a SHA-256 repository when invoking the builtin from a
repository using SHA-1 or outside of a repository altogether), then
we'll fail when trying to open the pack indexes.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YSgGBxh24UAZR5X3@nand.local/
