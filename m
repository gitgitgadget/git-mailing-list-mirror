Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAEF61163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhJFJPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJFJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:15:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8149C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:13:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so7095857edc.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8IymETce5Fo04ns77Gm4sGHHWURAyWUGPIP8QJz4gew=;
        b=A3jtYHTDR/1vM5Zi6W84o6lUAxLkRUeS44ZxHo61sH/eV959Tl2DToNSKRtjFkUU7w
         N/MmIGqIlhY/On1w87P6+GGsuBrmWc0fY1WRhJ8zfvPXaV7bRh8zxICJgAzSnVub6i0V
         6KCjccpmKHEDec5LVrrYyMVuVXdTbwouxlkIBaPobZSDQKchcdS9I/TmM4KxtbTHpkUo
         z42KyBW6PJP8/RNGx6mypkLIkY0vChOVtTV0qEVgwjS/m4PSrlhGWbOlVWTwGyKbvfuV
         jfvrN6PyhVFGafWZ7i7PrJoNK8zMaM0SkefTdNREBXn/4nSkPZcgwQzN0w8ehB9URcN7
         IKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8IymETce5Fo04ns77Gm4sGHHWURAyWUGPIP8QJz4gew=;
        b=jIZYDZEPnfgi7sDRaeSihgT0Rf5ENH2+TDIzs+ns938jEnzGXUxaAKfoOyH7iXbg2u
         5plJ8f8a558vTZaEo3zGXOFkfDd8tK9R5Ef1pfh3dAyC5/cc0n5DAi/iiDyYmB+zcYwO
         1Tv9/HNYdPbJpz+t49N/v66i6uxAtZ0yxhCnc+Udy7agRSlN9eqFQb00AeNTgy1/VuUi
         tuSZzi4WRkbb5vSPY15UD5FKAwEugQtHFYfeU/wTEVlDdhpBpT3eMPgsEslzR2oa9rPs
         azexWL02ytyVAuK/fNhQsDIYd8jmtcwi2myVcBy0OdB6MsQsebtW5HVzaTRdSjwSQ9/8
         cvUw==
X-Gm-Message-State: AOAM532Y2RlwUEiOI2Hyq3TliFmR5l77TPX5vBc6Hje332vutjxp9foo
        fkxNLzfniefT6uSaCzqsdwvK6tum1hYMWA==
X-Google-Smtp-Source: ABdhPJxzr6QvVmw0Ue2s+gf8RbJLE0oRI5+GJETyJ1Za6/9JkD3KYvLd6xlsl37shvwPcR1gO3IYgg==
X-Received: by 2002:a50:fc83:: with SMTP id f3mr20845768edq.134.1633511630230;
        Wed, 06 Oct 2021 02:13:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d17sm5552001edv.58.2021.10.06.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:13:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Date:   Wed, 06 Oct 2021 11:02:59 +0200
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
Message-ID: <87tuhuikhf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Jeff King wrote:

