Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E6C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5DA6144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhENTIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 15:08:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790EC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:07:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v22so451905oic.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=F+Msq1qeFKdTK7eU30W+YC+Z5iYsqMhsAC1/0J1PbJo=;
        b=F/YaXiQN0Xy4UrKoL3ub0GFZ5zCyDQiv7a/AN1FJ+iQzePT4uliNHpFRSWy/FWqLKO
         Z7eoLXmJ2RhuE6Pt2NU6WcQYSKmv+paJehzq+8hI3XzKgTFakPzYSRQXX4zFg+e7EFJj
         ycjhJsSJS8usoR/6KU2sq64aET+Xd0Etb+9HIH48C49Eykd1jg28lQjLoByeyfWh2eGU
         yTHRw702zJrkKlzZxWkko02K+kwIV+V7gAPb4Rp+mQ5VfI3mzpdJ/2OthX2EShtwQAKR
         mOugiP/1Ah5RIhdrblqYh6yvw6LS3lhl8F5Pnc/ZIJ23t1ZoLpc+YlZtQdML60gSKv5F
         tNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=F+Msq1qeFKdTK7eU30W+YC+Z5iYsqMhsAC1/0J1PbJo=;
        b=uoJ6GA3KcNVmaGyLCoR5RgTQ2wahp4O7ddkGh0I/QtkQeEpel266afNHlVBsMkFUJq
         NI5qeJRzrV9moS2toPhKnIbjJbN5ams9HHw3y0oKA0L5HI0m6zfQKKrYS7AGuz76bFlM
         s+5G6fH0y55Sw7lAA+rPBNdcVhBuqn6FqARg5FbLxtIwUfadpWiREnMoTeZuxhqgKdV0
         YfaMiccatM0Bjslk6f1NvPUKwbAhZRE9PipD4OKg0IiszBImOlllse5lVwKN1h0lriQs
         NXgwWKkT7wS39/fvTzB2LwG/SS9hjx0YXq7bAzLuILOm3o0VaDnrNI5GSW9cEqpv8KIu
         3STQ==
X-Gm-Message-State: AOAM533vcomE7oINaWUAn2DLR2CpeelD3N/mo4l5+6SopUV9sP54ZdQv
        ZqOv14x0+kyZ9q+dH48nLpo=
X-Google-Smtp-Source: ABdhPJxtzVy/1bkxaC27g7uy104l1+wWb9Tldx+3iStAEbLqqfNo9kI89pI/EvRhpstcNL5tZYYkUg==
X-Received: by 2002:aca:2319:: with SMTP id e25mr7547659oie.38.1621019228034;
        Fri, 14 May 2021 12:07:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d207sm1438110oob.7.2021.05.14.12.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:07:07 -0700 (PDT)
Date:   Fri, 14 May 2021 14:07:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609eca5a42be2_43127208f2@natae.notmuch>
In-Reply-To: <20210514003104.94644-1-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
Subject: RE: [PATCH v2 0/2] Asciidoctor native manpage builds
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
>     @@ Documentation/asciidoctor-extensions.rb: module Git
>               elsif parent.document.basebackend? 'html'
>                 %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
>      +        elsif parent.document.basebackend? 'manpage'
>     -+          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
>     ++          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
>               elsif parent.document.basebackend? 'docbook'
>                 "<citerefentry>\n" \
>                   "<refentrytitle>#{target}</refentrytitle>" \

Huh? Didn't you say \e was not needed?

You are doing basically the same thing thing my patches now, except in a
more convoluted way.

-- 
Felipe Contreras
