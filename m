Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DC34E777
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733766; cv=none; b=TwweWqqWMbo6DinbXyiuatvS+6UcF6WVvX0QkTookXPgRH2HuRprRgmpGwhD6BNpzEJJvnFfdW5wojG2WZpbBp/UvpELKQFwm/Jt9FT+K+SMbeiiS0Kq+hgFak5vl7aw4CP4ZXgm7d0Rst0gwRXGAcAt9J7DViBafs3uAN9iTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733766; c=relaxed/simple;
	bh=iFjvOurEPNmkpEgYfIO6zmbZMryPkGkQ1kAMYOp3Bu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPx4LG5eluWaKKZE/e0CUx1QWvpfp5iJuRLVB1fXa1jBlRZd+fWCNDAm2OsjP3886ZVaJb4JAOMUi5WNcaecK17GZrQKjpmek99YWRSD8tRY9Z8FKz+fhYeecOXxIrw8WzixSnzs/c1FtIxd0OGZ7kPRW3Boknvj19OF1wHJevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qrRW2X+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQB+/6Ty; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qrRW2X+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQB+/6Ty"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 567C814000DF;
	Fri, 14 Aug 2026 14:56:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 14 Aug 2026 14:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786733763; x=1786820163; bh=SYmNrSKKxc
	o86QZr5xVs35C+6u897SmBlwP1MNUcRM0=; b=qrRW2X+9lrrZpZFJHzNvouJ5Sw
	HU8YAHcWGv6cc+6rc7xc14DGVUcLRISolJd+vxZzegBixE7vEuTSNaFZNnO2ApL3
	vHG9kH3xkndOB9W88fbusnoPdevDDU8bQADEO4VddthOsmhJcwg2TNAehlD9i3PK
	oB4i3Q0+Nm8BfglLZCHVLzE0YptjWp1OFE7tk/xikFh7fw1aU6yVhKWv6ELwGaPI
	y6EadWFYMz+46FnOcOUvbODWRzNr47Hl+zKKtY06ALdmdd+IbnfjsNA4r7yP5T0p
	9wD3WsAanZGwR8rdYS9+gcQwcbHol7Ks+fMxiRk6zgwA+pTg8azFgPrRtSXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786733763; x=1786820163; bh=SYmNrSKKxco86QZr5xVs35C+6u897SmBlwP
	1MNUcRM0=; b=OQB+/6TyvvtI52qf99IkdRbAJHJqsK2fFYmo8MbF5ozfvDQy73z
	jJuJcMVJ9ZnE++KF0ulN9N+tuHYfARKyIdsjuKcCJ4p3qONgumSiJWr8o3Mw5I91
	hJNd5RP9+besbaiQzjWRJqO1hiofiAkvFSInj9jiMe7n7ARVkdeQQNTbY3uYEmg/
	WQVEhedg5C6bPdIMDdg5SNw/iOwMrHOLMGRHqvQW4V405UKg1owy5zIfCLPVJQ43
	IVBSQaCHa5QRM5cLS3ATGSNeapj9EoFdIdlUMUXCGa1x72C0ilBgTu+bzCLDedS9
	gDbJhIg4cTv6ttKNubODs0HJPkvSx0yTmWA==
X-ME-Sender: <xms:w2R_amzGEE140cWcUdYLYvL5V18KnXAJ5BHDlqNnx6u9d0vCtG2Ujw>
    <xme:w2R_ahV_YgRNvUTvleiMVaLu6tv_lwWSAOPnGu292YiZFQ69-MbaZlyBz3yMB5u77
    GbI2zPrhUw4MbyuCvJVznCWlCd90RAAh-BW04zoFdVkFvVepWRKFA>
X-ME-Received: <xmr:w2R_aui3BU2ZVSX0BpJNfcCD-17REJW7gLPeLdLmv5bhsGa7G2w32MqGhctowKpaEXzTrJqANzKpqXkQMhluWz6FzcEHEqawtA>
X-ME-Proxy-Cause: dmFkZTEdgAo9CR+ojqAJMry1ezMKyo1BtNEP7WOotfXZE5x1NGft9WCtqRwFb6dvB8DIZs
    sbYpmroHMr5tbk+s1I4rSCwCZgXfckv3kGY2bNIU0Nc2BUeyanRmcCgOzRaZOrpaBrVvIY
    s5FyyaoJ699JqiQLeGe9rOibyuVzG5iTwOF/Ra9kkheUWYs0mUVF9Pzg5qgXEYgEl9JkaE
    KDGK5E54Nbm8WEV7R3T1ln1/LeiuDwY0UcHT/2uiATnCCABljmBUWxcBxnyKf8buMXdt2x
    G+cdtqQI98T/yk9KK/D9oTyarDo6XQXp6Py0lwWe8zwdkB2AIim5zQIeZuU/YhixfobKW1
    Zz0uKaw+E5F2Tu0zERGcqcVGStQ8OEZkz0BcJIcZ/Q6PTVgxE4G7CdFNCIU/S4q9wdzfzu
    Ia243T/IA78s8D/Eg5XVRoKydXGVjkLo3/DI6SS2y82hanT2x/WrJt84hP8Q27KVl6RChn
    35eZ0/XmgkVQBRLJYUSpEqmQM/zopOschJhBTuh19Pxyi734c+fXYRPz8ddRCuPA4QlJF8
    WWmXhinbESkwn2PT/vfmrkWYOWI1kcoFcbxlQZgSxim6+YgDB0Y5Au5w9uSPYj6MA82uwn
    DtTVhWu2id4xbIGhJNWuYE3/Eb/AGZ7GXq9uJuB3w3JoBehf0f7YFiArLiJw
