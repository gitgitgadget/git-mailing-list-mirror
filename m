Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72962192F4
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380600; cv=none; b=ipS2IPhkCfAIlGXhm3MPk2DSDNx10px6WzI8T+TTOIEATm2ZVwML7w6HioxjRUVroAtBGIadeUqt/OFRCbGv6Gxr28SdzQJ/VIS11CffFHeYFgGFLrI/zOHDQJGMRUcyFPG2crmpsiaN579t74FWqY99wK39rlPIWcKOpyfXH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380600; c=relaxed/simple;
	bh=UYvG8lX4yAdsYNq9VYLwa+EQSApDkGcWnX5+3trF2qg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oc9GPgoPQxUEw9ZBOc75Ft0BYz8sWIMnj39MnrPQ4afnhNjJ+ORqpK/M6RXzwintdJhK0KCgJIb2PgiW8ojSVkzSeYd20T8EllctX7rZplPlws++RmjZIAjV7LZpNb6rkRLQJEoqnVvrzzP/juduk/TRzdL4G2e/LQ9FYsY1W+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s45cl/Yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHiT2TXx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s45cl/Yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHiT2TXx"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5DC114000EA;
	Thu, 24 Jul 2025 14:09:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 14:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753380597; x=1753466997; bh=Qc+qsQGqyX
	FoXHo6Hab2xysa0MgtETfh+khX9EksmtU=; b=s45cl/YtxgTXx9Y7UFrBbLnnbP
	G3RypS2iWIIAb5MztF/Tg3+I2Gc5z+L2AOlBi0FRRckbGu9J9LXKMM9RWmvdNh22
	CaUb+Bdk5nV5JDbEI4wZLXOzgMQKKNXs8bLhhpkNv1Y0Hfmjmc+ZcTmZGJuk5jP8
	W0hbSeDyB+BdCcTM33n9MBEu72PqEsKY2J2MY9bm2+FV+L27X2WX+lnPKGjowvr6
	ZlGfmiOTmZuJvlUlrrAqfMZH0KWsIkRRaHx/A7M1jD1B0L+nuPzNY8jUd4y08djW
	c8laGtwlIJTK5LiS59n4lIMVfMGxkqSxWWblRVaPXBRyTbvTgMOIs+pYHj5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753380597; x=1753466997; bh=Qc+qsQGqyXFoXHo6Hab2xysa0MgtETfh+kh
	X9EksmtU=; b=iHiT2TXxMwFFNxvbeDXAgAaa5LO/Xu/lfWa1spJmw8NHRNM8bKU
	6G0YAKN8U1TpWRjtfBnedIsfLZ614U9YN1xTnBXKBMWyaZj06CbkvS1otb8iAo3t
	o6dr0Vi1B2UEz4QWzz/wuAk9zf9F6dl3siL7bKBS+OkcRz1NvUqyASdKB98Ll6fh
	fCaHJnc0xbRE1ltYD6tuiDZZOd+GGD6Lt1cuZPZGy+ZDGSx1jC7s74jIulDFBtHM
	YqJcRje9cZzKEM9LAOuY87blNOT4m5I+cO3i5ViiyjJhK5D5LCdZ30M4OxMlT2fo
	1ip1cbf7+HFAtZp6G6uSKNiPI0hsGJ/YlTA==
X-ME-Sender: <xms:9XaCaO3CcedCzEmonB07IfZkDwaI0tyt_Q3CLt4vnmZ6Ak_v5LecQg>
    <xme:9XaCaEX1ii0PfFSOM3zgUeMvn2qLj1YHnxOl6o8dwxRVZt7c7IuHZ2A_b0IphAXwo
    M8uiKmFcybrCkqBGg>
X-ME-Received: <xmr:9XaCaAXw7BZefBUMC37KHt_18TiSI-kGjrv2ibNt8MZp_KHukwYTCnIXNneIou_WU38VK-D5Snunmi90O13ePAVjaFza8O13NqqHNrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhhhiifkhgu
    vddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9XaCaLcrhKfD04UVZFXkT_3t5S4QZ5Br2w_9kaVdxL68TPqAIvHbVg>
    <xmx:9XaCaBWI0hu0uwrhO95KntQQsoboRUQx91EG5xddKDZp3tfzkgm4vg>
    <xmx:9XaCaMfYFRaM9I-9Z7hIWsFwvLh8o-2vNuWcpmyHw6xlYoh8UlLiRw>
    <xmx:9XaCaFPXstSrGAJiQv9a8QijyNooletZOf2zA9zPjwjEdHBZzoxwFQ>
    <xmx:9XaCaA_SJ9NLjBYYkr5rFaoiZZhUCsaJvg-cYgvVSiXAfdgp0h2owpyM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:09:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] test-delta: simplify delta helper with strbuf
 and better cleanup
