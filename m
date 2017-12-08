Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A29120C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdLHRkO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:40:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752105AbdLHRkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:40:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D07ED1DFA;
        Fri,  8 Dec 2017 12:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GUgUInwpmjVqtUjr4OxiShw2Yis=; b=lwetjr
        VHQ/YvG+F+DWMNf86kVHMAZF4tApY2ea53DvTF00LvSE4EEyWTeifK5BWFJrC9wq
        Ds5qHZk/J1Nq139Pqtax9F+XXTZ4f5Pr9EDdEjjZLlPWeQFFToctUB1y4Mh8Y0FY
        guNxA87eziHZPP7kHq3Ymm9jmbSrkAmnTSUbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aOokiHuHuGlT6lmtv1m4eS9nfd1xzRmk
        YNsXah965gMdhJErKGo2INJQtshT9owYO7flvZoFIWGAU2ewubeLATWu05u06uK9
        MljPzITSDdPwtIFuAdgMzFoODu8JCYt5ooYGcCnC/ihP/d0+dvfmLvB4na2Y9qnu
        oN3C7wTNUr4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 048ABD1DF9;
        Fri,  8 Dec 2017 12:40:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 506A0D1DF8;
        Fri,  8 Dec 2017 12:40:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
Date:   Fri, 08 Dec 2017 09:40:09 -0800
In-Reply-To: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 8 Dec 2017 13:21:56 +0000")
Message-ID: <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D68801A0-DC3E-11E7-B17E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> -extern void get_commit_format(const char *arg, struct rev_info *);
> -extern const char *format_subject(struct strbuf *sb, const char *msg,
> -				  const char *line_separator);
> -extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
> -extern int commit_format_is_empty(enum cmit_fmt);
>  extern const char *skip_blank_lines(const char *msg);
> -extern void format_commit_message(const struct commit *commit,
> -				  const char *format, struct strbuf *sb,
> -				  const struct pretty_print_context *context);
> -extern void pretty_print_commit(struct pretty_print_context *pp,
> -				const struct commit *commit,
> -				struct strbuf *sb);
> -extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
> -			   struct strbuf *sb);
> -void pp_user_info(struct pretty_print_context *pp,
> -		  const char *what, struct strbuf *sb,
> -		  const char *line, const char *encoding);
> -void pp_title_line(struct pretty_print_context *pp,
> -		   const char **msg_p,
> -		   struct strbuf *sb,
> -		   const char *encoding,
> -		   int need_8bit_cte);
> -void pp_remainder(struct pretty_print_context *pp,
> -		  const char **msg_p,
> -		  struct strbuf *sb,
> -		  int indent);
> ...
> +void userformat_find_requirements(const char *fmt, struct userformat_want *w);
> +void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
> +			struct strbuf *sb);
> +void pp_user_info(struct pretty_print_context *pp, const char *what,
> +			struct strbuf *sb, const char *line,
> +			const char *encoding);
> +void pp_title_line(struct pretty_print_context *pp, const char **msg_p,
> +			struct strbuf *sb, const char *encoding,
> +			int need_8bit_cte);
> +void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
> +			struct strbuf *sb, int indent);
> +
> +void format_commit_message(const struct commit *commit,
> +			const char *format, struct strbuf *sb,
> +			const struct pretty_print_context *context);
> +
> +void get_commit_format(const char *arg, struct rev_info *);
> +
> +void pretty_print_commit(struct pretty_print_context *pp,
> +			const struct commit *commit,
> +			struct strbuf *sb);
> +
> +const char *format_subject(struct strbuf *sb, const char *msg,
> +			const char *line_separator);
> +
> +int commit_format_is_empty(enum cmit_fmt);

I see you've "standardized" to drop "extern" from the declarations
in the header; I have an impression that our preference however is
to go in the other direction.

The choice of bits that are moved to the new header looks quite
sensible to me.

Thanks.
