Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9AA2047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdI3Sl4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:41:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:51113 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3Slz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:41:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id p5so1246599pgn.7
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuSDa8bHYA67RKP6j2y5qDBxY6x1R8fX1/+LNwcrXzk=;
        b=KI+zY059dRbS0CNNfYLaWnWuwpaXdwaC2EXqLHVw3eiME8tFV302w3lt6HVAt5Lj33
         iWKVEfCrKifcOGast3ilw0rsTvWTK3X0ILUo5v/eUcs07DFrcK9cVOKOQEaXFl6oppRC
         jBJn6DKe7V7novBCNih2fXogaXXkl2/T6LwbVtqU3Iqo90iljEsBxt2oqQgqxOZ8Tmce
         tULbC52/k55CxadwHatH4bLPES7yu6mFIFjKPTI3ZJIMxkjJvf3X7itqq0xFPMoxxRDk
         PC/8tE8iqb6TMaDBEOHu0Tscchh4Wz3n5CquiyBIlk3zAEy9ejLfLohFqTnPZjlhBkGK
         tpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuSDa8bHYA67RKP6j2y5qDBxY6x1R8fX1/+LNwcrXzk=;
        b=Q7pcbFaLQLiLJWaw1yEoKuVEK61PGdD2dF6OaL9YcxuyfKkcEHoauPEDaEp4IDiFNt
         8n6hK2pNHtg0B35WhdJnzq2VXSSta7EPQoT2I/wbmmny0fIqslET4Vxv0/645jY89Toi
         n1gDGY6rYufLRygkD3hHIWPr+C9Qgl/LFrueKzgNZt0KQ4OZCEtnT9XJ9vT2PcGXqVGe
         F4syIyCTxwTOhO2/mn0aZQzfQLFb/SXblbV6X4Qg7xAcdneYf/lt0DbagSAnr/m+M2Rv
         4K6dv9oB3D7/G3MsR5YqNEJPJFYCAhR5Bs9SR2EV0hdO68mcffMun77cWiFo/Tnm2DAC
         klaQ==
X-Gm-Message-State: AHPjjUh3BDJPnCM6Uiv1/1ziethFzyH42osb+8Lr11L/cK4MNLB22ZFC
        gkMrQWI4hxieg7SyA69aEuKOMxf+N8M=
X-Google-Smtp-Source: AOwi7QA3hGize4fJM2z4fk5zZh2U2glTeaFTZzLX59sYqkF0ItRq3X6SfdJhiYn6eNH5xZ1Co7jjhg==
X-Received: by 10.99.63.74 with SMTP id m71mr4819668pga.207.1506796913998;
        Sat, 30 Sep 2017 11:41:53 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id f2sm11140325pfg.135.2017.09.30.11.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:41:52 -0700 (PDT)
Date:   Sat, 30 Sep 2017 11:41:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 0/6] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is v2 of my patch-set "Support %(trailers) arguments in
for-each-ref(1)".

It includes the following changes since v1:

  * Accept "empty-sub-argument" lists, like %(contents:trailers:).

  * Fix incorrect tabs/spaces formatting in t6300.

  * Modern-ize code fencing in Documentation/git-for-each-ref.txt

  * Squash commit adding trailer_opts to used_atom structure.

---

  [1/6]: pretty.c: delimit "%(trailers)" arguments with ","
  [2/6]: t6300: refactor %(trailers) tests
  [3/6]: doc: 'trailers' is the preferred way to format trailers
  [4/6]: doc: use modern "`"-style code fencing
  [5/6]: ref-filter.c: use trailer_opts to format trailers
  [6/6]: ref-filter.c: parse trailers arguments with %(contents) atom

Thanks in advance :-).

--
- Taylor
