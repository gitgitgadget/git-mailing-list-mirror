Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D3420282
	for <e@80x24.org>; Tue, 20 Jun 2017 20:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdFTUBx (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 16:01:53 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36106 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdFTUBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 16:01:52 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so47858403pgb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+A/Xmq2odFO1Xj+I2sB3a6Re1usifIqc3bUbC+llcY=;
        b=QuN7q0xDVTAyPXbEYip8g+31sU9n6XXHf2HL/FzLCARil7l/yqiWtSplKvImjE4n4l
         0LTK+eDw16rk5wJ+xLiuF2Xv0dRWlpx43WQtg3Yumf5wNNoLRSfmyWNhYLX4OdqgmLEp
         mM1s7/HHJoy7eQT8F0vjbHP7RvWSnm1hZyMILEidMKeJdqhs24y6ZwGpRosUDsKOa/X6
         ahQoHmUKBs9U11BWFke1xDO/rb2YZtan+70/89l+NIRP9f1BAGlC+7WwwQRt8Pf98elC
         JSpG5w9VxVwUKQFoRFDE8bzT0HV85tasLo0Hzvt7NDTirrj/0/neOYNly8RHcR6waS+A
         /upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+A/Xmq2odFO1Xj+I2sB3a6Re1usifIqc3bUbC+llcY=;
        b=JeEjcHFCLo0h1w+NEL9WzI2J6Jnv44mWpjm8+su5hNLlPBagPEiWF0bFWqCC03dV7a
         swylG2bGCIWQFPeeae7UcOk4V6lEj1T9/yJKODixT6i/fcO23NFSaAxUQe+mSx8Saci1
         ZG9XqEvZfmNNDTKn/STOyM4hbqWp1x4Pr22V7ld3WWe+zVaFKdFqHsECF8Z878hWRLgy
         r4+ucPXqr+wtIadiInu66uIzU4V4JUyT+x7mLPvYVAbRUFd+aPDwGaevYkjybfynE56S
         hkwley+2nXTMD43PS8O2JKF3gb1alunUdFT7322o0J1l+mpkENrg3ZUk+XyJxLX/T7MK
         //mw==
X-Gm-Message-State: AKS2vOz1e3A25uj+EUO1etxDPcfPmjF7Ywui08y1GZIV7wh4KsEJ8TkF
        h1bvolxVvEu6PNxB
X-Received: by 10.99.178.20 with SMTP id x20mr1081106pge.220.1497988911680;
        Tue, 20 Jun 2017 13:01:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id i14sm28719682pgn.14.2017.06.20.13.01.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 13:01:51 -0700 (PDT)
Date:   Tue, 20 Jun 2017 13:01:47 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 11/26] diff.c: emit_diff_symbol learns
 DIFF_SYMBOL_FILEPAIR
Message-ID: <20170620130147.75e1fb78@twelve2.svl.corp.google.com>
In-Reply-To: <20170620024816.20021-12-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-12-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Jun 2017 19:48:01 -0700
Stefan Beller <sbeller@google.com> wrote:

> @@ -676,6 +677,14 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>  		}
>  		emit_line(o, context, reset, line, len);
>  		break;
> +	case DIFF_SYMBOL_FILEPAIR:
> +		meta = diff_get_color_opt(o, DIFF_METAINFO);
> +		reset = diff_get_color_opt(o, DIFF_RESET);
> +		fprintf(o->file, "%s%s%s%s%s%s\n", diff_line_prefix(o), meta,
> +			flags ? "+++ " : "--- ",

I think that a constant should be defined for this flag, just like for
content lines. If not it is not immediately obvious that a flag should
be set for the +++ lines.

> +			line, reset,
> +			strchr(line, ' ') ? "\t" : "");
> +		break;
>  	default:
>  		die("BUG: unknown diff symbol");
>  	}
