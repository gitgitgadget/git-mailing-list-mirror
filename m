Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4B01F404
	for <e@80x24.org>; Wed, 14 Mar 2018 00:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeCNAop (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 20:44:45 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34595 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCNAoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 20:44:44 -0400
Received: by mail-qk0-f179.google.com with SMTP id z184so1765209qkc.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 17:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Cxlm3fNgw6tsls5fOrbqp0QqzOOsdoQeDw0ULGH4MoA=;
        b=KoRP3J4JANz8HJ019kgBYIlkLLJlBRjqtnNAyNknIfe4wYcXuCSqmCSe5PHke7TB/k
         yZkHJCCI6b64j3zWR73emyewSLbvdABqXH5UT285tnqd8mRaujtWriRYcelha5tjj+YP
         KxjUhlgrUgfxIpatqvVISjTXfbDIXc9JkOEKcexbAzZ8VuQQdmz207YmG6yKo2IOj7Jf
         +LCPIC3Wgxhd0lrVAAkMLh+aPvQB59Xvts0wDLng2WN15FGPXKkYRTDCpEGc5XJviIse
         cX9PVyEJ1isxadNpq2h8jZIH5W7/p4abooEXthaWCjTAwHr7OQudzrF/hcqZgZtMtE86
         FJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cxlm3fNgw6tsls5fOrbqp0QqzOOsdoQeDw0ULGH4MoA=;
        b=J6ICxUDWq5rMNzj0oip5QDkiigxVHrAdDNzv6SBH0ZrKDt7R87aHAYvj07S814cnHX
         NcWLqxjvVGxs6dIrldIArUmNa9ZjKlX1lb2n5y3ZgZP85FGbohJffORG2U+euuNnLZwS
         dDwd8594WAXBd/YKzXhOuTZbAtlcFQCc74YgXDnjbRfTIy3L8z/FlZMXFUwydso2NGYM
         IqNnGqjrCLCkQo+wiiv3W0JAEmh7tTMS7cBF0zHnaPy8EE+prjUoZLk1FqsnzOCFePCF
         UWMIEFKy7bYlP1O/3xls69TwmAeH9CUiQmiCFu7gJlUkFb6F6pCyhMEymtkVGhMw74sZ
         eEJg==
X-Gm-Message-State: AElRT7FNcwKj0YJkCtYc3/5sy747EVDCDyoKMhYR36Vp0GqLfrv9q2Pg
        /9eYyq9tuje4Xl9NZIFZhMH09a/v
X-Google-Smtp-Source: AG47ELsjh+ZCHu6pF4OC/yUDjBKC509+PJ4DJrimOwM2Tq6KCrZKKjLtK16WAeR9yY53Mnw3ubY6IQ==
X-Received: by 10.55.118.198 with SMTP id r189mr4124323qkc.72.1520988283680;
        Tue, 13 Mar 2018 17:44:43 -0700 (PDT)
Received: from viet-VPCEA32EG.hsd1.pa.comcast.net ([2601:4a:c102:100d:8071:bd5c:7727:4ae6])
        by smtp.gmail.com with ESMTPSA id b55sm1180836qta.27.2018.03.13.17.44.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Mar 2018 17:44:43 -0700 (PDT)
From:   Viet Hung Tran <viethtran1620@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: [GSoC][PATCH] git-ci: use pylint to analyze the git-p4 code 
Date:   Tue, 13 Mar 2018 20:44:41 -0400
Message-Id: <20180314004441.5075-1-viethtran1620@gmail.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da
In-Reply-To: <CAE5ih78HdDvN+x94H3Tzygis8QGROUe4B-yBubFH4simN2u9vQ@mail.gmail.com>
References: <CAE5ih78HdDvN+x94H3Tzygis8QGROUe4B-yBubFH4simN2u9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Mr. Diamand,

I see. Initially, I also thought of using .pylintrc but I don’t know 
which error should be ignored and which should be fixed so  I decided 
to adhere 100% to the convention and fix each type of errors in 
different patches.

Thank you for your help,

Viet

Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
