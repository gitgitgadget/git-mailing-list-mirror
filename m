Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54311F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfFXMwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:52:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36997 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfFXMwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:52:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so14312034qtk.4
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ITEBsvNzJcedp2T1ezaLqdwlq6MWpinYUS87l5EeoVM=;
        b=QRAYtQ5WnuHbQQGLaW+ryF1ch4ReV0fDydVbd9OtLC9dQKoqdCykcdHPyAnzuT44pJ
         B/fXXyAcv1dg0WBuBCEdXmq7WA3MHr41Ck5c/22Zaahjo19BIYBImytvedDALQpq8yyY
         qcL88jX1szWcTmn3bGgdRrZAk/DHG7q/qS7k+q56XEBSDBud+ixXR5DTqXQx8qsWguNl
         P0pQhmJX3ryMeA8lv/Z6PoEZdbT7KkclAzH98+9Qrp92dHlT8iBRDvmsdaEexyzgtbZP
         cNuNUTzd1lzDE8XgcADPPP5tpCbbjTgva1QkpHRiQT/siSTEZ+1pmC0RE/xb6HYVlJA9
         paWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITEBsvNzJcedp2T1ezaLqdwlq6MWpinYUS87l5EeoVM=;
        b=pmn77AbB7uakpzRAZ7HqjxTHVGUfeR+zH2M1uw86nRhUkEilA3dE24Eig3Mmn9eQRJ
         Bqnnv+9c4r/tRB4hTujT7d73yCUzSKG25858+LDmOHf7fumDwm7vNlWL/TsWld0CL2lS
         xNLUFMBjbel0hJhLLAUTZkiW93lwAK7MPhvBRZYUCqGwWctVKeV0Om8IeUtHUJSnOIkX
         MAVfZMXISwcNXQHg4+0D1Mj8WYhIFWwcPwRvuTnvejYZc7K7EwOHQpgzqNg3Jzi772Cb
         sre+vGqKthFkxpELBm6yHOEva3/FwEgF3yJiT+vGLEF8ITy7RldwC5mBxXWEtFhZBsb7
         KSFg==
X-Gm-Message-State: APjAAAUri6fUfGo53MRHHHit4aVUcKiJh3AqjcdzoMicsyIrnkQ0CNZd
        +9BNfGyM3yKlQvQbl0bfNuY1zmiF
X-Google-Smtp-Source: APXvYqyVg3TV8SbgRRFgF08ouH5zu0dynjmuZTU3fzHmB7fCUswzXcjjbC3tWgeYN9H9exXDJXo7bw==
X-Received: by 2002:a0c:b084:: with SMTP id o4mr57900395qvc.227.1561380739347;
        Mon, 24 Jun 2019 05:52:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1012:6e3f:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id z18sm6061294qka.12.2019.06.24.05.52.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:52:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] count-objects: report statistics about kept packs
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
 <20190624120711.27744-2-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <504c99bb-d264-4fc1-5dfb-00a691dfe39a@gmail.com>
Date:   Mon, 24 Jun 2019 08:52:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624120711.27744-2-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 8:07 AM, Nathaniel Filardo wrote:
> Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
> 
> update count-objects
> ---

This post-signoff text looks like cruft from a rebase.

-Stolee
