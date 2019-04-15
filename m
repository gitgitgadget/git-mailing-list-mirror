Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D786020248
	for <e@80x24.org>; Mon, 15 Apr 2019 04:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfDOEyv (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 00:54:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOEyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 00:54:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so15336073wrx.10
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jXD7Z30hEvlXGY/GhNmLO9EhfjMZe627HO++Uf6dX9A=;
        b=NGW0IB4NVCljh61LlvPjJaxYYeuwMLGnagnnu0mFzY3sn14K3IUTPl2yVNEZ4I5ZEo
         GoAXHMrDv8LAMRGdH9aYDys9GmcrQwQrFTIdNQi5TMCQbYewuJnH74QvU5X+BKIJf3mw
         +OdNwxadf6M2xg6iTXHR6Xu3ei+ECN9+Mx2jZ3wFZ1mOAk1YN+LMUq3spvK0/YGSBDKg
         lTaiCcClkFTF9M2SvhgbiAYnkMpUCGTlvl/1cC8CiBYP18lKEE0O+C62UaM34ctUhzH5
         UeiMpUne2PVu0mLCNbRkwLm21eaV0yWxBMVAjAX8yGugSjbbvpQoZ0ugIfnjuZZsRH/A
         CCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jXD7Z30hEvlXGY/GhNmLO9EhfjMZe627HO++Uf6dX9A=;
        b=grOic6vB1TRqlj6sYGDhcnYUL0GOs/kDNbVE0J/9PXGdJlQe4uuixpFwaxSSG0ieWn
         WyDsIacp3TH6EtIb1ARcrDfw+QcthaMyGCSwAdI8u6qqIBQwtG+NbVasfeDp5P4AOjzW
         dp1grXol7MuiYxoUT7Lw5j40EYRF4DMxUPwTJKP20X7JmAaQngY7aAqesSWR26yi1EA5
         m7IGMwpMoJIvCxoTP6HkwQh/U9m5ZKKlsRD16ySKJPpIC4kCmBVtVRGB8qpLbj5d6tHn
         W3kE3DUUHATRnBtZULSYq4Pi77BGBGqeBofbgl8v/cg9d6KXH+H+CfUopSvau4xYzGYR
         ilJw==
X-Gm-Message-State: APjAAAVyZdW9AdYzrqrK2W0VH1VMrKtwF4PcN0QOGdnYmNubJTzD8Utw
        sAkxD2F9d0pwsSRad8osmD8=
X-Google-Smtp-Source: APXvYqz5Y/1sMVsD6A0txF4VyBpiihMHZ1Q1ZilOChTh/5Tda8MPJZ99e+fy5dcIkvqHI9M+/iRKjg==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr44325555wro.170.1555304088996;
        Sun, 14 Apr 2019 21:54:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 7sm167224000wrc.81.2019.04.14.21.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 21:54:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v4 1/2] transport: die if server options are unsupported
References: <20190405204413.93900-1-jonathantanmy@google.com>
        <cover.1555098572.git.jonathantanmy@google.com>
        <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
        <20190412201228.GA15936@szeder.dev>
        <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com>
Date:   Mon, 15 Apr 2019 13:54:47 +0900
In-Reply-To: <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com> (Junio
        C. Hamano's message of "Mon, 15 Apr 2019 13:48:31 +0900")
Message-ID: <xmqqef63vpew.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> ... therefore these should be 'test_i18ngrep'.  This applies to the
>> other tests in this patch series as well.
>> ...
>
> Hmph.  That would mean the following is needed,...

And a corresponding fix for step 2/2 would look like this.

 t/t5702-protocol-v2.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 324bdf5715..9b048f6c8b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -288,8 +288,8 @@ test_expect_success 'warn if using server-option with clone with legacy protocol
 		clone --server-option=hello --server-option=world \
 		"file://$(pwd)/file_parent" myclone 2>err &&
 
-	grep "see protocol.version in" err &&
-	grep "server options require protocol version 2 or later" err
+	test_i18ngrep "see protocol.version in" err &&
+	test_i18ngrep "server options require protocol version 2 or later" err
 '
 
 test_expect_success 'upload-pack respects config using protocol v2' '
