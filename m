Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC484690
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509120; cv=none; b=Khc4/4Wxs3WV0n4Uhm5NPfLEs8dahLsrglXE7rA7v4hLUw8nczQitpgrySjMWJIzEMpXMNuq8jH0fEdXAJ40KinGVkBceu95pU5NojZ326EY0DTSBKSIKzF3rr0OnSwQyNVwDOMyc8TsFS2IZWXSXOeJhfXnfaCGxb5W/UOEc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509120; c=relaxed/simple;
	bh=8+JcKSX02qDZGmUJnqb6uMK+zER9kmIoq7m1QSur+AI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2wgDtB8tKeBhB74P6dCjan/mUkpB4MoGMyCbJynyDjAGGYzMAwDQQ97J7yDPaXvdyg2QQ6W7JfDu3Yhrpoe5tQiNFGoghjowDFp+C+Y8YhK8smkupqGqPvlo60y4KNSLxG9cENtR6Y9Mq6Betik8zdAFUa+ZsnqqFx6/+yhInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/rA/Rih; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/rA/Rih"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523edc385caso2430263e0c.3
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743509118; x=1744113918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=09ErWPHs7ieSdomS1oE9mlLUyZkzu+IoY8kdUF4/rRc=;
        b=H/rA/RihZjICVmFvhHHvugYkOTzreu//ik5i5HPy7YOzRiaWCCdaQBSvRnHVuhBMy+
         +bomVgFwGJEJ6o3TBg2C9L7U5vC5Ptfvj9grtxIZ+faWgY9H6OgPLXj2wQ/R3jxBLp+W
         6mF6CyLRRVC2gurktk9OmhBEMlvQplEUVsoaKvLpsNdL9p/RIknoqQsLE2isP0sB0hRl
         APeyEjzKRvmd9gaI5mtiQo/GGwe/unctqkOdZj+Iq/AX5nzjvXQDray8aKtHF6UlQqQX
         U5CHbPJtIR9qntQmjo6TapmzUihsISqVVyIufoeuI/l3SKyVdWmHiZNZ1PjsZKQa1Vau
         CNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743509118; x=1744113918;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09ErWPHs7ieSdomS1oE9mlLUyZkzu+IoY8kdUF4/rRc=;
        b=c7upcPnVQMcm66X/pHiKZ53AUBL1fXzF1f6eoGn9ImMh/p40viYIh3gtOHUJy01d7v
         mIP4rvXbQC0qgD54L5ocAmvBiE6RpI0CJiH4uTLW9tlnaxsTB/LQtvQepeeEOU9nO//D
         xcPT4AmZAiteEPfpkMiadgA7VlAAmDoebmk1TAtf4hd2z57pTNRLpCwRPA3W8LV7FsNu
         siLDVygOjnsGawwis+kQ+W9XNMhVUixJgXujfDTvXXRODvD9te8DyDK3vgUEuseAq+VV
         fVKcP92Jqfv8EtfrMRVSevHS/obudiuGolHR3xmyu0Grtedb6fgnxpJ60lo///RdmKTz
         StZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTojn6eHAiVjxoDbv6XdKq3fRivpwzacQ5BCMF+dCPAvhOeinAilh+HzeXMR5+2FmRgK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLhH6hv+yQL2NMvRnQEEsYVaBDasZ9+ZBmeld1u0WwdykGox1
	wJoK/n3Uv080xbTqsTiVgcl4gNe9tDD+15OWrUqE/hRoFyzxWkI9p5qfLF+YgBeCIwW7726z/r3
	VEKPGitWmqsYjBUjGTvb6MZttZ6c=
X-Gm-Gg: ASbGnctqP+xyboMl8QdgV/jai8xGBk2Y2W98VteWzkICPNwgR+uz5IhJrHXF5/yZAjZ
	JAgI08GCY2V9IUBaYD1gAD7P0ooRSYKzW1ROFCIJebJrnmAThL6c0rkzA+3UAGSPX9uaBq21w0r
	1sCXM33AuABsk3Nhj0kCoYAO2XENF6aydt7SApNjA2v+quvn9W9rAIkt2jinL8
X-Google-Smtp-Source: AGHT+IE3gToOc0A0ICqsTYcS05ayY3MOjxfI1+UxWpRhF8ebZTlzvKxDmazsx2IwvpUWMuEFdaZV8AInQ47mlqrkIU8=
X-Received: by 2002:a05:6122:65a5:b0:518:865e:d177 with SMTP id
 71dfb90a1353d-5261d4a0493mr6875985e0c.9.1743509117870; Tue, 01 Apr 2025
 05:05:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Apr 2025 05:05:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Apr 2025 05:05:17 -0700
