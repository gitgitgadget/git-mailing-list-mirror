Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5543B71BD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926830; cv=none; b=qnI2S3q4nvRF+0NpXZ7l/pnU85tueOGDBccJEGhwqZDnuVePKmWZnocBSYTlP4gQNc/WfD5c/TvqvVNBTr4J3fWvSJj9vt1fPFvCi8Mj4VmMpb3rBTcbKSNLDNfWpzND9cjgDK3bV+1FJm0OPsyRZ/Dsey7dRo1hQfZ2bU64W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926830; c=relaxed/simple;
	bh=Jtc44U9cINuIzCB+waixzejXd/eCVHuM4gv81FGN8OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AisUg11mV/Z3lAc2cFkT1vzL7+onIlhLjXcCt1L24wh7HfdyqgBG91tor4/a1M813/UiyuEMLdEady9uZlRAPdnUetvwvxlKsHoi3lVWIxR/cbrQMG0QBh3/j1Rd+RMZyoUqmqCTfop6Bl9ZA9kZc4sKdbzoV8glf7s76edllA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZND4cyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLXZaVF2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZND4cyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLXZaVF2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 368D614001E5;
	Mon,  8 Jun 2026 09:53:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 08 Jun 2026 09:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780926828; x=1781013228; bh=h7Elx/nI2B
	3HJP5aJB65XXNGYp0fpiXwLkv/wPQb0h4=; b=KZND4cyziGLJP34qBLWZ2rpmKS
	pLQB8EClPeTUMiHb7H1F4H8Xq/4VquEJDZA8d16Pl9xFSa4iJNzv7arHPm9VANT/
	6z44r2Cj2muOfWJUj0dCce8npXpFPYzYMUBg3nww7dMak8/V6CvhN00Aej7fLDGG
	wl+qbZuOgPSeHPsuQWJrtJ44HzEivYtCb5QO61f1TfLEcFA0Eodmg2iQoKE0lR14
	9px7FlXy8hfWxnkCsl4EVPS5nlKLamwahkGWBKcdfem1dn382YIJDEHzNLrJIFS/
	8HXfbQia+Y31CDGWfOblDtcROdXCID5ZyaLHHJfvrqrz1inlLpon4YZQhX9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780926828; x=1781013228; bh=h7Elx/nI2B3HJP5aJB65XXNGYp0fpiXwLkv
	/wPQb0h4=; b=LLXZaVF284GrrZFR8JGdnNEEukovCBsIw5aeikoOYK2QmnMeMZA
	QSlA+D72Fl3nSntISd7jfCFXC+yrMJ0CTyS1edX08mwTT9jZU8EjNWGmExSbmy6C
	X08drvk8cOcv44SFT6EbPblVVUvfrhC0QUtT1cHzaKOklh+BlLT7s8FTAox9aaiy
	T4z/Z2c9c7ckbJkgO0GG3XMf1NCAxPNsdmeucyO3JwbEux/8Z3mzmr9CzIwbq4vo
	jOWHlaJYi+nBJQizDyOIVZ7v82NFZhKUQwA0SB/DgMe6MvIDNyCfpUaZ/hzCaLpb
	zd/57EnoWcYeeWPpGIusWrpT3xIVEYc5AEA==
X-ME-Sender: <xms:bMkmar-hH3dl-vjCkKV22nGet3Niu3lz9Oia-Ei351j7ffqfIj5Qww>
    <xme:bMkmaus4DEUO8Z-UnVoSTY3CnepOgpXFJe9V6o_LRpHv0pSWOND8BI_kd_hk-VyjB
    rmgy5x4hHXDPV4wEXWBPZShp9Ev2TjWyNuGBTQFpFbdci4wEjzvqe8>
X-ME-Received: <xmr:bMkmauBr5RHT7e_3VcnT2pscvXAkM63ztczYKK9SZfO_OaStDxjrOzqOYAJda5AkzXzvufgSTOZbvxztqduohqcz2-RzoX3bc-8Wir1yOQ>
X-ME-Proxy-Cause: dmFkZTEGNy6bVM09haIyqX2KIYn/ergfrMZA2n/ttSf9FJ8t6Qlu0XEMZqRnf0UkauDWNb
    kV5MFqeyA8BnyPx4AOKlpz8Y8eIpyCpmcnUa7/1TyJ1Ixb2kHotdY7k9AhGOzBLmWudNH/
    Q8HnzyNK9OaSEJsaBt72oqAV24+e09kd9sHDdkn9CKb48m+tNtvAevZ+75p7c2SnYMkfoa
    C4X8N98/KsKhLLix+k9BuGmr1a3zsZ2uZE+wKT4MGM4780tYIEqtZaPXTAb3oe2PwVn3s3
    FdyIi1olLDbzdYRViV6istwz/PrMTPgmLX3e1o24pTO4MHN+ArWHUd4iC07bIqKSiz/gnL
    6HEBfock/N6P44oNbsn5b0WzQiktPOwZ2OrlEDjqwy0Woz2/sTpkYur2yqPRyONH0Ec69R
    5Zk+0KvfX3huYsXurIU5sE2uHoHbdZfJcVBOL/6ok7oc8uP+VhevsOvHDn/Sz15/UyLOhr
    E2AUt8D2ytRSrHnPbOLylnVy4c+EaEGLkfJJJ2oGfvj2XRYkfw7+EkVpcAw1J1Z+2K41Lu
    dyY8vgATVGrZYkHhNvEXN92Q6KUmenWN5I+dDB0CIBW95ApzpP0cO2MzzC9qFnZbH984Jh
    UraQbSylfPbFkdHjeJiy0R6BWUo55cZgqnPZu3+qeKofENEbLmffiEAH/iKA
