Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729A1BB698
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831907; cv=none; b=hy9OIaiVCdsbvfXtU8D4e2nplkkrhRXgX6DNw1R7QaTWMtwQfuKgp6U+/o5ni2WV6JYVkT/fIvkbNVakhsdjMNJFHHdT4X2i1iM5x6DeQ7EBf4XzvP0YEyrD4LdbYFgRK/Btf0pRRVU3/TvXKdO6j0Wk/+Jg4Yl4/Daeopp0MUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831907; c=relaxed/simple;
	bh=EdGjBVA4knU0DbfTJUDxyFN28ZqrTaAw8jqHHLmqchY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcJVT0CIC33K6Hxkyvu6Er/CNZOyAVLTQX9qp+XHdPeyocRSeF3ktnb+q/vPWK4/8n2wZGgLPLTDPMPKBZULMS+muDrsqHyfe7MW7PNKTFKhc9cTD2PI0LHhMdesx+vw/JsJuwPIlDjlQl4a50NTF6mJGYEPu9QLDja+pz+NXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwW+UtrB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwW+UtrB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so337590566b.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723831903; x=1724436703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ecJpdyfr1SL3jG41gU6XUHENnrchd+BFxAOa4lWfxvQ=;
        b=gwW+UtrBDtbiwbh7lKoJVVMc1wpFSUpQyy3HAase3QBafl4Olf6BtARnrCJmwij/sj
         6dIQEe6oD3PEC29BSrQkQrmErPi1QC/mE+tgpvMdLhmBvigP4tpoXnEXA4wA3eayJqWS
         6cZQ6sc8AkyZjTs/nc4TvlchMb6oRBql0JPaE7EUw4lVNzo8BWs6U4vEX2Pz0hBzS1jU
         /ggh9/LPI2ibu3mDhELPg7ha6D6/BNG3AnRMmLtIXqnOsXTNi5o00ZfB5vBd0L3uqZlU
         +Fu/JaBZPMrnl763rOL1kNGyVKx7Lfvbt5CLI5y+nMuDZaj0eTWINP5dNt6bgHJSdgj0
         DRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831903; x=1724436703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecJpdyfr1SL3jG41gU6XUHENnrchd+BFxAOa4lWfxvQ=;
        b=JEvM8ICFbowCHC4U/sW+aPsXOn34Q9kvuSs5QMmSXCt1eMOM/lp3fmlGJAUdlW/L6t
         NIzqXCwCc6MhfMfdHri/Gr+WDRRcWmOc3Wo5pnNceNj4LQpe610FfXqQ/VPhRvKuKlnB
         sjIK55XmItHcnkhYnw5R3qH2bVt4S6fph3vgoqg1h3lSJH5QNJtKu0QbWFkN18I4jRZk
         ykZ6ijkn2kSLBYnKB62PnKhLJ/Q9LXJVIOTGHNLRreqvkg/j3bmJBZkM5TFjBRxpqRVa
         4qYAEbhiANUGCrFC3JW480+GbaD5LhpfDdlbnxdmUxCRh5GDbNvQGHyiyR26ELhYVPXB
         oyfg==
X-Gm-Message-State: AOJu0YwyDc/LqMgLV/TKC3ARKL9eVbO+0BjxYO5i2F4PqWzYMwK/ejiK
	90LutIh/jaXFofugX2cc1Z1LNaNTpTaFRurPMWHsOkhWpwJJdTK5KsvPxv5QpwLh8S4Bx5wR2TN
	PNsNV7uu943lDu/HOhBhy1GNl3ovwhlR1
X-Google-Smtp-Source: AGHT+IHJ4rL0wa4ayQSCRmDaWy27EtgdfcMhkMYOOPzAiGJU1ckSWUhBnaDn9U6wRy3VbKfhqlxmnTdf4HqT5dGtstA=
X-Received: by 2002:a17:907:9708:b0:a80:f6f1:b249 with SMTP id
 a640c23a62f3a-a83928a986amr252885266b.7.1723831903206; Fri, 16 Aug 2024
 11:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com> <20240816175414.5169-11-chandrapratap3519@gmail.com>
In-Reply-To: <20240816175414.5169-11-chandrapratap3519@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 16 Aug 2024 23:41:15 +0530
Message-ID: <CA+J6zkQa9=7C_f=NqGHEEVhnAJZQ7q9gDMhFQ_F2QDn3RDJ+cA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] t-reftable-block: add tests for obj blocks
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 23:25, Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> In the current testing setup, block operations are left unexercised
> for obj blocks. Add a test that exercises these operations for obj
> blocks.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-block.c | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> index 1256c7df6a..7671a40969 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/t-reftable-block.c
> @@ -190,9 +190,91 @@ static void t_log_block_read_write(void)
>                 reftable_record_release(&recs[i]);
>  }
>
> +static void t_obj_block_read_write(void)
> +{
> +       const int header_off = 21;
> +       struct reftable_record recs[30];
> +       const size_t N = ARRAY_SIZE(recs);
> +       const size_t block_size = 1024;
> +       struct reftable_block block = { 0 };
> +       struct block_writer bw = {
> +               .last_key = STRBUF_INIT,
> +       };
> +       struct reftable_record rec = {
> +               .type = BLOCK_TYPE_OBJ,
> +       };
> +       size_t i = 0;
> +       int ret;
> +       struct block_reader br = { 0 };
> +       struct block_iter it = BLOCK_ITER_INIT;
> +       struct strbuf want = STRBUF_INIT;
> +
> +       REFTABLE_CALLOC_ARRAY(block.data, block_size);
> +       block.len = block_size;
> +       block.source = malloc_block_source();
> +       block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
> +                         header_off, hash_size(GIT_SHA1_FORMAT_ID));
> +
> +       for (i = 0; i < N; i++) {
> +               uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
> +               allocated = reftable_malloc(ARRAY_SIZE(bytes));
> +               DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));

The second line of this loop is redundant and causes a memory leak
in the GitHub CI. I'll fix this in the next iteration.

---snip---
