Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19013C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 06:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjEJGbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 02:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 02:31:40 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7FC212A
        for <git@vger.kernel.org>; Tue,  9 May 2023 23:31:39 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-541fb831026so2272733eaf.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683700299; x=1686292299;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=escc5rOdtOSAVk/+yspBmm9embVBjJ7CH4qK1cwbIsU=;
        b=r0Ra2W5KVhb8P9EqszmyTCUweh6ew+jJyR8kQWNdXUhpvS8vHH654hT4NdKC4fyY17
         XJaPo3aMinww6sfTf91UNg64jCp5uxStzMHkjWgxIE5B28ZcPbjfvfu/gtfRNfY9oAvp
         RXVKQeErwioP1DSpnKpXj4q5ptCGjPPT7f7m6YjjiHVCSUS2USu3z9Y6M7fW71rPOCud
         4iulI0/HbdAlw+1ELH1sEZqYHebt20/0Df97O0uro3AnqzshX5cEkilxiWCkYVFS12rn
         +pjWu2MdI3VkZSydEgtDS1lnBTPYSx5h1BMr74QtO3gthoWAyFy1xPXvs8JV94fkN7VI
         w9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683700299; x=1686292299;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=escc5rOdtOSAVk/+yspBmm9embVBjJ7CH4qK1cwbIsU=;
        b=c5OYQoVmXFmXOE1PNM/9Ya6msNsLVSLMouNDqscnGkcWp4J8ckDsp0exb//uELV4fg
         tQfDjH8h9pUcX5woBUo/Wvss0OXZeg6ED9UTZIq3Ph5VhJq7DJKcsn8KAzPBQs37vMjX
         lGrwfI8HUidrcr1LLoagALOD656V/o1kavK2x9OVdl87XhuahxHaStn8dg/eDAt4LYcY
         D3yoK4GWM9XWEMOUFTkSbaW2FECZmyuAlqdLdN5t3BmFrufh9qzgkee0U7bnNVkJHpjw
         YQpxpDcTDYQ6tJae8JwyTE//or3nJ/qwL6BOfrP4opIh+jvRiPywLJFBKWRUPyBZfBLN
         VdnQ==
X-Gm-Message-State: AC+VfDzeXjYmBrF7Isq3iQUQ6G4EcDHSeIbv5i2mx4vbvQMQ5CUarehd
        GrU1ZJFMbhN5HOUoEelVXAckmwuAdbKiVId+61aBlAbkHvw1iK8=
X-Google-Smtp-Source: ACHHUZ5pTY8FGM6qV6ASF1i8vmkJ9FIv0vngqiLXXhFO9o9JFSaNYUvfadlSmCu19xE3ZTA/2id2YV3Q+V7PggDKBKE=
X-Received: by 2002:a54:458c:0:b0:384:3975:3dfd with SMTP id
 z12-20020a54458c000000b0038439753dfdmr2304220oib.55.1683700298773; Tue, 09
 May 2023 23:31:38 -0700 (PDT)
MIME-Version: 1.0
From:   zhang lee <lizhangovo@gmail.com>
Date:   Wed, 10 May 2023 14:31:28 +0800
Message-ID: <CAPQzXO3X1G1VKDXyN=maRo5qZcFhAjqQJoKb6HTJZBrbr26X4w@mail.gmail.com>
Subject: git has no Authorization in the http header
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

When I cloned the code via git http, the url included username and
password, but the debug mode request header did not include
Authorization. As a result, I could not obtain the Basic Authorization
in spring cloud gateway,

as shown in the attachment.

Is there any configuration missing,

Any suggestions please reply, thank you very much.


git debug message:

GIT_CURL_VERBOSE=1 git clone
http://awp-git:kcNkdmW13AvFJoK7@10.109.37.87:8086/awp-git/action_2
Cloning into 'action_2'...
17:56:44.772293 http.c:781              == Info:   Trying 10.109.37.87:8086...
17:56:44.774521 http.c:781              == Info: Connected to
10.109.37.87 (10.109.37.87) port 8086 (#0)
17:56:44.774521 http.c:728              => Send header, 0000000225
bytes (0x000000e1)
17:56:44.774521 http.c:740              => Send header: GET
/awp-git/action_2/info/refs?service=git-upload-pack HTTP/1.1
17:56:44.774521 http.c:740              => Send header: Host: 10.109.37.87:8086
17:56:44.774521 http.c:740              => Send header: User-Agent:
git/2.33.1.windows.1
17:56:44.774521 http.c:740              => Send header: Accept: */*
17:56:44.774521 http.c:740              => Send header:
Accept-Encoding: deflate, gzip, br, zstd
17:56:44.774521 http.c:740              => Send header: Pragma: no-cache
17:56:44.774521 http.c:740              => Send header: Git-Protocol: version=2
17:56:44.774521 http.c:740              => Send header:
17:57:10.644479 http.c:781              == Info: Mark bundle as not
supporting multiuse
17:57:10.644479 http.c:728              <= Recv header, 0000000017
bytes (0x00000011)
17:57:10.644479 http.c:740              <= Recv header: HTTP/1.1 200 OK
17:57:10.644479 http.c:728              <= Recv header, 0000000028
bytes (0x0000001c)
17:57:10.644479 http.c:740              <= Recv header:
transfer-encoding: chunked
17:57:10.644479 http.c:728              <= Recv header, 0000000022
bytes (0x00000016)
17:57:10.644479 http.c:740              <= Recv header: Server: nginx/1.23.4
17:57:10.644479 http.c:728              <= Recv header, 0000000037
bytes (0x00000025)
17:57:10.644479 http.c:740              <= Recv header: Date: Tue, 09
May 2023 09:57:11 GMT
17:57:10.644479 http.c:728              <= Recv header, 0000000059
bytes (0x0000003b)
17:57:10.644479 http.c:740              <= Recv header: Content-Type:
application/x-git-upload-pack-advertisement
17:57:10.644479 http.c:728              <= Recv header, 0000000040
bytes (0x00000028)
17:57:10.644479 http.c:740              <= Recv header: Expires: Fri,
01 Jan 1980 00:00:00 GMT
17:57:10.644479 http.c:728              <= Recv header, 0000000018
bytes (0x00000012)
17:57:10.645480 http.c:740              <= Recv header: Pragma: no-cache
