Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7728150F
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958471; cv=none; b=eVBAfRqkVg3MlDyVfPuVr/3i8aW45dKS36bxf8AcnfJVVsmgGVFzoTwfgTgwz41WNlAe5rQxkLc5PoA9YhXFPMN2TUNf6NO//52At7zN8s5PKbQ2OokrSj17dbb2uXOmwcKmAZNHVbkotgT7MWRMjINbfTRRNZr5dOifg8QKfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958471; c=relaxed/simple;
	bh=GcJKEzk80dltUuDayqdlSHgSODORCmha2kfr59PuhQU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeqGuDhlaS+jVtL/gOGbm2Y639L+PHYnZEia9kmATL2dAdCWcQlVXTfM6UrquC3unLWgpFpiZlh4jWyFpvqF0mE5t+TWN9qPAiZqDa3+hBxEJ1y7aHVaPfUyjaLdEeuTdLR71mmTi+mYbJFz6L7xw9auVgALHMZ3Ypeiyn/tmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GdCpZmT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qb1oQGcu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GdCpZmT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qb1oQGcu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4402B1D00127;
	Thu, 19 Mar 2026 18:14:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 18:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773958469; x=1774044869; bh=9oZfQuFwsJ
	UC8k907QYEnpTh+EUUg0TBkpEWfBw+M3I=; b=GdCpZmT1sWoguSI/GJNGRTBELb
	9KK0u7v1qC/7QqFJuMC37Ys4tvH6IjX6UzF2U5PC6NpW+UIhtDfwwGjmwN7sVnMY
	ADjZ3LhMLQzTDhM70Bc+3I+w5it0fMZDCOzhIOIqn3h/Qh5s2JnPZlDazC0GvUmk
	qw51TBfbIys9/fg7EIUOgasDEIHFxyA9L7r+VZIKFv3qayxZPQJ2XW3Vlw5AxxD4
	d5+Eh47uw5m3y13ViphwYZ/a4TMHn6KDuRwbaz42pP5A7Q/S7m/ulLN0uAB/HbHR
	5aTwDVDLCLaFYO66qksiZk49LPIyGKLN92QsAMfrCD+y1y02lWe1TP+DYp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773958469; x=1774044869; bh=9oZfQuFwsJUC8k907QYEnpTh+EUUg0TBkpE
	WfBw+M3I=; b=Qb1oQGcuGxF8wwglY0DjVt2ZnGZTn6kL5yJYg2D6h+LtUjrZuXk
	eqE9fw59FaP+jvTjUiB4jujWJ6hCC6fLHrBjApRe+ezqxmu4JM9l6H/wbvPEpgbx
	PfeKj1n31hF99583ZRsHiUr7+6W4KgsbwA0K6ojVoRx0MNTBeEwr0q0TSSyWuYBE
	4BWMzNViqiVxSkTNLPc9EzyahnOYVPGcvtSguanGxrFP7WdTUajopj0stK5mA8hO
	Q7KBVISr5VpJH+wfpnBKemVBsAwidX8wJqv9wY0hQzAYUBU5QP2npZxOEXc9KsbF
	qCUKPODS4+3s7WmcpsuMdjliZtXdt35mehg==
X-ME-Sender: <xms:RHW8aa_MIUbDK6Z4nz1iMEnCStQOVijS_uIpDIptc_Aoq-xJmoZqQg>
    <xme:RHW8aQsAMYZYRq4t3CgExPXnt6oFB6ajjHyK75a5cvGDHF4hyMjfGypGQKvMcWtwG
    4e2bkldD2Ialu5yY2nRbl08weXYlpqUWWTTXGaVCFLLDIFxUSrnxg>
X-ME-Received: <xmr:RHW8adrcU_EW5J7dWtMmdvD4DYiRF30imlmkqybfPfPO7rPOrxn8iQYqv5DAhRemZ4CHdCXMRBwDhQE_Vkecmwcd_IUdPSaF8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:RHW8adkt8-UUCxjlVS82kqIkfS5n3YwkdtypPNvm7XoNVXTlL-novQ>
    <xmx:RHW8aRz5jb9MdnfC9sA4nXx2M8Jg34JVilGyhkicNQVPc82BPLHZig>
    <xmx:RHW8aVkkqqhY3kA5uiCyCPhfftLz4zAUkFrVTjrdiFXGPy1ZWlLDnA>
    <xmx:RHW8aaciujhxdVvwvjXT6IX9dWUF-kPV1Zj6H_cpKKJ1g4nJM3N_0g>
    <xmx:RXW8aWXeXTVFKGzk-VHkNxEXAqfyFobePSwCnBCXubEBpRTBSKjwa-bH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 18:14:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <xmqq341wnvbk.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Mar 2026 00:15:59 -0700")
