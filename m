Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB36C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiG0XFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0XFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:05:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7A422DA
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:05:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so234732ejb.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=Ul4AfHAqFDGuakLw3wjnuii0xTcczS4ppqvJ+6JwU7Q=;
        b=nqhzSfT8G787tRk4MtiEXDcTEQz7NQ9Hc943ZIInEv67plKi54ygIo/AJx94F4f4yf
         vz3ZNUtT9eL5o0yDGZICy+6MieJV1acOLTJVV6hFcxDsBqUANmjOZ1SBzdyr2/S5U+M6
         QYvVgt1wNNCLIQbTNYNLY0lmVouwkpdU6O0qQy8hfI//G8ZwXYxp4cdnT9ae8vQ09Bw3
         yR9+4rW0cVe8bq5ok7tfK7+8rv+MujEb7frTwlstkT0fDr8+gX0RDxJ8T8HOjBhQqHkX
         1T+01viSj7zMnSc9QaKMHP/xxGdHyI8mzk0kAOSfgBAb8KMUzzjhQoTkHAxRhT/nkYeE
         zCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ul4AfHAqFDGuakLw3wjnuii0xTcczS4ppqvJ+6JwU7Q=;
        b=1fhOIAKEOzfFovH6oEMV0JKpNP3sqz4AESc4HimpChFqiSqcXv4btLEg6bS09LCV+f
         TUGOw0SONYGMrzCZ4JvTHXMtlvPljFufUgO3t2294D0Tcz3C8fJVNo2IBCbJwmYvs3lT
         kFP0bfnbVHExgbWZHqKB2VubTHGaacdR7hKqs03ct08pK6HZhgabD2bsQB3bRhxlvhBP
         LpjYnOFI/xwykhze9NXKRODkf/RtChWzEjY7EskeqdxXJPBhC+gE66U5ApdqhTqhXYhy
         FPMdhLIaZ20kRHvr+qC8zEyYeVqUt8qyL1nKaYVryWq53ydnJeCHn8BIAaTZdcDGSImb
         otvw==
X-Gm-Message-State: AJIora/HgiBOCAA3sojvX6j92COhZDgQM/C8KRa/WNxIGhm4rDkViPfm
        8sII1wL0j4ys5+RzGnzBOZ+piYxrpGk=
X-Google-Smtp-Source: AGRyM1tgBqcEVFG7U/SUb9r1QwNJaJ4SMbeFgY9IcP1tfEK19s2f1/ejUWW4kbK7l8GiOaihYQCQBQ==
X-Received: by 2002:a17:906:9bd1:b0:72b:302:2b88 with SMTP id de17-20020a1709069bd100b0072b03022b88mr18909351ejc.250.1658963147147;
        Wed, 27 Jul 2022 16:05:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906538400b0072ae174cdd4sm8169600ejo.111.2022.07.27.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:05:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGq65-006tnC-36;
        Thu, 28 Jul 2022 01:05:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] remote-curl: add 'get' capability
Date:   Thu, 28 Jul 2022 01:00:44 +0200
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
Message-ID: <220728.86a68ukvg6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]

Add a:

	TEST_PASSES_SANITIZE_LEAK=true

Before:

> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'get by URL: 404' '
> +	url="$HTTPD_URL/none.txt" &&
> +	cat >input <<-EOF &&
> +	capabilities
> +	get $url file1
> +	EOF
> +
> +	test_must_fail git remote-http $url <input 2>err &&
> +	test_path_is_missing file1 &&
> +	grep "failed to download file at URL" err &&
> +	rm file1.temp

This should presumably be a :

	test_when_finished "rm file.temp"

Before the "test_must_fail", otherwise we'll leave this around if
e.g. the "grep" in the &&-chain fails, but we surely want to clean this
up in that case..

> +'
> +
> +test_expect_success 'get by URL: 200' '
> +	echo data >"$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" &&
> +
> +	url="$HTTPD_URL/exists.txt" &&
> +	cat >input <<-EOF &&
> +	capabilities
> +	get $url file2
> +
> +	EOF
> +
> +	GIT_TRACE2_PERF=1 git remote-http $url <input &&

Is this ad-hoc debugging that snuck into the test? Nothing here needs
this GIT_TRACE2_PERF...
