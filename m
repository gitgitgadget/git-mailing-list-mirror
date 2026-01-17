Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F117A2F0
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658188; cv=none; b=R94WbcwJt4YGfxB/elRJ6QKC0Gx36jbK3rV7Pxg/dfnr/3UFiX2ApWbQye8jMlPP2RoiBswnUX1gAbk43uFmLXvshQLZ+cUy2grpvUWqDcm46AlWG44A/ZB7ldHvrjVvw6RiOy2qz8Uam/rieinxYnoU/7i5sSqOl+OAl9GycKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658188; c=relaxed/simple;
	bh=txfVZ6Y6c268K0jsBfHcslV2SGn22oLk/VoYn01MI5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR74Ani4YJWeXiHlRDsLvmCaNWcvMtmc48bGaYMRAVq2tMQEgCWJxw6+BAAr3+d9o8XOxAj4SWs9JxmQpij/aruD1m83z7UikO+TOCMrlUc0UJGMgRkrtKpApYlFlGKsau3VW/zwe+yuCff2G9u4rgQ7AfmBd5WaVpho1apG3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZwsq4p0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZwsq4p0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so17710935e9.3
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 05:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768658184; x=1769262984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgpNkzXdbYHMua9y5WJDnMICYCr6Z/nXHvNq/Tj5zVA=;
        b=IZwsq4p0dTBf11z/I2oSkWQdODCrf3F+Iw1s3cfR2TYku87XykuTqPBVJmZc8GeUTC
         6Zp+3tKqUZqTsXslHSIe/RtFI+KOU+fGXxXy9tTcR0J3fjafCCjaB5/b3uywhA/yGC7r
         5xBlwiAdn0yMwMya0C8IAPBshmRCXihkh4jvXU0UJ+kTotmpTcjR1zEgdG0CEMbnlGcE
         8AytYu/rpB12kpy3nEEbcGHBCayVIZYzIE5nc8DQziT5EaNQikfrTfn2BTmFQeJG0Sfp
         amhncG0XO3EsiKDH4JAxokaLBPz9Fs00yrlHPSjlGgpUBBVtRxd3/LbtfOrEjVaIKqCp
         O4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768658184; x=1769262984;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgpNkzXdbYHMua9y5WJDnMICYCr6Z/nXHvNq/Tj5zVA=;
        b=BxPWTZs5/pe1/9OEPxYyBkocTwH/NCVjMCBD9Gw97BzNnlV8J/QU3vaymjXayfhrYW
         YlksndBP8pMXbpSkk+LT43Z1Syu/+sBB9oF+U3LPXOeAi0uX+Izpn0oBrTVdSOne+jEg
         LuXIETSf9BEawW+zqznYgg7Bgtkq9OI6wC/yapaisbRpQhkUR6awjVtLwc7zsH6QJddF
         hHKzmggKeRBJj+UHVsX6EN/T09gU+8UsAA6R+7LArB3zUQtfjXix4dc3Z8Mq1ZOi1b9u
         7tiLtnA7/TQd7vCiBvEnWXX60prLHfMeAQOR6XWmvUN/0HM6hr1PToBnyqKaq+q9J1Uw
         Gtkw==
X-Forwarded-Encrypted: i=1; AJvYcCWrces+4hVl5iGC066pXXCN8t2p/XuQyISiZWytdntjDHrmy3hbEN6gjVFHyuP7nS5IxfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSrfTLjV79LxEvffWWzVqrmsjLvfDZH/IT02XzSu2Pg3wdCc1
	iW7tjZL3ks3T19gEY6JEO+7veeqeavNxg47bmcMCAr8et6cw2NTt26Cp
X-Gm-Gg: AY/fxX5gYjUmqRackQzKlsq7i7hNV2p7GsvroTxKvyR3BrBDKRnSXm378CO3R/cMtVv
	sY+l8ohEGwlpWNUiwJzEo0uzc5Wz4LfMrlLfqwKjvdoGLdOCYR0aIaK5IP1ydfeUoZvcX90Zs/j
	n5UG4VAflN81tDdiHh7PD2WZoRQ5TNVEXqzt4D5hSAx8SReUrQ+7i437BszF3fR9z7rLTrrlcI0
	6Op0zSCxuL/Zvy9WY/6Y4yigFqIxNbGJhFb3+hpReBGTpsUS++jAxcgtXlafxPd7p32W2fyrnZf
	10XDiNsMi95mzudGnCom5oMPuexunEcaWYxcWb3Do6/vZ+Eb2Rd5C4Pk5dvEBjYzh47xRTaTO53
	C+g7LOGsoasXGImkYBpihqBlUddCSYAGeqQ3UsxTiAGQ3rR6IsJfEuIunXD9F0nYNVgQQ2RzoWC
	w6I+AOprRvbgSpIkSpC/z2UaD7qZbUmlgwDH4oGP8p4mNFGkApwBKnQeF/F8wY12ZFE/R64qQ=