> On Tue, Oct 05, 2021 at 11:02:38PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> > index 4eb0421b3f..6467707c6e 100644
>> > --- a/Documentation/git-cat-file.txt
>> > +++ b/Documentation/git-cat-file.txt
>> > @@ -94,8 +94,9 @@ OPTIONS
>> >  	Instead of reading a list of objects on stdin, perform the
>> >  	requested batch operation on all objects in the repository and
>> >  	any alternate object stores (not just reachable objects).
>> > -	Requires `--batch` or `--batch-check` be specified. Note that
>> > -	the objects are visited in order sorted by their hashes.
>> > +	Requires `--batch` or `--batch-check` be specified. By default,
>> > +	the objects are visited in order sorted by their hashes; see
>> > +	also `--unordered` below.
>> >=20=20
>> >  --buffer::
>> >  	Normally batch output is flushed after each object is output, so
>>=20
>> Since you're doing while-you're-at-it anyway: Isn't the --unordered
>> documentation also incorrect to reference --batch, which I take as it
>> lazily using as a shorthand for --batch-all-objects.
>
> I don't think so. It says:
>
> --unordered::
>         When `--batch-all-objects` is in use, visit objects in an
>         order which may be more efficient for accessing the object
>         contents than hash order. The exact details of the order are
>         unspecified, but if you do not require a specific order, this
>         should generally result in faster output, especially with
>         `--batch`.  Note that `cat-file` will still show each object
>         only once, even if it is stored multiple times in the
>         repository.
>
> So it correctly mentions that it is affecting --batch-all-objects in the
> first sentence. The "especially with --batch" is correct, too. The
> ordering has more of an effect if you are accessing the full object,
> since there we are increasing the locality which the delta-base cache
> relies on.  Whereas with --batch-check, even with size or type, that
> locality is much less important (it might help disk or even RAM caches a
> bit, but we are examining each object independently, even if it's a
> delta, and not caching the intermediate results in any way ourselves).
>
> Does that answer your question, or were you thinking of something else?

Urgh.

This is the Nth time I've completely failed to mentally model how this
command works, after having hacked on it extensively.

I thought that --batch-all-objects and --batch were mutually exclusive,
but they're obviously not.

In my defense I think the help/code is very confusing. I hacked up some
WIP changes to change it from:
=20=20=20=20
    $ git cat-file -h
    usage: git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-ty=
pe] | -e | -p | <type> | --textconv | --filters) [--path=3D<path>] <object>
       or: git cat-file (--batch[=3D<format>] | --batch-check[=3D<format>])=
 [--follow-symlinks] [--textconv | --filters]
=20=20=20=20
    <type> can be one of: blob, tree, commit, tag
        -t                    show object type
        -s                    show object size
        -e                    exit with zero when there's no error
        -p                    pretty-print object's content
        --textconv            for blob objects, run textconv on object's co=
ntent
        --filters             for blob objects, run filters on object's con=
tent
        --path <blob>         use a specific path for --textconv/--filters
        --allow-unknown-type  allow -s and -t to work with broken/corrupt o=
bjects
        --buffer              buffer --batch output
        --batch[=3D<format>]    show info and content of objects fed from t=
he standard input
        --batch-check[=3D<format>]
                              show info about objects fed from the standard=
 input
        --follow-symlinks     follow in-tree symlinks (used with --batch or=
 --batch-check)
        --batch-all-objects   show all objects with --batch or --batch-check
        --unordered           do not order --batch-all-objects output
=20=20=20=20
To:
=20=20=20=20
    usage: git cat-file (-e | -p) <object>
       or: git cat-file ( -t | -s ) [--allow-unknown-type] <object>
       or: git cat-file [--batch-all-objects] [--batch | --batch-check] [--=
buffer] [--follow-symlinks] [--unordered]
       or: git cat-file [--textconv|--filters] [--path=3D<path|tree-ish> <r=
ev> | <rev>:<path|tree-ish>]
=20=20=20=20
    Check object existence or emit object contents
        -e                    check if <object> exists
        -p                    pretty-print <object> content
