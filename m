Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A931195B
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762793; cv=none; b=tzO3ifkWvDp1iozkA5qHG0VFj9mFaPdRHoEIxhCUWZN9yNFrjeGWf8cI6wEVYAqEKvT4CV5rEazszEdEPatvYIGq2FvsSRihm2FXsBCCqmDStct0cOTVmtF13F3YtjW+LF9PRswel0PiV4kFEpfvQOFx72PYhTDDflvaTUus68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762793; c=relaxed/simple;
	bh=5IqJD9VolkbJEAPxeZlUF+kHU0E0KfTOCF6UMACbfGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRV1pQnH9aTqWXEzkEBBqSyAXcl5XtX99cktLlQTP3DD55bNnZIl6FXIhf3gOjLFQu0EGOJZenz8MkQLq+GfFvbB5Wf/asjaFZ/FHobko4nEXoAfvFmsS6GItKMriZrx/qUrslzq26Ne7mInK1rk85ZA8EvjyCBmLyeqeQWfKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHv5KVwW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYWZP5Jk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHv5KVwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYWZP5Jk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 64B721D0003E;
	Wed, 26 Aug 2026 12:46:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 12:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787762771; x=1787849171; bh=YRdlePeVJC
	sI49yHtCamHFsBGJEhMvR8twY4JSYFiH0=; b=gHv5KVwWxnvWTP58s66uLnLWIK
	cgPiCB/pAfzbJRAY2IbruF7IhHW50ADtARfwn+WWN51VrbfpkiO9S0JQ9dHXp5qQ
	7gHxZIR2niAxbgbjfKkAS1yRCWMIZXqGdUTMum81UQ8oarQjdCjvIPWbCPl1JlqJ
	eX3MCefnCTNkvnVh1TdQ0+RdkUmiHI6dso82rguoPJOwe7qO5ABpbLw18mqxklWS
	ef9Tj75Txx9cJzLiC9FsS5apbQOm9nzULwKbr9UjEBTQyjOsg0h47uKLIIBO1UBX
	Xco3elASBoPbVqxAeCtSFoyAea9tXFnH0GzcFD1U+cregB3GnGRyUfj9kUsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787762771; x=1787849171; bh=YRdlePeVJCsI49yHtCamHFsBGJEhMvR8twY
	4JSYFiH0=; b=NYWZP5JkJWLlGqQMJP9yqycxcTsrYLLmmBAHo3rFvSA6ESCQhH+
	L63dhnQPgBNzSzNNJudmvwCXL87Ln3+prUCG/qeiqOrTsD1JxEURGcQ8q/z8J53H
	xxT55aQVMLWV1BdJf1Jb7Ul4DV6gHoDSJ43c3I8Lyk4E1eQI3k8EdswMQdbv039F
	VBf0GyeLejOTc/j3hCaLkAgNUhx2FsaCAOp7ZGN9VMDBBER0XyHXu+jceQAs/Rcv
	8duxdEYnHhcdOFqXZcj19ackml+zRgyl/c/gooo+ijhKZ3o9WPExorynq51201Lw
	rFbXKpqL+CPTm+uzY0zFxvuolcqvdFF3wow==
X-ME-Sender: <xms:UxiPavPbRXqujZg1VIaJ35prIh9fushrA3USxdLuj1Tw6bOZKrK3xA>
    <xme:UxiPato50Eg0suKJME33ER06YGHqH3jpZl2SZMCaTqLR8fkVzjWzR26H0ikKrwhig
    t_ys5-Ic-3WsPUI5IMUhkK-zNtXTUFg0gtlawc1n7LXd745ZWwRiQ>
