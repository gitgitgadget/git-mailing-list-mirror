Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D231FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 16:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbcGSQkw (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:40:52 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34859 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbcGSQkv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2016 12:40:51 -0400
Received: by mail-wm0-f47.google.com with SMTP id f65so145089946wmi.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:40:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=45ansQwHoaBA5VTVghMDVR6aBKg9d/35lopiHSdxS9c=;
        b=Bx3/2LDzf+SL5ubYT1H3524MomsBv6YHQIFPAror/Sz4OqK41wEHdlbQ77JH1d8/W2
         8pDmepenhuTNWoAYcR1TRoJCmc/mWB54Qc0vcx30YM+0RnHd2oZI92yxePaANBBEhZnS
         4vl6IbbfnZayu7JiZGv6es60eutExWLFP+Z+fQjs/YBxLl/iPXDRng2cP0Mr9kxNtt6F
         7pVuBFnuGwg/JXR/4D4V017Bl0oWrB3wr/YAzdEmW9b0kWub0JX2EIPjGtFuyxUyOnPq
         J5XAJjvBV0Lv6hFPWEeFG+hZCGbc9Us6NfAcI9QmttEo1AXLORsIuT9juaD0mfrqkjuG
         1Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=45ansQwHoaBA5VTVghMDVR6aBKg9d/35lopiHSdxS9c=;
        b=jlZDZN9jZ3/tTTAQMjSuEOJZyG/CKIfghWVcdc5N0n1+xQS4fpc8ijaH95+oxRQch0
         OlKrTLwnlunJZkx8HsUxti2AdTQ+U2G4lrKveSJTOdNpG26T9FzK7TtqPerwMHBvHBL2
         X1yhOzPBKn4x427exosPqX6cPuc07n5QQTujpvSD8ripRgjdkze4SBskBCHP8v9M4418
         EN+HdNfFBeqODC5uszsN45UK+dXTTnr6fxmX6I0PJh5fuvtflz0lVJFRVIzWvlZwXyc3
         CICKlU6tUIQlPiIJ5Vvhysh6oysKQ0MYNy8cRex2bMn/y1q3k5V9OysTsJKSq2vHzxMP
         QdHg==
X-Gm-Message-State: ALyK8tK7+iKJs5+RIsO25vR73rEnIVyg4nWqDGI1TabUAsKROmE15xf2W6GysKp6biAOcw==
X-Received: by 10.28.109.197 with SMTP id b66mr5344550wmi.68.1468946449722;
        Tue, 19 Jul 2016 09:40:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r67sm24209390wmb.14.2016.07.19.09.40.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 09:40:49 -0700 (PDT)
From:	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: Looking for help to understand external filter driver code
Date:	Tue, 19 Jul 2016 18:40:48 +0200
Message-Id: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To:	Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

a long time ago in aa4ed4 Junio introduced the external filter driver definition. Since that time we fork the Git process and then we fork again to run the external filter. This is probably a super stupid question with an obvious answer... but can anyone help me to understand the code and explain why we fork twice? Wouldn't it be sufficient to just fork once for the external filter since we cannot process anything in parallel anyways?

In 546bb5 Hannes refactored Junio's code to use the async infrastructure that is used today.

Thank you,
Lars