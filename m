Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72120224B15
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668263; cv=none; b=uyzMq0DvrN5XrTF5gReVYKJ4DYNFkXJYXbbVzDl/PJjJtQlXMtnA8ow7D7qBFp74tjLzTkVvA32Yr5JbioAF/p5cVKKn0IFcHf47PheCCNibpXWzIwUo28P0uj57Ke6WzIQZ2n1xV7k3xb5XVDYy0Oiw+vT4ptccHzp9XmaGP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668263; c=relaxed/simple;
	bh=vKV3r8fOojIhG0LN6dj1OudRRe4TIpxqUrwMY1WGmMY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP7KUsMm1E+lcmXpdwURBgIagD7Lg3RUMCGoPoYasHlRPKknV6P+I64GhVAImxo1ZUixBJUc/BFAIZcfznePMPizDk7Ue5NtG6BBDi9MweJUM7I8OSu4nEzl+SMv4+/92mL24uOlI5vIvYTwNGu6UGVCu9hwTk2KmCkLk+iQ8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeFoAevV; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeFoAevV"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so310087241.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743668260; x=1744273060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUcyGXAPEfzlYDMhN8j1p2ixNbyC1AqbX562M0CSKU0=;
        b=XeFoAevVXK7xSWZLEEK0s4XH7YX8O7KnB4f/qQTXdIiuNI5F6SRGk3TB8JrVx8hPYH
         DBkFMkmBVOQ69jQxlHP2CbI1QR7j7Fqq+Tq7fzc1Kjn4JiTtEjYyCig20rj4eUcsBXY6
         xWqcwuTcUoiuE8niKKCT6jfpnh7sj8RLGtdTr92k08hCQd9s6cT6d2Nvl3x/HDTPxOAZ
         MtQXK55DU5dhz62yRrjSvY3xHYEUfLFb6ocOWatW1HzcE4/pxMk4fYyd/9xts81KBX07
         Bx6AZhTzJEVysilR8ZPipfmf2kbunxGuMaQKgUHBgSkpdhy0wnW1PYPhBzStYE0SCAWK
         bMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668260; x=1744273060;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUcyGXAPEfzlYDMhN8j1p2ixNbyC1AqbX562M0CSKU0=;
        b=cmVTfVnPJRy5li6D8rNUGHFS0pAtNUr+IdPvHct5i2oXc89z3yTBSEQBrTKXzHp+eg
         AXJJDXV7w3vZGb7lCOo87UqWVX++aBxwyCPMXr9c4ccx0E4t5J3tdwlgAsYFgLvR8xaB
         jMq+ZRktfYKglCEcK4Bpqni81+Kc4D0vS0tT/7RGJ+Q5NuTDjB41VeQg75JNrZGSdwh3
         XE8eUghepEkURdEPjIUv8Qkt0aALp6MqrOcCsdEeNI8eXB/NNb81j2lhm9MHioZWw1W4
         jW6yYRmzwlr+pAdCIh52TgOGstJehAQH/ZDnfTQk1uB4/OT/3ftZ37XFVIlFqim2mhs1
         CtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJcidkKk21eDQvU/VaQZK32UFN/bFhRFLxaa3AQL8//B/Q6ekuqBipXEWB/EMhMUUae4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWGrm0HYymvjStu/eFcY5nbrYlzgw+x0WzlduU07Ffo+wVGXC
	JJfvuU2DKMj5vJ9T742nYrHntEjTWyt69k86PF0BgoHtqcSvEYYOwce/g2j5/sgUTn5sxt8PIJ4
	41R30T7+BXMLNQYKg2BN2l7YEsxM=
X-Gm-Gg: ASbGncv78VsysztIcW1ldp2ZHvcqToWtu+jqV0MLTCLUBT3Y0B1fCBuwqyahkmETXBa
	ykCI1hyuow7XDrvHH5wU5TE85XVu0+WjxqjU1PM/8rRWVI7lKpoX7RkqcAwgjLcCF4U5YkdZMpk
	EKGtiZJpFMPZWEZC+yiymFYtI0dR718B3ciK14t/R8a3de/Lv0ur1mVnJlsg==
