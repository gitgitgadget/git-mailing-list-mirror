Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443E320A26
	for <e@80x24.org>; Wed, 20 Sep 2017 11:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbdITL04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 07:26:56 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:56135 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdITL0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 07:26:54 -0400
Received: by mail-pf0-f182.google.com with SMTP id r71so1372087pfe.12
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pEUIYYrXzFCrDmDpP8keWDjhFcDWjsWfU/a33UsKolU=;
        b=br7n4xldgI3eXCNtDxKlmy57AgyBD0h356pZCVjd0sQ/rSPwEzUPKRw/VPDnwTb2nV
         hz9BfhzShOR/yUCi9q4UUgtMZXwUj9ZgifZ/Dvj/6AKmrLO65zGq/y0CEqh+atDhvyea
         ZajrifrTt4wWvrkc4T/ELeTXjeaYPU1VJgZ7YKzZ03r0dcQeWIx93bUYeODIII594i0k
         mIsmE/A4rk4tK4iY0HUBUxVFkcewNrpabi+CB0ML+cVdK9rcbiaIjWSkwfjER1SjtIFA
         yoPx+RSHphURSVkt4bDruScA/YyX3RNwLXLKDvULfqNQK8YvsyfqPmj22XqrwcuQGTuh
         8gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pEUIYYrXzFCrDmDpP8keWDjhFcDWjsWfU/a33UsKolU=;
        b=sw9UBWJLVF+68Pd9Pc+Pf+lmn5P21PEp9lXlfqniI5fxoeKIi5O/Y4EzGFWoEBHnNf
         puhSpKaRqIFW2xUrNPTwb29wsex/JWrvkFVx6Xkxkr6Ugp6rAPGVDPOAP9T4POi3T5CK
         ccgd9v4ZFuylhq78YpdeH5aYhrOAm4CBELv6X8+c0+J5/DI+xn3Hr/69kV9YyXng01Q2
         jERsEdapCnQR6u5X+LLD94loZTatyLspxnDr+bVqhMMiWWnjsaqXHR67B0YN4muYAZpH
         oW1OYw9KBldcpHw4LquGaYH4G96K0VXkyvZMZgANSs2rn63MqQEkdQFI2UfPD0xU/Nw2
         vyTQ==
X-Gm-Message-State: AHPjjUibGK06CzEKOb1frpk8+15IH8dkfrn+SQIRJwaksd326ngFADry
        ZREsZAvKDzAe0VDmpWL0mvEPiTa6
X-Google-Smtp-Source: AOwi7QCTRW5+eVWKdvt3QZI8QELXepDEp7neZO9FVybpEaSWAs9CpKTUW7Ccf+TlaZmNhd4v5Wc53A==
X-Received: by 10.101.72.5 with SMTP id h5mr1880270pgs.305.1505906813527;
        Wed, 20 Sep 2017 04:26:53 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id z24sm7690111pfk.3.2017.09.20.04.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 04:26:52 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] builtin/checkout: avoid usage of '!!'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
 <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
 <e07a613e-8b69-e382-777b-b5797270ecaf@gmail.com>
Message-ID: <fbe3d3e2-a14c-fe7c-7e5d-c24789b249ca@gmail.com>
Date:   Wed, 20 Sep 2017 16:56:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <e07a613e-8b69-e382-777b-b5797270ecaf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wait, I missed a contradiction here.

On Wednesday 20 September 2017 09:30 AM, Junio C Hamano wrote:
> ....  And !!ptr is a shorter and more established way than ptr
> != NULL to turn non-NULL ness into an int boolean,

Documentation/SubmittingPatches says:

>  - Some clever tricks, like using the !! operator with arithmetic
>    constructs, can be extremely confusing to others.
If !!ptr is a **more established way** to then why should it confuse 
others. Of course,
!!ptr was stated as an "exception-rule" where ptr is a pointer (possibly 
NULL). That makes
me wonder in what case is it "confusing" at all?

---
Kaartic
