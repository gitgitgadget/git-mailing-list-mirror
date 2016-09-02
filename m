Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7DE1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 17:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbcIBREk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 13:04:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbcIBREj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 13:04:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so3628362wmf.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgliB9D/rXT/KWjWUBFRhLL27o+5GpkO/xl74YRGh8Q=;
        b=lltyEYrgA3QRZsgFaGP8NP0YJeIahA2ejyvm3k9CORoXgz7Zkynq+Usv/Rt3A7qMNQ
         DPt6MepwI2H/0nvW+RaphpwMCtCKbOd9N7jADPRoyLd0YDmbslogIXvbPACuVpSmu+O7
         eYaQ4i7lYgnXPHfkMNx3Lwm0IlHI7dow9W5yyCWXugzTEbkMGKi3Eq6iFK8/ByO9hj2H
         iy6k94INSydoH6CwaKDEmnbPBWdmRiRBSw3+fSH98jSijzLKykY+qhavZwfP3bux4alR
         /uOUtjnMsV/CpqktW/5pzmz1cudwPV7WoxvmHstxaf4+BiERUXYrnJHxM7O7MHQX3to2
         tLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgliB9D/rXT/KWjWUBFRhLL27o+5GpkO/xl74YRGh8Q=;
        b=d+GcbhyUIIekrL56HeN1/NuChdV14n4Q2BkZn4bL4a2YQFZ9stE5T/YuwDL05E9J8t
         YrtXXVr+/v5VlfwFgc2rJFk7U+b+D1ujPsgShgLmKOme/UDU9ggBplm/Y25CkUEwhaLT
         /4EzgQya9FSj5Hn0KrZf/SPCZpzElaXRP4vMatZDk/vVdCh7FXwh+WOPpwye8sVZV+qR
         bG2hG7aFkjW+0VuBZ4tJGeMwpkXieGjWgDtCI2bhNe0LarJsKnjIc4yd6zTehPzIBBpY
         jj7PwOtjRJVZ9yEAvhyB8wpvsQRZbTT4JEOAlyzE/SB8zcIXUJ5ue+aSoBCaOaaI7Bdd
         hqcg==
X-Gm-Message-State: AE9vXwPeqj3YQNU1u6o3L2RzFvmxvUCIOtdOrLjhIX2EF8QDxfzj00VNtlq4rZCM0ReAkw==
X-Received: by 10.28.47.7 with SMTP id v7mr4356924wmv.38.1472835877314;
        Fri, 02 Sep 2016 10:04:37 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id bw9sm11334192wjc.33.2016.09.02.10.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 10:04:36 -0700 (PDT)
Message-ID: <1472835875.4680.58.camel@kaarsemaker.net>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Date:   Fri, 02 Sep 2016 19:04:35 +0200
In-Reply-To: <alpine.DEB.2.20.1609021557060.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
            <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
           <1472718808.4680.19.camel@kaarsemaker.net>
           <alpine.DEB.2.20.1609011658300.129229@virtualbox>
          <1472746749.4680.33.camel@kaarsemaker.net>
          <alpine.DEB.2.20.1609012009070.129229@virtualbox>
         <1472818007.4680.53.camel@kaarsemaker.net>
         <alpine.DEB.2.20.1609021557060.129229@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-02 at 16:22 +0200, Johannes Schindelin wrote:
> I hope this clarifies why I am not so concerned about some issues
> such as translation, or commit messages, or grammar, and more so
> about others, such as incorrect code.

It does, thanks!

D.
