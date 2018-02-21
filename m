Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C440E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeBUWyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:54:15 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37516 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBUWyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:54:14 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so1780415plb.4
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCydeNn0Q1JcuvZlK8KLNlezxrXb9EW71xAbaTW5dck=;
        b=BUoM6lpCBCZdUaf71NWTD9QMTY6UB4OoGy/QP84+puMmh/JA0AnU56Zu3i0u1vh/0Z
         Bj+fBH4zSawQqsTfhc/XN3WU0nEFCFSeqMs+FgiOHWyBtEMaCDT/JtWIvu401daaAZjK
         Xmu2u0cJggB7hrq0C3xKqR6Dxc97Mrdanc+7lNIp2XdMWSlOmVoBWbfHEbazKsed6U5B
         stUpdYyn283QPR32BxvjqdGqfPpnPdOxbF/h8ivLCG1IPYzZe4lrvPNUT+DpZkSaBmRL
         cjMKZC/3g6YGKfexQVEn7y8IW4V4hXw+1iTXKQl8NDGKcsz7MkbNWzsJqivNwT0QFU+i
         QVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCydeNn0Q1JcuvZlK8KLNlezxrXb9EW71xAbaTW5dck=;
        b=kMC/5YeX7VFeJy0T9u4u44YssI34p4aLVOfFAYB67S+e9LYAkwOj97vjTCSwq+LFQ+
         /pvcB2sP+0Jre2qeyVL13ZJI/+DcWbTPtx7a4nmO3I7Uco/AkOEIqLRTqzcwe5GLOAax
         K3lxXuc8UDzJQ7+hRkGJlf1byGXnrjz9xS/21Arhre06wmuhe1b9g3ieZmi0Kr8S2e4e
         kf+OBJ+U84yi4GNlLkuULbNwrjAP6bEM/ZYV1Cz5XyCOXqanJSoMGozat101GXkM9P8Y
         dilt08fpgu9TW8DmShEBYWlo6jW1R7PXitpHHmQ+6hj63KlphTy/0BoTDXRd2SYNpfYP
         rvPA==
X-Gm-Message-State: APf1xPCad7UJKd7i+9AdrkUD7QWs1za+a2AnDV0S4jvSFLNauhBvzLoq
        NljopjCmRaJjPDUJMjRzYZb+H4KJXJE=
X-Google-Smtp-Source: AH8x225oMt5VP/cqREs1xuRrOXMHsEaaD5SK9k0oF8LTxmC5Mfvd3chFfAe4cXMAtCGqNxZELF8YMg==
X-Received: by 2002:a17:902:225:: with SMTP id 34-v6mr4538900plc.415.1519253653980;
        Wed, 21 Feb 2018 14:54:13 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l64sm76220229pfg.62.2018.02.21.14.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:54:12 -0800 (PST)
Date:   Wed, 21 Feb 2018 14:54:11 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-Id: <20180221145411.35b2ea84747518a499276bdd@google.com>
In-Reply-To: <20180207011312.189834-15-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-15-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:51 -0800
Brandon Williams <bmwill@google.com> wrote:

> +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> +				    struct ref **list, int for_push,
> +				    const struct argv_array *ref_patterns);

I haven't looked at the rest of this patch in detail, but the type of
ref_patterns is probably better as struct string_list, since this is not
a true argument array (e.g. with flags starting with --). Same comment
for the next few patches that deal with ref patterns.
