Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18217B401
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501702; cv=none; b=P0ch/KdF43bFYMU26+Wudvb6G3HGNIfhTuAqJXv+U4nQMvugpF3Gsr9ILesSPuqMAtacXFoKrDjiGDRAdiJ+9GLeHEuE/AvEXDIC/4TOSQS+50YY4mQLivluIex77E+hikVd9buDPl+1EAtijfF0et+6m0g2ZOmsuWEzjCsbNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501702; c=relaxed/simple;
	bh=NCOav9D8h07UqU33sazDmfIdQcDytD8v9iuHZvbP3/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADt4ZkprUU00LksLIh2efOUjD/rqdjdTtPvxhaN8rzaVfwlzhXjIFI3ftl5kVL51lXN1PWNfnK/+rWOwQLiJkpMGxgtrQ0NFJH3RvFAHXMDLN8JV5VKzNB4jVlZOXzrLNmWYIhxafizGrhp/jUpicEg7G7Wm8dPcYc0CZso2Nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=uC9M0xQI; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="uC9M0xQI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1731501694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dm2CA2F6R3ZsAnp+jmXef9ed8ZGpXSQItnfH+7n8aHA=;
	b=uC9M0xQILwE3kd+L4Z13pymtIjPhn2yvjAyK/cQKqylneGPP4VsrdfIjAGVNbUTWUxL8+r
	YSEMbXx1yYeHmLoPPpT7F8avKSBNvR9DpMoViY7g9c8CaWvOPqfmA04NpKQkj/dIIQ1jy5
	rBXOZGPVF4y9PIhRdaBHsXsDqYwswjo=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, karthik.188@gmail.com
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
In-Reply-To: <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
References: <cover.1731323350.git.karthik.188@gmail.com>
 <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
Date: Wed, 13 Nov 2024 13:41:18 +0100
Message-ID: <87ttcbi9w1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> [snip]
>
> diff --git a/object-store-ll.h b/object-store-ll.h
> index 53b8e693b1..538f2c60cb 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -10,6 +10,7 @@
>  struct oidmap;
>  struct oidtree;
>  struct strbuf;
> +struct repository;
>  
>  struct object_directory {
>  	struct object_directory *next;
> @@ -135,6 +136,10 @@ struct packed_git {
>  	 */
>  	const uint32_t *mtimes_map;
>  	size_t mtimes_size;
> +
> +	/* repo dentoes the repository this packed file belongs to */

Small typo here, I think you mean "denotes".

That's all I've got about all other changes in this patch series.

--
Toon
