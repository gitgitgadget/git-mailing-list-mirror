Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29978C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F180A2240E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aoUeCp+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKTDQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:16:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59370 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTDQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:16:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B4E99705A;
        Tue, 19 Nov 2019 22:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3xFT/GEiAKXRW4PRD/8cnuSgVw=; b=aoUeCp
        +XPKYQp5F+BYgUJL+tZAydijn8frkH+Q9glrnDedXzu7kk9waLN7cahMO0DvqTml
        L3H01JNlqZW3otBXgxvavUZ2lLzG8lCIC8kZrPBFL2CVGQioAmzMDbLjlbeKnHqb
        YlKzstOx8zdA0h3+INJ8RY5m0xY1X/eMJ46Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zh4rCCgrGgAK7rWNTgPDDEpE+0Im8YlA
        EK6S2j9Z5r3okOgSSiCA9Wq3bBtUtiHPwqWvd3yzE9OIJzMCKezRQZoMvm+ngAQl
        Qu9wQThVVOMHZO5U5+h/Gd/k9B86o5/Jmv3wJ3Ew4EKx80Qy97glhoDFqxpSrqB5
        CnQXfj9VjQ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34BE697059;
        Tue, 19 Nov 2019 22:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 094D297056;
        Tue, 19 Nov 2019 22:16:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 09/11] pretty: add struct cmt_fmt_map::default_date_mode_type
References: <cover.1574122784.git.liu.denton@gmail.com>
        <cover.1574211027.git.liu.denton@gmail.com>
        <ec05907b6202b07733c02ca4af55de2d01681b7e.1574211027.git.liu.denton@gmail.com>
Date:   Wed, 20 Nov 2019 12:15:58 +0900
In-Reply-To: <ec05907b6202b07733c02ca4af55de2d01681b7e.1574211027.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 19 Nov 2019 16:51:23 -0800")
Message-ID: <xmqqr223ck5t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1411996A-0B44-11EA-B458-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In a future commit, we plan on having a pretty format which will use a
> default date format unless otherwise overidden. Add support for this by
> adding a `default_date_mode_type` member in `struct cmt_fmt_map`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  pretty.c | 3 +++
>  1 file changed, 3 insertions(+)

Yup, that is what I meant.  expand_tabs_in_log and friends are
good examples of per-format tweak defined in this table, and the
default date mode is a good addition.

Thanks.

>
> diff --git a/pretty.c b/pretty.c
> index 61014cc25a..63fa600276 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -20,6 +20,7 @@ static struct cmt_fmt_map {
>  	int is_tformat;
>  	int expand_tabs_in_log;
>  	int is_alias;
> +	enum date_mode_type default_date_mode_type;
>  	const char *user_format;
>  } *commit_formats;
>  static size_t builtin_formats_len;
> @@ -181,6 +182,8 @@ void get_commit_format(const char *arg, struct rev_info *rev)
>  	rev->commit_format = commit_format->format;
>  	rev->use_terminator = commit_format->is_tformat;
>  	rev->expand_tabs_in_log_default = commit_format->expand_tabs_in_log;
> +	if (!rev->date_mode_explicit && commit_format->default_date_mode_type)
> +		rev->date_mode.type = commit_format->default_date_mode_type;
>  	if (commit_format->format == CMIT_FMT_USERFORMAT) {
>  		save_user_format(rev, commit_format->user_format,
>  				 commit_format->is_tformat);
