Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DB343889
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150226; cv=pass; b=DvWHCFPJxIkzh/L9L5Q03HG4X0/FYldeB1PJ+be8PLHAtMcKBiMTPB11ItYv8jQbMxh3GpgJneIA9wkX1ezoyhckRXnn7Hpye/r/5NdxEOZBPXCX6Y6vSk3gfR7hzQPKKd/GqgO4m5rCgXU1uCpJ0uoEMz87Tr0/5sTNV3CBIys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150226; c=relaxed/simple;
	bh=pz441eu4ESInPREOEBE1D2GBbsZYcyDpghZz36OpxH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY3TF0YFGaEbOMNHHHniS1am/zm1Tt7AhHD86vHz4sjqaSKv6f2+6YWIUHeVqMrKdjiraSh6ZXRb+yeq77aLNkEhyruy1hdbPUgNIL/9abMCjSrJkrsZhAwyZu5YA3q6pzHu4SEWuO6uIOTMrJwZ/LlvtPCOuaR3n6WK6TNJbrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxa/QpFV; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxa/QpFV"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7f4f0c89e34so160462a34.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150216; cv=none;
        d=google.com; s=arc-20260327;
        b=A5LC99ZrmEAxMyeKMcsGcDiBdFT1FaIBdCi49w/e+2UjP6tnpVmdr0exU3COBrSKdr
         HBRYeiFZ3qTCA9OYbzMJTM7TDeYnI/jsjg5J4xgii42eYxBU+H/jWR5SrhhIyRWnq8VU
         Uk8mnq5l7ewJqyf386TqkWm22b9J+HmYTR0/GjD4sz/d6fIwehq7FaKi/eA628GRRs0A
         qkRvfNcpohyhNU0ZyslwUNGTzlYNUX0PnSyXvsNfwzdtdiYoVsMmbvKO4JIoYVPVQtP9
         xSMJepuOIMacIYEoiIAk7kMdyKwI1dkXZvnuUmJ7fNcxpmZCW2p4RWTiBMtz/9rR6oGp
         Ok+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzWoK76AAn3/R6eWwhOc/RPkZXvI2LaZahlVDFUWdWU=;
        fh=NsHUkjK6rlqdfpYMwU6zlqMPfZYJIvzeJJcHD5Bou+c=;
        b=ZJsDoj1mH5WIHEEEyG/NpCHKAp5z2k630RIBS85da/RFYWqoRVxFz8g5TJQpAQSe8p
         UCQ4jaSsViJAN5i6HNtrSRQYp/zMFNLyO8pPJiAj5tsh1X/AbqZiybJTfVkAKr2XLtAp
         EKm9Pw70EUcw2PnbbXw2ogCYTDOBRZHw12nb1JeF60Fk1ft8YikvPGrMo7XM3mlw0iap
         w/yft/HhWa9e89pdrSf7EMM2+0jZbwkCMH8q7umTIq0A9hxc/Rp+n4XO0nfBfz4TeZrA
         IejZkaKmhDEZaPf41xMaWij8hhWXzJ8Y2uVE6AoFte/EBmdPHZegIxqjI4dSU3pgjaaE
         aRzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150216; x=1789755016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzWoK76AAn3/R6eWwhOc/RPkZXvI2LaZahlVDFUWdWU=;
        b=Oxa/QpFVDgThFJKbdfxeJ06YWTm41nFZ3VUT0ILWpq9ZGBSXHBZXeLBfyh9je6sP/o
         IPlB0KwzHsRLSfEY/XCFERuG6RZmrCg07Dj31DPOSkM4W+bHPGaaM3BnbrnAXoQExr6X
         62RejxutWWyR5DSgTmvyLvNqwWw6iLw4mEtcMWsz0mimlrQTKKkpFBNfBpfGg8xx+bgh
         yi0641wQxFPh1DShrwY6UGf1aaSr/0FdNwse1hM/CPY+3mxiOZoJCSm6NobfWUHN4KMo
         wtkGqTZYes/dNT9HP3gayn5MNpLpwRYnxsu67Zon5FxlFXSGRzM1inQ0pE+nS7QB8yRm
         iCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150216; x=1789755016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzWoK76AAn3/R6eWwhOc/RPkZXvI2LaZahlVDFUWdWU=;
        b=YQqGFeg0zLevuA7ddVCIRIw5Lp0qQ/+QEGMqlPAT/fXTwczdQKWpqcVfYyE/uUywPZ
         1R6Ip407ajEFPiutj94vLz2Mjf+Gvd0AJh62aIdDg9nIn95a0CMtxj7voaRNIK6ZiTGE
         DSouoWvmPjUyMRwCiZXUpvhG22luBnij8HvfI3Hcyg9xCaFgtLzkwM+qb955RVZxtKyu
         6+8a3+JwO9gsFPvCfjHeFwEPpcQ8T3pnS2jCNfUjv9Pb6yO13kGUIOQwGXBZA21LvPXQ
         tegftEIEXhO/tga37w5PcssIuFJRJj9iTmJLibsK4oWPyClqKHsP363c6qj8O0Ys9dLJ
         C7Ow==
