Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCF41D11D
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877996; cv=none; b=aMsCRiBRuLYuwfnVD3ItgeJDgw5fc6E2SVxgybB/QDWt1jBiQrjcxxCjoIwPBThjXTOfRao0YTsq6waJGqxJpOU09z7RkQCk8HG3HvQ/zPZSB4+OZJ2lEGGiIlZtXGAxj4Ezu/12wBi/AoyLvZCbnOeNUAXzTK1ZJ5kndcqTlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877996; c=relaxed/simple;
	bh=nspCqJ82i3Fc/uG0Pk+v18oJvahaK6p4+3yHD14dThk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eolCpZEptCIZK6B2qYZj8cuB3kr2lZcky+bHNoMN8d3Orc43sbuGmm1Dho7GdTETdR4FCaE4l4ZbcwJky8/aXKjq/1QP6fuJX9oo+u4cuNUS5Ut8vGlvxUVcAK/2lRYSfjsgBfUp7gf8LfD0uSulYOu1FCqi2cc3SqA5yOcD5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK5R/6LA; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK5R/6LA"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6682259cae6so276273d50.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877994; x=1786482794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AwAVb3ZHVJYjd++D4nUkHeeceN/8bwcqNgjGunbYTQ=;
        b=oK5R/6LAFYFWPC3MVDG+gR+OAfebTlxJYtNW0u5u8punEhy8iGpEHKsbzSdKNni45d
         03NT1yWEQsKi7MvvkKGZ8vuZX/wYx/5slX5oikUrsKlEDUT4vtLLuQnliCFzdPjkFDhX
         /ZC2A2C6HqBU0mTTMF31QY+f+bpRIR+XHzr9OV6YSLbG7g0E0u3aR88KGMwQKIs6+uRH
         RBfbv9hp2N0USlY8xBGXx4xeMSv3cnQXn6b1Vhwex3CLqe0eVpzZrLRTaeWRbzVu4dkh
         YG0H79HXFatxWBrZXD/F34gA0kKUx4AfpSfYM1P5dkTf9bjin0muIfFKKiA/o4nWfZBg
         eZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877994; x=1786482794;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AwAVb3ZHVJYjd++D4nUkHeeceN/8bwcqNgjGunbYTQ=;
        b=bn5FyjF75KbBkVJa/J7vNnEgea1Gxx6Fxa8K1dEV9N3z2xE3Tig4IpSl0Jm73EM6eH
         hHYiMerlQHIXp1pIVD2l3v3TXYBrw3Zz7SNVV8SmoAysVThd3FNpWvAJxxhNkeYCmh/f
         yFNvy1KQTkTevAzCpoYFa9LY1o2BrFu1xA3L/WmE+/IZ9KdmJSWfwx5AvY7U7DXDH6sw
         MuoogXHSZhDmC44Pb5sGcNm2en5N/odyZKoO6SLtw6ajNqNyaEtRNKzObCPGhUiU4Y1C
         R87aGGh7yOaF43+LOSPXMaLJYng1RcHxHFMCebD3W0ViFzEg4efGxV2pYAUfmcIfZjd6
         t6tw==
X-Forwarded-Encrypted: i=1; AHgh+RqwvjJvfz6P3oeydA5h9liKn7q63TWl67ReexClXMIfjd2Ufl3UkfRP3IbmsCZQzq2Y7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrW3Xg8wt0cyFhNnj/4DyKeWrPCEjkYIcsvC+PZ+rAPE6gbxd
	567Zo1DuxM7mOZ7WnNJAWFPtdlXZLCN1xl3onXTpMoJ0ry8EfzP1kQpv
X-Gm-Gg: AR+sD11hqLVFNLNFpXek0MUeSVWxRFbhcY/I/eCUKzqLV4kCpnY3BUfKte8KZv4xu4q
	IOuOHLfmkLuqVYIiG1XmvLtj1NS+jLc/MXk0DgK+nx0+CxToG7DnFkJcs/008yGG9AJBEyDpgrJ
	gW8WIuSgmP4/yzxxrVz/UYQcKJpmjFb62qRD6o6xu4PkRtXSy3me5BQibQ06VD63UdTunyYyG60
	MqpEZaPW2ncYGm+0ZLqJNH2DEu82Q5zv8NzpXxD5o+NHXlh6Yjj5rM9WVUMChDI93slOuDUsDbm
	QHwnTCTUQ+B+hCnZBeTiyNA758RMGCWwibhdPOGaUyd7Ov6sDN3l6LWgi6g96rNJ1Jd6uHpwfvb
	XCOsM+6ulfAtfPxtUBFx3J3nt0yIoHMYi9nnYymH2hKg+JPhdyxunT+n+XB4VbY6MUWzT697eGk
	9ljFsgdnCEfVK7EugDbzGBmySClije4VfDG9Rfngt8htcd3HmGzY/nNKG7aZhSAWoIHjtq92ZCx
	PotibF7KH7lxyjvL/0A4B3Fk/6K1FoO2utVsBedrhWFfFPBaFTpnl3s1rJ1UMCJYK2/gcgRT2ZZ
	9jm1uwXPO360ovJZjuD1J9smCtHUAoy3qSvDRWv9n+F+K9PZGJ+lp9bfa2AHKctL/KuRn7sjDtA
	eTlawulcf
