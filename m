Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C240C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F2920829
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA8BWkKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKKTYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKKTYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:24:49 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5DC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:24:49 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so2118513qtb.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3/f2/BSbYBvtWCl/vFamYRSQuXSC4BIcg3v2QKa1u9s=;
        b=GA8BWkKsQ17/EKKQ6RseVCz0VZNxG6QVwALfhwwsBiC1EUJ3nEjbQLvsE05ebApHiJ
         SuOIBpC6nlLIY04lt9LZqQ6M11/b1HIGBuen51o1J67FiGSVgqgYFfXM1EdzUhTtrZzo
         CZsiIh4Khj2Dc1xQYoeIZuwDlMP9F+ojqNr7bO+lw6kTLh5hquzyDPUmQK++1C6ZoBF7
         RctSM8FQm7t7jrRd7aCv40h0gxE4qt0BSiZT8sEqmLZdRjMJgZzfBgZeaFJYvK7olZdQ
         F2iEnt0T1A/HVCdMmVY5IiLYWW+KtxCdpOuLWtFv9PnlTiIiksH0WTM6udl6caqeH/n/
         mIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3/f2/BSbYBvtWCl/vFamYRSQuXSC4BIcg3v2QKa1u9s=;
        b=mTFAlrCSopNTgBShDr5XHffxFiL5UQ1eXWXKXpbUb25OmnOW7WBauHIi/HsLXMPztp
         qe1o/xPEA6LZOpO0Nw7ucicAU7/slSI8PrD1uZ0MpBfemz4ZI6HV/jA1GJhaC/9sU+nS
         xzDZQshi0un/47WbSe2hQ+7GcX33ktuJEKyRkc++RXgHH650+BpQPMf6HGkt05Sv+eoJ
         0eeATAW2Id7GIoVXfExC5kPd/EzRK3XQ8A67SSXD8ixrB8Fk/+GF3uTHB4PZq9kHN/aS
         smFZVK23yeqN+ZHXM6Wf11bVfLLfSktspCIsjq7H9s8ZQS1jCdHktaVuHxovDnU51jeh
         VPHQ==
X-Gm-Message-State: AOAM531mZYPLjq6jujcwjsH5lFOSB4z0Tlbn9CoRphle9DBhgHCE/nK5
        FR5ZmaIyAhwfI/nUvb0NxtI=
X-Google-Smtp-Source: ABdhPJy1RKtqFlJRk4EShS8xYTdvZNUjwyL6EBCZnJ8TJFYlobibc98lMv5hBRdpnaxGjQTAP1qrVw==
X-Received: by 2002:aed:237c:: with SMTP id i57mr24791251qtc.324.1605122688595;
        Wed, 11 Nov 2020 11:24:48 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i192sm3150318qke.73.2020.11.11.11.24.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2020 11:24:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
Date:   Wed, 11 Nov 2020 14:24:46 -0500
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48197610-9B5B-43A0-9748-AB71B061858A@gmail.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com> <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,


> Le 9 nov. 2020 =C3=A0 03:33, Peter Kaestle <peter.kaestle@nokia.com> a =
=C3=A9crit :
>=20
> --- snip ---
>=20
> +add_commit_push()
> +{
> +	dir=3D"$1"
> +	msg=3D"$2"
> +	shift 2
> +	git -C "$dir" add "$@" &&
> +	git -C "$dir" commit -a -m "$msg" &&
> +	git -C "$dir" push
> +}
> +
> +test_expect_failure 'fetching a superproject containing an =
uninitialized sub/sub project' '
> +	# does not depend on any previous test setups
> +
> +	for repo in outer middle inner
> +	do
> +		git init --bare $repo &&
> +		git clone $repo ${repo}_content &&
> +		echo $repo > ${repo}_content/file &&
> +		add_commit_push ${repo}_content "initial" file
> +	done &&
> +
> +	git clone outer A &&
> +	git -C A submodule add "$pwd/middle" &&
> +	git -C A/middle/ submodule add "$pwd/inner" &&
> +	add_commit_push A/middle/ "adding inner sub" .gitmodules inner =
&&
> +	add_commit_push A/ "adding middle sub" .gitmodules middle &&
> +
> +	git clone outer B &&
> +	git -C B/ submodule update --init middle &&
> +
> +	echo "change on inner repo of A" > A/middle/inner/file &&
> +	add_commit_push A/middle/inner "change on inner" file &&
> +	add_commit_push A/middle "change on inner" inner &&
> +	add_commit_push A "change on inner" middle &&

In addition to what Junio wrote, maybe your test could make better use =
of the=20
functions provided by the test harness library. Take a look at t/README =
[1] for a=20
partial list, and t/test-lib-functions.sh [2] for the full list. =
test_create_repo, in particular,
could be useful.

Cheers,

Philippe.


[1] https://github.com/git/git/blob/master/t/README#L743
[2] https://github.com/git/git/blob/master/t/test-lib-functions.sh

