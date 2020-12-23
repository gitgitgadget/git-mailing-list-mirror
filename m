Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB00C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13609224B0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgLWVzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:55:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63400 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgLWVzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 16:55:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3583499BC9;
        Wed, 23 Dec 2020 16:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhTgtyIW7SQm8Fw59pHWN+JlW90=; b=ZgmjLd
        8Y5wQmGfyH4Fgklvr96pUUK2ZOc3mXPseH01yYZkDOMlmYisipwr7aHDw6URAfTt
        AzLOdtUaPQrJcar5gIkar9T52OZyFvFc9PZI7Cod0FGPqGIoIv7JlyrPPG1awovv
        XbgdDE5jxLuJKScob11ppsVeBMkyQ4r5K9Cmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TQxhk6XHs6KRXifsvgNqSwfPhEjWbpXv
        PXgsUPcLW+CroBnPxMwLfY8ad24SP8pKV8KlLKy3T2eIdPehfewDJcbwjRsPnCIA
        88iXwjcf9AlAHQhBEcl3ypZ9U8XrJABXfNFQoRxAPaW/CE9GfFOVp2lfPM/Tkoq2
        IFFi+QfFQo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D4BD99BC8;
        Wed, 23 Dec 2020 16:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9109799BC7;
        Wed, 23 Dec 2020 16:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 8/8] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im> <cover.1608104755.git.ps@pks.im>
        <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
        <xmqqczz06x83.fsf@gitster.c.googlers.com>
Date:   Wed, 23 Dec 2020 13:55:08 -0800
In-Reply-To: <xmqqczz06x83.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Dec 2020 13:14:52 -0800")
Message-ID: <xmqq1rfg6vcz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 868C5B50-4569-11EB-82EE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The same problem may exist in new paragraphs in git.txt that
> describes the "--config-env" stuff.

Here is what I tentatively queued on top of these 8 patches as a fixup.

Thanks.


 Documentation/git-config.txt |  8 ++++----
 Documentation/git.txt        | 29 +++++++++++++++--------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b71c1ac7b8..67eb40f506 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -348,10 +348,10 @@ GIT_CONFIG_VALUE_<n>::
 	pairs are processed. These environment variables will override values
 	in configuration files, but will be overridden by any explicit options
 	passed via `git -c`.
-
-	This is useful for cases where you want to spawn multiple git commands
-	with a common configuration but cannot depend on a configuration file,
-	for example when writing scripts.
++
+This is useful for cases where you want to spawn multiple git commands
+with a common configuration but cannot depend on a configuration file,
+for example when writing scripts.
 
 
 [[EXAMPLES]]
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 80fb8fab11..3b0f87a71b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -81,25 +81,26 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 --type=bool` will convert to `false`.
 
 --config-env=<name>=<envvar>::
-	Like `-c <name>=<var>` except the value is the name of an
+	Like `-c <name>=<value>`, give configuration variable
+	'<name>' a value, where <envvar> is the name of an
 	environment variable from which to retrieve the value. Unlike
 	`-c` there is no shortcut for directly setting the value to an
 	empty string, instead the environment variable itself must be
-	set to the empty strin. Errors if the `<envvar>` does not exist
+	set to the empty string.  It is an error if the `<envvar>` does not exist
 	in the environment. `<envvar>` may not contain an equals sign
 	to avoid ambiguity with `<name>`s which contain one.
-
-	This is useful for cases where you want to pass transitory
-	configuration options to git, but are doing so on OS's where
-	other processes might be able to read your cmdline
-	(e.g. `/proc/self/cmdline`), but not your environ
-	(e.g. `/proc/self/environ`). That behavior is the default on
-	Linux, but may not be on your system.
-
-	Note that this might add security for variables such as
-	`http.extraHeader` where the sensitive information is part of
-	the value, but not e.g. `url.<base.insteadOf` where the
-	sensitive information can be part of the key.
++
+This is useful for cases where you want to pass transitory
+configuration options to git, but are doing so on OS's where
+other processes might be able to read your cmdline
+(e.g. `/proc/self/cmdline`), but not your environ
+(e.g. `/proc/self/environ`). That behavior is the default on
+Linux, but may not be on your system.
++
+Note that this might add security for variables such as
+`http.extraHeader` where the sensitive information is part of
+the value, but not e.g. `url.<base>.insteadOf` where the
+sensitive information can be part of the key.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
-- 
2.30.0-rc1-197-ga312a798fc