X-Received: by 2002:a05:690e:24dc:b0:668:449f:81ae with SMTP id 956f58d0204a3-6699ab867d1mr1063439d50.51.1785877994040;
        Tue, 04 Aug 2026 14:13:14 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21? ([2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66998d162b8sm680717d50.6.2026.08.04.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:13:13 -0700 (PDT)
Message-ID: <16614424-7b1a-48b5-9a85-bc90cbc4c6ab@gmail.com>
Date: Wed, 5 Aug 2026 02:43:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-2-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260730174153.9949-2-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/07/26 23:11, Siddharth Shrimali wrote:
> Add two new command-line options to 'git-repack':
> 
>    --drop-filtered: intended to eventually delete objects that match
>                     the filter specification. Requires --filter and -a,
>                     and is incompatible with --filter-to.
>    --dry-run: show which objects would be dropped without making any
>               changes. Only meaningful with --drop-filtered.
> 
> Keep --dry-run as a separate option rather than folding it into
> --drop-filtered (e.g --drop-filtered=dry-run), to stay consistent with
> the --dry-run option other Git commands already provide and to leave
> room for it to describe other repack behavior later. A
> --drop-filtered=<mode> form can still be added later if more
> drop-specific modes are needed.
> 
> --drop-filtered also requires a promisor remote to be configured, since
> dropping objects without a remote to fetch them back from would be
> permanent data loss.
> 
> --drop-filtered is incompatible with bitmap writing: filtering breaks
> the "all objects in one pack" closure that bitmaps require. Snapshot
> the bitmap setting after config but before option parsing so an
> explicit -b/--write-bitmap-index on the command line can be told apart
> from a repack.writeBitmaps configuration value. An explicit -b is
> reported as a conflict, while a config-provided default is silently
> disabled for the duration of the command.
> 
> These options currently only perform validation. The actual enumeration
> and deletion will be added in follow-up commits.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>   builtin/repack.c                | 63 +++++++++++++++++++++++++++++++++
>   t/meson.build                   |  1 +
>   t/t7706-repack-drop-filtered.sh | 49 +++++++++++++++++++++++++
>   3 files changed, 113 insertions(+)
>   create mode 100755 t/t7706-repack-drop-filtered.sh
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index db504d673f..322b01cb3e 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -14,6 +14,7 @@
>   #include "promisor-remote.h"
>   #include "repack.h"
>   #include "shallow.h"
> +#include "list-objects-filter-options.h"
>   
>   #define ALL_INTO_ONE 1
>   #define LOOSEN_UNREACHABLE 2
> @@ -28,6 +29,8 @@ static int use_delta_islands;
>   static int run_update_server_info = 1;
>   static char *packdir, *packtmp_name, *packtmp;
>   static int midx_must_contain_cruft = 1;
> +static int drop_filtered;
> +static int dry_run;
>   
>   static const char *const git_repack_usage[] = {
>   	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
> @@ -148,6 +151,7 @@ int cmd_repack(int argc,
>   	/* variables to be filled by option parsing */
>   	struct repack_config_ctx config_ctx;
>   	int delete_redundant = 0;
> +	int write_bitmaps_before_parse;
>   	const char *unpack_unreachable = NULL;
>   	int keep_unreachable = 0;
>   	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
> @@ -231,6 +235,10 @@ int cmd_repack(int argc,
>   			   N_("pack prefix to store a pack containing pruned objects")),
>   		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
>   			   N_("pack prefix to store a pack containing filtered out objects")),
> +		OPT_BOOL(0, "drop-filtered", &drop_filtered,
> +				N_("delete filtered out objects (requires --filter)")),
> +		OPT_BOOL(0, "dry-run", &dry_run,
> +				N_("only show which objects would be dropped")),
>   		OPT_END()
>   	};
>   
> @@ -244,6 +252,13 @@ int cmd_repack(int argc,
>   
>   	repo_config(repo, repack_config, &config_ctx);
>   
> +	/*
> +	 * update the bitmap setting after config but before command line
> +	 * parsing, so we can later tell whether -b/--write-bitmap-index was
> +	 * given explicitly on the command line or not
> +	 */
> +	write_bitmaps_before_parse = write_bitmaps;
> +
>   	argc = parse_options(argc, argv, prefix, builtin_repack_options,
>   				git_repack_usage, 0);
>   
> @@ -252,6 +267,54 @@ int cmd_repack(int argc,
>   	po_args.depth = xstrdup_or_null(opt_depth);
>   	po_args.threads = xstrdup_or_null(opt_threads);
>   
> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> +		!!filter_to, "--filter-to");
> +
> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> +		write_bitmaps > 0, "--write-bitmap-index");
> +
> +	if (dry_run && !drop_filtered)
> +		die(_("--dry-run only takes effect with --drop-filtered"));
> +
> +	if (drop_filtered) {
> +		int bitmaps_from_cmdline = (write_bitmaps != write_bitmaps_before_parse);
> +
> +		if (!dry_run)
> +			die(_("--drop-filtered doesn't work without --dry-run yet"));
> +
> +		if (!po_args.filter_options.choice)
> +			die(_("--drop-filtered requires --filter"));
> +
> +		if (!(pack_everything & ALL_INTO_ONE))
> +			die(_("--drop-filtered requires -a"));
> +
> +		/*
> +		 * Only blob:limit=<n> is supported for now. Reject other
> +		 * filter choices early, before walking the object database.
> +		 */
> +		if (po_args.filter_options.choice != LOFC_BLOB_LIMIT)
> +			die(_("--drop-filtered only supports --filter=blob:limit=<n> for now"));
> +
> +		/*
> +		 * an explicit -b on the command line is a conflict we have to
> +		 * report, a bitmap setting from config is silently overridden
> +		 * for the duration of the command
> +		 */
> +		if (bitmaps_from_cmdline && write_bitmaps > 0)
> +			die(_("options '%s' and '%s' cannot be used together"),
> +				"--drop-filtered", "--write-bitmap-index");


Thanks for tackling the bitmap CLI vs config split.

One case still looks off: if repack.writeBitmaps is already true and
the user also passes -b, write_bitmaps is 1 before and after parse, so
bitmaps_from_cmdline stays false and we never error. I think explicit
-b should still be rejected there.

Thanks.
Siddharth



> +
> +		/*
> +		 * Without a promisor remote there is nowhere to re-fetch the
> +		 * dropped objects from, so dropping them would be permanent
> +		 * data loss.
> +		 */
> +		if (!repo_has_promisor_remote(repo))
> +			die(_("--drop-filtered requires a promisor remote"));
> +
> +		write_bitmaps = 0;
> +	}
> +
>   	if (delete_redundant && repo->repository_format_precious_objects)
>   		die(_("cannot delete packs in a precious-objects repo"));
>   
> diff --git a/t/meson.build b/t/meson.build
> index d8161c368b..c2bf60d129 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -963,6 +963,7 @@ integration_tests = [
>     't7703-repack-geometric.sh',
>     't7704-repack-cruft.sh',
>     't7705-repack-incremental-midx.sh',
> +  't7706-repack-drop-filtered.sh',
>     't7800-difftool.sh',
>     't7810-grep.sh',
>     't7811-grep-open.sh',
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
> new file mode 100755
> index 0000000000..65be756e33
> --- /dev/null
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='git repack --drop-filtered option validation'
> +
> +. ./test-lib.sh
> +
> +# checks for options validations before any promisor walk
> +test_expect_success 'setup plain repo for validation' '
> +	git init plain &&
> +	test_commit -C plain initial &&
> +	git clone --bare plain plain.git &&
> +	git -C plain.git repack -a -d
> +'
> +
> +test_expect_success '--drop-filtered requires --filter' '
> +	test_must_fail git -C plain.git repack --drop-filtered --dry-run -a 2>err &&
> +	test_grep "drop-filtered requires --filter" err
> +'
> +
> +test_expect_success '--drop-filtered cannot be used with --filter-to' '
> +	test_must_fail git -C plain.git repack --drop-filtered \
> +		--filter=blob:limit=1k --filter-to=./filter-out 2>err &&
> +	test_grep "options .--drop-filtered. and .--filter-to. cannot be used together" err
> +'
> +
> +test_expect_success '--dry-run only takes effect with --drop-filtered' '
> +	test_must_fail git -C plain.git repack --dry-run 2>err &&
> +	test_grep "dry-run only takes effect with --drop-filtered" err
> +'
> +
> +test_expect_success '--drop-filtered requires -a' '
> +	test_must_fail git -C plain.git repack --drop-filtered \
> +		--filter=blob:limit=1k --dry-run 2>err &&
> +	test_grep "drop-filtered requires -a" err
> +'
> +
> +test_expect_success '--drop-filtered fails with --write-bitmap-index' '
> +	test_must_fail git -C plain.git repack --drop-filtered \
> +		--filter=blob:limit=1k --dry-run -a -b 2>err &&
> +	test_grep "options .--drop-filtered. and .--write-bitmap-index. cannot be used together" err
> +'
> +
> +test_expect_success '--drop-filtered fails without a promisor remote' '
> +	test_must_fail git -C plain.git repack --drop-filtered \
> +		--filter=blob:limit=1k --dry-run -a 2>err &&
> +	test_grep "drop-filtered requires a promisor remote" err
> +'
> +
> +test_done

