Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF021E0AF
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751095975; cv=none; b=oteYYu0CY3e3OeZK2e/8vtrvJMGDpqzws1aLmEDhgzcWtU5JwbE3D0QFjeIdljB+IvNs5UEqHThz53vrqh3aYn4hfrmHcF2mfGFk/jmCA2hnDUmazAyQPcaoWd3dkj1l5yBls4nd2WCQCWgiXZPJ0346ge7xnbUurJYexRK9Sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751095975; c=relaxed/simple;
	bh=82dzFa4Y59nIO6IFFYM+42dbVNRzFysVhl+WO3A5Y7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmD8tf+fQjfqC/2/VyvnSHIily1XTusj5OmuIZWKQeJLxDzI+BQ7L7+ccyLgH+f1658TUdkk4wAmTsvlPm/qzvZa9bQGRXj0dcH2940j+ZntGrt2kSRLdcw8V3sDVakL/QW46Q0qyev4h8hEKDMlFreE7vH3QAUddkv69huoXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqx7urjG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqx7urjG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2fd091f826so2802160a12.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751095974; x=1751700774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvDqu18F5ivo8LU2ag6Cri2uaRqTQbDKAaRL7wtTL2w=;
        b=Rqx7urjGZq7FHnHe9rv/ta9tfZmbzsjZPsfiDczzjnA/PdEzvBSkmVNjN6fbnpXNPT
         ueTz+NMYN3Vv1sm/e4vXfmVddzCTbgI4bk//QnHdWjZH0+6sX/PKWSRvhnV6SgmS1c+B
         RGdpJI/cPv+IgJ7+ODr36+4lWMMiDaIs2hDDquRbuSAxEvJJt0pkqggcGmAjXzXu2+Z7
         WGcA0jubdabxNu0gp9xal/zkvncdC29ZjJ3ngPo3aHeAYSZAj35T4wqza6mpshkyRwXj
         co3I/ChMRZUDJagcLdNqR/9f5l1OQuMdCVgGQcAe6h5JTv4sRIurupdXVqkB+wjP2jP5
         VzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751095974; x=1751700774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvDqu18F5ivo8LU2ag6Cri2uaRqTQbDKAaRL7wtTL2w=;
        b=J9p7jHDIMkCra0Rj3cjS1qgKlS4tTKDmNqfZNEzVyWD+iqcxfx5nTLKKaHsuK5UK+4
         LWNyxJmOR9FqxGfgmH0XrvckMvMLRJD+jFiispF1NK0UwF+n8zx8fexHhP9o4LJsiQQS
         QxFmv3YU7+d5wNNfXj2seQifYaCiOiZshvQN0UtiAZRgSjWltW9iU8NLbA68dbQ3BXQu
         zEnG0M6A646kMqpO7mkr5FKwJTqWSrDxEZjPE5grj5HvGiYC0DmuxQVCsbCgP1kulh4w
         piQFTL0LYL2Kx2hqw96KsjTiREOqinQeqAJvRf2lKnbg8k7udSNPeY1CrNpg2yMUhtEP
         TSzQ==
X-Gm-Message-State: AOJu0YyOHuCzU/YFMEK0NJ0EN/np4+mTMQo2y7DgUiizRso42rFOeMup
	WyMTVuZAIpAoCc3uOTkJAj8WLinNv09KPPjtkiXpM73SJ1ZoMBJwivsqNac7nQ==
X-Gm-Gg: ASbGnctOVGUoWGqyTTkH70wYHk8QV+X0ZEJKUTIpGtOKRVU9N5YDdmiPxCSKzKcUAGu
	haxtB7u81XNjhRsQ0O6nR6Ed4AUlk+TLIh5XxgFAXBTbbVNO3nb6OukFu8M8SnCrqpa8rqybb1T
	JFsRN2Ojg8tL9DdytApbpNX+zaytDBhKmNxc1iKhF0DQe2jVNeq21J+7Xw77aSd+jWPi1cQECz9
	MIkTq8pbXlWi+P1eLKaYeCs0mDBKCx8BG1kKNVGFEP8/yLBBonRqiUdGZRzj02Odq1NcVNG4WkA
	jcsyocQHnpgZQDVtcDXp70sTnWGrE2qUYKhsPxXG8I6AQ97ZTQHsJWIJXA==
X-Google-Smtp-Source: AGHT+IErDs779eX026+sSFY4q98cUgGnwiIYQRoRTjz0j37ihfWCuh+p8Zn6qN4ZptDnyHRIzuPMOQ==
X-Received: by 2002:a17:903:4b08:b0:236:10b1:50cb with SMTP id d9443c01a7336-23ac70e0c14mr94692775ad.26.1751095973591;
        Sat, 28 Jun 2025 00:32:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b871csm31831285ad.187.2025.06.28.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 00:32:52 -0700 (PDT)
Date: Sat, 28 Jun 2025 15:33:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 2/2] builtin/prune: stop depending on
 'the_repository'
Message-ID: <aF-asGE-cX8IpAae@ArchLinux>
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
 <9b274efd7dfde90990ace66bfbe5f7e3b6ce30d1.1749343601.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b274efd7dfde90990ace66bfbe5f7e3b6ce30d1.1749343601.git.ayu.chandekar@gmail.com>

On Sun, Jun 08, 2025 at 06:36:35AM +0530, Ayush Chandekar wrote:

[snip]

> @@ -99,7 +98,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
>  	if (st.st_mtime > expire)
>  		return 0;
>  	if (show_only || verbose) {
> -		enum object_type type = oid_object_info(the_repository, oid,
> +		enum object_type type = oid_object_info(revs->repo, oid,
>  							NULL);

Could we simply make `NULL` in the same line by the way? The readability
would be better.

>  		printf("%s %s\n", oid_to_hex(oid),
>  		       (type > 0) ? type_name(type) : "unknown");
> @@ -154,7 +153,7 @@ static void remove_temporary_files(const char *path)
>  int cmd_prune(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> -	      struct repository *repo UNUSED)
> +	      struct repository *repo)
>  {
>  	struct rev_info revs;
>  	int exclude_promisor_objects = 0;
> @@ -173,19 +172,19 @@ int cmd_prune(int argc,
>  	expire = TIME_MAX;
>  	save_commit_buffer = 0;
>  	disable_replace_refs();
> -	repo_init_revisions(the_repository, &revs, prefix);
> +	repo_init_revisions(repo, &revs, prefix);
>  
>  	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
>  
> -	if (the_repository->repository_format_precious_objects)
> +	if (repo->repository_format_precious_objects)
>  		die(_("cannot prune in a precious-objects repo"));
>  
>  	while (argc--) {
>  		struct object_id oid;
>  		const char *name = *argv++;
>  
> -		if (!repo_get_oid(the_repository, name, &oid)) {
> -			struct object *object = parse_object_or_die(the_repository, &oid,
> +		if (!repo_get_oid(repo, name, &oid)) {
> +			struct object *object = parse_object_or_die(repo, &oid,
>  								    name);

Same, could we just make `name` in the same line. There is no need for
the newline right now as we change "the_repository" to "repo" which
would reduce some columns.

Thanks,
Jialuo
