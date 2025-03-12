Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25125A2A2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809238; cv=none; b=L6e7aRW3vVhR362GWg/AP4xcv/dJMVuOdbu+o5iF9BSCLjx0htYYQj58OeqNI1yVIsYhZ6aJXvrq2FtS3vJr+izKHe4+H1fBTbHdwyKWYkZSMd5S4jw4Z3/aQjlMU+nVRdG2spYf80MOgrVMuwsScKgpKYujFfYt3k4nryfuZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809238; c=relaxed/simple;
	bh=TcpwnOmeUXRfO0qgI8y+mbIdojGseiJvGIJW1DN4A2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3K5PDrIFZx5Z+7MPSSYqwbCzGAVDu7+cVuYdR2LDS2mQlTkfpZ+520enR40s2I3RPATzF9i0cZkP/hbT5PXP6GSYi2ItU5RpM4NLEgpOzrjz7z+uwimuKjuatZsTTwGFdauHSaAbwMmMax2wpoHYbHWyIvlXjTLAfHoXPDHciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ7fc4ZK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ7fc4ZK"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef7c9e9592so1893097b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741809235; x=1742414035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIEy/ZYlDWvc+eSzre3gg65cmCnOdPAb/5u1xjTTqAg=;
        b=LZ7fc4ZKg3Dph+qjW/pgM+ngDOsZVLBkv6sbdf9EEqMZjm3XBZtRhNzarRdyxI5gI9
         AIJLGn/C4fJvs/v901BSKYSthclUZYplIxtEiQSKYgw9C99JW/Z1DyZZ9KrpFtY+2Lng
         hsjwlEfJP/GyByZyRdD87QJLmWtSbdu+8DCGDFGIiLk0kTft4b3MOe1dMaJmY/XqSCMJ
         b6oyNKP4zyX/i5p3vHHuKlSqSBhCU8So7/+vJ+q22uPsNfoMo8lpD03T1CfmE2/nrUZv
         Vyjw3H5AvHCjm2CoSWQH1vEexWS97oAODobC+fKbVbyKMPJjGfVllc1rvPni/AoQm7eY
         WY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809235; x=1742414035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIEy/ZYlDWvc+eSzre3gg65cmCnOdPAb/5u1xjTTqAg=;
        b=NZYRNS6CHHFAUvrlhZz9JmJOSIIYWB/uklKIDKeiHAlbH2dxsl/qzfAfb6tNDKtk+6
         YkhJAw+gjKogVYq3d1qkJtBDGzRvGS4NQwN+zaUB5OA6IhyStO+JmH9IT5eWChfQomiY
         08CITA3nY5D+RwVj9dYo+wJVy2tMd5Wvy/zvjgqt0j2huI3YTXvbjol7z2LtXsYhP231
         3HIs85eJFzc4DW58z7Hdtfm0maf97KF8SY/oevDxRr4UC51ZIsrUmrbW7BshQjPYVo2A
         p8udDGro6IY+yOdXNYhPVmY6inrJR4DuDSlMEhXvgApUW6jox6eAradMcKq99s99UT0a
         nDWw==
X-Gm-Message-State: AOJu0YxBaPMU4rxJ65OXngypqcP2YlUzI7zsnutBfUg2NfSXCnfpofjn
	opxvT8xhhWK8b919dRMMm+fi6O8CNZrxqZEf+s2eEgJTb/E00m3GLIfXtRiZbWEhw+bwL7UuAN6
	HLVTJmzv7/lE2poKOlqyQqmUS+jYOtNfd02k=
X-Gm-Gg: ASbGncv5Rr8muup4NeOdw+EEE0bkW65zjlahB9q/Z/PmqPPVVP1QyUiDULcj4zV/Pen
	uOl1nvpm0/oPYZInGscb1s2uYOhQLoN7sT6cBDiJfgn8AHyYBCMh+PppSO7ldYOInvsG5PyPjok
	ncVJn3h47hAliDz+rCUlO+dY8rI3U=
