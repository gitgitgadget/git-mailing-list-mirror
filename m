Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DF25B083
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871375; cv=none; b=V3pJYEvMKwbbzND6FhXbYtlGa3uF5q6mYcLrDSle7uHAyrKI9YmaF29TbW5ONvbFX+sn/g/MnDM5q7e7InpOAlzteoeOmKWXjesbCqNWkKiL6dcn401iCX2PzE7dYZIbJq1OV6eMbf5ZtUVDre2L+u2KV8hqYfgqn37WpuXpT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871375; c=relaxed/simple;
	bh=TrX6sezLssPE8DW8/aKT9L+/OyqSGUSvjiraaR5ww/g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=F7ijXSXw3epwCetElWFRAS1MxTUkcRcC/d+i+xobNpk0lznf5jus/Q/8jP8wUG+Kta9eMSMEJaBrgLj8rR/Zjx3Gfia3XS95v7ik/1OJXZZgkW+xuQTkGNLWOKc3QEA/H0Ktw51DrACagyVJKgP3wX2C77v7XI5g1COpWfimXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx3lzEW/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx3lzEW/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1245126f8f.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783871372; x=1784476172; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=51xr8bL/xng7vcjc4jmvFuX+Kd5sEh0EYUBACBR6s5U=;
        b=bx3lzEW/B4gFPjQ35Ooczi0oh3LJqeBUwYlUYYpNuYw2gTz/cNYHndtzhefT5HyeVJ
         to2X/RPLMupt5yIDgxMM9mIJl3cSDSrynjK8pFbB92eVV9+PZ0l1wCdswEJ+7ntp8AH5
         SS/VLjBcnZMXAPOT/Vo6YwQq8cdUUB6bnbPu+hVLxvDt5T30IM0z3FP3f/KRG+X/Aga1
         b05SHcmPMLv6jC2RL6AXimjRpcKvbKW0UpKMMjkD0IuBbd4typIqE3Wu4qp0HJI1rlcE
         NGwCKXPA4SLWwk1pwbEWJCssjW7Y+Ra+HNftemr/Hu7kkfncLHA+ROCC1r15dvzlhpF+
         2CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871372; x=1784476172;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51xr8bL/xng7vcjc4jmvFuX+Kd5sEh0EYUBACBR6s5U=;
        b=G7abSpd1BvVZwTjeUjml9yA79gIIevszptANWJBbzB3YscK+BLr0uMYpWJQDWnaerr
         6D7A6rJ6RPliVpAg1WpBhKk/afVeLeYtyetwLeO82q2hayT28rsAivTNGBuH1d8pOTPE
         IEKZkPtEpiC4f/eK6Sqg31xUS9UQjWx+qS5EmGs88aRbukWidMbsVMR3QUEBZ0D39+og
         LsyA1mhTwXddBG05XsWZKjWg9ao93Z/YXctGK9BQ2O9h5aL9o0rkcVMLQJHtKad5os6e
         gt7DKx8CPrtnZ4sQvOdsjs8lgBaVGTdn/nOS6WdCAyJXqNkkHxnwb1WV09MBA15vsHKA
         1/3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqB+DHC1XdeoCLY/BGgVaAv8RKUFkWVAmY2NCcPCrSezYddcbHvu4yX4ro1IxGLmQqiLHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWS39OMRG6Vua7u+kZikALL1lisA47nkirot/D2PDzKnODrGuy
	BRVIBKgheyqFJ5rbwrYJLinyGwoSbXFAovQxraXyk7Qcsg6oYZTsYSb8SjDequJV
X-Gm-Gg: AfdE7cnFx4V1VMSMfHYIL8PB1NFdyzR5u2ePvqPghMSCgjdn04nL/bB5gWg9IdKjvB8
	NmQ7NRXEN/IgUAL2xA7TKMFdUNTPwSAiq3AFwh8oEAqD6CcY6LAjEqx/4IYBf5OZKH1s1kOb0O7
	VjTUsnMFf545Sc0Lp1EPxECLvrbxfkoto9shUvhJn3vqa88hq8DY5AUvwGBO2hvU4ntL8BbERJz
	fbT41m1/4yfmHpa9S7k6gM2HzCUKkG7bLLrk8c6HFpC0rkX+LWlo0OorFz3BBXr5iSHx10FI0hs
	10Fkt8XnERsy617KlI1gF1ItFA3+eFCc+CwTqYhP6+Pe3LkKpzoNPW1w2sm34vDNCxG1yGrzCDV
	7CZ+I10fzmeuQ1XQBzcGqi9tL+oPj7yXNb0XWWy1HB+1n3p0VwrEdtGqlNPk2YBGh3iuj/DVW0v
	/kOl4ildukaO3pBttzsimMjPJRcVUmRceIi++6n090v44JgcCizZaM6Y1R6njqhwXgNYlzglz6V
	JSkEVIsKkwDsMJohjlubrvF4wLYA8GGnKW0e6R5D3xhweTpahpuZxK8zxH4/UDIEkEKYPCcocNI
	o5CXXCkiZNfP0iLcp4yVmdD1sxUgipF63wlF/8gWKvVBHlkYAIf2LRGNHOIkb8uaRfHugg==
