Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29540202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 03:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdKNDIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:08:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56182 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751376AbdKNDIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:08:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 767B0ABF16;
        Mon, 13 Nov 2017 22:08:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jhZzEFZy3RhJuoTMgah5gtLTUqU=; b=AvkP4p
        Zjbf7GdqPvcQnIngVSlLSulXchn6roTCvaePwj3mj6wZ8iFfB4+Ozi55rJRd2Hne
        zLLiXxI2Mwr9M67g9pNprwyDyLNIca7G/waeb4Y915LQU9fBf+yAyw04XqFhnECz
        Gq7Ec3TGrc0OEg33YpqPsjbOPB/F+wxGxVYyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oVR6iRUMPP2s5iYH6DluMW+itdQ2Yasl
        ygs1djTDsdN1qxkyd0IoDq2sGANN/Rfc9Uu4eT9gW/6mQ+zDYFxrQrcPmr6XC9q6
        YWArYm/DM9VpSdqeLgjXcdUBT9kDC/R0cpsnQOXiOs542HTSsHqaxyQXeOhLJakP
        LKA0gv/ua2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA35ABF15;
        Mon, 13 Nov 2017 22:08:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF9F4ABF14;
        Mon, 13 Nov 2017 22:08:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 3/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
References: <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
Date:   Tue, 14 Nov 2017 12:08:13 +0900
In-Reply-To: <20171113223654.27732-3-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Mon, 13 Nov 2017 23:36:51 +0100")
Message-ID: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E33ACB2-C8E9-11E7-ADF3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> Neither Git nor the user are in need of this (visual) aid anymore, but
> we must offer a transition period.
>
> Also, fix a typo: "abbbreviated" ---> "abbreviated".
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
> v2: rename patch series & focus on removal of ellipses
>  diff.c | 69 +++++++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 0763e89263ef..9709dc37c6d7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4902,41 +4902,50 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
>  	int abblen;
>  	const char *abbrev;
>  
> +	/* Do we want all 40 hex characters?
> +	 */

The oldest parts of the codebase (including diff.c) deviate from the
rule in places, but in our multi-line comment, /* and */ occupy a
line on their own.  In this case, a single-line comment should be
sufficient, though.

>  	if (len == GIT_SHA1_HEXSZ)
>  		return oid_to_hex(oid);
>  
> -	abbrev = diff_abbrev_oid(oid, len);
> -	abblen = strlen(abbrev);
> -
> -	/*
> -	 * In well-behaved cases, where the abbbreviated result is the
> -	 * same as the requested length, append three dots after the
> -	 * abbreviation (hence the whole logic is limited to the case
> -	 * where abblen < 37); when the actual abbreviated result is a
> -	 * bit longer than the requested length, we reduce the number
> -	 * of dots so that they match the well-behaved ones.  However,
> -	 * if the actual abbreviation is longer than the requested
> -	 * length by more than three, we give up on aligning, and add
> -	 * three dots anyway, to indicate that the output is not the
> -	 * full object name.  Yes, this may be suboptimal, but this
> -	 * appears only in "diff --raw --abbrev" output and it is not
> -	 * worth the effort to change it now.  Note that this would
> -	 * likely to work fine when the automatic sizing of default
> -	 * abbreviation length is used--we would be fed -1 in "len" in
> -	 * that case, and will end up always appending three-dots, but
> -	 * the automatic sizing is supposed to give abblen that ensures
> -	 * uniqueness across all objects (statistically speaking).
> +	/* An abbreviated value is fine, possibly followed by an
> +	 * ellipsis.
>  	 */

Ditto.

> -	if (abblen < GIT_SHA1_HEXSZ - 3) {
> -		static char hex[GIT_MAX_HEXSZ + 1];
> -		if (len < abblen && abblen <= len + 2)
> -			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
> -		else
> -			xsnprintf(hex, sizeof(hex), "%s...", abbrev);
> -		return hex;
> -	}
> +	if (print_sha1_ellipsis) {
> +		abbrev = diff_abbrev_oid(oid, len);
> +		abblen = strlen(abbrev);
> +
> +		/*
> +		 * In well-behaved cases, where the abbreviated result is the
> +		 * same as the requested length, append three dots after the
> +		 * abbreviation (hence the whole logic is limited to the case
> +		 * where abblen < 37); when the actual abbreviated result is a
> +		 * bit longer than the requested length, we reduce the number
> +		 * of dots so that they match the well-behaved ones.  However,
> +		 * if the actual abbreviation is longer than the requested
> +		 * length by more than three, we give up on aligning, and add
> +		 * three dots anyway, to indicate that the output is not the
> +		 * full object name.  Yes, this may be suboptimal, but this
> +		 * appears only in "diff --raw --abbrev" output and it is not
> +		 * worth the effort to change it now.  Note that this would
> +		 * likely to work fine when the automatic sizing of default
> +		 * abbreviation length is used--we would be fed -1 in "len" in
> +		 * that case, and will end up always appending three-dots, but
> +		 * the automatic sizing is supposed to give abblen that ensures
> +		 * uniqueness across all objects (statistically speaking).
> +		 */
> +		if (abblen < GIT_SHA1_HEXSZ - 3) {
> +			static char hex[GIT_MAX_HEXSZ + 1];
> +			if (len < abblen && abblen <= len + 2)
> +				xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
> +			else
> +				xsnprintf(hex, sizeof(hex), "%s...", abbrev);
> +			return hex;
> +		}
>  
> -	return oid_to_hex(oid);
> +		return oid_to_hex(oid);
> +	} else {
> +		return diff_abbrev_oid(oid, len);
> +	}
>  }

If I were writing this, I would have called diff_abbrev_oid() before
checking print_sha1_ellipsis, returned it if it is not set.  That
way the indentation level of the code would not have to change.

HOWEVER.

Notice the name of the function.  We no longer even attempt to align
the output, and in general the output column length of each line
would be shorter than the original.  I am wondering if the change
would be of less impact if we try to abbreviate to len+3 and then
chomp the result at the right hand side to len+3 (only if the result
is unique) when print_sha1_ellipsis is false.  Of course, once we go
that path, the code structure this patch introduces (not the one I
mentioned in the previous paragraph) would be necessary.  Essentially
you would be enhancing the "else" clause.


>  
>  static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
