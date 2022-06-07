Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F18C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiFGHix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiFGHiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 03:38:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32708C0385
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 00:38:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq6so20376938ejb.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 00:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t0btAop2zX8dHv3NgZ0TSbVI7e14Hi1Vi/TmOaoDNek=;
        b=HPHqXH6PhsTyRLAkHBtrJaQk4UZvVV5DNz3pIvONSmBBGEnMJZyaWTV9vahrmpZebP
         pgEuM41EG8Za1LudMzIbOkTSC3azoXTD34zQrAoKHN90eeohjrYg13nxtOOJyV3PdFvR
         KLaaBePUex+Vr/WugROLhBF3VPy13XTCwgOdWT7ZGvYaj8hiMb2QuyHiWCU0hBgNZxFN
         aXsf3845HMCth0/4ORnOzCHN+998yJpadYjMagdxtegManJ9JnFHnIA1ycz4mlFuFTDg
         bX2fsolZvFJoM4uojlVcXEoDK1pfYDhuEpiXgW6qS9ixrIXQIoW9w+P7t2F23wYNephy
         AP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t0btAop2zX8dHv3NgZ0TSbVI7e14Hi1Vi/TmOaoDNek=;
        b=pWWOwJLDkOSStZkXuALaWtNs9HoeTM2zbWA5JJM1whqJxmGBkCd9258gls74kz3D85
         NwubSNXcbr9DJWmwVlNi3Ea2K8nuh65AULkWgGvyuIk+rHe7yQRGdo3uqR8tuZwPxI3k
         KhqGmn6NMgo3HbiGbCCLQdcxfSlKQ7Tm4xqqrI6E+lQSe9dFIK9TPLj/61u7GysiYrI5
         Vju/miZtUdUHj30Rdb6GjiIHF24oBWPbS2IWcw3Os7zHRaAMBZTuaVeXoKcEgf+7zFEP
         4UiwVpUpCMSBJB78TkVQQYeyfrQLtL97Rwt3EAdK+4vcbsCbENE8+n04gEaq+Frwlvwa
         iVBg==
X-Gm-Message-State: AOAM532kSkztuEp98cxt3pw3FhWE32MIGuElcxZZYCQz3gV2J/BwARjv
        pkNCQKAPfdlkye03EJlQtFfc6An7b6DyQFexWFBMSpMP
X-Google-Smtp-Source: ABdhPJwrmypfjsuJ+Js1TTYG/hfl0QaegpUeayH1TcHz98Utjlno/U+zwWUSv6/uU6eeYlIwqyDsrUguzdQK717xALE=
X-Received: by 2002:a17:907:c302:b0:711:cb4b:1382 with SMTP id
 tl2-20020a170907c30200b00711cb4b1382mr9323391ejc.476.1654587526368; Tue, 07
 Jun 2022 00:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet>
 <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2206060019510.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206062325020.349@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2206062325020.349@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Jun 2022 00:38:35 -0700
Message-ID: <CABPp-BF3JwBGugN25RKxwTUQ6BDZL6OUwgLPVZQdj3d1mFdBgQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jun 6, 2022 at 2:37 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> [after this update, I will shut up until you chime in, promise!]
>
> On Mon, 6 Jun 2022, Johannes Schindelin wrote:
>
> > On Sun, 5 Jun 2022, Johannes Schindelin wrote:
> >
> > > On Sat, 4 Jun 2022, Johannes Schindelin wrote:
> > >
> > > > It would be great if you could have a quick look over the commits I
> > > > added on top of your branch, to see whether things make more or les=
s
> > > > sense to you. But if you're too busy elsewhere, I am one of the bes=
t
> > > > persons to understand that, too.
> > >
> > > Hopefully I will get this into a reviewable shape before you get to
> > > looking at it, so that your time is spent more wisely than what I
> > > asked for ;-)
> >
> > I hope to find some time to work on this more tomorrow; If not, I will
> > get back to the project on Wednesday and push it further.
>
> I did get a chance, and polished the patch series a bit. I also rebased i=
t
> onto the current tip of Git's main branch, mainly to address some merge
> conflicts preemptively. The result is pushed up to
> https://github.com/dscho/git/tree/js/in-core-merge-tree. This is the
> range-diff relative to `newren/wip-for-in-core-merge-tree`:

This is so awesome; thanks for working on this.  Sorry I haven't had
time to review yet, but I'm hoping to be able to near the end of this
week.  I'm excited to see how it looks.  :-)

> -- snip --
>  1:  cccb3888070 <  -:  ----------- tmp-objdir: new API for creating temp=
orary writable databases
>  2:  4e44121c2d7 <  -:  ----------- tmp-objdir: disable ref updates when =
replacing the primary odb
>  3:  0b94724311d <  -:  ----------- show, log: provide a --remerge-diff c=
apability
>  4:  f06de6c1b2f <  -:  ----------- log: clean unneeded objects during `l=
og --remerge-diff`
>  5:  8d6c3d48f0e <  -:  ----------- ll-merge: make callers responsible fo=
r showing warnings
>  6:  de8e8f88fa4 <  -:  ----------- merge-ort: capture and print ll-merge=
 warnings in our preferred fashion
>  7:  6b535a4d55a <  -:  ----------- merge-ort: mark a few more conflict m=
essages as omittable
>  8:  e2441608c63 <  -:  ----------- merge-ort: format messages slightly d=
ifferent for use in headers
>  9:  62734beb693 <  -:  ----------- diff: add ability to insert additiona=
l headers for paths
> 10:  17eccf7e0d6 <  -:  ----------- show, log: include conflict/warning m=
essages in --remerge-diff headers
> 11:  b3e7656cfc6 <  -:  ----------- merge-ort: mark conflict/warning mess=
ages from inner merges as omittable
> 12:  ea5df61cf35 <  -:  ----------- diff-merges: avoid history simplifica=
tions when diffing merges
> 13:  4a7cd5542bb =3D  1:  8fb51817ed4 merge-tree: rename merge_trees() to=
 trivial_merge_trees()
> 14:  4780ff6784d =3D  2:  8e0a79fa1ad merge-tree: move logic for existing=
 merge into new function
> 15:  60253745f5c =3D  3:  baf0950bcb6 merge-tree: add option parsing and =
initial shell for real merge function
> 16:  f8266d39c1b =3D  4:  697470e50ae merge-tree: implement real merges
> 17:  6629af14919 =3D  5:  069af1ecc30 merge-ort: split out a separate dis=
play_update_messages() function
> 18:  17b57efb714 =3D  6:  53c92a5d8d9 merge-tree: support including merge=
 messages in output
> 19:  4c8f42372dd =3D  7:  67a728d35f0 merge-ort: provide a merge_get_conf=
licted_files() helper function
> 25:  8fe5be07cd0 !  8:  6419487e26b merge-ort: remove command-line-centri=
c submodule message from merge-ort
>     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
>                 strbuf_release(&sb);
>                 break;
>         default:
>     +
>     + ## t/t6437-submodule-merge.sh ##
>     +@@ t/t6437-submodule-merge.sh: test_expect_success 'merging should c=
onflict for non fast-forward' '
>     +   (cd merge-search &&
>     +    git checkout -b test-nonforward b &&
>     +    (cd sub &&
>     +-    git rev-parse sub-d > ../expect) &&
>     ++    git rev-parse --short sub-d > ../expect) &&
>     +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
>     +     then
>     +           test_must_fail git merge c >actual
> 20:  7b1ee417f3d !  9:  c92b81e7366 merge-tree: provide a list of which f=
iles have conflicts
>     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opti=
ons *o,
>      +          string_list_clear(&conflicted_files, 1);
>      +  }
>         if (o->show_messages) {
>     -           printf("\n");
>     +-          printf("\n");
>     ++          putchar(line_termination);
>                 merge_display_update_messages(&opt, &result);
>     +   }
>     +   merge_finalize(&opt, &result);
>      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **a=
rgv, const char *prefix)
>
>         /* Do the relevant type of merge */
> 21:  f1231a8fbc8 =3D 10:  d7360f58f16 merge-tree: provide easy access to =
`ls-files -u` style info
>  -:  ----------- > 11:  b53ef9c2116 merge-ort: store messages in a list, =
not in a single strbuf
>  -:  ----------- > 12:  b16d570d248 merge-ort: make `path_messages` a str=
map to a string_list
>  -:  ----------- > 13:  b575a6b5f8a merge-ort: store more specific confli=
ct information
>  -:  ----------- > 14:  4f245cc28ae merge-ort: optionally produce machine=
-readable output
> 22:  22297e6ce75 ! 15:  6a369f837be merge-tree: allow `ls-files -u` style=
 info to be NUL terminated