X-ME-Received: <xmr:UxiPaoHYXb64hcZUsn_8TV8-VkTov9uzDZfPSrjcAmEof-Hy7gmJOy8UqQYV4hl2zI5NYcha6BBrcQa494Jl60VzPq66ncgZmA>
X-ME-Proxy-Cause: dmFkZTGnXWT06w1L+H08EYZiS5x8M0rh3Uq5bZvRccz+hIqu3QQPKw5Czobtp7R9RCgLpW
    qs5IwhC/udaEwHGy+x7ZNpUwistDE217jiETnmBmdoczR7HEBObIGHxrZB+qAuk4B1EIQG
    lmYeuGA+5SIyyC4IRGchJFcMEAn0MAOE7QKNIXjGH5d9kNJVGQmqobuuSLHMueMgaqWf3Z
    Icf29tlzPO+DvdSfPUA3WxACgwkYp93WWPqehPYPFfXFU3Wh7vM8gdg5Z4ALMUDXqM2ojV
    AUtIhfdh2n2dHFPUWkvQfkZDOQ8YPr19bESKfJlgMOLc0dCpFFapvJ2/HHgKob3eaiHAXM
    VrYHIyYGjzhhAWxxuMIihIJLh7QY8ZfIE7TzCdz0/TKrDgtrsnp4h/uSO4wOVdxhJjPrbQ
    QTWibHJZQVccU+m5ZpcC1b4HeWjmL04qMLFuDNAEDpnyVgP5bkBUUi5Dp1+tFJs8KWHegi
    7fIgu9mXltJQMIYoY+9faUcHrDt/5AawlqyXPqZZxgem5YP8FkGYYZakosmbCYzTtO9AVb
    SFlrU2vrPeqvtsSVV8JVWD9Hbjukro9+qP+O7SHOFcWqkohdLUunM1J9h6RdwSG9F0s2Us
    If6BSJ1691XS+fPS9pntuecgT9hfli6zwCgSSXdlN8YJW5BnvQOTgWERr0TQ
X-ME-Proxy: <xmx:UxiPaqqEUreAzKvmA5iO6ZVXY9EnAUWbUzXgJpglTEIcL1gYUXV3dg>
    <xmx:UxiPapYHgVCsHpqh760KVc3zX3Arx7fDNSIsK4OgTxdIEZmC7JvT6Q>
    <xmx:UxiParUdOdXJnWwuCRpBiInUB3h20zeABYie5pdwEY9hS0Xv99Kg8Q>
    <xmx:UxiPaq-65oDDuzA9JsH0zInwSggYm2YW4US2qyqO1euNHt1nrZLTKA>
    <xmx:UxiPajzDsRwTXT9noGoMNlqQNtptEp_zuE5A62HMSUl9PKYK2RSt-8bD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 12:46:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v9 2/4] checkout: improve message for ambiguous remote
 branch name
In-Reply-To: <89c0f4d30317ebf7cda884710944e9a6f23d46fe.1787741111.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Wed, 26 Aug 2026
	10:45:08 +0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
	<89c0f4d30317ebf7cda884710944e9a6f23d46fe.1787741111.git.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 09:46:09 -0700
Message-ID: <xmqqmru8j0dq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/checkout.c b/checkout.c
> index 1588b116ee..2806b783ec 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -8,6 +8,7 @@
>  #include "checkout.h"
>  #include "config.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  
>  struct tracking_name_data {
>  	/* const */ char *src_ref;
> @@ -17,6 +18,7 @@ struct tracking_name_data {
>  	const char *default_remote;
>  	char *default_dst_ref;
>  	struct object_id *default_dst_oid;
> +	struct string_list **remote_names;
>  };

Do we really need double indirection?  The unique_tracking_name()
function that uses this struct for callback receives a pointer to
the string list the caller has, and the job of the callback is to
append to the supplied string list.  

It is not like it wants to swap the given pointer to a string list
to the pointer to another string list, so I do not see a reason for
anybody involved in the callchain to want this as a pointer to a
pointer.

>  #define TRACKING_NAME_DATA_INIT { 0 }
> @@ -39,6 +41,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>  		oidcpy(dst, cb->dst_oid);
>  		cb->default_dst_oid = dst;
>  	}
> +	if (cb->remote_names)
> +		string_list_append(*cb->remote_names, remote->name);

If we lose the double indirection, this can become

		string_list_append(cb->remote_names, remote->name);

>  char *unique_tracking_name(const char *name, struct object_id *oid,
> -			   int *dwim_remotes_matched)
> +			   int *dwim_remotes_matched,
> +			   struct string_list *dwim_remote_names)
>  {
>  	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
>  	const char *default_remote = NULL;
> -	if (!repo_config_get_string_tmp(the_repository, "checkout.defaultremote", &default_remote))
> +
> +	if (!repo_config_get_string_tmp(the_repository,
> +					"checkout.defaultremote",
> +					&default_remote))
>  		cb_data.default_remote = default_remote;
>  	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
>  	cb_data.dst_oid = oid;
> +	if (dwim_remote_names)
> +		cb_data.remote_names = &dwim_remote_names;

And this can become

		cb_data.remote_names = dwim_remote_names;