X-Forwarded-Encrypted: i=1; AKwUvBz6bawbo32MlKYFcv6G7WF2iZndXsE+EX01zMTenYzMtuIFyT/oTRuqfeKKfkA1h38Xvjc=@vger.kernel.org
X-Gm-Message-State: AFuF++nX7MiMAOdILYLIW2emNGWkKRpd+GsNQ9fFXUhR4QvK7Yekgsem
	dId9qqbLrIgldKeEBr7GASZK5Ho38UeVv0kNNTDpWOj/tO1epPe4B34FcajaW9+ZkXobCoaQxlV
	XZpo6764RuGLPSQUVfyfm4ZmvGZ37W+w=
X-Gm-Gg: AYBFou01Q1HRxIg+Bm+8i06aOrX0Au80oD5NPLivo5UNb1tKwAy/spAOkaWjItftUE4
	NBgqPkwn8SYgIHiyqk5H5Fo8WBLdQ9dn8zGYkUUtJGrayxOmJkCSfjZFDJulPXS0bcOMXk/NIK6
	+isA9Ou2SL7dnWtR+XYPQlgQvQFe6PT5WKm9eS6nELmopg8QM6zV3OOhV4mha3h4KnxXc0DYHlD
	FC3gsca7kiaj7mwX+9oVpJdec/JMj3RMCznM0ak/QnSN96WK/IqDOgHYBDo6TQs553Gr29Xb16P
	PowEsfRn4ZmkFEMawaqn2Nz7ql3YjlwLetUt4G4s6eNf9rdmyPDlofEz2XyOFHRJmzxDjpCbMZ2
	1SndXHtLN2JfMJpunWE+HpJOKeAtENbxSw3M7aZatfyLk28xKZrh5haBDf9o6aZjWkEDBR5RB
X-Received: by 2002:a05:6820:813:b0:6b7:46fa:16a9 with SMTP id
 006d021491bc7-6c0bdb6ca32mr3795072eaf.62.1789150216576; Fri, 11 Sep 2026
 11:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911171044.GA1609692@coredump.intra.peff.net> <20260911171339.GC1610200@coredump.intra.peff.net>
In-Reply-To: <20260911171339.GC1610200@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 11 Sep 2026 11:10:03 -0700
X-Gm-Features: AcwNN1X-50LmeXOJvjms0OIB3zA6nabH9PxtPA-6eQWdlog032KHwpwb44cwLhc
Message-ID: <CABPp-BFyKaByMYZ212O3cB2GD9OjNJNZEO+krf2GGs9vxFYPhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] merge-ll: use tempfile API for external driver files
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.de>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:13=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> When there's a long(er) running merge driver helper, the user may just
> decide to terminate it with Ctrl+C. That sends a signal to the driver
> prog and to the whole process group as well, including the git merge

Minor nit:

prog -> program ?  or -> process ?

Or maybe tweak whole sentence? :  That sends a signal to the whole
foreground process group, including both the driver and the git merge
process.

> command proper. Hence the cleanup code would not run and .merge_file_*
> files are left behind.
>
> We can fix this by using the tempfile API, which auto-cleans files on
> signal or other error. That covers the Ctrl+C case above, as well as any
> other incidental death (e.g., allocation error due to a gigantic
> output).
>
> Note that there is one gotcha here. The current code uses short,
> relative filenames for the tempfiles (like ".merge_file_abc123"). But
> the tempfile API stores and returns absolute paths. Because we run the
> merge driver as a shell command, this can result in problems if the
> leading directories contain shell metacharacters (like our tests, which
> put a space in the trash directory name for exactly this purpose).
>
> If we were starting from scratch, I'd say the correct solution here is
> to shell-quote the filenames we put in the command. But doing so isn't
> strictly backwards compatible, because users might have their own shell
> characters. For example, if I configure a driver like this:
>
>   [merge "foo"]
>   driver =3D "my-driver '%O' '%A' '%B'"
>
> then adding extra quoting will screw things up! Strictly speaking, this
> kind of quoting is wrong (it would fail if %A expanded to something with
> a single-quote in it), but it is entirely harmless with the current
> vanilla relative paths. It doesn't seem worth breaking it.
>
> So let's take the most conservative route, and just continue reporting
> the relative paths.
>
> Commit-message-stolen-from: Michal Koutn=C3=BD <mkoutny@suse.com>

:-)

But maybe Commit-message-mostly-stolen-from?  Much of your commit
message is understandably about tempfile specifics, which the original
didn't have.

(Yeah, probably not important enough to bother changing; I'm just
"thinking out loud" as I read...)

> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  merge-ll.c | 50 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/merge-ll.c b/merge-ll.c
> index 5a11a9613b..ec0f012b4f 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -17,6 +17,7 @@
>  #include "quote.h"
>  #include "strbuf.h"
>  #include "gettext.h"
> +#include "tempfile.h"
>
>  struct ll_merge_driver;
>
> @@ -174,15 +175,27 @@ static struct ll_merge_driver ll_merge_drv[] =3D {
>         { "union", "built-in union merge", ll_union_merge },
>  };
>
> -static void create_temp(mmfile_t *src, char *path, size_t len)
> +static struct tempfile *create_temp(mmfile_t *src)
>  {
> -       int fd;
> -
> -       xsnprintf(path, len, ".merge_file_XXXXXX");
> -       fd =3D xmkstemp(path);
> -       if (write_in_full(fd, src->ptr, src->size) < 0 ||
> -           close(fd) < 0)
> +       struct tempfile *t =3D xmks_tempfile(".merge_file_XXXXXX");
> +       if (write_in_full(t->fd, src->ptr, src->size) < 0 ||
> +           close_tempfile_gently(t) < 0)
>                 die_errno("unable to write temp-file");
> +       return t;
> +}
> +
> +static const char *temp_path_basename(struct tempfile *t)
> +{
> +       /*
> +        * basename() takes a non-const pointer because it can
> +        * modify the input string to remove trailing directory
> +        * separators. We know that we don't have any because
> +        * this is a clean path generated from our vanilla
> +        * tempfile template.
> +        *
> +        * So casting away the const here is safe, albeit gross.
> +        */
> +       return basename((char *)get_tempfile_path(t));

Thanks for the comment.

>  }
>
>  /*
> @@ -197,11 +210,11 @@ static enum ll_merge_result ll_ext_merge(const stru=
ct ll_merge_driver *fn,
>                         const struct ll_merge_options *opts,
>                         int marker_size)
>  {
> -       char temp[3][50];
> +       struct tempfile *tmp_o, *tmp_a, *tmp_b;
>         struct strbuf cmd =3D STRBUF_INIT;
>         const char *format =3D fn->cmdline;
>         struct child_process child =3D CHILD_PROCESS_INIT;
> -       int status, i;
> +       int status;
>         struct strbuf result_buf =3D STRBUF_INIT;
>         enum ll_merge_result ret;
>         assert(opts);
> @@ -211,19 +224,19 @@ static enum ll_merge_result ll_ext_merge(const stru=
ct ll_merge_driver *fn,
>
>         result->ptr =3D NULL;
>         result->size =3D 0;
> -       create_temp(orig, temp[0], sizeof(temp[0]));
> -       create_temp(src1, temp[1], sizeof(temp[1]));
> -       create_temp(src2, temp[2], sizeof(temp[2]));
> +       tmp_o =3D create_temp(orig);
> +       tmp_a =3D create_temp(src1);
> +       tmp_b =3D create_temp(src2);
>
>         while (strbuf_expand_step(&cmd, &format)) {
>                 if (skip_prefix(format, "%", &format))
>                         strbuf_addch(&cmd, '%');
>                 else if (skip_prefix(format, "O", &format))
> -                       strbuf_addstr(&cmd, temp[0]);
> +                       strbuf_addstr(&cmd, temp_path_basename(tmp_o));
>                 else if (skip_prefix(format, "A", &format))
> -                       strbuf_addstr(&cmd, temp[1]);
> +                       strbuf_addstr(&cmd, temp_path_basename(tmp_a));
>                 else if (skip_prefix(format, "B", &format))
> -                       strbuf_addstr(&cmd, temp[2]);
> +                       strbuf_addstr(&cmd, temp_path_basename(tmp_b));
>                 else if (skip_prefix(format, "L", &format))
>                         strbuf_addf(&cmd, "%d", marker_size);
>                 else if (skip_prefix(format, "P", &format))
> @@ -242,13 +255,14 @@ static enum ll_merge_result ll_ext_merge(const stru=
ct ll_merge_driver *fn,
>         strvec_push(&child.args, cmd.buf);
>         status =3D run_command(&child);
>
> -       if (strbuf_read_file(&result_buf, temp[1], 0) >=3D 0) {
> +       if (strbuf_read_file(&result_buf, get_tempfile_path(tmp_a), 0) >=
=3D 0) {
>                 result->size =3D result_buf.len;
>                 result->ptr =3D strbuf_detach(&result_buf, NULL);
>         }
>
> -       for (i =3D 0; i < 3; i++)
> -               unlink_or_warn(temp[i]);
> +       delete_tempfile(&tmp_o);
> +       delete_tempfile(&tmp_a);
> +       delete_tempfile(&tmp_b);
>         strbuf_release(&cmd);
>         if (!status)
>                 ret =3D LL_MERGE_OK;
> --
> 2.56.0.rc0.314.g7a874b6915

Looks good to me.
