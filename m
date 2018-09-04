Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1089F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIEAy3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:54:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36861 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIEAy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:54:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so5565373wmj.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMXVTyOwXPUYArREfOgtf9+ICsupsmN5NHTzZIEPgjU=;
        b=SgIJwfx0WITKDU2BDPG36HuUfd0oPBHcLOlwfPqPHJNcd0c3tJghgkbOAwP/EpXM3U
         fikqTk8RDNeuRJFwM9KHTSMZlWx25lhA4PtaqJWqp2xdMgM0D5yJ12e6dMnFqmh6p7+r
         FtCEMGseeKJOEpmtGCBZ6ki25qjBvqm/3/YfKni1R531HoqDds97NW2FbrX0IvEcrRUg
         2sGdt2DR5HL3uEquK57RoAambBOpdlzBKYSTM39toLGCGgdOJGodhq6pvkQqp/3+QisD
         gedFbalBk/bBLQBTmnVDWc4CI0/g0wUhURwZ2HkCTSFWEQwLRCnsn44DDLVU4Hs9ATAH
         beew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMXVTyOwXPUYArREfOgtf9+ICsupsmN5NHTzZIEPgjU=;
        b=iKWNIpkhTj0G/7e5LKRUM+a939e4PH6wboV03xvJfkHz1xH5k12xMUYv7O4Atv+0dQ
         e8yA1ejCXL3CE5UI/LNtvZHqFStG4uJYx04cmZ3qFj9Ix9KwLjraU/jqheFccUgLTxbA
         VcYErP5tsRh475GEszsQ7/Ee8yKqxW1qn5NIHq7WXdxuyNF/8S3xv6hGlRhg2JmYgoE5
         P/uYnYoOvnpqwXO8lpdVn8J5cNYDC+ptVZ3uZowGExr+I95LBo5nNopcwrxc8K6dutmR
         goVIpxT8xoHoOMsM7HMSu7ddz4xfFp62kyLoSEM7wWtngj9lVHWNp8W9ZVsnJRRYVzkc
         OSPw==
X-Gm-Message-State: APzg51Cham+LsRRa9K6IErZH8xbZcB/s0LYolwr+aV1z9tnymhelKpN3
        bWpzLBzijisO0CsmqoX2IALhFuDr
X-Google-Smtp-Source: ANB0VdZz7HxxP6Tw4sRiJ4JMRFAzT47n7CrB6Xwbxs4rDgynwQX+1XeQrXtAb6bech7Cy5a0qGn8FA==
X-Received: by 2002:a7b:c119:: with SMTP id w25-v6mr3582395wmi.163.1536092863426;
        Tue, 04 Sep 2018 13:27:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l130-v6sm257109wmd.16.2018.09.04.13.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 13:27:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] commit-graph: add progress output
Date:   Tue,  4 Sep 2018 20:27:27 +0000
Message-Id: <20180904202729.13900-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds progress output to the commit-graph command, so that
when it's called by "git gc" or "git fsck" we can see what's going on
with it.

Ævar Arnfjörð Bjarmason (2):
  commit-graph write: add progress output
  commit-graph verify: add progress output

 commit-graph.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

-- 
2.19.0.rc1.350.ge57e33dbd1

