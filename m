Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF7149DF1
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866707; cv=none; b=Z8md0Wylk4JqU470OIh4Y7BlSkNizWjYrTy09iG8QDSsr69gphJ73pwF/14KMmQQy+0h+Ig0N4S2hZIaeUA40izmb28hfu6xTJpy+b9NMElIXbfxKfS9Hz9znGbksIgrfaWZLiRCTLXa8uAT9YBEOVCdM3KDEwa38oLtSYgGT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866707; c=relaxed/simple;
	bh=Mx8Bgjw0UsGTs4rEAMVDIb3CZUjSc9c5s6xNy7XlKTY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cf4Zd1J5flvV6tkpn8FIV5IgGSzAhRE5v60fmlhCZnm8W4el75Hx0bC08fKaX9vZmFERPJ4MP9L/rIa+0Jz9UnS2bHjG+rV8chXB32A591hpQBywYVFa78HWy4LhncuOY4SOoq5n+cQX94to9KzJXD8UorNHq/8hT2bivebFLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1BpsNdu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1BpsNdu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f18d92172aso31450526d6.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783866705; x=1784471505; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TtmXn5csb5x4CG6Djg7CzI6MhwgN9R5r9AqYVyZ/KjU=;
        b=X1BpsNdu+7ooQZWF8IqT3QTyUwg0y9U6ATLeqRmr/EAd4y2g8x15XapYa0/Hh3KxKe
         XiPe2XYbG7nFB+zTmvfFl3IYMy5pTCpsRewoIlCdSlIXmUeLiPYAbuHkUilMqYTfATG/
         vjVlVPCENjAxMwntfrkf1ZbyQ1Y6gea+hHhCIr+n3EBagCau+vfGg3PhkQkvXH9wq8Qr
         I3HR2h/NQ+CkqweSkOu43iq5NwHT5gg1DRLhLTak/WzUpXkAgqmOpIrUPQzApAQyJ5dv
         FqTnK7/G+znjMADkEuAKiDvQnw6MnfuyuOjdH1bdqEatWy1eqURss+oUSG32c2GSHIlK
         BPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783866705; x=1784471505;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtmXn5csb5x4CG6Djg7CzI6MhwgN9R5r9AqYVyZ/KjU=;
        b=XLc74oMuvoMMnnFSi0H6GTlsIxsivfYwy12/VOAVmEPAwXEgJYLD7/8D8Uqb5Z4tg8
         LgPB/5dwBDt1Nxvz5OFpZDUP2qJtgIujTjyguFYFsMDXpTpY9keHqDZFnaEjugngFx53
         deG3myRyQQ3MyXkxW0fL2S+VKkf68Mc0WtCLCiybiHih3sUMI7z+MCjAgbDgm504TP/+
         bG9naelbXkKl1rdOmYXL4lHshnoEkdnVZQuloz2BBXpFwm688mwGgIbsJHIO+HXVznt0
         X1C499j6LDQ8cGUSLTeNO7IbdaEbuvs503GLo07nzwXlFNCUHmaGJlYPfFEJwRBQqBfn
         ACEw==
X-Forwarded-Encrypted: i=1; AHgh+RoMzmY9uGs8pwT2b70WV6+5PCdP5RQ2Rjf1gRVODBAAawC48j+WetxCLz0ioxZ4/Zuo5Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQy7gqU1gEelU/+GcR4CT+N8l5q/yWugVmXhP/A1oUPoVWAFlB
	jMyKdpcpiRrhOD8fuaCugw1b7EXncKmpRLiXZx3P027XoMJXdCDdXewD
X-Gm-Gg: AfdE7ckxKAD7l3br9afTcmYnO8LuJ8/wqsItSBuEtBCRVBD0AFFU8cn6bhYZSucemR5
	eRqwmb/23nVtmub0xvzzyHnm0jKu1wpPrJBpSB+4R1DBjOadBFwl4c+WQyPHLXdhaWfqd45S4k1
	AGQDxXyLYqGCVafTthiyY/EAjXZ7YROKu59jLrYEc/UdC8QLrQTv5iCjdp4LIumgeZlRsCW6wTC
	6iFgHWRDYQnOAR/SkEljSJxXqMiB+VwFdk9+P0h7hODy/hogN0LvnqqKr/IRDNfjGL69CrkM0k1
	3YWgfBQgRUR7iNn6xWDj5bnO1iCgIC/hejVeHemTpxqsu/2wLyS3LMIo7Iy6BisaW59xTZFPjV4
	CHDl27mcMk4ZPUG2r9PQowpVi+JmH58YO5f2x8InGV880/EXz7Jq8wz3YWiPh/LdNhtd2Mfrs3d
	8gnu67w1bqPUUPU8BBrCudmn+kXqq9450fvw6/i2dek0uP2twsfTCLeZrSOkR3Mq7yn0NZOfcNU
	pBSaNL348tZ4yrDp4TfKGCrCUIZkKQ83b/era3LB0iq9Cp1bM5Mnd4EiFAQtwAMzer9/Jj1iqat
	LYtVILxzmiF3c+k6ih52bsJEr9RPnmqNAkm47SyyH4YbnxpadPIRfMHFb9TSK0MB9+3UmQ==
