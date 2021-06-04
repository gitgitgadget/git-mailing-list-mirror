Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B466C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E45661405
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFDJtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJtu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 05:49:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7DFC06174A
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 02:47:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so4352668plf.11
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PzQYn7hKULLjG5/aWOpZmi6olgr4losYm/DQyRKVn4U=;
        b=EqX431DiAX6TkelRRTcx6MRlfOzLeKd95DT6PxdE1vKu9nbweGmbGfeMz7++AxCXkb
         k4AJi9AS8D/7ZUOVVzieOS6KK1MSr5hscBc9sA8XzpRJICfKI/ptrTPnLDfhIp//Fpuw
         XBlEem//6EjJj7vkXOm/JEwtRQxcw/3RhK68hGWInQ6bWqfKnIVcdOXsH4eazOy0qDh3
         IwZK+TM5WXQr5l8yy8hJ00ciISHND0W/wBXz2Cgqhsfquy5X+Fwh0/yDL5vGPUoQdtaz
         HHVo7QGXN791MZ+pKioqe0PeOcs5RV72tcMLfKJ94XuiyV7DR8t2DLNvRZLBLEsN0Dj0
         1jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PzQYn7hKULLjG5/aWOpZmi6olgr4losYm/DQyRKVn4U=;
        b=BtnbBy5r5wd+hy3wYxPND7zweJvhBI+H5wXs9zqGkfmH96tL1UqsF0VXsMsY+2MQke
         0AP4CQpjTB71hHES/KUcSYOFS8LjfhWGv+yDuF3Si/Ic3YPpgCg3cPO2i6rB+2tU6q7O
         Bvm1iCy17rQCIr/ACAxLfI7AN8XaLy+LDzlGH3xjUlgmbQEYe3Dl4h6mu/d/WhGPXdc1
         T+ttzyZ/bCrkc8el845ICAgHawDZK3BQfgNwAD6CNkO1bZxZ4KxMQqzpcRu9XdIo46mi
         iP+GH961Su56McvpBQUnOCNGWpaS4/hgEcRFWBmD5l92U8EMpMx79c1lmAdAYCMBe2Uf
         NBlQ==
X-Gm-Message-State: AOAM533axPYFsOx3rgFxwr7imwiKBCZfGMBHSoQ7y8FbOZpMZYrah7d8
        v+JAHnz+fqzKGjFrlcXSb+o=
X-Google-Smtp-Source: ABdhPJykccv+RA8JYjpVle18NWpZcsPLUP3MEcIzj4Ch5qlmzB+ibIoFamHqdtuBXhAFhcdBJvC6wQ==
X-Received: by 2002:a17:90a:4f0a:: with SMTP id p10mr16303045pjh.36.1622800073099;
        Fri, 04 Jun 2021 02:47:53 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id g29sm1528170pgm.11.2021.06.04.02.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 02:47:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] [GSoC] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD01-VJpUEGg3cEG7X=xU0KCv1AEgq2n_qhk=U+rXV5mvA@mail.gmail.com>
Date:   Fri, 4 Jun 2021 15:17:48 +0530
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11A04D37-41CB-43D7-B237-3BFA10B1313A@gmail.com>
References: <20210528081224.69163-1-raykar.ath@gmail.com>
 <20210602131259.50350-1-raykar.ath@gmail.com>
 <CAP8UFD01-VJpUEGg3cEG7X=xU0KCv1AEgq2n_qhk=U+rXV5mvA@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Jun-2021, at 13:51, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Wed, Jun 2, 2021 at 3:13 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>=20
