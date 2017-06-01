Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98AC02027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdFAJmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:42:01 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35388 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdFAJmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:42:00 -0400
Received: by mail-it0-f42.google.com with SMTP id f72so31526800ite.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=SqjLIiEaKj+cyqvNhuIDSJlV6zXzsY3rP8gKeFm48iMXv5q2OSSzT3/xlOY7DufeeK
         OwogYQRXrhmnodZBEkyCDat+3nevqrym+Z4MZeeCkMZenDDMLIVPVIPO3fShihs0vZmV
         iU2J+dqXMA7cq14ouAaMeRRJJ8el7WqvF3t7yHqtgdC07mbar4E3k5czQTFEP/IcyjKe
         p0wtQMapszuE0aMMwyJrJhzWE9UJvbcXh/on+EFra65I1VsqXoQR4cQGSDqEuQG4eysl
         YWbVqUfZ59F7iq2PIVpmbQ+DPqO0FLSRdlDvdmSqXjER89ei2w7c0ASveLB9FZ6mwpQR
         i/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=Q1yNoLXIs3QBWkl3flC1M/aieLadP5hxStRIsZeBUYrE1dh+jGaLXrAaJIs9JBminx
         8OzdiEThv9z6D1DSMTc0s1nWH4t2zY29RrqyPAdzwFhoMEbHkxyoQd7uxUPst2OZDxSz
         RyumnLoVYiUZdMwglL9at3ACcYqtYzzzx2CPBFKBQ6YKCEyuU6Pi1ay2IUOYlwfjWzP8
         Vt7j66JIzUw/63wcy5J3ZXPQO79Z3UqozorTdu4uLBDn7MLHHUmor6YSxfcuQy4lpOm0
         W7J1O9gJnGaOweHciZiIkLEJXk7QaLng/5l51mOiILLITMbm/8IkH9jYkt2bt8Kmecxf
         9Dlg==
X-Gm-Message-State: AODbwcCQIOItEDJTQ17wl4KDAbm9ezNtjmj4TUHfZRrL6GP2bhkwfe6d
        ejiXQ0Gtcw8g1Ga/sLc=
X-Received: by 10.36.18.135 with SMTP id 129mr1744459itp.111.1496310119194;
        Thu, 01 Jun 2017 02:41:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id h189sm12320446ith.6.2017.06.01.02.41.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:41:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tyler Brazier <tyler@tylerbrazier.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] pull: ff --rebase --autostash works in dirty repo
References: <0102015c5c7054ac-5ec72a28-ff81-42b8-8224-26a588cef485-000000@eu-west-1.amazonses.com>
        <0102015c61e06acf-70b79f3e-a6a8-43a9-b87d-273c1e2665f3-000000@eu-west-1.amazonses.com>
Date:   Thu, 01 Jun 2017 18:41:57 +0900
In-Reply-To: <0102015c61e06acf-70b79f3e-a6a8-43a9-b87d-273c1e2665f3-000000@eu-west-1.amazonses.com>
        (Tyler Brazier's message of "Thu, 1 Jun 2017 04:18:36 +0000")
Message-ID: <xmqq60gg59ju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