References: <xmqq341wnvbk.fsf@gitster.g>
Date: Thu, 19 Mar 2026 15:14:27 -0700
Message-ID: <xmqqcy0zii0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Subject: Re: [PATCH] rerere: update to modern representation of empty strbufs
>
> Finally get rid of the special casing that was unnecessary for the
> last 19 years.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  rerere.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 6ec55964e2..0296700f9f 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -403,12 +403,8 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
>  			strbuf_addbuf(out, &two);
>  			rerere_strbuf_putconflict(out, '>', marker_size);
>  			if (ctx) {
> -				git_hash_update(ctx, one.buf ?
> -						one.buf : "",
> -						one.len + 1);
> -				git_hash_update(ctx, two.buf ?
> -						two.buf : "",
> -						two.len + 1);
> +				git_hash_update(ctx, one.buf, one.len + 1);
> +				git_hash_update(ctx, two.buf, two.len + 1);
>  			}
>  			break;
>  		} else if (hunk == RR_SIDE_1)

I wrote a trivial Coccinele rule (attached at the end) to rewrite 

    SB.buf ? SB.buf : ""

into

    SB.buf

and this found only the above instance, which is good.

However, a related rule, "it is nonsense to expect that SB.buf could
sometimes be false", finds two questionable instances.

One is in list-objects-filter-options.c::parse_list_objects_filter()

        void parse_list_objects_filter(
                struct list_objects_filter_options *filter_options,
                const char *arg)
        {
                struct strbuf errbuf = STRBUF_INIT;

                if (!filter_options->filter_spec.buf)
                        BUG("filter_options not properly initialized");

The filter_options variable points at a list_objects_filter_options
structure, which has an embedded "struct strbuf".  This BUG() is
unnecessary if the structure is properly initialized, either by the
LIST_OBJECTS_FILTER_INIT macro or a list_objects_filter_init() call.
But it is easy to memset(&lofo, 0, sizeof(lofo)) or zero initialize
with "= {0}", so I think it is OK to special case and allow for
checking the possibility that .buf might be NULL.

The other exception comes from use of getdelim() in
strbuf_getwholeline(), whose early part reads like this:

        int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
        {
                ...
                /* Translate slopbuf to NULL, as we cannot call realloc on it */
                if (!sb->alloc)
                        sb->buf = NULL;
                errno = 0;
                r = getdelim(&sb->buf, &sb->alloc, term, fp);
                if (r > 0) {
                        sb->len = r;
                        return 0;
                }


Before calling getdelim(), we deliberately break the strbuf
invariant ".buf is never NULL; it can point at the slopbuf if .len
is 0".  If we read even a single byte, we are OK, as the invariant
is restored.

Upon EOF, later in the function we have

                if (!sb->buf)
                        strbuf_init(sb, 0);
                else
                        strbuf_reset(sb);
                return EOF;

to recover the strbuf invariant.

Because strbuf_getwholeline() discards what is originally in sb and
replaces it with what getdelim() returns, I have a suspicion that
working with bare char * and size_t to interact with getdelim() and
then using strbuf_attach() on the success case would be simpler to
read and maintain.  Once such a rewrite of this function is done
(#leftoverbits), the special case we see in the Coccinelle rule can
be lifted.

Thoughts?


 contrib/coccinelle/strbuf.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/contrib/coccinelle/strbuf.cocci w/contrib/coccinelle/strbuf.cocci
index 5f06105df6..3dc5cd02a3 100644
--- c/contrib/coccinelle/strbuf.cocci
+++ w/contrib/coccinelle/strbuf.cocci
@@ -60,3 +60,18 @@ expression E1, E2;
 @@
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+
+@@
+struct strbuf SB;
+@@
+- SB.buf ? SB.buf : ""
++ SB.buf
+
+@@
+identifier funcname != { strbuf_getwholeline, parse_list_objects_filter };
+struct strbuf SB;
+@@
+  funcname(...) {<...
+- !SB.buf
++ 0
+  ...>}