X-Gm-Features: AQ5f1Jq8YuWzXGn2D5l93WXKiad9zC_q8Uz2a2D8ZvwOefe5fOUK_91AijSfuwQ
Message-ID: <CAOLa=ZTgU+E3Y6DRCA0EOg9uOvNoggCRPBNYjDZTOinaDVj95Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] builtin/cat-file: wire up an option to filter objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000a244590631b659c5"

--000000000000a244590631b659c5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In batch mode, git-cat-file(1) enumerates all objects and prints them
> by iterating through both loose and packed objects. This works without

Nit: I assume you're referring to the `--batch-all-objects` mode. So
would be nice to specify here perhaps?

> considering their reachability at all, and consequently most options to
> filter objects as they exist in e.g. git-rev-list(1) are not applicable.
> In some situations it may still be useful though to filter objects based
> on properties that are inherent to them. This includes the object size
> as well as its type.
>
> Such a filter already exists in git-rev-list(1) with the `--filter=`
> command line option. While this option supports a couple of filters that
> are not applicable to our usecase, some of them are quite a neat fit.
>
> Wire up the filter as an option for git-cat-file(1). This allows us to
> reuse the same syntax as in git-rev-list(1) so that we don't have to
> reinvent the wheel. For now, we die when any of the filter options has
> been passed by the user, but they will be wired up in subsequent
> commits.
>
> Further note that the filters that we are about to introduce don't
> significantly speed up the runtime of git-cat-file(1). While we can skip
> emitting a lot of objects in case they are uninteresting to us, the
> majority of time is spent reading the packfile, which is bottlenecked by
> I/O and not the processor. This will change though once we start to make
> use of bitmaps, which will allow us to skip reading the whole packfile.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-cat-file.adoc |  6 ++++++
>  builtin/cat-file.c              | 37 +++++++++++++++++++++++++++++++++----
>  t/t1006-cat-file.sh             | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index d5890ae3686..f7f57b7f538 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -81,6 +81,12 @@ OPTIONS
>  	end-of-line conversion, etc). In this case, `<object>` has to be of
>  	the form `<tree-ish>:<path>`, or `:<path>`.
>
> +--filter=<filter-spec>::
> +--no-filter::
> +	Omit objects from the list of printed objects. This can only be used in
> +	combination with one of the batched modes. The '<filter-spec>' may be
> +	one of the following:
> +

Shouldn't we say this is specific to `--batch-all-objects`?