X-Google-Smtp-Source: AGHT+IFAwYOkGCcTSAdfuwD6dFT7W84dES8MxfrRcO1N2RXodMktkZFcbdMMECzPSzeHavUDkMI1+J8lq6d296GUTDE=
X-Received: by 2002:a05:690c:6411:b0:6fe:b109:6965 with SMTP id
 00721157ae682-6febf3fa49bmr340151487b3.35.1741809235097; Wed, 12 Mar 2025
 12:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com> <20250114021502.41499-9-eric.peijian@gmail.com>
 <20250201020321.GA4081169@coredump.intra.peff.net> <CAN2LT1AFA8AG58NNVvW2nvWR27qisPXDzSTR-tUycWGi96kcaw@mail.gmail.com>
 <20250224234525.GB729825@coredump.intra.peff.net>
In-Reply-To: <20250224234525.GB729825@coredump.intra.peff.net>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 12 Mar 2025 15:53:44 -0400
X-Gm-Features: AQ5f1Jq19gMe55a43iTpGvDiyCdxg7e8CSOsJ2UpB_StBICBHPKE7W4CURe8wjs
Message-ID: <CAN2LT1A97fz+KXTVd+hziNjqJheuJB60nountB9CLiwdmb7D_w@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] cat-file: add remote-object-info to batch-command
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:45=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 21, 2025 at 10:34:44AM -0500, Peijian Ju wrote:
>
> > Thank you. Revised to use xstrdup() in v11.
> >
> > >   2. Are there any bounds on the size of "line"? E.g., is it coming i=
n
> > >      as a single pkt, or can it be arbitrarily large if an attacker
> > >      wants (it looks like maybe the latter, since it comes from a str=
buf
> > >      in batch_objects_command(), but I didn't look at how network dat=
a
> > >      gets passed in to that). At any rate, I think we ran into proble=
ms
> > >      before with split_cmdline() and integer overflow, since it retur=
ns
> > >      an int (CVE-2022-39260). I thought we fixed it by rejecting long
> > >      lines in git-shell, but it looks like we also hardened
> > >      split_cmdline() in 0ca6ead81e (alias.c: reject too-long cmdline
> > >      strings in split_cmdline(), 2022-09-28).
> > >
> > >      So we are maybe OK, but I wonder if we should punt on absurd lin=
es.
> > >      Related, can an attacker just flood input into that strbuf, maki=
ng
> > >      it grow forever and waste memory? That's just a simple resource
> > >      attack, but we have tried to avoid those elsewhere in upload-pac=
k,
> > >      etc.
> > >
> >
> > Thank you. Adding a check in v11 for the length of `lines`. Please let
> > me know if something like this makes sense:
> >
> > if (strlen(line) >=3D INT_MAX) {
> >         die(_("remote-object-info command input overflow"));
> > }
>
> I took a look at what you ended up with in v11, and...I think I totally
> misunderstood what was going on in your series, or when this code would
> be run.
>
> I had thought the cat-file here was running on the server side, and that
> we needed to protect ourselves against malicious clients. But your new
> parse_cmd_remote_object_info() is purely a client-side function that
> will then access the server behind the scenes. And its input will be
> coming from the stdin of cat-file locally.
>
> So I'm not sure that we need to protect it unless we think there's some
> way that an attacker can automatically trigger arbitrary
> remote-object-info requests.
>

Thank you. Yes, remote-object-info is purely a client-side command.If
an attacker is able to automatically
trigger arbitrary remote-object-info requests, it likely means they
already have control over that system.

From my understanding, Git generally trusts its clients. So unless
there are strong objections,
I will revert those input length checks.


> That said, I'm not sure why you need split_cmdline() at all. The format
> seems to be:
>
>   remote-object-info <url> <oid>...
>
> The only thing that _might_ need quoting is the url, but is shell
> quoting a reasonable thing there? I'd think that it would be
> URL-encoded, and thus contain no spaces. The <oid> has to be a real full
> oid, I think, because the object-info on the server side insists on
> that.
>