X-Received: by 2002:a05:600c:3d8b:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-4801e30ac2cmr67364905e9.12.1768658184336;
        Sat, 17 Jan 2026 05:56:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:31b4:1316:18dc:6259? ([2a0a:ef40:627:1f01:31b4:1316:18dc:6259])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm11418585f8f.35.2026.01.17.05.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 05:56:23 -0800 (PST)
Message-ID: <0082426c-a945-4f2e-969e-897e1aeaed66@gmail.com>
Date: Sat, 17 Jan 2026 13:56:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] fetch: delay user information post committing of
 transaction
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
 gitster@pobox.com
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
 <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-7-925a0e9c7f32@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-7-925a0e9c7f32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karthik

On 16/01/2026 21:27, Karthik Nayak wrote:
> In Git 2.50 and earlier, we would display failure codes and error
> message as part of the status display:
> 
>    $ git fetch . v1.0.0:refs/heads/foo
>      error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
>      From .
>       ! [new tag]               v1.0.0     -> foo  (unable to update local ref)
> 
> With the addition of batched updates, this information is no longer
> shown to the user:
> 
>    $ git fetch . v1.0.0:refs/heads/foo
>      From .
>       * [new tag]               v1.0.0     -> foo
>      error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
> 
> Since reference updates are batched and processed together at the end,
> information around the outcome is not available during individual
> reference parsing.
> 
> To overcome this, collate and delay the output to the end. Introduce
> `ref_update_display_info` which will hold individual update's
> information and also whether the update failed or succeeded. This
> finally allows us to iterate over all such updates and print them to the
> user. While this brings back the functionality, it does change the order
> of the output. Modify the tests to reflect this.

It is unfortunate that a fix for a regression the the messages changes 
the order of those messages. It is doubly unfortunate that the new order 
depends on the implementation of strmap_for_each() which may change in 
the future. I think you can avoid this by appending each update to an 
array in update_local_ref() and adding the errors to a separate strmap 
in ref_transaction_rejection_handler(). Then when you come to print the 
massages, loop over the array and for each update lookup the ref in the 
strmap to see if it failed before printing the appropriate message.

Thanks

Phillip

