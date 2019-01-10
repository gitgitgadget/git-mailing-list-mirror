Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377B01F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfAJTeV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:21 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:33545 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAJTeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:21 -0500
Received: by mail-oi1-f201.google.com with SMTP id x65so5660958oix.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0LXXQh/phLcJSBoQ1/ajHr41OFqU0Pt0amfiRWH3bi4=;
        b=dm//X7Q7+Ux+w1ZyB4+DHG7nHIeGiN2mwg5zpeiiQ7Bxv1EL+IMztsygvVaX/WpD3c
         a0jvdHqvwbrSssPv2ZaoWg6HtPn5Mvym9fcJqaIsUB/rqgm9pLc45u0DXIz5BoxB9tCe
         EKGdq08k0Lxo5sagygReqKfrtG9c0UzayMMapaznDy/aa7PJeIij5iX2gnmR8w7IXYJ+
         /SJkvilrM7A2YHJlDxCu4sxc4mXkVFoPMZus1hSp45162vIQBrR3QXKj6xLZT/pb+oNb
         hWPVkohMQnYfdBP1CE+NwZQWguqI2lO8xMHJ/blJzBJ7qp5jEDuFxBSTA8q0ftcMx0sg
         vo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0LXXQh/phLcJSBoQ1/ajHr41OFqU0Pt0amfiRWH3bi4=;
        b=HYOOtEq3/mTWusj7FQrFs5SueS1maA7ZgOEJpV7tmBXvDLjJ794f0+ausySNn6cynZ
         4xIKSd7MD92q+Kxijx4QemerRxR5t5cfgaMwaZxH1zUtbNnRwGODYGKy7c3Ymt2c6KmL
         gt7QmAq8M2TpJQjMPQSSgVb9gdxLyCfF0jgS+ow/aKRfCH7AolgIxVv6JKZjyS5XpSDC
         Xw3x9/JhSkSoWAh4iI9CbbVItkJoltgDds1RlOsmkBbEnFsDSu+A6hSGdpQSIvV9Yc+D
         HG6YCnfpUqa5/WgvP0zwEHUxRUUO0aR0mGF4If/ZI8TF7ZHRYYviC6VVMRqFEJ6W7H80
         tYWw==
X-Gm-Message-State: AJcUukeyqEjM3q3DN3+K+FGF/pY/NZyOoPASFOJOkdKejYyE4U7msUlT
        jsD9kooczLh3GBGHWCnl+Fx+2sQlsL+8lRRoQac=
X-Google-Smtp-Source: ALg8bN5+/r2CqMsJRN0oKsrxrMgn9oH6RMihCnBBG1C94NtYRSXTlgjM+uUaKzWCcyPIkWhmyYmQEDUVB9e/GaF/Y0g=
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr4540457oiy.15.1547148860743;
 Thu, 10 Jan 2019 11:34:20 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:45 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 0/5] Show HTTP headers of failed requests with GIT_CURL_VERBOSE
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff from v3[1]:

*   Handle ftruncate and fflush return values
*   Call rewind to set the position back

[1]: https://public-inbox.org/git/20190108024741.62176-1-masayasuzuki@google.com/

Masaya Suzuki (5):
  http: support file handles for HTTP_KEEP_ERROR
  http: enable keep_error for HTTP requests
  remote-curl: define struct for CURLOPT_WRITEFUNCTION
  remote-curl: unset CURLOPT_FAILONERROR
  test: test GIT_CURL_VERBOSE=1 shows an error

 http.c                       | 32 +++++++++++++++++++-------------
 http.h                       |  1 -
 remote-curl.c                | 29 ++++++++++++++++++++++++-----
 t/lib-httpd/apache.conf      |  1 +
 t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 19 deletions(-)
 create mode 100755 t/t5581-http-curl-verbose.sh

-- 
2.20.1.97.g81188d93c3-goog