X-ME-Proxy: <xmx:w2R_apDbch0GSIjzD_PFEqmphVrDHxX9VuwviUKqbRywY3kEYHWnzQ>
    <xmx:w2R_astqKSyakUU8B3EXJY8Zfc-r2mMIot5bTr_hMJThTFNeiUdp5w>
    <xmx:w2R_alfYcGFyFE0IgyJ0tsb7HfUXI1pNaA2D6lzsucrTHoHssCLMfg>
    <xmx:w2R_ap-XYUQqy_QIxBbZUnneaGQxSkE8VDTUh7J3TNYOqd_U8I7NqQ>
    <xmx:w2R_am1qeJJtzIGxmy0ernQjmxUVF_a44tLviVBlvRT_xTMz9edx7wrA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 14:56:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 4/5] upload-pack: read uploadpack.lazyFetchTrusted
In-Reply-To: <20260813154748.2378747-5-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:47 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-5-christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 11:56:00 -0700
Message-ID: <xmqqtsowmszj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Previous commits created and prepared the path_allowlist_apply()
> function.
>
> Let's reuse this function for a new "uploadpack.lazyFetchTrusted"
> configuration variable.
>
> It allows us to:
>
>   - read an allowlist from that config variable,
>   - check if the current repo is in that list, and
>   - return the result from a new upload_pack_lazy_fetch_trusted()
>     function.
>
> The new function will be used in a following commit.
>
> Note that the new config variable should be read only from protected
> configuration files.
>
> Signed-off-by: Christian Couder <christian.couder@gmail.com>
> ---

OK.

I am not sure if the idea of configuration variable is truly sound,
but if it were, I agree that this is a reasonable implementation for
it.

Thanks.

>  upload-pack.c | 37 +++++++++++++++++++++++++++++++++++++
>  upload-pack.h |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index a52856d869..29e700e43b 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -34,6 +34,8 @@
>  #include "json-writer.h"
>  #include "strmap.h"
>  #include "promisor-remote.h"
> +#include "setup.h"
> +#include "abspath.h"
>  
>  /* Remember to update object flag allocation in object.h */
>  #define THEY_HAVE	(1u << 11)
> @@ -1378,6 +1380,41 @@ static int upload_pack_config(const char *var, const char *value,
>  	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
>  }
>  
> +struct lazy_fetch_trusted {
> +	int trusted;
> +	char *repo_path;
> +};
> +
> +static int upload_pack_protected_lazy_fetch_config(const char *var, const char *value,
> +						   const struct config_context *ctx UNUSED,
> +						   void *cb_data)
> +{
> +	struct lazy_fetch_trusted *data = cb_data;
> +
> +	if (!strcmp("uploadpack.lazyfetchtrusted", var)) {
> +		path_allowlist_apply(var, value, data->repo_path,
> +				     &data->trusted, false);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +bool upload_pack_lazy_fetch_trusted(struct repository *r)
> +{
> +	struct lazy_fetch_trusted data = { 0 };
> +
> +	data.repo_path = real_pathdup(r->worktree ? r->worktree : r->gitdir, 0);
> +	if (!data.repo_path)
> +		return false;
> +
> +	git_protected_config(upload_pack_protected_lazy_fetch_config, &data);
> +
> +	free(data.repo_path);
> +
> +	return !!data.trusted;
> +}
> +
>  static int upload_pack_protected_config(const char *var, const char *value,
>  					const struct config_context *ctx UNUSED,
>  					void *cb_data)
> diff --git a/upload-pack.h b/upload-pack.h
> index d6ee25ea98..b2212992c3 100644
> --- a/upload-pack.h
> +++ b/upload-pack.h
> @@ -12,4 +12,7 @@ struct strbuf;
>  int upload_pack_advertise(struct repository *r,
>  			  struct strbuf *value);
>  
> +/* Is this repo trusted for lazy fetching? */
> +bool upload_pack_lazy_fetch_trusted(struct repository *r);
> +
>  #endif /* UPLOAD_PACK_H */