> Using an strmap does add some overhead to 'git-fetch(1)', but from
> benchmarking this seems to be not too bad:
> 
>    Benchmark 1: fetch: many refs (refformat = files, refcount = 1000, revision = master)
>      Time (mean ± σ):      51.9 ms ±   2.5 ms    [User: 15.6 ms, System: 36.9 ms]
>      Range (min … max):    47.4 ms …  58.3 ms    41 runs
> 
>    Benchmark 2: fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
>      Time (mean ± σ):      53.0 ms ±   1.8 ms    [User: 17.6 ms, System: 36.0 ms]
>      Range (min … max):    49.4 ms …  57.6 ms    40 runs
> 
>    Summary
>      fetch: many refs (refformat = files, refcount = 1000, revision = master) ran
>        1.02 ± 0.06 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
> 
> Another approach would be to move the status printing logic to be
> handled post the transaction being committed. That however would require
> adding an iterator to the ref transaction that tracks both the outcome
> (success/failure) and the original refspec information for each update,
> which is more involved infrastructure work compared to the strmap
> approach here.
> 
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   builtin/fetch.c         | 179 ++++++++++++++++++++++++++++++++++++++++--------
>   t/t5516-fetch-push.sh   |   1 +
>   t/t5574-fetch-output.sh |  16 ++---
>   3 files changed, 161 insertions(+), 35 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 49495be0b6..afe5d321d1 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -861,12 +861,77 @@ static void display_ref_update(struct display_state *display_state, char code,
>   	fputs(display_state->buf.buf, f);
>   }
>   
> +struct ref_update_display_info {
> +	bool failed;
> +	char success_code;
> +	char fail_code;
> +	const char *summary;
> +	const char *fail_detail;
> +	const char *success_detail;
> +	const char *remote;
> +	const char *local;
> +	struct object_id old_oid;
> +	struct object_id new_oid;
> +};
> +
> +static struct ref_update_display_info *ref_update_display_info_new(
> +						char success_code,
> +						char fail_code,
> +						const char *summary,
> +						const char *success_detail,
> +						const char *fail_detail,
> +						const char *remote,
> +						const struct object_id *old_oid,
> +						const struct object_id *new_oid)
> +{
> +	struct ref_update_display_info *info;
> +	CALLOC_ARRAY(info, 1);
> +
> +	info->success_code = success_code;
> +	info->fail_code = fail_code;
> +	info->summary = xstrdup(summary);
> +	info->success_detail = xstrdup_or_null(success_detail);
> +	info->fail_detail = xstrdup_or_null(fail_detail);
> +	info->remote = xstrdup(remote);
> +
> +	oidcpy(&info->old_oid, old_oid);
> +	oidcpy(&info->new_oid, new_oid);
> +
> +	return info;
> +}
> +
> +static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
> +{
> +	info->failed = true;
> +}
> +
> +static void ref_update_display_info_free(struct ref_update_display_info *info)
> +{
> +	free((char *)info->summary);
> +	free((char *)info->success_detail);
> +	free((char *)info->fail_detail);
> +	free((char *)info->remote);
> +}
> +
> +static void ref_update_display_info_display(struct ref_update_display_info *info,
> +					    struct display_state *display_state,
> +					    const char *refname, int summary_width)
> +{
> +	display_ref_update(display_state,
> +			   info->failed ? info->fail_code : info->success_code,
> +			   info->summary,
> +			   info->failed ? info->fail_detail : info->success_detail,
> +			   info->remote, refname, &info->old_oid,
> +			   &info->new_oid, summary_width);
> +}
> +
>   static int update_local_ref(struct ref *ref,
>   			    struct ref_transaction *transaction,
>   			    struct display_state *display_state,
>   			    const struct ref *remote_ref,
>   			    int summary_width,
> -			    const struct fetch_config *config)
> +			    const struct fetch_config *config,
> +			    struct strmap *delayed_ref_display)
>   {
>   	struct commit *current = NULL, *updated;
>   	int fast_forward = 0;
> @@ -900,12 +965,19 @@ static int update_local_ref(struct ref *ref,
>   	if (!is_null_oid(&ref->old_oid) &&
>   	    starts_with(ref->name, "refs/tags/")) {
>   		if (force || ref->force) {
> +			struct ref_update_display_info *info;
>   			int r;
> +
>   			r = s_update_ref("updating tag", ref, transaction, 0);
> -			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
> -					   r ? _("unable to update local ref") : NULL,
> -					   remote_ref->name, ref->name,
> -					   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +			info = ref_update_display_info_new('t', '!', _("[tag update]"), NULL,
> +							   _("unable to update local ref"),
> +							   remote_ref->name, &ref->old_oid,
> +							   &ref->new_oid);
> +			if (r)
> +				ref_update_display_info_set_failed(info);
> +			strmap_put(delayed_ref_display, ref->name, info);
> +
>   			return r;
>   		} else {
>   			display_ref_update(display_state, '!', _("[rejected]"),
> @@ -921,6 +993,7 @@ static int update_local_ref(struct ref *ref,
>   	updated = lookup_commit_reference_gently(the_repository,
>   						 &ref->new_oid, 1);
>   	if (!current || !updated) {
> +		struct ref_update_display_info *info;
>   		const char *msg;
>   		const char *what;
>   		int r;
> @@ -941,10 +1014,15 @@ static int update_local_ref(struct ref *ref,
>   		}
>   
>   		r = s_update_ref(msg, ref, transaction, 0);
> -		display_ref_update(display_state, r ? '!' : '*', what,
> -				   r ? _("unable to update local ref") : NULL,
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_new('*', '!', what, NULL,
> +						   _("unable to update local ref"),
> +						   remote_ref->name, &ref->old_oid,
> +						   &ref->new_oid);
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +		strmap_put(delayed_ref_display, ref->name, info);
> +
>   		return r;
>   	}
>   
> @@ -960,6 +1038,7 @@ static int update_local_ref(struct ref *ref,
>   	}
>   
>   	if (fast_forward) {
> +		struct ref_update_display_info *info;
>   		struct strbuf quickref = STRBUF_INIT;
>   		int r;
>   
> @@ -967,23 +1046,36 @@ static int update_local_ref(struct ref *ref,
>   		strbuf_addstr(&quickref, "..");
>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>   		r = s_update_ref("fast-forward", ref, transaction, 1);
> -		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
> -				   r ? _("unable to update local ref") : NULL,
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_new(' ', '!', quickref.buf, NULL,
> +						   _("unable to update local ref"),
> +						   remote_ref->name, &ref->old_oid,
> +						   &ref->new_oid);
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +		strmap_put(delayed_ref_display, ref->name, info);
> +
>   		strbuf_release(&quickref);
>   		return r;
>   	} else if (force || ref->force) {
> +		struct ref_update_display_info *info;
>   		struct strbuf quickref = STRBUF_INIT;
>   		int r;
> +
>   		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>   		strbuf_addstr(&quickref, "...");
>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>   		r = s_update_ref("forced-update", ref, transaction, 1);
> -		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
> -				   r ? _("unable to update local ref") : _("forced update"),
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_new('+', '!', quickref.buf,
> +						   _("forced update"),
> +						   _("unable to update local ref"),
> +						   remote_ref->name, &ref->old_oid,
> +						   &ref->new_oid);
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +		strmap_put(delayed_ref_display, ref->name, info);
> +
>   		strbuf_release(&quickref);
>   		return r;
>   	} else {
> @@ -1103,7 +1195,8 @@ static int store_updated_refs(struct display_state *display_state,
>   			      int connectivity_checked,
>   			      struct ref_transaction *transaction, struct ref *ref_map,
>   			      struct fetch_head *fetch_head,
> -			      const struct fetch_config *config)
> +			      const struct fetch_config *config,
> +			      struct strmap *delayed_ref_display)
>   {
>   	int rc = 0;
>   	struct strbuf note = STRBUF_INIT;
> @@ -1219,7 +1312,8 @@ static int store_updated_refs(struct display_state *display_state,
>   
>   			if (ref) {
>   				rc |= update_local_ref(ref, transaction, display_state,
> -						       rm, summary_width, config);
> +						       rm, summary_width, config,
> +						       delayed_ref_display);
>   				free(ref);
>   			} else if (write_fetch_head || dry_run) {
>   				/*
> @@ -1300,7 +1394,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>   				  struct ref_transaction *transaction,
>   				  struct ref *ref_map,
>   				  struct fetch_head *fetch_head,
> -				  const struct fetch_config *config)
> +				  const struct fetch_config *config,
> +				  struct strmap *delayed_ref_display)
>   {
>   	int connectivity_checked = 1;
>   	int ret;
> @@ -1322,7 +1417,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>   
>   	trace2_region_enter("fetch", "consume_refs", the_repository);
>   	ret = store_updated_refs(display_state, connectivity_checked,
> -				 transaction, ref_map, fetch_head, config);
> +				 transaction, ref_map, fetch_head, config,
> +				 delayed_ref_display);
>   	trace2_region_leave("fetch", "consume_refs", the_repository);
>   
>   out:
> @@ -1493,7 +1589,8 @@ static int backfill_tags(struct display_state *display_state,
>   			 struct ref_transaction *transaction,
>   			 struct ref *ref_map,
>   			 struct fetch_head *fetch_head,
> -			 const struct fetch_config *config)
> +			 const struct fetch_config *config,
> +			 struct strmap *delayed_ref_display)
>   {
>   	int retcode, cannot_reuse;
>   
> @@ -1515,7 +1612,7 @@ static int backfill_tags(struct display_state *display_state,
>   	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>   	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>   	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
> -					 fetch_head, config);
> +					 fetch_head, config, delayed_ref_display);
>   
>   	if (gsecondary) {
>   		transport_disconnect(gsecondary);
> @@ -1641,6 +1738,7 @@ struct ref_rejection_data {
>   	bool conflict_msg_shown;
>   	bool case_sensitive_msg_shown;
>   	const char *remote_name;
> +	struct strmap *delayed_ref_display;
>   };
>   
>   static void ref_transaction_rejection_handler(const char *refname,
> @@ -1653,6 +1751,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>   					      void *cb_data)
>   {
>   	struct ref_rejection_data *data = cb_data;
> +	struct ref_update_display_info *info;
>   
>   	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
>   	    !data->case_sensitive_msg_shown) {
> @@ -1681,6 +1780,10 @@ static void ref_transaction_rejection_handler(const char *refname,
>   			      refname, ref_transaction_error_msg(err));
>   	}
>   
> +	info = strmap_get(data->delayed_ref_display, refname);
> +	if (info)
> +		ref_update_display_info_set_failed(info);
> +
>   	*data->retcode = 1;
>   }
>   
> @@ -1690,6 +1793,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>    */
>   static int commit_ref_transaction(struct ref_transaction **transaction,
>   				  bool is_atomic, const char *remote_name,
> +				  struct strmap *delayed_ref_display,
>   				  struct strbuf *err)
>   {
>   	int retcode = ref_transaction_commit(*transaction, err);
> @@ -1701,6 +1805,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
>   			.conflict_msg_shown = 0,
>   			.remote_name = remote_name,
>   			.retcode = &retcode,
> +			.delayed_ref_display = delayed_ref_display,
>   		};
>   
>   		ref_transaction_for_each_rejected_update(*transaction,
> @@ -1729,6 +1834,10 @@ static int do_fetch(struct transport *transport,
>   	struct fetch_head fetch_head = { 0 };
>   	struct strbuf err = STRBUF_INIT;
>   	int do_set_head = 0;
> +	struct strmap delayed_ref_display = STRMAP_INIT;
> +	int summary_width = 0;
> +	struct strmap_entry *e;
> +	struct hashmap_iter iter;
>   
>   	if (tags == TAGS_DEFAULT) {
>   		if (transport->remote->fetch_tags == 2)
> @@ -1853,7 +1962,7 @@ static int do_fetch(struct transport *transport,
>   	}
>   
>   	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
> -				   &fetch_head, config)) {
> +				   &fetch_head, config, &delayed_ref_display)) {
>   		retcode = 1;
>   		goto cleanup;
>   	}
> @@ -1876,7 +1985,7 @@ static int do_fetch(struct transport *transport,
>   			 * the transaction and don't commit anything.
>   			 */
>   			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
> -					  &fetch_head, config))
> +					  &fetch_head, config, &delayed_ref_display))
>   				retcode = 1;
>   		}
>   
> @@ -1886,8 +1995,12 @@ static int do_fetch(struct transport *transport,
>   	if (retcode)
>   		goto cleanup;
>   
> +	if (verbosity >= 0)
> +		summary_width = transport_summary_width(ref_map);
> +
>   	retcode = commit_ref_transaction(&transaction, atomic_fetch,
> -					 transport->remote->name, &err);
> +					 transport->remote->name,
> +					 &delayed_ref_display, &err);
>   	/*
>   	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
>   	 * continue to fetch head and perform other post-fetch operations.
> @@ -1965,7 +2078,17 @@ static int do_fetch(struct transport *transport,
>   	 */
>   	if (retcode && !atomic_fetch && transaction)
>   		commit_ref_transaction(&transaction, false,
> -				       transport->remote->name, &err);
> +				       transport->remote->name,
> +				       &delayed_ref_display, &err);
> +
> +	/*
> +	 * Clear any pending information that needs to be shown to the user.
> +	 */
> +	strmap_for_each_entry(&delayed_ref_display, &iter, e) {
> +		struct ref_update_display_info *info = e->value;
> +		ref_update_display_info_display(info, &display_state, e->key, summary_width);
> +		ref_update_display_info_free(info);
> +	}
>   
>   	if (retcode) {
>   		if (err.len) {
> @@ -1980,6 +2103,8 @@ static int do_fetch(struct transport *transport,
>   
>   	if (transaction)
>   		ref_transaction_free(transaction);
> +
> +	strmap_clear(&delayed_ref_display, 1);
>   	display_state_release(&display_state);
>   	close_fetch_head(&fetch_head);
>   	strbuf_release(&err);
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 45595991c8..29e2f17608 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
>   
>   		tagsha=$(git rev-parse test^{tag}) &&
>   		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
> +		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
>   		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
>   	)
>   '
> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index 5883839a04..22bfc0c74d 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -40,8 +40,8 @@ test_expect_success 'fetch aligned output' '
>   		grep -e "->" actual | cut -c 22- >../actual
>   	) &&
>   	cat >expect <<-\EOF &&
> -	main                 -> origin/main
>   	looooooooooooong-tag -> looooooooooooong-tag
> +	main                 -> origin/main
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -55,8 +55,8 @@ test_expect_success 'fetch compact output' '
>   		grep -e "->" actual | cut -c 22- >../actual
>   	) &&
>   	cat >expect <<-\EOF &&
> -	main       -> origin/*
>   	extraaa    -> *
> +	main       -> origin/*
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -103,15 +103,15 @@ do
>   		cat >expect <<-EOF &&
>   		- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
>   		- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
> -		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
>   		! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
> +		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
> +		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
> +		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
> +		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
>   		* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
>   		  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
> -		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
> -		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
>   		  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
> -		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
> -		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
> +		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
>   		EOF
>   
>   		# Change the URL of the repository to fetch different references.
> @@ -179,8 +179,8 @@ test_expect_success 'fetch porcelain overrides fetch.output config' '
>   	new_commit=$(git rev-parse HEAD) &&
>   
>   	cat >expect <<-EOF &&
> -	  $old_commit $new_commit refs/remotes/origin/config-override
>   	* $ZERO_OID $new_commit refs/tags/new-commit
> +	  $old_commit $new_commit refs/remotes/origin/config-override
>   	EOF
>   
>   	git -C porcelain -c fetch.output=compact fetch --porcelain >stdout 2>stderr &&
> 