Thank you! We hadn=E2=80=99t given much thought to the URL format earlier,
but I agree that it=E2=80=99s reasonable to require the URL in
remote-object-info to be properly URL-encoded.

With that assumption, splitting on spaces makes sense. I=E2=80=99ll update
this in the next patch and
also revise the documentation to clarify that URL parameters must be
URL-encoded.


> So why not just split on space? Something like this:
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 9de1016acd..aedbcba347 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -597,7 +597,7 @@ static void batch_one_object(const char *obj_name,
>         object_context_release(&ctx);
>  }
>
> -static int get_remote_info(struct batch_options *opt, int argc, const ch=
ar **argv)
> +static int get_remote_info(struct batch_options *opt, const char *url, c=
onst char *oid_list)
>  {
>         int retval =3D 0;
>         struct remote *remote =3D NULL;
> @@ -613,16 +613,19 @@ static int get_remote_info(struct batch_options *op=
t, int argc, const char **arg
>         if (!opt->format)
>                 opt->format =3D "%(objectname) %(objectsize)";
>
> -       remote =3D remote_get(argv[0]);
> +       remote =3D remote_get(url);
>         if (!remote)
>                 die(_("must supply valid remote when using remote-object-=
info"));
>
>         oid_array_clear(&object_info_oids);
> -       for (size_t i =3D 1; i < argc; i++) {
> -               if (get_oid_hex(argv[i], &oid))
> -                       die(_("Not a valid object name %s"), argv[i]);
> +       while (*oid_list) {
> +               if (parse_oid_hex(oid_list, &oid, &oid_list))
> +                       die(_("Not a valid object name %s"), oid_list);
>                 oid_array_append(&object_info_oids, &oid);
> +               while (*oid_list =3D=3D ' ')
> +                       oid_list++;
>         }
> +
>         if (!object_info_oids.nr)
>                 die(_("remote-object-info requires objects"));
>
> @@ -747,21 +750,15 @@ static void parse_cmd_remote_object_info(struct bat=
ch_options *opt,
>                                          const char *line, struct strbuf =
*output,
>                                          struct expand_data *data)
>  {
> -       int count;
> -       const char **argv;
> -       char *line_to_split;
> -
> -       if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
> -               die(_("remote-object-info command input overflow "
> -                       "(no more than %d objects are allowed)"),
> -                       MAX_ALLOWED_OBJ_LIMIT);
> +       char *url;
> +       const char *space;
>
> -       line_to_split =3D xstrdup(line);
> -       count =3D split_cmdline(line_to_split, &argv);
> -       if (count < 0)
> -               die(_("split remote-object-info command"));
> +       space =3D strchr(line, ' ');
> +       if (!space)
> +               return; /* report error somehow? */
> +       url =3D xmemdupz(line, space - line);
>
> -       if (get_remote_info(opt, count, argv))
> +       if (get_remote_info(opt, url, space + 1))
>                 goto cleanup;
>
>         data->skip_object_info =3D 1;
> @@ -774,16 +771,15 @@ static void parse_cmd_remote_object_info(struct bat=
ch_options *opt,
>                          */
>                         data->size =3D *remote_object_info[i].sizep;
>                         opt->batch_mode =3D BATCH_MODE_INFO;
> -                       batch_object_write(argv[i+1], output, opt, data, =
NULL, 0);
> +                       batch_object_write(oid_to_hex(&data->oid), output=
, opt, data, NULL, 0);
>                 }
>         }
>         data->skip_object_info =3D 0;
>
>  cleanup:
>         for (size_t i =3D 0; i < object_info_oids.nr; i++)
>                 free_object_info_contents(&remote_object_info[i]);
> -       free(line_to_split);
> -       free(argv);
> +       free(url);
>         free(remote_object_info);
>  }
>
>
> You'd need to adjust t1017 to remote the quotes from the inputs, and I
> think you'd have to correctly url-encoded the file:// one to avoid
> spaces (but that is technically true already! If the filesystem path has
> a "%" in it, it would be misinterpreted).
>

Thank you. Tests will be adjusted.
> -Peff
