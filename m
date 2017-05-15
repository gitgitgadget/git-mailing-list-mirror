Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5017B201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbdEOSmO (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:42:14 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36012 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbdEOSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:42:13 -0400
Received: by mail-pg0-f53.google.com with SMTP id x64so44759093pgd.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OlYm+m50f3tqdntD28UT7HA8BoqoyIi2miswhwtklz8=;
        b=NAoe01XkQQ7FBumeyTiqHNN1HYby/xzWLcoG9sTIawF+wI1XTVCreJ6SKOu/hzDTOP
         HwiLShPGe73zJK11DAi2e6jDAABHtyjJhPB9h/OyzlpIOxN/d+JtFNvhI9rZ5oktQMGX
         Vy/d2skXM8hT9MadD6hfHfbWq048KEel+/p7utBIJ/iBpRevZgTMfu/mD8td0sC5MTWf
         pfMrhi3yKRWzeTgYBPGuVaNZRSGqlkDPUnJWHXX8BNYdZv3lQeiDuOI/VK71NAluMhbU
         Lfm5t18gK/mWf94FYiEzTz+tb4+CzK5blEG+wbIc41bH0A4gTrj3V8UJoq2EhccgfvUd
         AajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OlYm+m50f3tqdntD28UT7HA8BoqoyIi2miswhwtklz8=;
        b=YOKgNuN68maaeX0YBQfiTEl5SIpHesqBcchO56HrKLzyfBDnLXJL4QmrDpernJ2+ei
         42U3xC8WU612qGQCti0/8a1v07Mad37IXKe+z7/RaGU06+Ji9tv4Re52YEWzbuUBFwmk
         sq8hP4mcO7bM917brzq4e2ycxuWuXkrJ1nEm4bqNijACmGLVpWnA9I4UabahljWfa58i
         O4Oc0+sA28So3FwqYNAZ92yu/B609zlbVClQRmVSJ3IA5rTHqCefoZZ8kY69153wotiC
         5dvbjJuJRQ6NVVp4iAPaW6/t3hl7lLqjPruzB0g/ZalP3gNE181iqIGHHhyZPRPbWJdg
         /IAg==
X-Gm-Message-State: AODbwcCwdnU7POCKDhHaWyRJ3NXFD7G/TIY7UC3JpjZjpyXQC9fbOyrZ
        3hJD5Ze0rd0DnT/y
X-Received: by 10.84.245.8 with SMTP id i8mr10387560pll.109.1494873732780;
        Mon, 15 May 2017 11:42:12 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id a3sm14853860pfc.26.2017.05.15.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 11:42:11 -0700 (PDT)
Subject: Re: [PATCH 08/19] diff.c: convert builtin_diff to use emit_line_*
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-9-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c88f7f39-b0c1-d437-3786-6c470bfe7d00@google.com>
Date:   Mon, 15 May 2017 11:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-9-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13/2017 09:01 PM, Stefan Beller wrote:
> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This covers builtin_diff.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 93343a9ccc..8e00010bf4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1293,8 +1293,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	o->found_changes = 1;
>
>  	if (ecbdata->header) {
> -		fprintf(o->file, "%s", ecbdata->header->buf);
> -		strbuf_reset(ecbdata->header);
> +		emit_line(o, NULL, NULL,
> +			  ecbdata->header->buf, ecbdata->header->len);
> +		strbuf_release(ecbdata->header);
>  		ecbdata->header = NULL;
>  	}
>
> @@ -2407,7 +2408,7 @@ static void builtin_diff(const char *name_a,
>  	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
> -	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
> +	strbuf_addf(&header, "%sdiff --git %s %s%s\n", meta, a_one, b_two, reset);
>  	if (lbl[0][0] == '/') {
>  		/* /dev/null */
>  		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
> @@ -2439,7 +2440,7 @@ static void builtin_diff(const char *name_a,
>  		if (complete_rewrite &&
>  		    (textconv_one || !diff_filespec_is_binary(one)) &&
>  		    (textconv_two || !diff_filespec_is_binary(two))) {
> -			fprintf(o->file, "%s", header.buf);
> +			emit_line(o, NULL, NULL, header.buf, header.len);
>  			strbuf_reset(&header);
>  			emit_rewrite_diff(name_a, name_b, one, two,
>  						textconv_one, textconv_two, o);
> @@ -2449,7 +2450,8 @@ static void builtin_diff(const char *name_a,
>  	}
>
>  	if (o->irreversible_delete && lbl[1][0] == '/') {
> -		fprintf(o->file, "%s", header.buf);
> +		if (header.len)
> +			emit_line(o, NULL, NULL, header.buf, header.len);

This used to unconditionally output diff_line_prefix(0), but now outputs 
it only if the non-prefix part is blank. Is that expected? (Same 
comments below.)

>  		strbuf_reset(&header);
>  		goto free_ab_and_return;
>  	} else if (!DIFF_OPT_TST(o, TEXT) &&
> @@ -2459,13 +2461,16 @@ static void builtin_diff(const char *name_a,
>  		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
>  		    !DIFF_OPT_TST(o, BINARY)) {
>  			if (!oidcmp(&one->oid, &two->oid)) {
> -				if (must_show_header)
> -					fprintf(o->file, "%s", header.buf);
> +				if (must_show_header && header.len)
> +					emit_line(o, NULL, NULL,
> +						  header.buf, header.len);
>  				goto free_ab_and_return;
>  			}
> -			fprintf(o->file, "%s", header.buf);
> -			fprintf(o->file, "%sBinary files %s and %s differ\n",
> -				line_prefix, lbl[0], lbl[1]);
> +			if (header.len)
> +				emit_line(o, NULL, NULL,
> +					  header.buf, header.len);
> +			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
> +				      lbl[0], lbl[1]);
>  			goto free_ab_and_return;
>  		}
>  		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
> @@ -2473,17 +2478,21 @@ static void builtin_diff(const char *name_a,
>  		/* Quite common confusing case */
>  		if (mf1.size == mf2.size &&
>  		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
> -			if (must_show_header)
> -				fprintf(o->file, "%s", header.buf);
> +			if (must_show_header && header.len)
> +				emit_line(o, NULL, NULL,
> +					  header.buf, header.len);
>  			goto free_ab_and_return;
>  		}
> -		fprintf(o->file, "%s", header.buf);
> +		if (header.len)
> +			emit_line(o, NULL, NULL,
> +				  header.buf, header.len);
>  		strbuf_reset(&header);
>  		if (DIFF_OPT_TST(o, BINARY))
>  			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
>  		else
> -			fprintf(o->file, "%sBinary files %s and %s differ\n",
> -				line_prefix, lbl[0], lbl[1]);
> +			emit_line_fmt(o, NULL, NULL,
> +				      "Binary files %s and %s differ\n",
> +				      lbl[0], lbl[1]);
>  		o->found_changes = 1;
>  	} else {
>  		/* Crazy xdl interfaces.. */
> @@ -2494,8 +2503,8 @@ static void builtin_diff(const char *name_a,
>  		struct emit_callback ecbdata;
>  		const struct userdiff_funcname *pe;
>
> -		if (must_show_header) {
> -			fprintf(o->file, "%s", header.buf);
> +		if (must_show_header && header.len) {
> +			emit_line(o, NULL, NULL, header.buf, header.len);
>  			strbuf_reset(&header);
>  		}
>
>
