Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B6C2D0CE
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC84206E6
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 23:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="kGkXHtrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLaXSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 18:18:30 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39126 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfLaXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 18:18:30 -0500
Received: by mail-wr1-f45.google.com with SMTP id y11so36097892wrt.6
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=mBgc1jePLgA93NHn6Cnk+dZESOiMKBzkrp/Fobm1+30=;
        b=kGkXHtrQqbKfiBX1dqzM7jfaotrHqcT6OxnLHn2je9LsPb92is65aHGyEZzQ7j37ev
         7ObWVwglrxFQ4KedDRJzh0E09TA7R+efLL+EAiHdufHxeKEo9pIftfTHR0FsQZZpaHhy
         epzM2F+rwQBB7H+qo8lP5kbvr0/Fyw9/FEMn0RXgd9mquELuVEAVqrRIdvbh6YaMajTg
         QZI/zYK/OzfS/RRelDc8Ah6SzFBFNGlpSn/F4cCD49QJW3Hj7v5TMKr6FV2y2atE4GJX
         2fRt+0jDXsEXDhJLihD+UkKlUDyJVMhV1irTAchSmc8QK/BYQqDWl0cbtUu9a6OTYi49
         Yu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mBgc1jePLgA93NHn6Cnk+dZESOiMKBzkrp/Fobm1+30=;
        b=giBh0HEY9ph9k1WP4Yr8setoOsPmCde6TTtBQhSk2WmI42flQG5gLPmzuV97V42YsG
         zsFiSDwKqLd0F/KQF5QR5BDMczd5MLLNw8l4JpNsP9duc1BFL6HPjklsH4teUEDxnVwJ
         ldYx9IEkbxIAa1APmbxeSdPWUKf1Ofd+OQYePeyDli/wqgQpYeOd9vX1s6lBMhjSYBA/
         scfNjCibb35BlLlmgB1J5yjNCWkGnYIQ1hgM3qhElRdvjYHCISdeKRasWJOCFZ3OChGw
         WBl4lICrBVNinHv4yTEG+yHf8HzzExym5DcCkn4i2+2x3MopQINmRlMezwlt5dgB7WHo
         Valw==
X-Gm-Message-State: APjAAAUcDF1UBGKk1L+Ct8foA2MqaiwSz/W3Pqt8xPbKJ5rCpXH31QyT
        GCGwFI9q2FVTPMRqgcT3yiTdSFmLcZf7xlaCGY8mGS8QNh8=
X-Google-Smtp-Source: APXvYqxuHvZWuStKe2WBhVUEtkn/IoDhRyyWeTke3tCDxGUTbie0SrOcujIavBKCqN1BLeuirpJrKJDs9RWSRaWK0AE=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr73077254wrn.133.1577834308007;
 Tue, 31 Dec 2019 15:18:28 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 31 Dec 2019 15:18:17 -0800
Message-ID: <CA+dzEB=m94egho+1UOGeDSFjjzwXYA-HncM-9C7NLLP=E3U2Jw@mail.gmail.com>
Subject: Reduction in blanks in `git status` makes output pretty cramped
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a comment on 7b098429355bb3271f9ffdf73b97f2ef82794fea

https://github.com/git/git/commit/7b098429355bb3271f9ffdf73b97f2ef82794fea
