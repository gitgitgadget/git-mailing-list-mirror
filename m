Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A001F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeCUT1p (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:27:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41329 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753597AbeCUT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:27:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id f14so6351218wre.8
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l1/Q5xd+aiNETHiToF5K9aV5Vvff738fgaXkAVniUrw=;
        b=SeFsA1Wyyc3lB7i5UyCGyHMFcgpys8X9d2qgRR8DpzjEBALJ9xKbPe/dQ/lcVELFxw
         IxwflUe35CHTpSZ/8mF9D2InBbBPhf+uaBcWOn34aYmDSi8mhUqjdUjY6KP39zmrgdZe
         XDHd2s2l6QyCA3wZv2O5vuq8O555m7NWGXa/DZRCoOAIU9cWAJFKzBi1sRtt79KAsjXe
         MnRCi8I6anl9ciRySQzVf/aELufVMLtJjDGtAbTLBUO+6IfHbjtqTwZGdOr7RhhIzYK8
         RuGUi3oQ/ZB+pHIlfVAZJY81wscQD/btHTTJrZM5N1N7FNcStSCk5N/1ddyRTripqXnc
         KRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l1/Q5xd+aiNETHiToF5K9aV5Vvff738fgaXkAVniUrw=;
        b=Fdy+g2GbOHUAgcM6JWYMzvcMVe2A6Ya4wKdJQOEw1+74B6coWBda7IUnlj87M2hknG
         T0dzoGrj7DQgU2ma6gck6iXFvRAHfI8MEfa9ceO4CAaxhBd2yrVxAb9MwPcMood89jDZ
         3FvYvjKepW/Xi3/rOW4m59cQOLa3imSR16skXaNpekOewMRpNEvucms+dGG/BbPm0QYr
         v+/mqCjyKDIgPqnJWnDw+io9mJntjnq4hERbbqN469mjg/RFtTSpSTuCLLx3rzil00Rf
         SdPrKBkQSpIaYJyBWPvLO0X1Oi+JkXnN6y3Mx6BF4MgtDHup8Bc7J4cwmN9PkBZC1+BF
         JXlg==
X-Gm-Message-State: AElRT7E/yuGchSGfNTr7F3AF/H5zPZbFxLfy7uhu3/cocsoHgTHhasZ4
        t0axzwOcMwlJHBBi37G6560=
X-Google-Smtp-Source: AG47ELvDExhtzM/COXkLV5Y6AdmYNUypFKPm7NhlFZXKooIE7pLiErpQafgb2oQ2ZzZ5CPCjjucJnw==
X-Received: by 10.223.145.161 with SMTP id 30mr17181321wri.106.1521660448066;
        Wed, 21 Mar 2018 12:27:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 124sm3413275wmv.19.2018.03.21.12.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 12:27:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     jameson.miller81@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: Re: [PATCH 0/3] Extract memory pool logic into reusable component
References: <20180321164152.204869-1-jamill@microsoft.com>
Date:   Wed, 21 Mar 2018 12:27:26 -0700
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com> (jameson's message
        of "Wed, 21 Mar 2018 12:41:49 -0400")
Message-ID: <xmqq8talp6u9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jameson.miller81@gmail.com writes:

> This patch series extracts the memory pool implementation, currently
> used by fast-import, into a generalized component. This memory pool
> can then be generally used by any component that needs a pool of
> memory.

The way this series is organized is quite reviewer hostile.  

Step #2 that adds bunch of new code without introducing any caller
nor adjusting existing code means the readers will have no idea how
the new code relates to the existing code in fast-import.c (e.g. "Is
it just a rename of some type, structure fields, function names
etc., and moving the lines without no other change?"  "Is the new
code more capable than fast-import's one and does step #3 just makes
the existing fast-import callers use just a subset of the feature?").

Either case, if I were doing this (by the way, I am not in
particular an expert in this area), I probably would make existing
memtool implementation more generic (e.g. renaming, feature
generalization, etc.) and adjust existing callers while the code is
still in its original place in one step, and then in a separate step
move the resulting reusable bits to a new file wilt a new header.