>  --path=<path>::
>  	For use with `--textconv` or `--filters`, to allow specifying an object
>  	name and a path separately, e.g. when it is difficult to figure out
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8e40016dd24..940900d92ad 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -15,6 +15,7 @@
>  #include "gettext.h"
>  #include "hex.h"
>  #include "ident.h"
> +#include "list-objects-filter-options.h"
>  #include "parse-options.h"
>  #include "userdiff.h"
>  #include "streaming.h"
> @@ -35,6 +36,7 @@ enum batch_mode {
>  };
>
>  struct batch_options {
> +	struct list_objects_filter_options objects_filter;
>  	int enabled;
>  	int follow_symlinks;
>  	enum batch_mode batch_mode;
> @@ -487,6 +489,13 @@ static void batch_object_write(const char *obj_name,
>  			return;
>  		}
>
> +		switch (opt->objects_filter.choice) {
> +		case LOFC_DISABLED:
> +			break;
> +		default:
> +			BUG("unsupported objects filter");
> +		}
> +

Okay here it seems like it also applies to other batch modes. So it
would be nice to perhaps clarify how this works when not used with
`--batch-all-objects`?

>  		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
>  			size_t s = data->size;
>  			char *buf = NULL;
> @@ -812,7 +821,8 @@ static int batch_objects(struct batch_options *opt)
>  		struct object_cb_data cb;
>  		struct object_info empty = OBJECT_INFO_INIT;
>
> -		if (!memcmp(&data.info, &empty, sizeof(empty)))
> +		if (!memcmp(&data.info, &empty, sizeof(empty)) &&
> +		    opt->objects_filter.choice == LOFC_DISABLED)
>  			data.skip_object_info = 1;
>
>  		if (repo_has_promisor_remote(the_repository))
> @@ -936,10 +946,13 @@ int cmd_cat_file(int argc,
>  	int opt_cw = 0;
>  	int opt_epts = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
> -	struct batch_options batch = {0};
> +	struct batch_options batch = {
> +		.objects_filter = LIST_OBJECTS_FILTER_INIT,
> +	};
>  	int unknown_type = 0;
>  	int input_nul_terminated = 0;
>  	int nul_terminated = 0;
> +	int ret;
>
>  	const char * const builtin_catfile_usage[] = {
>  		N_("git cat-file <type> <object>"),
> @@ -1000,6 +1013,8 @@ int cmd_cat_file(int argc,
>  			    N_("run filters on object's content"), 'w'),
>  		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
>  			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
> +		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
> +			     N_("object filtering"), opt_parse_list_objects_filter),
>  		OPT_END()
>  	};
>
> @@ -1014,6 +1029,14 @@ int cmd_cat_file(int argc,
>  	if (use_mailmap)
>  		read_mailmap(&mailmap);
>
> +	switch (batch.objects_filter.choice) {
> +	case LOFC_DISABLED:
> +		break;
> +	default:
> +		usagef(_("objects filter not supported: '%s'"),
> +		       list_object_filter_config_name(batch.objects_filter.choice));
> +	}
> +
>  	/* --batch-all-objects? */
>  	if (opt == 'b')
>  		batch.all_objects = 1;
> @@ -1068,7 +1091,8 @@ int cmd_cat_file(int argc,
>  			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
>  				      options);
>
> -		return batch_objects(&batch);
> +		ret = batch_objects(&batch);
> +		goto out;
>  	}
>
>  	if (opt) {
> @@ -1097,5 +1121,10 @@ int cmd_cat_file(int argc,
>
>  	if (unknown_type && opt != 't' && opt != 's')
>  		die("git cat-file --allow-unknown-type: use with -s or -t");
> -	return cat_one_file(opt, exp_type, obj_name, unknown_type);
> +
> +	ret = cat_one_file(opt, exp_type, obj_name, unknown_type);
> +
> +out:
> +	list_objects_filter_release(&batch.objects_filter);
> +	return ret;
>  }
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 398865d6ebe..1246d3119f8 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1353,4 +1353,36 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
>  	perl -e "$script" -- --batch-command $hello_oid "$expect" "info "
>  '
>
> +test_expect_success 'setup for objects filter' '
> +	git init repo
> +'
> +
> +test_expect_success 'objects filter with unknown option' '
> +	cat >expect <<-EOF &&
> +	fatal: invalid filter-spec ${SQ}unknown${SQ}
> +	EOF
> +	test_must_fail git -C repo cat-file --filter=unknown 2>err &&
> +	test_cmp expect err
> +'
> +

Would it be also worthwhile to test the `--no-filter` option?

> +for option in blob:none blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
> +do
> +	test_expect_success "objects filter with unsupported option $option" '
> +		case "$option" in
> +		tree:1)
> +			echo "usage: objects filter not supported: ${SQ}tree${SQ}" >expect
> +			;;
> +		sparse:path=x)
> +			echo "fatal: sparse:path filters support has been dropped" >expect
> +			;;
> +		*)
> +			option_name=$(echo "$option" | cut -d= -f1) &&
> +			printf "usage: objects filter not supported: ${SQ}%s${SQ}\n" "$option_name" >expect
> +			;;
> +		esac &&
> +		test_must_fail git -C repo cat-file --filter=$option 2>err &&
> +		test_cmp expect err
> +	'
> +done
> +
>  test_done
>
> --
> 2.49.0.472.ge94155a9ec.dirty

--000000000000a244590631b659c5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 65ba2d8052749258_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mcjFuc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzV6Qy85TFpHVmtSMFJ3bWNIZXZsNXlpUzFWRGlpQgpqY09WUFNPMENz
cTZ2UEJGUk9KS29kcXU4TngxOFdFT0ZlT1V0bVVwenJyWjRsU1RxTmcyUzhnT3dpQVBHZE1nCmta
ZHE1V2REd2dOcjRyd0s3ZVI2TW54ZXlQaktMZW8xTlphUTF0NmErd21VWUlZTDBFQnZFenBzSFhC
eHF1QUsKcHFaV1hTN3RXcnBEb0FJTFJmRWJ5RE1CQkxrQ0o0UGQyd3F2OWV1cE1EZTZvOC9PQTli
SUYrT2MwaVhwUUc3WQpSWEVHRm9QS0RQaWU3cHI2ajRVUXVoWWVBODV5eVhTNU41MUs0Tll1cWxD
MUUwOU5KNlBhL2s1cDhELzQ4MDZzCnNTVExhWStBWFdzUSs1dmpLNkpubTV0RHhXVkdnLzd5Y09Q
TW9EZUJQOTFLK3JnZzV1cG1EQmpjWG5IRHA4VEEKZXcwSVpXczJDM20zRTdOZmorZ3lrcWxEQlR3
NDZ3SzlZMTMwS2JWaklScFdpRlVYQUMvS0htRHdCVUVnY0pvOApGdldmdTQ1UXZGd2QydFJWbU1y
bVFPYjUvbHUyYUcxU0ZXNUJDMTNBQ3FSMDFpSTdoZzV0RVU1RkdZRFFlRjUyCnBuMjhBd1pjZzFu
S2dkN0RlOUxocmEwa2Q3ZEE4ZlljYzZKazQwUT0KPTMyYkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a244590631b659c5--
