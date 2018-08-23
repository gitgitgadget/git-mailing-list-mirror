Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5151F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeHXAHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39334 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so7149740wmq.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//K+q9BJzyUB3j0s6RVf0plU9hbpD3Mq0d5M69cR6dI=;
        b=CFAPC47g0Om1qWvY4fcHmI4aXRmAP5tuSFklb33nSrKYOjAng5dkT4edIOwhj/kzmm
         8GQlc0iP2oGIpuOtARLJhIQ8fktHq3TL4e2KMe39FSD/6URXlQSbf+rAxByqVYmhkh8h
         nhJvOtfJQR1OoOwaEH1ktblS0J30v3+N56nkZU0jcdy5mQ8pu3mTK6aPk7W5vdRNqieT
         pMWD9a6iAsKCQUQd7t0UdxXk8UErblffPG67Hs5SO/l1sBKW6bJ18fltswFPN/RO/neq
         uv1R3N2BuoxcyaJdp9Bt6FsZhkcWZr/i7dVjGGSnuYj/knVKn3/8Eja8gSJ6xscePJVp
         MOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//K+q9BJzyUB3j0s6RVf0plU9hbpD3Mq0d5M69cR6dI=;
        b=ojqjNVFK9zOyf3jxPO3LkWrpvmOTGXLL9Ya/P5Bc4i4ZndaD6TgX+eRJM9LH9QYVvE
         M6IF/KGKgs+jfNsKRX1/Es+oHB+qOFd1oWioodlGmwlB5ELfhTrMzu/7fcaHbx3w+SuC
         +e1PojvktzRKL1t9B0isJdczRvRdTRek21vGkjOH0uQoH7syGdI9bGHSsIKT62I5vlTz
         X/EfP/9v3tpfCqmNRZOOKuXQyqTjdJ6UHnRul81LLO/IVtGtOM7NlCuzWpH0jhzLtF2X
         1AzMtWra5IpMZnt7X/N9VgwD8Ubkade3bxAnL6zG4G7NHgYEZUDtqaShOIQTp38czhKo
         tX8w==
X-Gm-Message-State: APzg51CZm0KvsQanFVfidedBe1bZfibHJZIt5d+TMhL0esjXdZ3vVDTW
        ftsuwAYsrJoa3IdJl/6RdolTzlRyxD4=
X-Google-Smtp-Source: ANB0VdYjkKLjMkF/P4TEayPsrqrOb6Y/kv7sdkBkqc6YQKzHiJB7LLdPaO/HM1OJMfmQf0fFfNp/tQ==
X-Received: by 2002:a1c:c4ce:: with SMTP id u197-v6mr6143323wmf.10.1535056590757;
        Thu, 23 Aug 2018 13:36:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] tests: fix version-specific portability issue in Perl JSON
Date:   Thu, 23 Aug 2018 20:36:03 +0000
Message-Id: <20180823203604.5564-5-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test guarded by PERLJSON added in 75459410ed ("json_writer: new
routines to create JSON data", 2018-07-13) assumed that a JSON boolean
value like "true" or "false" would be represented as "1" or "0" in
Perl.

This behavior can't be relied upon, e.g. with JSON.pm 2.50 and
JSON::PP A JSON::PP::Boolean object will be represented as "true" or
"false". To work around this let's check if we have any refs left
after we check for hashes and arrays, assume those are JSON objects,
and coerce them to a known boolean value.

The behavior of this test still looks odd to me. Why implement our own
ad-hoc encoder just for some one-off test, as opposed to say Perl's
own Data::Dumper with Sortkeys et al? But with this change it works,
so let's leave it be.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0019/parse_json.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
index ca4e5bfa78..fea87fb81b 100644
--- a/t/t0019/parse_json.perl
+++ b/t/t0019/parse_json.perl
@@ -34,6 +34,9 @@ sub dump_item {
     } elsif (ref($value) eq 'HASH') {
 	print "$label_in hash\n";
 	dump_hash($label_in, $value);
+    } elsif (ref $value) {
+	my $bool = $value ? 1 : 0;
+	print "$label_in $bool\n";
     } elsif (defined $value) {
 	print "$label_in $value\n";
     } else {
-- 
2.18.0.865.gffc8e1a3cd6