X-Google-Smtp-Source: AGHT+IFqSTyind1dWcVUFE2o9TOVGWj9RP+x02QdbNklSJMIEmqwBiFzpsmq5S4WZFF0VCYTVg8iD2CeN+Pp6iVgdnU=
X-Received: by 2002:a05:6102:3ec1:b0:4c1:801e:deb2 with SMTP id
 ada2fe7eead31-4c839e15bf5mr5303877137.7.1743668260014; Thu, 03 Apr 2025
 01:17:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 01:17:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 01:17:38 -0700
X-Gm-Features: ATxdqUGeKOVr9ZRLjbCY1qgUWgSZdCtg1QDsVNdqp4x_woKEYJpwiAOXDdxLvdE
Message-ID: <CAOLa=ZTY4AE4ONHoZX+VrHRC9461utdV6g7FFbWtnGuay55G9g@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] builtin/cat-file: allow filtering objects in
 batch mode
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000003eaa1b0631db67c6"

--0000000000003eaa1b0631db67c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> at GitLab, we sometimes have the need to list all objects regardless of
> their reachability. We use git-cat-file(1) with `--batch-all-objects` to
> do this, and typically this is quite a good fit. In some cases though,
> we only want to list objects of a specific type, where we then basically
> have the following pipeline:
>
>     git cat-file --batch-all-objects --batch-check=3D'%(objecttype) %(obj=
ectname)' |
>     grep '^commit ' |
>     cut -d' ' -f2 |
>     git cat-file --batch
>
> This works okayish in medium-sized repositories, but once you reach a
> certain size this isn't really an option anymore. In the Chromium
> repository for example [1] simply listing all objects in the first
> invocation of git-cat-file(1) takes around 80 to 100 seconds. The
> workload is completely I/O-bottlenecked: my machine reads at ~500MB/s,
> and the packfile is 50GB in size, which matches the 100 seconds that I
> observe.
>
> This series addresses the issue by introducing object filters into
> git-cat-file(1). These object filters use the exact same syntax as the
> filters we have in git-rev-list(1), but only a subset of them is
> supported because not all filters can be computed by git-cat-file(1).
> Supported are "blob:none", "blob:limit=3D" as well as "object:type=3D".
>
> The filters alone don't really help though: we still have to scan
> through the whole packfile in order to compute the packfiles. While we
> are able to shed a bit of CPU time because we can stop emitting some of
> the objects, we're still I/O-bottlenecked.
>
> The second part of the series thus expands the filters so that they can
> make use of bitmap indices for some of the filters, if available. This
> allows us to efficiently answer the question where to find all objects
> of a specific type, and thus we can avoid scanning through the packfile
> and instead directly look up relevant objects, leading to a significant
> speedup:
>
>     Benchmark 1: cat-file with filter=3Dobject:type=3Dcommit (revision =
=3D HEAD~)
>       Time (mean =C2=B1 =CF=83):     86.444 s =C2=B1  4.081 s    [User: 3=
6.830 s, System: 11.312 s]
>       Range (min =E2=80=A6 max):   80.305 s =E2=80=A6 93.104 s    10 runs
>
>     Benchmark 2: cat-file with filter=3Dobject:type=3Dcommit (revision =
=3D HEAD)
>       Time (mean =C2=B1 =CF=83):      2.089 s =C2=B1  0.015 s    [User: 1=
.872 s, System: 0.207 s]
>       Range (min =E2=80=A6 max):    2.073 s =E2=80=A6  2.119 s    10 runs
>
>     Summary
>       cat-file with filter=3Dobject:type=3Dcommit (revision =3D HEAD) ran
>        41.38 =C2=B1 1.98 times faster than cat-file with filter=3Dobject:=
type=3Dcommit (revision =3D HEAD~)
>
> We now directly scale with the number of objects of a specific type
> contained in the packfile instead of scaling with the overall number of
> objects. It's quite fun to see how the math plays out: if you sum up the
> times for each of the types you arrive at the time for the unfiltered
> case.
>
> Changes in v2:
>   - The series is now built on top of "master" at 683c54c999c (Git 2.49,
>     2025-03-14) with "tb/incremental-midx-part-2" at 27afc272c49 (midx:
>     implement writing incremental MIDX bitmaps, 2025-03-20) merged into
>     it.
>   - Rename the filter options to "--filter=3D" to match
>     git-pack-objects(1).
>   - The bitmap-filtering is now reusing existing mechanisms that we
>     already have in "pack-bitmap.c", as proposed by Taylor.
>   - Link to v1: https://lore.kernel.org/r/20250221-pks-cat-file-object-ty=
pe-filter-v1-0-0852530888e2@pks.im
>
> Changes in v3:
>   - Wrap some overly long lines.
>   - Better describe how filters interact with the different batch modes.
>   - Adapt the format with `--batch` and `--batch-check` so that we tell
>     the user that the object has been excluded.
>   - Add a test for "--no-filter".
>   - Use `OPT_PARSE_LIST_OBJECTS_FILTER()`.
>   - Link to v2: https://lore.kernel.org/r/20250327-pks-cat-file-object-ty=
pe-filter-v2-0-4bbc7085d7c5@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: https://github.com/chromium/chromium.git
>
> ---
> Patrick Steinhardt (11):
>       builtin/cat-file: rename variable that tracks usage
>       builtin/cat-file: introduce function to report object status
>       builtin/cat-file: wire up an option to filter objects
>       builtin/cat-file: support "blob:none" objects filter
>       builtin/cat-file: support "blob:limit=3D" objects filter
>       builtin/cat-file: support "object:type=3D" objects filter
>       pack-bitmap: allow passing payloads to `show_reachable_fn()`
>       pack-bitmap: add function to iterate over filtered bitmapped object=
s
>       pack-bitmap: introduce function to check whether a pack is bitmappe=
d
>       builtin/cat-file: deduplicate logic to iterate over all objects
>       builtin/cat-file: use bitmaps to efficiently filter by object type
>
>  Documentation/git-cat-file.adoc |  26 ++++
>  builtin/cat-file.c              | 256 +++++++++++++++++++++++++++++-----=
------
>  builtin/pack-objects.c          |   3 +-
>  builtin/rev-list.c              |   3 +-
>  pack-bitmap.c                   |  81 +++++++++++--
>  pack-bitmap.h                   |  22 +++-
>  reachable.c                     |   3 +-
>  t/t1006-cat-file.sh             |  99 ++++++++++++++++
>  8 files changed, 411 insertions(+), 82 deletions(-)
>
> Range-diff versus v2:
>
>  1:  a75888e0bf4 !  1:  b0642b6c495 builtin/cat-file: rename variable tha=
t tracks usage
>     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       		;
>       	else if (batch.follow_symlinks)
>      -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>     -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage, options,
>     - 			       "--follow-symlinks");
>     +-			       "--follow-symlinks");
>     ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage,
>     ++			       options, "--follow-symlinks");
>       	else if (batch.buffer_output >=3D 0)
>      -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>     -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage, options,
>     - 			       "--buffer");
>     +-			       "--buffer");
>     ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage,
>     ++			       options, "--buffer");
>       	else if (batch.all_objects)
>      -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>     -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage, options,
>     - 			       "--batch-all-objects");
>     +-			       "--batch-all-objects");
>     ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage,
>     ++			       options, "--batch-all-objects");
>       	else if (input_nul_terminated)
>      -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>     -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage, options,
>     - 			       "-z");
>     +-			       "-z");
>     ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage,
>     ++			       options, "-z");
>       	else if (nul_terminated)
>      -		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>     -+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage, options,
>     - 			       "-Z");
>     +-			       "-Z");
>     ++		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_u=
sage,
>     ++			       options, "-Z");
>
>       	batch.input_delim =3D batch.output_delim =3D '\n';
>     + 	if (input_nul_terminated)
>      @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       			batch.transform_mode =3D opt;
>       		else if (opt && opt !=3D 'b')
>     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>      +				       builtin_catfile_usage, options, opt);
>       		else if (argc)
>      -			usage_msg_opt(_("batch modes take no arguments"), usage,
>     -+			usage_msg_opt(_("batch modes take no arguments"), builtin_catfil=
e_usage,
>     - 				      options);
>     +-				      options);
>     ++			usage_msg_opt(_("batch modes take no arguments"),
>     ++				      builtin_catfile_usage, options);
>
>       		return batch_objects(&batch);
>     + 	}
>      @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       	if (opt) {
>       		if (!argc && opt =3D=3D 'c')
>       			usage_msg_optf(_("<rev> required with '%s'"),
>      -				       usage, options, "--textconv");
>     -+				       builtin_catfile_usage, options, "--textconv");
>     ++				       builtin_catfile_usage, options,
>     ++				       "--textconv");
>       		else if (!argc && opt =3D=3D 'w')
>       			usage_msg_optf(_("<rev> required with '%s'"),
>      -				       usage, options, "--filters");
>     -+				       builtin_catfile_usage, options, "--filters");
>     ++				       builtin_catfile_usage, options,
>     ++				       "--filters");
>       		else if (!argc && opt_epts)
>       			usage_msg_optf(_("<object> required with '-%c'"),
>      -				       usage, options, opt);
>     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       			obj_name =3D argv[0];
>       		else
>      -			usage_msg_opt(_("too many arguments"), usage, options);
>     -+			usage_msg_opt(_("too many arguments"), builtin_catfile_usage, op=
tions);
>     ++			usage_msg_opt(_("too many arguments"), builtin_catfile_usage,
>     ++				      options);
>       	} else if (!argc) {
>      -		usage_with_options(usage, options);
>      +		usage_with_options(builtin_catfile_usage, options);
>  -:  ----------- >  2:  18353ba706d builtin/cat-file: introduce function =
to report object status
>  2:  bee9407c1a9 !  3:  1e46af5d07b builtin/cat-file: wire up an option t=
o filter objects
>     @@ Documentation/git-cat-file.adoc: OPTIONS
>      +--filter=3D<filter-spec>::
>      +--no-filter::
>      +	Omit objects from the list of printed objects. This can only be us=
ed in
>     -+	combination with one of the batched modes. The '<filter-spec>' may=
 be
>     -+	one of the following:
>     ++	combination with one of the batched modes. Excluded objects that h=
ave
>     ++	been explicitly requested via any of the batch modes that read obj=
ects
>     ++	via standard input (`--batch`, `--batch-check`) will be reported a=
s
>     ++	"filtered". Excluded objects in `--batch-all-objects` mode will no=
t be
>     ++	printed at all. No filters are supported yet.
>      +
>       --path=3D<path>::
>       	For use with `--textconv` or `--filters`, to allow specifying an o=
bject
>       	name and a path separately, e.g. when it is difficult to figure ou=
t
>     +@@ Documentation/git-cat-file.adoc: the repository, then `cat-file` =
will ignore any custom format and print:
>     + <object> SP missing LF
>     + ------------
>     +
>     ++If a name is specified on stdin that is filtered out via `--filter=
=3D`,
>     ++then `cat-file` will ignore any custom format and print:
>     ++
>     ++------------
>     ++<object> SP excluded LF
>     ++------------
>     ++
>     + If a name is specified that might refer to more than one object (an=
 ambiguous short sha), then `cat-file` will ignore any custom format and pr=
int:
>     +
>     + ------------
>
>       ## builtin/cat-file.c ##
>      @@
>     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       			    N_("run filters on object's content"), 'w'),
>       		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
>       			   N_("use a <path> for (--textconv | --filters); Not with 'batc=
h'")),
>     -+		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
>     -+			     N_("object filtering"), opt_parse_list_objects_filter),
>     ++		OPT_PARSE_LIST_OBJECTS_FILTER(&batch.objects_filter),
>       		OPT_END()
>       	};
>
>     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>       	if (opt =3D=3D 'b')
>       		batch.all_objects =3D 1;
>      @@ builtin/cat-file.c: int cmd_cat_file(int argc,
>     - 			usage_msg_opt(_("batch modes take no arguments"), builtin_catfil=
e_usage,
>     - 				      options);
>     + 			usage_msg_opt(_("batch modes take no arguments"),
>     + 				      builtin_catfile_usage, options);
>
>      -		return batch_objects(&batch);
>      +		ret =3D batch_objects(&batch);
>     @@ t/t1006-cat-file.sh: test_expect_success PERL '--batch-command inf=
o is unbuffere
>      +		test_cmp expect err
>      +	'
>      +done
>     ++
>     ++test_expect_success 'objects filter: disabled' '
>     ++	git -C repo cat-file --batch-check=3D"%(objectname)" --batch-all-o=
bjects --no-filter >actual &&
>     ++	sort actual >actual.sorted &&
>     ++	git -C repo rev-list --objects --no-object-names --all >expect &&
>     ++	sort expect >expect.sorted &&
>     ++	test_cmp expect.sorted actual.sorted
>     ++'
>      +
>       test_done
>  3:  ec1d0c63de6 !  4:  878ae8e2a76 builtin/cat-file: support "blob:none"=
 objects filter
>     @@ Commit message
>          Implement support for the "blob:none" filter in git-cat-file(1),=
 which
>          causes us to omit all blobs.
>
>     +    Note that this new filter requires us to read the object type vi=
a
>     +    `oid_object_info_extended()` in `batch_object_write()`. But as w=
e try to
>     +    optimize away reading objects from the database the `data->info.=
typep`
>     +    pointer may not be set. We thus have to adapt the logic to condi=
tionally
>     +    set the pointer in cases where the filter is given.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>       ## Documentation/git-cat-file.adoc ##
>      @@ Documentation/git-cat-file.adoc: OPTIONS
>     - 	Omit objects from the list of printed objects. This can only be us=
ed in
>     - 	combination with one of the batched modes. The '<filter-spec>' may=
 be
>     - 	one of the following:
>     + 	been explicitly requested via any of the batch modes that read obj=
ects
>     + 	via standard input (`--batch`, `--batch-check`) will be reported a=
s
>     + 	"filtered". Excluded objects in `--batch-all-objects` mode will no=
t be
>     +-	printed at all. No filters are supported yet.
>     ++	printed at all. The '<filter-spec>' may be one of the following:
>      ++
>      +The form '--filter=3Dblob:none' omits all blobs.
>
>     @@ builtin/cat-file.c: static void batch_object_write(const char *obj=
_name,
>       		case LOFC_DISABLED:
>       			break;
>      +		case LOFC_BLOB_NONE:
>     -+			if (data->type =3D=3D OBJ_BLOB)
>     ++			if (data->type =3D=3D OBJ_BLOB) {
>     ++				if (!opt->all_objects)
>     ++					report_object_status(opt, obj_name,
>     ++							     &data->oid, "excluded");
>      +				return;
>     ++			}
>      +			break;
>       		default:
>       			BUG("unsupported objects filter");
>     @@ t/t1006-cat-file.sh: test_expect_success 'objects filter with unkn=
own option' '
>       do
>       	test_expect_success "objects filter with unsupported option $optio=
n" '
>       		case "$option" in
>     -@@ t/t1006-cat-file.sh: do
>     - 	'
>     - done
>     +@@ t/t1006-cat-file.sh: test_expect_success 'objects filter: disable=
d' '
>     + 	test_cmp expect.sorted actual.sorted
>     + '
>
>      +test_objects_filter () {
>      +	filter=3D"$1"
>     @@ t/t1006-cat-file.sh: do
>      +		sort expect >expect.sorted &&
>      +		test_cmp expect.sorted actual.sorted
>      +	'
>     ++
>     ++	test_expect_success "objects filter prints excluded objects: $filt=
er" '
>     ++		# Find all objects that would be excluded by the current filter.
>     ++		git -C repo rev-list --objects --no-object-names --all >all &&
>     ++		git -C repo rev-list --objects --no-object-names --all --filter=
=3D"$filter" --filter-provided-objects >filtered &&
>     ++		sort all >all.sorted &&
>     ++		sort filtered >filtered.sorted &&
>     ++		comm -23 all.sorted filtered.sorted >expected.excluded &&
>     ++		test_line_count -gt 0 expected.excluded &&
>     ++
>     ++		git -C repo cat-file --batch-check=3D"%(objectname)" --filter=3D"=
$filter" <expected.excluded >actual &&
>     ++		awk "/excluded/{ print \$1 }" actual | sort >actual.excluded &&
>     ++		test_cmp expected.excluded actual.excluded
>     ++	'
>      +}
>      +
>      +test_objects_filter "blob:none"
>  4:  a3ed054994d !  5:  a88d5d4b60a builtin/cat-file: support "blob:limit=
=3D" objects filter
>     @@ Commit message
>
>       ## Documentation/git-cat-file.adoc ##
>      @@ Documentation/git-cat-file.adoc: OPTIONS
>     - 	one of the following:
>     + 	printed at all. The '<filter-spec>' may be one of the following:
>       +
>       The form '--filter=3Dblob:none' omits all blobs.
>      ++
>     @@ builtin/cat-file.c: static void batch_object_write(const char *obj=
_name,
>       		if (pack)
>       			ret =3D packed_object_info(the_repository, pack, offset,
>      @@ builtin/cat-file.c: static void batch_object_write(const char *ob=
j_name,
>     - 			if (data->type =3D=3D OBJ_BLOB)
>       				return;
>     + 			}
>       			break;
>      +		case LOFC_BLOB_LIMIT:
>      +			if (data->type =3D=3D OBJ_BLOB &&
>     -+			    data->size >=3D opt->objects_filter.blob_limit_value)
>     ++			    data->size >=3D opt->objects_filter.blob_limit_value) {
>     ++				if (!opt->all_objects)
>     ++					report_object_status(opt, obj_name,
>     ++							     &data->oid, "excluded");
>      +				return;
>     ++			}
>      +			break;
>       		default:
>       			BUG("unsupported objects filter");
>     @@ t/t1006-cat-file.sh: test_objects_filter () {
>      +test_objects_filter "blob:limit=3D1"
>      +test_objects_filter "blob:limit=3D500"
>      +test_objects_filter "blob:limit=3D1000"
>     -+test_objects_filter "blob:limit=3D1g"
>     ++test_objects_filter "blob:limit=3D1k"
>
>       test_done
>  5:  8e39cd218c2 !  6:  13be54300c9 builtin/cat-file: support "object:typ=
e=3D" objects filter
>     @@ builtin/cat-file.c: static void batch_object_write(const char *obj=
_name,
>       		if (opt->objects_filter.choice =3D=3D LOFC_BLOB_LIMIT)
>       			data->info.sizep =3D &data->size;
>      @@ builtin/cat-file.c: static void batch_object_write(const char *ob=
j_name,
>     - 			    data->size >=3D opt->objects_filter.blob_limit_value)
>       				return;
>     + 			}
>       			break;
>      +		case LOFC_OBJECT_TYPE:
>     -+			if (data->type !=3D opt->objects_filter.object_type)
>     ++			if (data->type !=3D opt->objects_filter.object_type) {
>     ++				if (!opt->all_objects)
>     ++					report_object_status(opt, obj_name,
>     ++							     &data->oid, "excluded");
>      +				return;
>     ++			}
>      +			break;
>       		default:
>       			BUG("unsupported objects filter");
>     @@ t/t1006-cat-file.sh: test_expect_success 'objects filter with unkn=
own option' '
>      @@ t/t1006-cat-file.sh: test_objects_filter "blob:limit=3D1"
>       test_objects_filter "blob:limit=3D500"
>       test_objects_filter "blob:limit=3D1000"
>     - test_objects_filter "blob:limit=3D1g"
>     + test_objects_filter "blob:limit=3D1k"
>      +test_objects_filter "object:type=3Dblob"
>      +test_objects_filter "object:type=3Dcommit"
>      +test_objects_filter "object:type=3Dtag"
>  6:  a0655de3ace =3D  7:  d525a5bc2ef pack-bitmap: allow passing payloads=
 to `show_reachable_fn()`
>  7:  e1e44303dac =3D  8:  e3cc1ae3a87 pack-bitmap: add function to iterat=
e over filtered bitmapped objects
>  8:  23bc040bb15 =3D  9:  c0fc0e4ce0c pack-bitmap: introduce function to =
check whether a pack is bitmapped
>  9:  4eba2a70619 =3D 10:  28ef93dceec builtin/cat-file: deduplicate logic=
 to iterate over all objects
> 10:  d40f1924ef5 =3D 11:  842a6002c50 builtin/cat-file: use bitmaps to ef=
ficiently filter by object type
>

Thanks for the new version, the range-diff looks good. Good that you
also added a test for "excluded" message too.

> ---
> base-commit: 003c5f45b8447877015b2a23ceab2297638fe1f1
> change-id: 20250220-pks-cat-file-object-type-filter-9140c0ed5ee1

--0000000000003eaa1b0631db67c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e654e97534e30f85_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdVJCMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFFUQy8wWTd5NXRNM252bGlreXpaZ25GbE95aVZRQQpvYjh6UVB5dTFJ
ZXd1MWpQSjBTbVA2NldzeUpWeVZEa3NmRGprMnZWcUdWOXVPRFRMQ0J3azdVRzl2YkVEL1pYCld4
Lzk0dlMzRVNaSWkvdTVRcG1qK0MrNjY4S2czRitxcEJpRjJHZVdSSHU2U21CUmhUT2JUaUpseDNy
T2IrVVcKQmw2ZEx6TkErWHFhQnNsVE1mdlpaazZTWjlTZGtVbmo1VFZqR0JmMnFnblZUcFV0cmE5
Mll4aEI4a1BIMzRyRgpHSS9XMGJ3K2lmN2tNVHRKemlQMmVHcmRQN3pJaUxXTkFMWmhlcVNIdi9u
US9nV1hjNE1tL3ZPY2NFUkVRL3VWCkp0Y3MvL1RlNHFUM3BsWnVFZ2ZQUlBLc2orZmFnQS9EUmt1
dmcrZ3E4ZkZhNjFISXNncXdNY0U3bjMyRTFmY0UKdkFSdnp6WWQ2eDNtYWVvbXczYWljekVrSkhz
R1k4elVwZTFBWHd1THcySlY2ZHFEeHA5bjRzTzFaQmZmRjRUaApoQ1dZWHgyQTcwZGtsNFRWY2ZZ
d25CNTBMeGxGMndSNjRrWmpDL0l2ZDA0WTFxNWk2amJ2R3JYcEowdjk5VHptCmMyd3hRbC9kK0dp
NnZSRHY0a0w0UzFWcHlLWXlkY3UvaGRZS0ttdz0KPXJteXYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003eaa1b0631db67c6--
