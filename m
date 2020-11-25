Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC6C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE2A206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UFFjc1AN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgKYXAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:00:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52101 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgKYXAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:00:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7728FFCF7F;
        Wed, 25 Nov 2020 18:00:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+0zzmKcIXu9P5JzWuVRNBqz8TQw=; b=UFFjc1
        AN2e5qoVDFcc5q9IobLPWNLzyE39QXh5IdwqB2lB6BxNfsHGS5tech+zJX3fbph8
        uZYM22bqt9mBSGvyttSQ14YMN6ary3QPknvH0p8qrcB0LonDxJMCcEbRx5jQgAXk
        1OVOG4GcUbr9AwG5N5nsoVmCbrMOH36vfSAD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cjo4els9LcQpJ1lgVAneDJLrC7Ighm8w
        bZ0aJw+ec3k572Wk2Jx9anncg0d5j2ghSTTZW442RAxpHe3k1t7Qp49x8ek+/NU2
        RtDUy4HhqTf4umSLk19d7mueWwlIgbjYmxY8VXQYP7ARr5ZqRrUoPblTMNKQb+rk
        eJTghZSkuC4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F1ADFCF7E;
        Wed, 25 Nov 2020 18:00:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B021FCF78;
        Wed, 25 Nov 2020 18:00:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/8] config: add --fixed-value option
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 15:00:39 -0800
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 25 Nov 2020 22:12:48
        +0000")
Message-ID: <xmqq7dq9ca94.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AA8A5FA-2F72-11EB-B023-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As reported [1], 'git maintenance unregister' fails when a repository is
> located in a directory with regex glob characters.
>
> [1] 
> https://lore.kernel.org/git/2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com/T/#mb96fa4187a0d6aeda097cd95804a8aafc0273022
>
> The discussed solution was to modify 'git config' to specify that the
> 'value_regex' argument should be treated as an exact string match. This is
> the primary change in this series, with an additional patch at the end to
> make 'git maintenance [un]register' use this option, when necessary.
>
> While we're here, let's rename 'value_regex' to 'value_pattern' to make
> things a bit clearer.
>
> Updates in V3
> =============
>
>  * Renamed 'value_regex' to 'value_pattern' in code and 'value-pattern' in
>    docs (except po/)
>    
>    
>  * Reordered commits slightly to help with that rename.
>    
>    
>  * Updated tests to use 'test_when_finished rm -f ...'
>    
>    
>  * Changed all references to "glob" characters to "meta" characters.
>    
>    
>  * Several other test modifications. Thanks, Emily, for the review!
>    
>    
>
> Thanks, -Stolee
>
> P.S. Happy Thanksgiving to those celebrating!

Thanks.  The only thing that still stand out, after the first 7
patches (queued as its own "add --fixed-value option to config"
topic) are queued, is that the early part of the documentation,
namely, a paragraph where it mentions value-pattern, still lives
in the world where it can only be a regexp.

Perhaps insert the following between step 7 and 8?

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
Subject: config doc: value-pattern is not necessarily a regexp

The introductory part of the "git config --help" mentions the
optional value-pattern argument, but give no hint that it can be
something other than a regular expression (worse, it just says
"POSIX regexp", which usually means BRE but the regexp the command
takes is ERE).  Also, it needs to be documented that the '!' prefix
to negate the match, which is only mentioned in this part of the
document, works only with regexp and not with the --fixed-value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
index 09a1d273a9..0e9351d3cb 100644
--- c/Documentation/git-config.txt
+++ w/Documentation/git-config.txt
@@ -33,10 +33,13 @@ escaped.
 
 Multiple lines can be added to an option by using the `--add` option.
 If you want to update or unset an option which can occur on multiple
-lines, a POSIX regexp `value-pattern` needs to be given.  Only the
-existing values that match the regexp are updated or unset.  If
-you want to handle the lines that do *not* match the regex, just
-prepend a single exclamation mark in front (see also <<EXAMPLES>>).
+lines, a `value-pattern` (which is an extended regular expression,
+unless the `--fixed-value` option is given) needs to be given.  Only the
+existing values that match the pattern are updated or unset.  If
+you want to handle the lines that do *not* match the pattern, just
+prepend a single exclamation mark in front (see also <<EXAMPLES>>),
+but note that this only works when the `--fixed-value` option is not
+in use.
 
 The `--type=<type>` option instructs 'git config' to ensure that incoming and
 outgoing values are canonicalize-able under the given <type>.  If no
