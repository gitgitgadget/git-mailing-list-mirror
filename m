Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D84280CD5
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285699; cv=none; b=ZqyXluA9TTgrFFmuHmvwUVouJCblP9krskbVGyIJwLXowAzKo0LheUfsxELqK+zLnf9UsBHIXMG5FG+lGSGwRf3Hj1wFwuTSt7eaZShQz2kwwhXvm4b3wn2hR9oau5u6Sd0T5IVDJfj4IRyTEPeEXnxK83Q6yo3iQAxw7vN9mO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285699; c=relaxed/simple;
	bh=x5hZlMTKAA85q/Vir9zg+7WTQZznWUfHAgnRcf/rMA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pkm4cBKWRtOFkd9euuwOVixkjzHEHxH8c0jdHajKx/0sZt//eQK3MabDDqGm5FCJqfTzlyXR/0TP3MYtGWbyQiycCbnjY1ZsfS6J5mllqaTz8GUss7lNik0eSHf92MYrarMfiESn2y85iTpPHWHu+W9IqyYQD/wV/MlQsWHIE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vTwcYWQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0e+LnYu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vTwcYWQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0e+LnYu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56BDB140015A;
	Tue, 28 Jul 2026 20:41:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 20:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785285696; x=1785372096; bh=U+D+t0amYh
	1Rf40wom2LQB2gQBif/uw9b6lHSOUs+BI=; b=vTwcYWQ1m/c3DS3jJxvGtnuFKy
	A+/ED8TmymVjdmXqJ0GNvMmDdbeSVU6LJTa/BBOdFu7pQo2Pgk28j9tf2ddMSv6Q
	VHvFze/yBdQHBKYw190Re1AW/R36t3UG2HrlNJdW1kw8ep+jQce7+EqYy/NrnCEt
	A2KdnV12Sapw1Ss2+1DqR4f9968Mhhdw8eTdHU2lZUusbvCaLm+NCD9QswaxA4FR
	nd2p5zBHH5yAUH8X5wb+c85aZRO4gTxuPmII7mbz6fBit+bnaUfRwzixTcnCqDXQ
	m+vg+fxdRU4FY60MG0jQgM7PgW1yyxop2NoHvhUETnzID0DaFNQuQwuh5T3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785285696; x=1785372096; bh=U+D+t0amYh1Rf40wom2LQB2gQBif/uw9b6l
	HSOUs+BI=; b=c0e+LnYusRfmjG//p+VqKseVRrSjqqepn2k1D8nSURN5NAgWEQe
	hv29zfkAVBD9bn84ubMLk55YHiPR6HSsPrC0rC9l1ex86YNscCQEVL0M6HW/amki
	kpy/19LY/pPus3QUwvg1EsOpZ1Cua5S3JBxTn7/khUz5jNIU1zZqGAHMfIMHnV7t
	jjier/Qvhj3aIfSCeRsxkTshWpnoCBdGsXyl3AuBNIXK23FOYtPyam3Ixa73uIYT
	/kVXaH3h6LpPbRACDej+6T5pKx8nThdOdjsflPVWSUyS2bGYeju3LiOhkG5R0X5B
	a9RbSRvBJ0WjeKYZNoC4xpvlKT+wXK+Wfew==
X-ME-Sender: <xms:QExpaqS5gpvodLNFApoJyNPOTgR-X9ltdOeNMQ2bWSg_hxfILBX9Ow>
    <xme:QExpanNadLYrx_QeCUUhVqL-o1W9ZoO6UeOvSRQ4Wcis8brsW7ZPTw18hEWEztgDB
    S7WdvkGiw0s9XHnQX9Rqj41UyxbC5wWxcRTQyjV5Qwc4JafmWO7voI>
