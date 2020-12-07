Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C00C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3268823340
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgLGLVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgLGLVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 06:21:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE1C0613D1
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 03:21:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a6so11147263wmc.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalbizsolutions.net; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=66VBKWVRN0zlIsA1qFA4XZQ1IO/NFBpe/zzPOjr6dr4=;
        b=FWOI60TrBLqzTHT0N0BYVKO19gypSUbleXbk8iaZw/xb8kZZ1ve1Ei7Vaw/Bubef3b
         P1Clt3m7U55ey+n6KYt8PTwOX4xDZRyWWFZp9oc5Q6PoFOLIg1e0vgWVm7ZmwLeZkXM9
         8x2M6no2r2kuSyK676EaNlsy9hTo7XkM5/zs/EnaxSePvJ1Es+pDkhGb1ndtaMVHHGtI
         v7JtlYM9MYcwaUrIetos1dckg4qPjRasqfnPAZfgxldygIySZ07mgGsHSX4gPTLtiYeD
         Raq+WKj8ujJlT7lsFjTyBzA10sK9CqBWimkZzWiu4jE+PmM8YyeXvHiy9jNC/uek5cRF
         ZWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=66VBKWVRN0zlIsA1qFA4XZQ1IO/NFBpe/zzPOjr6dr4=;
        b=qDYfs2M1irIho8oHdmigulkWE5WJdj+CS/xjF04PFiDMX/qrU1ZL1DaYoUYzsI1A1L
         /trQ1J8ifPVWtdpAcPN6itbDUeygGKKMYQV+cXkhayhKsqh9CJuupSYeD5Aat5PFKDBE
         TSce8Q/mYrfo7kvGESI964Vy+GU9FC/VB5/nAOITV4KTUaEMmeeLqE9mx/qJ2hSCjYOG
         hRgSKKKzutcEJVCRFeRKvX3cvKDn2NqfuHZoFBW9C/dtvxncPcQA/szUC6PLrL069djE
         nYXJVs4fqA3duRqLNqyllgHVVolUdF/h1BT78vB8A/SpDWP1HIOcVMG5LNufmGvnIwq8
         62Sw==
X-Gm-Message-State: AOAM532aIlRDyAa5ZEkp9hIQppzQx+83IYeqXHOHRX5ScRguU02lb6Pf
        qKNYvf1Uzk7TPiVpsBAYsk7mWfVBLkab8w==
X-Google-Smtp-Source: ABdhPJzE+nvaptk6zvhMj4lGknF3mw3HrrYEPzq92y7P6d6rnXj7iGZCJDi2GlhlL/jXFopxgbQc+Q==
X-Received: by 2002:a1c:bc41:: with SMTP id m62mr18189309wmf.46.1607340060824;
        Mon, 07 Dec 2020 03:21:00 -0800 (PST)
Received: from 72.255.36.144 ([72.255.36.144])
        by smtp.gmail.com with ESMTPSA id y7sm14475941wrp.3.2020.12.07.03.20.59
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2020 03:21:00 -0800 (PST)
MIME-Version: 1.0
From:   "John Pallister" <john@digitalbizsolutions.net>
Reply-To: john@digitalbizsolutions.net
To:     git@vger.kernel.org
Subject: Paid Guest Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 7 Dec 2020 16:20:57 +0500
Message-ID: <7236385999024159487449@DESKTOP-9F9T06U>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I hope you're enjoying good health.
I'm reaching out to make a partnership with you for Publishing article on y=
our website.
I can provide you with multiple unique articles for you to host on your web=
site.
Kindly let me know the cost for including Do-Follow Links in the Live Post.
I can pay you through PayPal or Payoneer.
Thanking you for your time and looking forward to our future correspondence.
Kind Regards.
