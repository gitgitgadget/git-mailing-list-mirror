Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91BC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJMVhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMVhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:37:53 -0400
X-Greylist: delayed 873 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 14:37:51 PDT
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F93D5A1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665697066; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nuM+W5qoLWjy5Qlhl6z5StaqbRsGFx8BfgLJEbpf1u/W7Qfx4Q1IpFQ9F/W0SgcuwbpJvSpZVTgC75qEZHg6foT1UiF5Iu6YuJ7lnNNymFwgnZGFUT4vETdoLhGI32f9c2wce2XXFlXVGrb7uoIsIQVVOsjR6LNGjpoh9HXF+F8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665697066; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WriEwAGCCbdtxZZWgijkthAoUR2Q9mWufNU5NzTqAp4=; 
        b=kAVk/Hc6RJRmut/Xy6gNAiUJaflYqpL6fMlULBJJGXXaIkNEL6R0iJ6N+X7Tf8Opfx+C4HSW2/wJV3drNorS2Rey3tyDhvWOgPtMT7ZLQzTkSSfCzPmkdcLUh52y4bv9x4IpdswN1sBzP966StuCaIg01XCY/YhMWsQBYLv+Q5Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=alphaservcomputing.solutions;
        spf=pass  smtp.mailfrom=alpha@alphaservcomputing.solutions;
        dmarc=pass header.from=<alpha@alphaservcomputing.solutions>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665697066;
        s=zoho; d=alphaservcomputing.solutions;
        i=alpha@alphaservcomputing.solutions;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=WriEwAGCCbdtxZZWgijkthAoUR2Q9mWufNU5NzTqAp4=;
        b=c2ce8NJ/aG/l0ACHYIdXdWNc7IYBJeI0XXXHSnAu1S0VuL0afERE1IkDE8dReP0k
        O9nGzdv8hYQt5Alxm4poSurSGg1Sufjoi+guDYKcd5Kj/5kV8r/3h8Q2uH5XIrPxhdF
        1C4Vpksx4L0KAeQ+X96TOB8XKJOKFBTh/wGc/Q8U=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1665697063563603.3747238879733; Thu, 13 Oct 2022 14:37:43 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:37:43 -0700
From:   Heather Lapointe <alpha@alphaservcomputing.solutions>
To:     =?UTF-8?Q?=22Ren=C3=A9_Scharfe=22?= <l.s.r@web.de>
Cc:     "alphadelta14 via gitgitgadget" <gitgitgadget@gmail.com>,
        "git" <git@vger.kernel.org>
Message-ID: <183d348227c.c5ba226d125397.1082382798689125662@alphaservcomputing.solutions>
In-Reply-To: <ee64f463-c4f7-cd1e-50ca-7c302415cf52@web.de>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
 <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <41664a59029e2492079bef3d3da10f44d315064b.1665660960.git.gitgitgadget@gmail.com> <ee64f463-c4f7-cd1e-50ca-7c302415cf52@web.de>
Subject: Re: [PATCH v2 1/2] archive: add --recurse-submodules to git-archive
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


