Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6C920248
	for <e@80x24.org>; Wed,  3 Apr 2019 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDCTyO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 15:54:14 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33220 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 15:54:14 -0400
Received: by mail-oi1-f170.google.com with SMTP id e5so14685353oii.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mYZraSQ3quTNsuckPPk4abvZv/FHf0jI2d+bKrZTeW8=;
        b=R7zNRr7gAJgl8DZh7stjyqbvIo85b8QT7b0054NH0ZZ5NcMMCqlKEo5Fth4emFNN47
         ucKXIQjjbjEyRNS+Ecp8u+GtCpqOPIit9NGVK2EY60umgpmWE2fCzimZMcPIhm6DDtKw
         6F7SHqUx4US/cUGIvMxXc4g7RBczynEKbXI/h46dsUhN3X/HVtolIUNL8Cc0lwuvrZlU
         HvdOyXmI5m0K9tu8qIfRTDI073RV+zVaSO8E0czA+w1y3V7WEALEjIEHCIADk+LELs9E
         woC90zULJHSeRNTlr4lH4zvmrgGWYKFPOZ5vV1uPJ8U6gMRrABKVAR7h1uscicHpKs7h
         7r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mYZraSQ3quTNsuckPPk4abvZv/FHf0jI2d+bKrZTeW8=;
        b=ZFHvRsRsSq19p3id0My3+otLPtnG5dvXeVd2+uzdxSpwlW94dfbp1VL8HDe/AJYQqQ
         zo14DM2Wtt6ocD8DZ6kwpma7xFcwFEF2TbTqu5dAPPIpVGNkp+JE12Ypbys4f5w2sIwU
         8tnGMUMNzcguzxWiYZw/AKWwJErPkmcJeaeR0QtUq4tTpsRf/0eh4jRIlzVhzafkonil
         zD3DcQsDeA4rsHkzYw7oZ1M+w1R3UqSWgLcTMU/XYO1kvSVcmpA4MVFIr+SqtyMv2wAx
         HhrcSc/VfgwQe7lZmNgjlU0m+RHaaKoHl/saQpZo84O4FKQWHCnovsgQgi3dakvn6/yl
         IXFw==
X-Gm-Message-State: APjAAAW9XcCl4EzLH3edW1b+q9MdqYrI/mPqVnsg+lB7OENZdr97Orzy
        R7kWpXmQx17g8wrzH4EP/erLOPnpQKkHZaCB6LNzqvZh
X-Google-Smtp-Source: APXvYqzkDSSC28bbZXu7bhTE4UPfo9qqulnN5IRw+LDwUTeMc/vFwE0nKokIaeqZ25u+3LAnklOYnUrSNH62McaaD3I=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr932421oif.110.1554321253631;
 Wed, 03 Apr 2019 12:54:13 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Thu, 4 Apr 2019 01:24:02 +0530
Message-ID: <CAMknYEPzUpa3c9PSfJNo6rzUOt-bDUDYrcn9JcHgSGW43KuRYg@mail.gmail.com>
Subject: [GSoC] [RFC] Unify ref-filter formats with other --pretty formats
To:     git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, peff@peff.net,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reference: https://git.github.io/SoC-2019-Ideas/#unify-ref-filter-formats-with-other---pretty-formats

I have spent some time with both pretty.* and ref-filter.*

First off, we are aiming to reuse ref-filter, so avoiding any sort of
re-implementation is recommended.

Now, coming to pretty.* and ref-filter.*

suppose, a function named xyz() in ref-filter.c seems like it could be
reused in pretty.c.
since ref-filter doesn't use any struct of pretty.c. The xyz()
function in its original form is not useful for pretty.c.
So now, in order for the xyz() function to be useful in pretty.c.
Function xyz() should be using structs of pretty.*

now, if we make xyz() use the pretty.* structs, then its
re-implementation and not reusing. its like keeping two different
functions one for ref-filter and another for pretty.*.
which is what is already happening.

please provide any starting point for reusing ref-filter. i don't see
any in pretty.*.
reusing ref-filter specifically in pretty.* is not the motive. please
point out any file in entire code base, that you may feel can reuse
some ref-filter logic.