In-Reply-To: <20250724093327.2261615-1-lhywkd22@gmail.com> (Hoyoung Lee's
	message of "Thu, 24 Jul 2025 09:33:27 +0000")
References: <20250724093327.2261615-1-lhywkd22@gmail.com>
Date: Thu, 24 Jul 2025 11:09:55 -0700
Message-ID: <xmqqjz3xh34c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hoyoung Lee <lhywkd22@gmail.com> writes:

> diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
> index f5811e96ad..1c4322b7c0 100644
> --- a/t/helper/test-delta.c
> +++ b/t/helper/test-delta.c
> @@ -11,76 +11,47 @@
>  #include "test-tool.h"
>  #include "git-compat-util.h"
>  #include "delta.h"
> +#include "strbuf.h"
>  
>  static const char usage_str[] =
>  	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
>  
>  int cmd__delta(int argc, const char **argv)
>  {
> -	int fd = -1;
> -	struct stat st;
> -	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
> -	unsigned long from_size, data_size, out_size;
> -	int ret = 1;
> +	int fd;
> +        struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
> +        char *out_buf;
> +        unsigned long out_size;

Mixed indentation.  Make sure you indent with tabs, with tab-width
set to 8.  Not limited to the above code block.

> -	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
> -		fprintf(stderr, "usage: %s\n", usage_str);
> -		return 1;
> -	}
> +	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
> +                usage(usage_str);

Nice.

> -	fd = open(argv[2], O_RDONLY);
> -	if (fd < 0 || fstat(fd, &st)) {
> -		perror(argv[2]);
> -		goto cleanup;
> -	}
> -	from_size = st.st_size;
> -	from_buf = xmalloc(from_size);
> -	if (read_in_full(fd, from_buf, from_size) < 0) {
> -		perror(argv[2]);
> -		goto cleanup;
> -	}
> -	close(fd);
> -
> -	fd = open(argv[3], O_RDONLY);
> -	if (fd < 0 || fstat(fd, &st)) {
> -		perror(argv[3]);
> -		goto cleanup;
> -	}
> -	data_size = st.st_size;
> -	data_buf = xmalloc(data_size);
> -	if (read_in_full(fd, data_buf, data_size) < 0) {
> -		perror(argv[3]);
> -		goto cleanup;
> -	}
> -	close(fd);
> +	if (strbuf_read_file(&from, argv[2], 0) < 0)
> +                die_errno("unable to read '%s'", argv[2]);
> +        if (strbuf_read_file(&data, argv[3], 0) < 0)
> +                die_errno("unable to read '%s'", argv[3]);

OK.  from_buf/from_size has become strbuf from; data_buf/data_size
has become strbuf data.  Very straight-forward and understandable.

>  	if (argv[1][1] == 'd')
> -		out_buf = diff_delta(from_buf, from_size,
> -				     data_buf, data_size,
> -				     &out_size, 0);
> -	else
> -		out_buf = patch_delta(from_buf, from_size,
> -				      data_buf, data_size,
> -				      &out_size);
> -	if (!out_buf) {
> -		fprintf(stderr, "delta operation failed (returned NULL)\n");
> -		goto cleanup;
> -	}
> -
> -	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
> -	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
> -		perror(argv[4]);
> -		goto cleanup;
> -	}
> -
> -	ret = 0;
> -cleanup:
> -	free(from_buf);
> -	free(data_buf);
> -	free(out_buf);
> -
> -	if (fd >= 0)
> -		close(fd);
> -
> -	return ret;
> +                out_buf = diff_delta(from.buf, from.len,
> +                                     data.buf, data.len,
> +                                     &out_size, 0);
> +        else
> +                out_buf = patch_delta(from.buf, from.len,
> +                                      data.buf, data.len,
> +                                      &out_size);

OK, quite straight-forward again.

> +	if (!out_buf)
> +                die("delta operation failed (returned NULL)");

Nice again.

> +	fd = xopen(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +        if (write_in_full(fd, out_buf, out_size) < 0)
> +                die_errno("write(%s)", argv[4]);
> +        if (close(fd) < 0)
> +                die_errno("close(%s)", argv[4]);
> +
> +	strbuf_release(&from);
> +        strbuf_release(&data);
> +        free(out_buf);
> +
> +        return 0;
>  }

OK.  Except for the whitespace breakage, I didn't spot anything
glaringly wrong in the patch.  Looking good.

Thanks.
