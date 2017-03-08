Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777B420135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdCHXXw (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:23:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751394AbdCHXXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:23:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0861709ED;
        Wed,  8 Mar 2017 18:08:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pcpW1iVhpSRPisZe1IwHBFNBCiw=; b=QWxk6d
        HwMKtnoVR/ftGIKvU+ZMvuKe8e+jY0wUg+DilQqnfnzM8uT/FHYbBGNCJSYnVljS
        FXZqiYOQBWSHQK6YTRQ4WSS3UdMeqMl6xLJMXQhq/ONv65BLISxwujVG07TdY0Ti
        qeV0/5Fm119f6Diss6pmEt1hR6KkNmvzqsBH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YFKGdbrlntXPzD3NSjZZ0ySltRs5d99X
        jjYbUvj8qI8L4rIojfU7MEQnV6w1QdprjAQbK/UUxytJ0QlpWoDZ6c+r68iYxwBu
        stan/DjeRrDYl5CiyBYYArsKoc0wCM0BXSQtkumSWa2A7dr5jFKWHRN1Uoz16sjT
        Lka4HFDzsZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98226709EC;
        Wed,  8 Mar 2017 18:08:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1DFC709EB;
        Wed,  8 Mar 2017 18:08:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: diff.ignoreSubmoudles config setting broken?
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
        <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
        <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
        <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net>
        <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
        <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com>
        <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZFGP0zMP5CtOH3poU9vx8FoT25UVr8ridQo0_VdH2cmA@mail.gmail.com>
Date:   Wed, 08 Mar 2017 15:08:12 -0800
In-Reply-To: <CAGZ79kZFGP0zMP5CtOH3poU9vx8FoT25UVr8ridQo0_VdH2cmA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Mar 2017 14:11:05 -0800")
Message-ID: <xmqqa88v1i5f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B59E2B2-0454-11E7-9F79-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yeah the .gitmodules file is a good hint.
>
> Here is my understanding of the precedence:
>
>   command line options > .git/config (in various forms) > .gitmodules
>
> where in the .git config we have precedence levels for different files
>
>   .git/config > ~/.gitconfig
>
> as well as different settings:
>
>   submodule.<name>.ignore > diff.ignoreSubmodules

I've never understood why people thought it a good idea to let
.gitmodules supplied by the upstream override the configuration
setting the end user has like this.  This is quite bad.

Perhaps this is a good starting point?

 diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a628ac3a95..75b7140c63 100644
--- a/diff.c
+++ b/diff.c
@@ -273,8 +273,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.orderfile"))
 		return git_config_pathname(&diff_order_file_cfg, var, value);
 
-	if (!strcmp(var, "diff.ignoresubmodules"))
+	if (!strcmp(var, "diff.ignoresubmodules")) {
 		handle_ignore_submodules_arg(&default_diff_options, value);
+		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
+		return 0;
+	}
 
 	if (!strcmp(var, "diff.submodule")) {
 		if (parse_submodule_params(&default_diff_options, value))
