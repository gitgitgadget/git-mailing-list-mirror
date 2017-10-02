Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19BE202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdJBFxV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:53:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:47957 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdJBFxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:53:20 -0400
Received: by mail-pf0-f177.google.com with SMTP id u12so2423896pfl.4
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKzhyqvNMG2gksHcBI74+/OQHFsYbDQqMzeZFAC7h2A=;
        b=uFv8ZQ0ve/3RsorRnVcPd1Evx4j6RkvfsJnPJBH1733Epqqe3GZu4oSQ/rR2pyunDL
         vmTo1/Is0ditlur86+hVmVUJQpAtwPEw5GuC7PBLZmBbICyJe4/jCLSvi52oIZm9y/tC
         M4Ztp6oUoQxSnyOohiFVwqdVo0a+wVgW/2YkFkcCZJFxr5JVEDNcJfCKzlXR4GrsYpCK
         KEFyicjfU7exgy3q9c08slzF0bw2ZB0lmkELhaghvh7Uydzx0y8Fs90wurPwfhoUwb91
         ba7MCXdmUVRj4SAJ7VWdOR9tnmUxusTafVhdNBSpoljVZukeYhNrtX5u1gRt1soIna5s
         2xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SKzhyqvNMG2gksHcBI74+/OQHFsYbDQqMzeZFAC7h2A=;
        b=DNTe4u/qVhK9OQHFMRQHCtVZyDmrcKgLR4DEu+fZ4nbSuEkhR35gcJZ+bvr7gONq08
         rLlLtVr2mFir/QED2sJYLyMi8l4I2w6spL0C4KM1CtheiZ85iK6jiiQ+zIPLP1QUO+la
         rXZolmbY/dEw96ySXAubqKG/lJt+2geDORyX+anUrGH0gh44nQjh6dQeYe3WnWQzgpa6
         87TT4tVvKkV1z/mxjJr07Q3Q6GSAtbcsxHIhzWzuZUowSpaW+GH8lgA4GoLFJbCeSWdE
         XgiZ0yEUnxSL3dEq2yHx+ldTdfH0yjiuyz01uI8mtPbvVvc+0aVZJyWW4oc4/4SoAwM3
         2dxA==
X-Gm-Message-State: AHPjjUhX7kIKvMi0jyfMUpWQMGV5OmIvPGFnsD/MrekngvMLCh6Txy6J
        MkYJXcC1Ttt59Szf8rhNoF+bWq3gKyM=
X-Google-Smtp-Source: AOwi7QBKaEl4G6rptSRw7Ix/67l2Bpzs7y23QjYA5BWpTstYXD0YPU0tJ9iPSDQobCcROUudYPjEcQ==
X-Received: by 10.84.209.135 with SMTP id y7mr13263963plh.439.1506923599591;
        Sun, 01 Oct 2017 22:53:19 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id q136sm14959751pfq.10.2017.10.01.22.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:53:18 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers
Date:   Sun,  1 Oct 2017 22:53:11 -0700
Message-Id: <20171002055311.29681-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff points out that different atom parsers handle the empty
"sub-argument" list differently. An example of this is the format
"%(refname:)".

Since callers often use `string_list_split` (which splits the empty
string with any delimiter as a 1-ary string_list containing the empty
string), this makes handling empty sub-argument strings non-ergonomic.

Let's fix this by assuming that atom parser implementations don't care
about distinguishing between the empty string "%(refname:)" and no
sub-arguments "%(refname)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c            | 17 ++++++++++++++++-
 t/t6300-for-each-ref.sh |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3..22be4097a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -415,8 +415,23 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
-	if (arg)
+	if (arg) {
 		arg = used_atom[at].name + (arg - atom) + 1;
+		if (!*arg) {
+			/*
+			 * string_list_split is often use by atom parsers to
+			 * split multiple sub-arguments for inspection.
+			 *
+			 * Given a string that does not contain a delimiter
+			 * (example: ""), string_list_split returns a 1-ary
+			 * string_list that requires adding special cases to
+			 * atom parsers.
+			 *
+			 * Thus, treat the empty argument string as NULL.
+			 */
+			arg = NULL;
+		}
+	}
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(format, &used_atom[at], arg);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b73..edc1bd8ea 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -51,6 +51,7 @@ test_atom() {
 }
 
 test_atom head refname refs/heads/master
+test_atom head refname: refs/heads/master
 test_atom head refname:short master
 test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
-- 
2.14.1.145.gb3622a4ee