X-ME-Received: <xmr:QExpalPdT4nyV2duP6RR5lFWUdHIk_lp3HGY17Gmi8IXTo7WrSxeMtJCnOwDLaJ2D18VLstK7quNnF16mKm09v7tuM5y_xZ2ng>
X-ME-Proxy-Cause: dmFkZTEgfOEhMb2WfZUu1DGtwAvqo0S6ZDbmkMQSeN89nGzRRbjh9RsD3338UknXO+DbPm
    1LYaWOBBBRkMcW8N5KYGt/OhRUu/nWiQS29+eNaCkSRDWR10z4uDOkWLYO1VtyKPb+5g4d
    fzd6KTZPyPa68kamqNHfjQHKE7sl52Gux4kiov8OZ0skLoKv/eYjW/XMNBSr+8ONMqEJee
    3dThVUV/gPaoyLk3BQOPmAkBg46HH/skThcqf48fijKlLvnC0WnuRqodbpihkLc57g2a1f
    1Z8BHlI7bMhxeK0/GuEGLgwWjPHP9aW+s5D1IIxJc2NT3OJLaoaqnTzcU8fH8+Ol3YkjWs
    96aDjPDWqccu1TG9FRxN90hls0KM5ax0OviVluNElmrQZu29161NWf5Rad8IHt/xNtAJtX
    3gqnsmF+pbg4Kxcxg/hO+9+gc/z7BcQBVIhZr5KkcIjDzZ0vqccdzLtnyCfZ/t2EhAYAZy
    6kbRA3YnpcNv23LtyhVjGwcuOnBTdQ01dGTKDuQyqqusP686xDionFhXtTYYRhdAxGxRzP
    JiP2FPeiPFAbvGUtWvPek39Vopy6ETaJiIRNlxUNPSGufy1EWGoo2PKcy4oaNGokO6K6CC
    ShSGhS/Cv/onPIEXDUteJY+93bVJYxuxwOpN+78ZFE9G49Y0+vwiPTJJdt+w
X-ME-Proxy: <xmx:QExpavtRKCNgDwDdsTFJ6d-PQX1mOnvb97AmEozJw2lKekqHdgwfpQ>
    <xmx:QExpanXll9kYLdQdgsJIM4uyEyIy8pt8Pc4YF-PanNVu9MruN5IpWg>
    <xmx:QExpavtRQSZrp-oOfcf4EWy46lIGQvsqID8LZPmD64WFHUyaOav1YQ>
    <xmx:QExparVzrqQb6yxzu0OLrh0C_11tAijORF0F5IVs2zF6YdYaQL6zGA>
    <xmx:QExpagI9WWh1yt-LOBADw_cXFWRRBIY_ZWcwEM4r9ZRzcURYaOv5ab_R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 20:41:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chungmin Lee <chungmin@chungminlee.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] regexec: work around macOS TRE leak on invalid UTF-8
In-Reply-To: <20260728052538.12429-1-chungmin@chungminlee.com> (Chungmin Lee's
	message of "Mon, 27 Jul 2026 22:25:38 -0700")
References: <20260722053127.37244-1-chungmin@chungminlee.com>
	<20260728052538.12429-1-chungmin@chungminlee.com>
Date: Tue, 28 Jul 2026 17:41:34 -0700
Message-ID: <xmqqse52bpa9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chungmin Lee <chungmin@chungminlee.com> writes:

> diff --git a/Makefile b/Makefile
> index 1cec251..81075c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2264,6 +2264,10 @@ ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
>  	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
>  	COMPAT_OBJS += compat/regcomp_enhanced.o
>  endif
> +ifdef DARWIN_REGEXEC
> +	COMPAT_OBJS += compat/darwin/regexec.o
> +	BASIC_CFLAGS += -DDARWIN_REGEXEC
> +endif
>  endif
>  ifdef NATIVE_CRLF
>  	BASIC_CFLAGS += -DNATIVE_CRLF
> diff --git a/compat/darwin.h b/compat/darwin.h
> new file mode 100644
> index 0000000..6fbdc34
> --- /dev/null
> +++ b/compat/darwin.h
> @@ -0,0 +1,8 @@
> +#ifndef COMPAT_DARWIN_H
> +#define COMPAT_DARWIN_H
> +
> +int darwin_regexec_buf(const regex_t *preg, const char *buf, size_t size,
> +		       size_t nmatch, regmatch_t pmatch[], int eflags);
> +#define regexec_buf darwin_regexec_buf
> +
> +#endif


This iteration looks much easier to grok, at least to me.  Two
things:

 * The name of the header, <compat/darwin.h>, sounds so nice and
   central, that those who care a lot more about macOS than I do may
   want to consolidate other support for the peculiarities macOS has
   also into it.  I personally do not have a strong opinion.

 * We'd need a comment near the beginning of Makefile, like other
   symbolis like NO_FINK and NO_APPLE_COMMMON_CRYPTO do, to tell the
   users when to define this new symbol.

The latter I would feel strong enough, so here is a sample update in
a squashable form.  If you have reasons to send a new iteration, you
are free to include it.  After waiting for comments from others for
a few days, if you still don't have reasons to send an update, you
can just tell me to squash the change on my end (if you agree with
the change, that is).



diff --git c/Makefile w/Makefile
index 81075c38a2..ed2868ce10 100644
--- c/Makefile
+++ w/Makefile
@@ -110,6 +110,9 @@ include shared.mak
 # Define USE_HOMEBREW_LIBICONV to link against libiconv installed by
 # Homebrew, if present.
 #
+# Define DARWIN_REGEXEC if regexec() in your platform regex library
+# leaks when fed an invalid UTF-8 sequence.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.