X-Received: by 2002:a05:620a:6cca:b0:92e:4687:b84c with SMTP id af79cd13be357-92ef2b2faa5mr613256585a.25.1783866704923;
        Sun, 12 Jul 2026 07:31:44 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfacb3sm838046385a.26.2026.07.12.07.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 07:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 16:31:41 +0200
Message-Id: <DJWNYXB8MWLC.2PYST8ANV51MB@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
Cc: <pabloosabaterr@gmail.com>, <cirnovskyv@gmail.com>,
 <szeder.dev@gmail.com>, "Christian Couder" <christian.couder@gmail.com>,
 "Ayush Chandekar" <ayu.chandekar@gmail.com>, "Olamide Caleb Bello"
 <belkid98@gmail.com>
Subject: Re: [PATCH v10 5/9] environment: move askpass_program into
 repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-6-cat@malon.dev>
In-Reply-To: <20260712111734.1073514-6-cat@malon.dev>

On Sun Jul 12, 2026 at 1:17 PM CEST, Tian Yuchen wrote:
> The global variable 'askpass_program' stores the path to the program
> used to prompt the user for credentials. Move it into repo_config_values
> to continue the libification effort.
>
> While it is uncommon for a single process to require different askpass
> programs for different repositories, maintaining this value as a mutable
> global string is a blocker for libification. Global heap-allocated
> strings introduce thread-safety issues in a multi-repo environment.
>
> Move 'askpass_program' into 'struct repo_config_values' to eliminate
> this global state. The memory is now safely managed and freed via
> 'repo_config_values_clear()'.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 6 ++++--
>  environment.h | 1 +
>  prompt.c      | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 975c9cb9eb..1a26c9c6d6 100644
> --- a/environment.c
> +++ b/environment.c

I think that the drop of the global variable is missing.

> @@ -464,8 +464,8 @@ int git_default_core_config(const char *var, const ch=
ar *value,
>  	}
>
>  	if (!strcmp(var, "core.askpass")) {
> -		FREE_AND_NULL(askpass_program);
> -		return git_config_string(&askpass_program, var, value);
> +		FREE_AND_NULL(cfg->askpass_program);
> +		return git_config_string(&cfg->askpass_program, var, value);
>  	}
>
>  	if (!strcmp(var, "core.excludesfile")) {
> @@ -726,6 +726,7 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  	cfg->excludes_file =3D NULL;
>  	cfg->editor_program =3D NULL;
>  	cfg->pager_program =3D NULL;
> +	cfg->askpass_program =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -744,4 +745,5 @@ void repo_config_values_clear(struct repo_config_valu=
es *cfg)
>  	FREE_AND_NULL(cfg->excludes_file);
>  	FREE_AND_NULL(cfg->editor_program);
>  	FREE_AND_NULL(cfg->pager_program);
> +	FREE_AND_NULL(cfg->askpass_program);
>  }
> diff --git a/environment.h b/environment.h
> index 39b6691b47..a2e9def89d 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -93,6 +93,7 @@ struct repo_config_values {
>  	char *excludes_file;
>  	char *editor_program;
>  	char *pager_program;
> +	char *askpass_program;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> diff --git a/prompt.c b/prompt.c
> index 706fba2a50..d8d74c7e37 100644
> --- a/prompt.c
> +++ b/prompt.c
> @@ -3,6 +3,7 @@
>  #include "git-compat-util.h"
>  #include "parse.h"
>  #include "environment.h"
> +#include "repository.h"
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "prompt.h"
> @@ -51,7 +52,7 @@ char *git_prompt(const char *prompt, int flags)
>
>  		askpass =3D getenv("GIT_ASKPASS");
>  		if (!askpass)
> -			askpass =3D askpass_program;
> +			askpass =3D repo_config_values(the_repository)->askpass_program;
>  		if (!askpass)
>  			askpass =3D getenv("SSH_ASKPASS");
>  		if (askpass && *askpass)

The rest LGTM.

Regards,
Pablo
