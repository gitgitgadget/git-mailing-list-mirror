Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C0C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1C620684
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q6HNYOYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIBRWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:22:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64077 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIBRWF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 13:22:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B8337E1F9;
        Wed,  2 Sep 2020 13:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mJ7ooio4ykGErzZQrVBy5HCceus=; b=q6HNYO
        YiYbWLR4SFy7T6zi9dKabq1+QXfJPGtruLfcaReO5teCP2ko/aL7JljmxtyNPYLw
        Qi/PQqG78ltQLTXwG1IlmLZukcbjUjczcR5TpOFPiH3xALu8VhxjFtmetEInTqSE
        A9Wqv5Y7sOVNI9yoGaKCv3ofom7PQqE81emuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yZrx7QP/55GsaSwgYaPbCsF7iS9V7B5o
        XQXiDcoWv7bkqb94rn5nu/52i9YR+brkf1P5n6sKT9UhNi8gKk/luPLzkO9Rp0vK
        EM71WxF29bxjpkdNEvWgSRbJacjv4UYcLv+D5fQi7YgMVe08iDJGeaI3ZnJ7YPHY
        ImZEDXYzHM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B85F7E1F7;
        Wed,  2 Sep 2020 13:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15E5C7E1F6;
        Wed,  2 Sep 2020 13:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Makefile: add support for generating JSON compilation database
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
        <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 10:21:59 -0700
In-Reply-To: <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 01 Sep 2020 23:09:19 +0000")
Message-ID: <xmqq1rjkccw8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFF8DC54-ED40-11EA-A89A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/.gitignore b/.gitignore
> index ee509a2ad2..f4c51300e0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -197,6 +197,7 @@
>  /git.spec
>  *.exe
>  *.[aos]
> +*.o.json

Does this naming/suffix follow the common practice followed among
those projects that use the -MJ option?  Even though I may have
heard of it, I am not familiar with the use of the feature at all,
and to such a person, naming a file after what format it is written
in (i.e. 'json') feels a lot less useful than what it contains
(i.e. compilation database entries).  

It's like naming our source files with .txt suffix ;-)

> +# Define GENERATE_COMPILATION_DATABASE to generate JSON compilation database
> +# entries during compilation if your compiler supports it, using the `-MJ` flag.
> +# The JSON entries will be placed in the `compile_commands/` directory,
> +# and the JSON compilation database 'compile_commands.json' will be created 
> +# at the root of the repository. 

Likewise for the name of the directory and the resulting single
database file.  I just want to make sure that we are following the
common convention, so people familiar with the use of the feature
would feel at home, so a simple answer "yes" would suffice.

> +ifdef GENERATE_COMPILATION_DATABASE
> +compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
> +	-c -MJ /dev/null \
> +	-x c /dev/null -o /dev/null 2>&1; \
> +	echo $$?)
> +ifeq ($(compdb_check),0)
> +override GENERATE_COMPILATION_DATABASE = yes

This feels strange.  If the end user said to GENERATE and we find we
are capable, we still override to 'yes'?  What if the end user set
'no' to the GENERATE_COMPILATION_DATABASE macro?  Shouldn't we be
honoring that wish?

> +else
> +override GENERATE_COMPILATION_DATABASE = no
> +$(warning GENERATE_COMPILATION_DATABASE is set, but your compiler does not \
> +support generating compilation database entries)

This side is perfectly understandable and I think it is a valid use
of override.  But I do not understand the other side.

> @@ -2381,16 +2401,30 @@ missing_dep_dirs =
>  dep_args =
>  endif
>  
> +compdb_dir = compile_commands/
> +
> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> +missing_compdb_dir = $(compdb_dir)
> +$(missing_compdb_dir):
> +	@mkdir -p $@
> +
> +compdb_file = $(compdb_dir)$(subst .-,,$(subst /,-,$(dir $@)))$(notdir $@).json

This detail does not matter as long as the end result ensures unique
output for all source files, but I am having trouble guessing what
the outermost subst, which removes ".-" sequence, is trying to make
prettier.  Care to explain?

> +compdb_args = -MJ $(compdb_file)
> +else
> +missing_compdb_dir =
> +compdb_args =

These are unfortunate.  I briefly wondered if we can make GIT-CFLAGS
depend on these two variables so that ASM_OBJ and C_OBJ do not have
to depend on them, but the actual rules need to be updated anyway,
so it cannot be helped.

I do wonder if we can unify dep_args and compdb_args into a single
extra_args (and similarly dep_dirs and compdb_dir to extra_dirs) so
that future similar options can all piggyback on it, but this can do
for now.

> @@ -2413,6 +2447,14 @@ else
>  $(OBJECTS): $(LIB_H) $(GENERATED_H)
>  endif
>  
> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> +all:: compile_commands.json
> +compile_commands.json:
> +	@$(RM) $@
> +	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)*.o.json > $@+

OK.  The entire thing is concatenated and enclosed by a single pair
of '[' and ']'.

If we are planning to allow developers customize compdb_dir,
requiring trailing slash in the value of $(compdb_dir) is not very
friendly.


Thanks.
