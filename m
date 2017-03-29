Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0014E20958
	for <e@80x24.org>; Wed, 29 Mar 2017 17:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbdC2RjN (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:39:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59101 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752454AbdC2RjM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:39:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFBAA85CFE;
        Wed, 29 Mar 2017 13:39:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Cm1n2f0DVM/FJB0U+sklv76W1o=; b=tHxUxT
        9uAb6YmjCl/av/Nn1LRjc8sS90ndY9QL305TL7NTGQWxCbYsI4dnQGAyh+H+1MXE
        TSKg80c3J/UfB+u8HPlAcb9dsEMyu8ZNQmftBH+gpAAerMnGjJMrepK1zoyY53ri
        ybNDcITsgN2obtceANJHw5cN1dDKlKUSvdyA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Df+uzWHi6tbuJgCDsGQs4B+Z0mBZNaB/
        MpL6JfmYfsyAEys1q9T8ZKPhyXTCQkOqAUf1+JTmjMMW3RgiID159XNPh/vCdomP
        47XtWKPC5VViTvZT0VTXgI4eDbT3OE3e4A9I6BmbrDW4EkL739DDGuZLvMdXYSnL
        BJbxf4O93v8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7D9785CFD;
        Wed, 29 Mar 2017 13:39:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A2D185CFB;
        Wed, 29 Mar 2017 13:39:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Tham <pickfire@riseup.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add build-in pattern for shell
References: <20170329165331.17742-1-pickfire@riseup.net>
Date:   Wed, 29 Mar 2017 10:39:08 -0700
In-Reply-To: <20170329165331.17742-1-pickfire@riseup.net> (Ivan Tham's message
        of "Thu, 30 Mar 2017 00:53:31 +0800")
Message-ID: <xmqqzig49e4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DC08FBE-14A6-11E7-A627-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Tham <pickfire@riseup.net> writes:

> Shell are widely used but comes with lots of different patterns. The
> build-in pattern aim for POSIX-compatible shells with some additions:
>
> - Notably ${g//re/s} and ${g#cut}
> - "function" from bash
>
> Signed-off-by: Ivan Tham <pickfire@riseup.net>
> ---
>  Documentation/gitattributes.txt |  2 ++
>  t/t4034-diff-words.sh           |  1 +
>  t/t4034/sh/expect               | 14 ++++++++++++++
>  t/t4034/sh/post                 |  7 +++++++
>  t/t4034/sh/pre                  |  7 +++++++
>  userdiff.c                      |  5 +++++
>  6 files changed, 36 insertions(+)
>  create mode 100644 t/t4034/sh/expect
>  create mode 100644 t/t4034/sh/post
>  create mode 100644 t/t4034/sh/pre
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index a53d093ca..1bad72df2 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -706,6 +706,8 @@ patterns are available:
>  
>  - `ruby` suitable for source code in the Ruby language.
>  
> +- `sh` suitable for source code in POSIX-compatible shells.

The new test you added seems to show that this is not limited to
POSIX shells but also understands bashisms like ${x//x/x}.  Perhaps
drop "POSIX-compatible" from here.

> diff --git a/userdiff.c b/userdiff.c
> index 8b732e40b..8d5127fb6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -148,6 +148,11 @@ PATTERNS("csharp",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> +PATTERNS("sh",
> +	 "^[ \t]*(function )?[A-Za-z_][A-Za-z_0-9]*[ \t]*()[\t]*\\{?$",

There is something funky going on around parentheses on this line.
The ones around "function " is meant to be syntactic metacharacters
to produce a group in the regexp so that you can apply '?'
(i.e. zero or one occurrence) to it.  But I think the second pair of
parentheses that appears later on the line, which enclose nothing,
are meant to be literal?  E.g. "hello (){\n\techo world;\n}\n"  They
would need some quoting, perhaps like

	...[ \t]*\\(\\)[\t]*....

> +	 /* -- */
> +	 "(\\$|--?)?([a-zA-Z_][a-zA-Z0-9._]*|[0-9]+|#)|--" /* command/param */

TBH, I have no idea what this line-noise is doing.

$foobar, $4, --foobar, foobar, 123 and -- can be seen easily out of
these patterns.  I am not sure what --# would be (perhaps you meant
to only catch $# and --# is included by accident, in which case it
is understandable).  It feels a bit strange to see that $# is
supported but not $?; --foo but not --foo=bar; foobar but not "foo
bar" inside a dq-pair.

> +	 "|\\$[({]|[)}]|[-+*/=!]=?|[\\]&%#/|]{1,2}|[<>]{1,3}|[ \t]#.*"),

And this one is even more dense.