>> +static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
>> +{
>> +       struct child_process cp_remote =3D CHILD_PROCESS_INIT;
>> +       struct strbuf sb_remote_out =3D STRBUF_INIT;
>> +
>> +       cp_remote.git_cmd =3D 1;
>> +       strvec_pushf(&cp_remote.env_array,
>> +                    "GIT_DIR=3D%s", git_dir_path);
>> +       strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
>> +       strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
>> +       if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
>> +               char *line;
>> +               char *begin =3D sb_remote_out.buf;
>> +               char *end =3D sb_remote_out.buf + sb_remote_out.len;
>> +               while (begin !=3D end && (line =3D =
get_next_line(begin, end))) {
>> +                       char *name, *url, *tail;
>> +                       name =3D parse_token(&begin, line);
>> +                       url =3D parse_token(&begin, line);
>> +                       tail =3D parse_token(&begin, line);
>=20
> Sorry for not replying to your earlier message, but I think it's a bit
> better to save a line with:
>=20
>                       char *name =3D parse_token(&begin, line);
>                       char *url =3D parse_token(&begin, line);
>                       char *tail =3D parse_token(&begin, line);

Alright.

>> +                       if (!memcmp(tail, "(fetch)", 7))
>> +                               fprintf(output, "  %s\t%s\n", name, =
url);
>> +                       free(url);
>> +                       free(name);
>> +                       free(tail);
>> +               }
>> +       }
>> +
>> +       strbuf_release(&sb_remote_out);
>> +}
>> +
>> +static int add_submodule(const struct add_data *info)
>> +{
>> +       char *submod_gitdir_path;
>> +       /* perhaps the path already exists and is already a git repo, =
else clone it */
>> +       if (is_directory(info->sm_path)) {
>> +               printf("sm_path=3D%s\n", info->sm_path);
>=20
> I don't see which shell code the above printf(...) instruction is
> replacing. That's why I asked if it's some debugging leftover.

Oh, my bad. It is a leftover debugging statement. Please excuse
my temporary blindness to it (:

> [...]
>=20
>> +               if (info->dissociate)
>> +                       strvec_push(&clone_args, "--dissociate");
>> +               if (info->depth >=3D 0)
>> +                       strvec_pushf(&clone_args, "--depth=3D%d", =
info->depth);
>=20
> It's ok if there is a blank line here.

OK. Makes sense.

>> +               if (module_clone(clone_args.nr, clone_args.v, =
info->prefix)) {
>> +                       strvec_clear(&clone_args);
>> +                       return -1;
>> +               }
>> +               strvec_clear(&clone_args);
>=20
>> +static int add_clone(int argc, const char **argv, const char =
*prefix)
>> +{
>> +       const char *branch =3D NULL, *sm_path =3D NULL;
>> +       const char *wt_prefix =3D NULL, *realrepo =3D NULL;
>> +       const char *reference =3D NULL, *sm_name =3D NULL;
>> +       int force =3D 0, quiet =3D 0, dissociate =3D 0, depth =3D -1, =
progress =3D 0;
>> +       struct add_data info =3D ADD_DATA_INIT;
>=20
> Maybe: s/info/add_data/

'info' was the local convention for naming similar structures that
held the flag values (like summary_cb, module_cb, deinit_cb etc).

The exception to the above is 'struct submodule_update_clone', which
was named as 'suc'. It did not follow the *_cb naming convention,
presumably because it was not used as a parameter passed to any
*_cb() function.

Since 'struct add_data' is more similar to the latter (as it is not
used in any callback function) I guess it would be okay to name it
differently and more descriptively as 'add_data'?

> Also it seems that in many cases it's a bit wasteful to use new
> variables for option parsing and then to copy them into the add_data
> struct when the field of the add_data struct could be used directly
> for option parsing...
>=20
>> +       struct option options[] =3D {
>> +               OPT_STRING('b', "branch", &branch,
>=20
> ...for example, here maybe `&add_data.branch` could be used instead of
> `&branch`...

I thought of this too, but decided to stick to the surrounding
convention, where a new variable is used and then assigned to the
struct.

I had a looked at the file again, and turns out...

	OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
		   N_("reference repository")),
	OPT_BOOL(0, "dissociate", &suc.dissociate,
		   N_("use --reference only while cloning")),
	OPT_STRING(0, "depth", &suc.depth, "<depth>",
		   N_("create a shallow clone truncated to the "
		      "specified number of revisions")),

... update_clone() is the exception again.

So there is precedent, and I'd rather follow what you suggested,
because that looks much better to me, and saves a lot of redundant
code.

>> +                          N_("branch"),
>> +                          N_("branch of repository to checkout on =
cloning")),
>=20
> [...]
>=20
>> +       info.branch =3D branch;
>=20
> ...so that the above line would not be needed.

Yes, although I might still need to use an extra variable for
booleans, like 'progress' or 'dissociate', because of the need
to use !! to make it either 1 or 0. I am not too familiar with
why doing that would be important in this context, but since
this is the convention, I'll keep it intact.=
