Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D9C1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDJASc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:18:32 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:42044 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDJAS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:18:26 -0400
Received: by mail-pl0-f48.google.com with SMTP id t20-v6so3374245ply.9
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JkLCl+T+HmVLtQIcU6Lq+Z8LViCe9WdqbVyrRNB3Q3U=;
        b=Ae13Ijm+RrzNZluuIU7jZ4JAmbXUxSwgBzugFukyzpTzTSBRMrH2v7Kw4UkmIx8kTj
         g8iGPilhcUfRKoBRtQc3KTaVSfoYTgNfBobg0/lhqPlCTW/YdX5Du654XEJ5OCmBU8cX
         ubMXUavCR2TwwOcG345U7fJFVevirWBv3XrUZAWcyZlI6MFXZp6UX8Z33UBvdC556nuv
         hQIcPvgsLy55YjFQDVtDh+pq62PQw65D+wZe5+bpN9NTHeYOG5KpSSUScgVJdUiq1G5d
         gf3zfZUXu448faTHhlUdpzqiIl3gVBeRRonyfiX0Vu8V6K46zoXiDP6OU53LZyXEXapk
         QoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JkLCl+T+HmVLtQIcU6Lq+Z8LViCe9WdqbVyrRNB3Q3U=;
        b=pLG6cWg+KP9/kCxpTHB8BXviUbF7UAfbw1lrvYRSuDQ3ZMfwXwmAJ0v5LEBTiWfkB1
         fDbJvJOv/+eNM+ISKSy+lfCr9iHXxW1tIs9jhhMBfxeAaXAZi/ENN4GyOThzqMDDwnCz
         vqdjS8gfGDYMqKcMhvAuAV7+B8jXukiOviDh+cwaKMRC8gJ1BIK8kRgDHBgS3+42U4IB
         2ZebyxWLkwpZ74kgym4IlQLMKScdwQLGwoneZaB4NEf+vxaOTLExuRNpKJxfGCk3qFpD
         768ttPF2txQyN3uT0Smd+5RcjHCJF4oYV1lsciYN2SjD9KSEosWhO45tKk6dcpfPp9Ai
         6rYA==
X-Gm-Message-State: ALQs6tBZCe4jD7ibavqYs5GLuLwzSJR1OwZSJC/eyJfmypFcP6dTKQ6p
        R43Sl5ItfIZ3OyLFbzxiXWvvdnnW+Dw=
X-Google-Smtp-Source: AIpwx4/4A2g9QadwzOk4cqWzjthtcmTay8NCx8RbUA1EqvzNzVa2BjuWPQZvawXU5T0t6NF8yuuTCg==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3-v6mr18047609plb.299.1523319504915;
        Mon, 09 Apr 2018 17:18:24 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id r70sm2775635pfe.22.2018.04.09.17.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 17:18:23 -0700 (PDT)
Date:   Mon, 9 Apr 2018 17:18:22 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 0/3] Teach `--default` to `git-config(1)`
Message-ID: <20180410001822.GA67209@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the sixth re-roll of my series to add '--type=color' as a valid
option to 'git-config(1)'.

I have changed the following since v5 (an inter-diff is available below for
easier consumption):

  - Update prose in Documentation/git-config.txt to match Eric's
    suggestions.

  - Remove extraneous braces, newlines from builtin/config.c. (cc:
    Eric).

  - Rename, reorder tests in t1310 to make clear which tests are duals
    of one another. Use '-c' to introduce short-lived configuration
    values. (cc: Eric).


Thanks,
Taylor

Taylor Blau (3):
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt | 10 +++++++++
 builtin/config.c             | 40 ++++++++++++++++++++++++++++++++++++
 config.c                     | 10 +++++++++
 config.h                     |  1 +
 t/t1300-repo-config.sh       | 30 +++++++++++++++++++++++++++
 t/t1310-config-default.sh    | 36 ++++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+)
 create mode 100755 t/t1310-config-default.sh

Inter-diff (since v5):

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 05a555b568..7c8365e377 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -177,10 +177,10 @@ Valid `<type>`'s include:
   ~/` from the command line to let your shell do the expansion.)
 - 'expiry-date': canonicalize by converting from a fixed or relative date-string
   to a timestamp. This specifier has no effect when setting the value.
-- 'color': When writing to a caller, canonicalize by converting to an ANSI color
-  escape sequence. When writing to the configuration file, a sanity-check is
-  performed to ensure that the given value is canonicalize-able as an ANSI
-  color, but it is written as-is.
+- 'color': When getting a value, canonicalize by converting to an ANSI color
+  escape sequence. When setting a value, a sanity-check is performed to ensure
+  that the given value is canonicalize-able as an ANSI color, but it is written
+  as-is.
 +

 --bool::
@@ -233,8 +233,7 @@ Valid `<type>`'s include:
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 +
-It is preferred to use `--type=color`, or `--type=color [--default=<default>]`
-instead of `--get-color`.
+`--type=color [--default=<default>]` is preferred over `--get-color`.

 -e::
 --edit::
diff --git a/builtin/config.c b/builtin/config.c
index 0c7cfcf6c9..08016863ac 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -300,9 +300,9 @@ static int get_value(const char *key_, const char *regex_)
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item = &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(item, key_, default_value) < 0) {
-			die(_("failed to format default config value"));
-		}
+		if (format_config(item, key_, default_value) < 0)
+			die(_("failed to format default config value: %s"),
+				default_value);
 	}

 	ret = !values.nr;
@@ -657,7 +657,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}

-
 	if (default_value && !(actions & ACTION_GET)) {
 		error("--default is only applicable to --get");
 		usage_with_options(builtin_config_usage,
@@ -814,3 +813,4 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}

 	return 0;
+}
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index b74c932763..6049d91708 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -4,23 +4,21 @@ test_description='Test git config in different settings (with --default)'

 . ./test-lib.sh

-test_expect_success 'uses --default when missing entry' '
+test_expect_success 'uses --default when entry missing' '
 	echo quux >expect &&
-	git config -f config --default quux core.foo >actual &&
+	git config -f config --default=quux core.foo >actual &&
 	test_cmp expect actual
 '

-test_expect_success 'canonicalizes --default with appropriate type' '
-	echo true >expect &&
-	git config -f config --default=true --bool core.foo >actual &&
+test_expect_success 'does not use --default when entry present' '
+	echo bar >expect &&
+	git -c core.foo=bar config --default=baz core.foo >actual &&
 	test_cmp expect actual
 '

-test_expect_success 'uses entry when available' '
-	echo bar >expect &&
-	git config --add core.foo bar &&
-	git config --default baz core.foo >actual &&
-	git config --unset core.foo &&
+test_expect_success 'canonicalizes --default with appropriate type' '
+	echo true >expect &&
+	git config -f config --default=yes --bool core.foo >actual &&
 	test_cmp expect actual
 '
--
2.17.0