X-ME-Proxy: <xmx:bMkmamU8OkmeSFwkY7Kaf4YKKlLTCDMOdYZGWY8P64zc7eEh_YEL5Q>
    <xmx:bMkmasCqa3DuT6XvjrWYJ9G-8As_D2ym4Syp2eiQ60K43DrjF59rVQ>
    <xmx:bMkmap-B1tD2lt9h3E7yMdav_e2kJwsw5-0EAcDnd62LjS9s2IDtCA>
    <xmx:bMkmajEeSYzyW3J3NfS9B4MCUuxKAJi7f8kANl4-HAoZ-e8Sn_LHsA>
    <xmx:bMkmapwsz-utX3TejZhrdPfSlLMRkiUkTqSkffh_vZxS6YeW19N4ruJu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:53:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e833d5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 13:53:46 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:53:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 7/7] odb: use size_t for object_info.sizep and the size
 APIs
Message-ID: <aibJZ8EXoQSD2lsB@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <f3aeae983ac8b281d6ba54299961e19d16699c94.1780570273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3aeae983ac8b281d6ba54299961e19d16699c94.1780570273.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 10:51:12AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index fa45f774d7..fa6e396ddc 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -120,7 +120,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	struct object_id oid;
>  	enum object_type type;
>  	char *buf;
> -	unsigned long size;
> +	size_t size;
>  	struct object_context obj_context = {0};
>  	struct object_info oi = OBJECT_INFO_INIT;
>  	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
> @@ -166,7 +166,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
>  			size_t s = size;
>  			buf = replace_idents_using_mailmap(buf, &s);
> -			size = cast_size_t_to_ulong(s);
> +			size = s;
>  		}
>  
>  		printf("%"PRIuMAX"\n", (uintmax_t)size);

Can't we drop this local variable completely and instead supply `&size`
directly?

> @@ -219,7 +225,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		if (use_mailmap) {
>  			size_t s = size;
>  			buf = replace_idents_using_mailmap(buf, &s);
> -			size = cast_size_t_to_ulong(s);
> +			size = s;
>  		}
>  
>  		/* otherwise just spit out the data */
> @@ -266,7 +272,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  		if (use_mailmap) {
>  			size_t s = size;
>  			buf = replace_idents_using_mailmap(buf, &s);
> -			size = cast_size_t_to_ulong(s);
> +			size = s;
>  		}
>  		break;
>  	}
> @@ -446,7 +455,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  		if (use_mailmap) {
>  			size_t s = size;
>  			contents = replace_idents_using_mailmap(contents, &s);
> -			size = cast_size_t_to_ulong(s);
> +			size = s;
>  		}
>  
>  		if (type != data->type)

Likewise for these three instances.

> @@ -555,7 +564,7 @@ static void batch_object_write(const char *obj_name,
>  			if (!buf)
>  				die(_("unable to read %s"), oid_to_hex(&data->oid));
>  			buf = replace_idents_using_mailmap(buf, &s);
> -			data->size = cast_size_t_to_ulong(s);
> +			data->size = s;
>  
>  			free(buf);
>  		}

And I think this site here can be adapted, as well.

> diff --git a/diff.c b/diff.c
> index 5a584fa1d5..816b89dc6c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4594,8 +4594,9 @@ int diff_populate_filespec(struct repository *r,
>  		}
>  	}
>  	else {
> +		size_t size_st = 0;
>  		struct object_info info = {
> -			.sizep = &s->size
> +			.sizep = &size_st
>  		};
>  
>  		if (!(size_only || check_binary))
> @@ -4617,6 +4618,7 @@ int diff_populate_filespec(struct repository *r,
>  			die("unable to read %s", oid_to_hex(&s->oid));
>  
>  object_read:
> +		s->size = cast_size_t_to_ulong(size_st);
>  		if (size_only || check_binary) {
>  			if (size_only)
>  				return 0;
> @@ -4631,6 +4633,7 @@ object_read:
>  			if (odb_read_object_info_extended(r->objects, &s->oid, &info,
>  							  OBJECT_INFO_LOOKUP_REPLACE))
>  				die("unable to read %s", oid_to_hex(&s->oid));
> +			s->size = cast_size_t_to_ulong(size_st);
>  		}
>  		s->should_free = 1;
>  	}

The flow in this function is quite weird if you ask me, but that's a
preexisting issue. This does look correct to me, even if it's awkward.

Patrick