X-Received: by 2002:a05:6000:4020:b0:474:d7a5:4b7a with SMTP id ffacd0b85a97d-47f2dcd7881mr6492440f8f.28.1783871371923;
        Sun, 12 Jul 2026 08:49:31 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm72703376f8f.30.2026.07.12.08.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 08:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 17:49:30 +0200
Message-Id: <DJWPMI6GXV28.1LRVLX04M49GC@gmail.com>
Subject: Re: [PATCH v10 7/9] environment: move push_default into
 repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
Cc: <pabloosabaterr@gmail.com>, <cirnovskyv@gmail.com>,
 <szeder.dev@gmail.com>, "Christian Couder" <christian.couder@gmail.com>,
 "Ayush Chandekar" <ayu.chandekar@gmail.com>, "Olamide Caleb Bello"
 <belkid98@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-8-cat@malon.dev>
In-Reply-To: <20260712111734.1073514-8-cat@malon.dev>

On Sun Jul 12, 2026 at 1:17 PM CEST, Tian Yuchen wrote:
> The global variable 'push_default' specifies the default behavior of
> 'git push' when no explicit refspec is provided. Move 'push_default'
> into 'struct repo_config_values' to continue the libification effort.
>
> While 'enum push_default_type' ideally belongs in 'remote.h', moving it
> there introduces a circular dependency chain:
>
>   remote.h -> hash.h -> repository.h -> environment.h.
>
> Therefore, the enum definition is kept in 'environment.h' just above
> 'struct repo_config_values' with a NEEDSWORK comment for future cleanup.
>
> Modify the configuration parsing in environment.c to update the
> per-repository structure directly, and update caller across the
> codebase to access the value via 'repo_config_values()'.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  builtin/push.c |  8 ++++----
>  environment.c  | 16 +++++++++-------
>  environment.h  | 26 ++++++++++++++++----------
>  remote.c       |  2 +-
>  4 files changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 6021b71d66..6dc3224b60 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -88,7 +88,7 @@ static void refspec_append_mapped(struct refspec *refsp=
ec, const char *ref,
>  		}
>  	}
>
> -	if (push_default =3D=3D PUSH_DEFAULT_UPSTREAM &&
> +	if (repo_config_values(the_repository)->push_default =3D=3D PUSH_DEFAUL=
T_UPSTREAM &&

Can we extract cfg from repo_config_values() to shorten this line?
If we look at the hunk below, we can see this pattern. let's do the
same.

>  	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
>  		struct branch *branch =3D branch_get(branch_name);
>  		if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
> @@ -160,7 +160,7 @@ static NORETURN void die_push_simple(struct branch *b=
ranch,
>  	 * Don't show advice for people who explicitly set
>  	 * push.default.
>  	 */
> -	if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
> +	if (cfg->push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
>  		advice_pushdefault_maybe =3D _("\n"
>  				 "To choose either option permanently, "
>  				 "see push.default in 'git help config'.\n");
> @@ -232,7 +232,7 @@ static void setup_default_push_refspecs(int *flags, s=
truct remote *remote)
>  	const char *dst;
>  	int same_remote;
>
> -	switch (push_default) {
> +	switch (repo_config_values(the_repository)->push_default) {
>  	case PUSH_DEFAULT_MATCHING:
>  		refspec_append(&rs, ":");
>  		return;
> @@ -252,7 +252,7 @@ static void setup_default_push_refspecs(int *flags, s=
truct remote *remote)
>  	dst =3D branch->refname;
>  	same_remote =3D !strcmp(remote->name, remote_for_branch(branch, NULL));
>
> -	switch (push_default) {
> +	switch (repo_config_values(the_repository)->push_default) {
>  	default:
>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:
> diff --git a/environment.c b/environment.c
> index 41ba013c86..0080012f31 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -59,7 +59,6 @@ enum eol core_eol =3D EOL_UNSET;
>  int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
>  char *check_roundtrip_encoding;
>  enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
> -enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
>  #ifndef OBJECT_CREATION_MODE
>  #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
>  #endif
> @@ -621,21 +620,23 @@ static int git_default_branch_config(const char *va=
r, const char *value)
>
>  static int git_default_push_config(const char *var, const char *value)
>  {
> +	struct repo_config_values *cfg =3D repo_config_values(the_repository);
> +
>  	if (!strcmp(var, "push.default")) {
>  		if (!value)
>  			return config_error_nonbool(var);
>  		else if (!strcmp(value, "nothing"))
> -			push_default =3D PUSH_DEFAULT_NOTHING;
> +			cfg->push_default =3D PUSH_DEFAULT_NOTHING;
>  		else if (!strcmp(value, "matching"))
> -			push_default =3D PUSH_DEFAULT_MATCHING;
> +			cfg->push_default =3D PUSH_DEFAULT_MATCHING;
>  		else if (!strcmp(value, "simple"))
> -			push_default =3D PUSH_DEFAULT_SIMPLE;
> +			cfg->push_default =3D PUSH_DEFAULT_SIMPLE;
>  		else if (!strcmp(value, "upstream"))
> -			push_default =3D PUSH_DEFAULT_UPSTREAM;
> +			cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
>  		else if (!strcmp(value, "tracking")) /* deprecated */
> -			push_default =3D PUSH_DEFAULT_UPSTREAM;
> +			cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
>  		else if (!strcmp(value, "current"))
> -			push_default =3D PUSH_DEFAULT_CURRENT;
> +			cfg->push_default =3D PUSH_DEFAULT_CURRENT;
>  		else {
>  			error(_("malformed value for %s: %s"), var, value);
>  			return error(_("must be one of nothing, matching, simple, "
> @@ -727,6 +728,7 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  	cfg->askpass_program =3D NULL;
>  	cfg->apply_default_whitespace =3D NULL;
>  	cfg->apply_default_ignorewhitespace =3D NULL;
> +	cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> diff --git a/environment.h b/environment.h
> index 553f87adee..6a5c8bd06f 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -87,6 +87,21 @@ extern const char * const local_repo_env[];
>  struct strvec;
>
>  struct repository;
> +
> +/*
> + * NEEDSWORK: It would be better if these definitions could be moved to
> + * other more specific files, but care is needed to avoid circular
> + * inclusion issues.
> + */
> +enum push_default_type {
> +	PUSH_DEFAULT_NOTHING =3D 0,
> +	PUSH_DEFAULT_MATCHING,
> +	PUSH_DEFAULT_SIMPLE,
> +	PUSH_DEFAULT_UPSTREAM,
> +	PUSH_DEFAULT_CURRENT,
> +	PUSH_DEFAULT_UNSPECIFIED
> +};
> +
>  struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
> @@ -96,6 +111,7 @@ struct repo_config_values {
>  	char *askpass_program;
>  	char *apply_default_whitespace;
>  	char *apply_default_ignorewhitespace;
> +	enum push_default_type push_default;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> @@ -197,16 +213,6 @@ enum rebase_setup_type {
>  };
>  extern enum rebase_setup_type autorebase;
>
> -enum push_default_type {
> -	PUSH_DEFAULT_NOTHING =3D 0,
> -	PUSH_DEFAULT_MATCHING,
> -	PUSH_DEFAULT_SIMPLE,
> -	PUSH_DEFAULT_UPSTREAM,
> -	PUSH_DEFAULT_CURRENT,
> -	PUSH_DEFAULT_UNSPECIFIED
> -};
> -extern enum push_default_type push_default;
> -
>  enum object_creation_mode {
>  	OBJECT_CREATION_USES_HARDLINKS =3D 0,
>  	OBJECT_CREATION_USES_RENAMES =3D 1
> diff --git a/remote.c b/remote.c
> index 00723b385e..d48c01d375 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1933,7 +1933,7 @@ static char *branch_get_push_1(struct repository *r=
epo,
>  	if (remote->mirror)
>  		return tracking_for_push_dest(remote, branch->refname, err);
>
> -	switch (push_default) {
> +	switch (repo_config_values(repo)->push_default) {
>  	case PUSH_DEFAULT_NOTHING:
>  		return error_buf(err, _("push has no destination (push.default is 'not=
hing')"));
>

I haven't checked how doable fixing the dependency cycle of the
NEEDSWORK is.

Similar to other patches where we add repo_config_values() to functions
that didn't have it before. We need to check that there's no caller that
could pass a repository different from the_repository. I haven't checked
it this time.

Regards,
Pablo