=20=20=20=20
    Emit [broken] object attributes
        -t                    show object type (one of 'blob', 'tree', 'com=
mit', 'tag', ...)
        -s                    show object size
        --allow-unknown-type  allow -s and -t to work with broken/corrupt o=
bjects
=20=20=20=20
    Run <rev>:<blobs|tree> via conversion or filter
        --textconv            for blob objects, run textconv on object's co=
ntent
        --filters             for blob objects, run filters on object's con=
tent
        --path <blob>         use a specific path for --textconv/--filters
=20=20=20=20
    Emit objects in batch via requests on STDIN, or --batch-all-objects
        --batch-all-objects   Emit all objects in the repository, instead o=
f taking requests on STDIN
        --buffer              buffer --batch output
        --batch[=3D<format>]    show info and content of objects fed from t=
he standard input
        --batch-check[=3D<format>]
                              show info about objects fed from the standard=
 input
        --follow-symlinks     follow in-tree symlinks
        --unordered           do not order objects before emitting them

Which actually reflects reality, i.e. half of the options aren't
accepted by the batch mode, so grouping them makes sense, and the
current help gives the impression that e.g. --textconv can be used with
--batch, but it's effectively a CMDMODE.

Then we don't document that [--textconv|--filters] will fallback to -p
if given <tree-ish>, I'm not sure if that's intentional (but a
"fallthrough" comment suggests so).

And we silentnly accept --buffer etc. without the batch mode, but it
should die.

Looking at the history it seems you added --batch-all-objects around the
same time as the OPT_CMDMODE() was used in the command, so we should
probably have something like this to start with:

-- >8 --
Subject: [PATCH] cat-file: make --batch-all-objects a CMDMODE

The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
the development of[3] the --batch-all-objects option[4], so we've
since grown[5] checks that it can't be combined with other command
modes, when it should just be made a top-level command-mode
instead. It doesn't combine with --filters, --textconv etc.

1. b48158ac94c (cat-file: make the options mutually exclusive, 2015-05-03)
2. https://lore.kernel.org/git/xmqqtwspgusf.fsf@gitster.dls.corp.google.com/
3. https://lore.kernel.org/git/20150622104559.GG14475@peff.net/
4. 6a951937ae1 (cat-file: add --batch-all-objects option, 2015-06-22)
5. 321459439e1 (cat-file: support --textconv/--filters in batch mode, 2016-=
09-09)

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 243fe6844bc..50861bb02da 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -643,6 +643,8 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_CMDMODE(0, "filters", &opt,
 			    N_("for blob objects, run filters on object's content"), 'w'),
+		OPT_CMDMODE(0, "batch-all-objects", &opt,
+			    N_("show all objects with --batch or --batch-check"), 'b'),
 		OPT_STRING(0, "path", &force_path, N_("blob"),
 			   N_("use a specific path for --textconv/--filters")),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
@@ -658,8 +660,6 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 			batch_option_callback),
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
-		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
-			 N_("show all objects with --batch or --batch-check")),
 		OPT_BOOL(0, "unordered", &batch.unordered,
 			 N_("do not order --batch-all-objects output")),
 		OPT_END()
@@ -669,28 +669,25 @@ int cmd_cat_file(int argc, const char **argv, const c=
har *prefix)
=20
 	batch.buffer_output =3D -1;
 	argc =3D parse_options(argc, argv, prefix, options, cat_file_usage, 0);
-
-	if (opt) {
+	if (argc && batch.enabled)
+		usage_with_options(cat_file_usage, options);
+	if (opt =3D=3D 'b') {
+		batch.all_objects =3D 1;
+	} else if (opt) {
 		if (batch.enabled && (opt =3D=3D 'c' || opt =3D=3D 'w'))
 			batch.cmdmode =3D opt;
 		else if (argc =3D=3D 1)
 			obj_name =3D argv[0];
 		else
 			usage_with_options(cat_file_usage, options);
-	}
-	if (!opt && !batch.enabled) {
+	} else if (!opt && !batch.enabled) {
 		if (argc =3D=3D 2) {
 			exp_type =3D argv[0];
 			obj_name =3D argv[1];
 		} else
 			usage_with_options(cat_file_usage, options);
-	}
-	if (batch.enabled) {
-		if (batch.cmdmode !=3D opt || argc)
-			usage_with_options(cat_file_usage, options);
-		if (batch.cmdmode && batch.all_objects)
-			die("--batch-all-objects cannot be combined with "
-			    "--textconv nor with --filters");
+	} else if (batch.enabled && batch.cmdmode !=3D opt) {
+		usage_with_options(cat_file_usage, options);
 	}
=20
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
--=20
2.33.0.1441.gbbcdb4c3c66
