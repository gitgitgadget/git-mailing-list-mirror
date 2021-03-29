Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E866C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EE86196E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC2WR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:17:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59601 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhC2WRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:17:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36336B8E63;
        Mon, 29 Mar 2021 18:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lv4PRZ4XGmTT
        lYcMFUFgL7NQ064=; b=nV476mZjj5uOiz3jOFFlRyrUCO0xTJEyhwWv/esD5uFE
        OlFk+srlgzAtv0eMl+9pMYox9ADrxTrYLOJ4yoIJB6B42Bh+Lmrn5ScmP75APPkF
        bSe1l3uHDVn5fsOBb6C/v6c2v5puhHEhJ+YGiQQfzzoDoyiJqBvl+ZpyCRbFpR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rT+9kF
        BOJTzoRESlItAvgGrry+5mva3N7qo1x50sswfn6qiLcZj+1c+Mrkhc9zp5y2RrSf
        faqcvIz/hIGMUF/V1phcexPQG335CEhCey1zgNHGSSIGip2HM4ZmURvFFFL9GCRZ
        IyqFgzAYSElFRK4n3DD8mGRphc2jXxWakmlKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D0B7B8E62;
        Mon, 29 Mar 2021 18:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9955B8E61;
        Mon, 29 Mar 2021 18:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] Makefile: symlink the same way under "symlinks" and
 "no hardlinks"
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-1.7-39926acb0d1-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:17:34 -0700
In-Reply-To: <patch-1.7-39926acb0d1-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:39 +0200")
Message-ID: <xmqq1rbxiozl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 908ABFFC-90DC-11EB-B25B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In particular INSTALL_SYMLINKS=3DY will result in a link tree like:
>
>     bin/git
>     libexec/git -> ../bin/git
>     libexec/git-add -> ../bin/git
>
> Whereas NO_INSTALL_HARDLINKS=3DY in cases where the "ln" would fail wou=
ld result in:
>
>     bin/git
>     libexec/git
>     libexec/git-add -> git
>
> I.e. we duplicated the "git" between the bin/ and libexec/
> directories (by default they're hardlinked), and potentially had had
> e.g. "git-add" pointing at the libexec/git hardlink (or more likely if
> "ln" is failing, a copy), instead of the bin/git.
>
> Now we'll instead use the same symlinks to point to the bindir. I
> don't see any reason not to do so, and no breakage related to this has
> been reported with INSTALL_SYMLINKS in all this time. I just did it
> this way to maintain bug-for-bug compatibility at the time.

Makes sense.  I do not see a reason why libexec/git-add that points
at ../bin/git would cause problems, either.

> +# Define NO_INSTALL_HARDLINKS if you'd like to have programs in bin/
> +# and libexec/ either symlinked (we try with INSTALL_SYMLINKS first),
> +# or if that fails fall back on a "cp" instead of a "ln". Useful for
> +# when you don't want hardlinks at all.

So without INSTALL_SYMLINKS and with NO_INSTALL_HARDLINKS, the only
remaining choice is "cp".  With both set, we favour "ln -s" over
"cp" and do not allow "ln".  With INSTALL_SYMLINKS and without
NO_INSTALL_HARDLINKS, we try "ln -s", "ln" and finally "cp".  With
neither, we try "ln" and fall back to "cp"?

That precedence order does make sense.

> @@ -3019,33 +3020,30 @@ endif
>  	} && \
>  	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
>  		$(RM) "$$bindir/$$p" && \
> -		test -n "$(INSTALL_SYMLINKS)" && \
> +		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \

I had an impression that we avoid -o/-a used with "test" (instead
we'd use "test && test" or "test || test")?

In either case, if we are told to favor "ln -s", or told not to use
"ln", we try "ln -s"?  That does not make much sense to me, though.

What do I need to do if I do not ever want symbolic links?  Is it
impossible now?

>  		ln -s "git$X" "$$bindir/$$p" || \
>  		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>  		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> -		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
>  		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
>  	done && \
>  	for p in $(BUILT_INS); do \
>  		$(RM) "$$execdir/$$p" && \
>  		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
>  		then \
> -			test -n "$(INSTALL_SYMLINKS)" && \
> +			test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \

Perhaps the same comment applies here and to the next hunk, too?

>  			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$ex=
ecdir/$$p" || \
>  			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>  			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
> -			  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
>  			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
>  		fi \
>  	done && \
>  	remote_curl_aliases=3D"$(REMOTE_CURL_ALIASES)" && \
>  	for p in $$remote_curl_aliases; do \
>  		$(RM) "$$execdir/$$p" && \
> -		test -n "$(INSTALL_SYMLINKS)" && \
> +		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
>  		ln -s "git-remote-http$X" "$$execdir/$$p" || \
>  		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>  		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
> -		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
>  		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
>  	done && \
>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