>     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opti=
ons *o,
>         if (!result.clean) {
>                 struct string_list conflicted_files =3D STRING_LIST_INIT_=
NODUP;
>                 const char *last =3D NULL;
>     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opt=
ions *o,
>     -           string_list_clear(&conflicted_files, 1);
>     -   }
>     -   if (o->show_messages) {
>     --          printf("\n");
>     -+          putchar(line_termination);
>     -           merge_display_update_messages(&opt, &result);
>     -   }
>     -   merge_finalize(&opt, &result);
>      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **a=
rgv, const char *prefix)
>                             N_("do a trivial merge only"), MODE_TRIVIAL),
>                 OPT_BOOL(0, "messages", &o.show_messages,
>     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check confl=
icted oids and
>      +
>      +  test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >o=
ut &&
>      +  anonymize_hash out >actual &&
>     ++  printf "\\n" >>actual &&
>      +
>      +  # Expected results:
>      +  #   "greeting" should merge with conflicts
>     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check confl=
icted oids and
>      +
>      +  EOF
>      +
>     -+  cat <<-EOF >>expect &&
>     -+  Auto-merging greeting
>     -+  CONFLICT (content): Merge conflict in greeting
>     -+  CONFLICT (file/directory): directory in the way of whatever from =
tweak1; moving it to whatever~tweak1 instead.
>     -+  CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and mo=
dified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
>     -+  Auto-merging =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=
=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=
=CE=B6=CE=B9=CE=BA=CE=B1
>     -+  CONFLICT (content): Merge conflict in =CE=91=CF=85=CF=84=CE=AC =
=CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =
=CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
>     ++  q_to_nul <<-EOF >>expect &&
>     ++  1QgreetingQAuto-mergingQAuto-merging greeting
>     ++  Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflic=
t in greeting
>     ++  Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLICT (f=
ile/directory): directory in the way of whatever from tweak1; moving it to =
whatever~tweak1 instead.
>     ++  Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/dele=
te): whatever~tweak1 deleted in side2 and modified in tweak1.  Version twea=
k1 of whatever~tweak1 left in tree.
>     ++  Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=
=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=
=CE=BA=CE=B1QAuto-mergingQAuto-merging =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=
=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=
=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
>     ++  Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=
=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=
=CE=BA=CE=B1QCONFLICT (contents)QCONFLICT (content): Merge conflict in =CE=
=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=
=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
>     ++  Q
>      +  EOF
>      +
>      +  test_cmp expect actual
> 23:  db73c6dd823 =3D 16:  47146dd59dd merge-tree: add a --allow-unrelated=
-histories flag
> 24:  d58a7c7a9f6 ! 17:  3ce28f6fd97 git-merge-tree.txt: add a section on =
potentional usage mistakes
>     @@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
>      +<<IM,Informational messages>> section has the necessary info, thoug=
h it
>      +is not designed to be machine parseable.
>      +
>     ++Do NOT assume that each paths from <<CFI,Conflicted file info>>, an=
d
>     ++the logical conflicts in the <<IM,Informational messages>> have a
>     ++one-to-one mapping, nor that there is a one-to-many mapping, nor a
>     ++many-to-one mapping.  Many-to-many mappings exist, meaning that eac=
h
>     ++path can have many logical conflict types in a single merge, and ea=
ch
>     ++logical conflict type can affect many paths.
>     ++
>      +Do NOT assume all filenames listed in the <<IM,Informational messag=
es>>
>      +section had conflicts.  Messages can be included for files that hav=
e no
>      +conflicts, such as "Auto-merging <file>".
> 26:  78e1243eca1 <  -:  ----------- WIP
> -- snap --
>
> I am pretty happy with the current state of the patches, and hope that we
> can push this patch series over the finish line.
>
> If you can think of anything I can do to help with this, please do let me
> know, I am _very_ interested in getting this done, and finally am in a
> position to help.

Very much appreciated.  Looks like you're now blocking on my review,
so I'll try to make some time by end of week to look over things.
