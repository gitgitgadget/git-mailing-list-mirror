Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD0F20401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdFUUNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:13:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36517 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdFUUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:13:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so32704938pfd.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tiOCVehPKinQ5u9tFIOFVSd4hGj2Eotl2sBFzePaARw=;
        b=rJwTC4PT6JNAdl4tE4gUpwcJLEGE0qBt61W59j3rVhn3frzIkeYRQyC27WgFTeVFje
         H2voHx67FLVJwqjgvnbh0VB4bMYLxFpsJ0zZXw/gPSCLaEwYepDkZ57W2PnhLaezAbLE
         TPynAlh3q1BLRzZGAdyFFvbpEpnUz2XpAqreKJFzlhStVOlnRf5f8VrErDG3e6EIBxFk
         MLYs9baRWOYF3ILidGF69Lo/qx41dIvjdfUvIeRh4pI2y2ndYQnUPozsz7RVyBhkHmmk
         aHYna3xiyCP0RxKQXH1/kg9c/6Z4xBJE/+zmZc091+LdqcC03sm9Lj3I4JugRGf/G7uN
         EXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tiOCVehPKinQ5u9tFIOFVSd4hGj2Eotl2sBFzePaARw=;
        b=YE4WKArNI5J+fgouSJIWWq778k/QrWvRZHWyenFEdawibyAI7C8C/KRUadu+Ul/col
         55EZnn8ToRDfG92fO+pYSbqmIDNeGR++zs0mp+BKo6cW/qY1OVKzBAhVWQyNzjVRd3Ge
         06W472XMLSlKiHufSKfjuZfFk5WDpCTOGQf0KienT9KE9z/2ERYB6G4EDAsBo7RA6otx
         D74zhT2WsbdeZroYjNfLPXEKXoEDhGMToZfwvePldfH/3rRiPd3fVCiaRrqQkBA11zB4
         JrPirwYLUETsR9WzDXZ2QRGlv3JxKnly8VAjxkBGi8LvivqDPpAGCz1PbLv48vCRRGck
         8cMA==
X-Gm-Message-State: AKS2vOy68unSMNc/cbBk2wTnUcrqS7zY4fwKWyVDyddF4bXoC47pNqJF
        vPGNp9hedGzb6g==
X-Received: by 10.84.231.15 with SMTP id f15mr44577807plk.131.1498076028620;
        Wed, 21 Jun 2017 13:13:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id o6sm32171387pfb.110.2017.06.21.13.13.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:13:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 13/26] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-14-sbeller@google.com>
Date:   Wed, 21 Jun 2017 13:13:47 -0700
In-Reply-To: <20170620024816.20021-14-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Jun 2017 19:48:03 -0700")
Message-ID: <xmqqr2ydnlok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 95f11ea86f..e56962b844 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -572,6 +572,7 @@ enum diff_symbol {
>  	DIFF_SYMBOL_WORDS,
>  	DIFF_SYMBOL_FILEPAIR,
>  	DIFF_SYMBOL_HEADER,
> +	DIFF_SYMBOL_BINARY_FILES,
>  };
>  /*
>   * Flags for content lines:
> @@ -689,6 +690,10 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>  	case DIFF_SYMBOL_HEADER:
>  		fprintf(o->file, "%s", line);
>  		break;
> +	case DIFF_SYMBOL_BINARY_FILES:
> +		fprintf(o->file, "%sBinary files %s differ\n",
> +			diff_line_prefix(o), line);
> +		break;

It is curious why the "line" is defined to be "A and B" here.  It
could have been defined to be the whole string "Binary files A and B
differ" or even with the terminating LF.

And with that it may have been able to share concepts with the
"HEADER" we see above.  SYMBOL_HEADER becomes "oneline without
prefix", and this one (updated to make the caller prepare the whole
sentence) becomes "oneline with prefix".

> @@ -2549,8 +2555,10 @@ static void builtin_diff(const char *name_a,
>  			}
>  			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
>  					 header.buf, header.len, 0);
> -			fprintf(o->file, "%sBinary files %s and %s differ\n",
> -				line_prefix, lbl[0], lbl[1]);
> +			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
> +			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
> +					 sb.buf, sb.len, 0);
> +			strbuf_release(&sb);
>  			goto free_ab_and_return;
>  		}
>  		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
> @@ -2567,9 +2575,12 @@ static void builtin_diff(const char *name_a,
>  		strbuf_reset(&header);
>  		if (DIFF_OPT_TST(o, BINARY))
>  			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
> -		else
> -			fprintf(o->file, "%sBinary files %s and %s differ\n",
> -				line_prefix, lbl[0], lbl[1]);
> +		else {
> +			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
> +			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
> +					 sb.buf, sb.len, 0);
> +			strbuf_release(&sb);
> +		}
>  		o->found_changes = 1;
>  	} else {
>  		/* Crazy xdl interfaces.. */