---- On Thu, 13 Oct 2022 10:53:46 -0700 Ren=C3=A9 Scharfe  wrote ---

 > Am 13.10.22 um 13:35 schrieb Alphadelta14 via GitGitGadget:=20
 > > From: Alphadelta14 alpha@alphaservcomputing.solutions>=20
 > >=20
 > =20
 > > diff --git a/tree.c b/tree.c=20
 > > index 410e3b477e5..c5b5a0ac08f 100644=20
 > > --- a/tree.c=20
 > > +++ b/tree.c=20
 > > @@ -8,6 +8,7 @@=20
 > >  #include "alloc.h"=20
 > >  #include "tree-walk.h"=20
 > >  #include "repository.h"=20
 > > +#include "pathspec.h"=20
 > >=20
 > >  const char *tree_type =3D "tree";=20
 > >=20
 > > @@ -22,8 +23,8 @@ int read_tree_at(struct repository *r,=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0int len, oldlen =3D base->len;=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0enum interesting retval =3D entry_not_interes=
ting;=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0if (parse_tree(tree))=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if (repo_parse_tree(r, tree))=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0die("Failed to parse =
tree");=20
 > >=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0init_tree_desc(&desc, tree->buffer, tree->siz=
e);=20
 > >=20
 > > @@ -37,7 +38,7 @@ int read_tree_at(struct repository *r,=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (fn(&entry.oid=
, base,=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (fn(r, &entry.=
oid, base,=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0   entry.path, entry.mode, context)) {=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case 0:=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0continue;=20
 > > @@ -47,36 +48,57 @@ int read_tree_at(struct repository *r,=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return -1;=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (S_ISDIR(entry.mod=
e))=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (S_ISDIR(entry.mod=
e)) {=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0oidcpy(&oid, &entry.oid);=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (S_ISGITLINK(=
entry.mode)) {=20
 > =20
 > So you remove the non-recursive handling of submodules here...=20

The original logic looked like it had not been thoroughly used in the past =
years.
It was performing a commit lookup within the submodule using the superproje=
ct
repository, which would not actually work unless there was global state
being contextually pushed where `the_repository` was being replaced
with a submodule repository instance (it appeared to not be the case curren=
tly).

 > =20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0len =3D tree_entry_len(&entry);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_add(base, entry.path, len);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_addch(base, '/');=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0retval =3D read_tree_at(r, lookup_tree(r, &oid),=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
base, pathspec,=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
fn, context);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_setlen(base, oldlen);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (retval)=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (pathspec->=
recurse_submodules && S_ISGITLINK(entry.mode)) {=20
 > =20
 > ... and add recursive handling here, and there is no further else=20
 > branch.  Why do we no longer need the non-recursive variant?=20

The else case is that we either have submodules, but we don't have pathspec=
->recurse_submodules.
Both the dir case and submodule cases handle recursion
(but with enough difference that it didn't make sense to use the same logic=
).
The other else case we simply not recurse (for files).

 > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0struct commit *commit;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0struct repository subrepo;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0struct repository* subrepo_p =3D &subrepo;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0struct tree* submodule_tree;=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0commit =3D lookup_commit(r, &entry.oid);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0die("couldn't init submodule %s%s", base->buf, e=
ntry.path);=20
 > > +=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (repo_read_index(subrepo_p) < 0)=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0die("index file corrupt");=20
 > > +=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0commit =3D lookup_commit(subrepo_p, &entry.oid);=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (!commit)=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0die("Commit %s in submodule path %s%s not found"=
,=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0    oid_to_hex(&entry.oid),=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0    base->buf, entry.path);=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (parse_commit(commit))=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (repo_parse_commit(subrepo_p, commit))=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0die("Invalid commit %s in submodule path %s%s",=
=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0    oid_to_hex(&entry.oid),=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0    base->buf, entry.path);=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0oidcpy(&oid, get_commit_tree_oid(commit));=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0submodule_tree =3D repo_get_commit_tree(subrepo_p, commit);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);=20
 > > +=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0len =3D tree_entry_len(&entry);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_add(base, entry.path, len);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_addch(base, '/');=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0retval =3D read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
base, pathspec,=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
fn, context);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (retval) {=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0    die("failed to read tree for %s%s", base->buf, entry.path);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0    return -1;=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0strbuf_setlen(base, oldlen);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0repo_clear(subrepo_p);=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0continue;=20
 > >=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D tree_entry_le=
n(&entry);=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strbuf_add(base, entr=
y.path, len);=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strbuf_addch(base, '/=
');=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retval =3D read_tree_=
at(r, lookup_tree(r, &oid),=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0      base, pathspec,=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0      fn, context);=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strbuf_setlen(base, o=
ldlen);=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (retval)=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return -1;=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0}=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0return 0;=20
 > >  }=20
 > > @@ -121,7 +143,7 @@ int parse_tree_buffer(struct tree *item, void *buf=
fer, unsigned long size)=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0return 0;=20
 > >  }=20
 > >=20
 > > -int parse_tree_gently(struct tree *item, int quiet_on_missing)=20
 > > +int parse_tree_gently(struct repository *r, struct tree *item, int qu=
iet_on_missing)=20
 > >  {=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0 enum object_type type;=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0 void *buffer;=20
 > > @@ -129,7 +151,7 @@ int parse_tree_gently(struct tree *item, int quiet=
_on_missing)=20
 > >=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0if (item->object.parsed)=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;=20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0buffer =3D read_object_file(&item->object.oid=
, &type, &size);=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0buffer =3D repo_read_object_file(r, &item->ob=
ject.oid, &type, &size);=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0if (!buffer)=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return quiet_on_missi=
ng ? -1 :=20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0error("Could not read %s",=20
 > =20
 >=20
