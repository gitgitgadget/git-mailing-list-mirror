Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1CC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGMUO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGMUOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:14:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8152D59
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:13:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so10648175e9.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689279233; x=1691871233;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDjosh931RMCHZK0Jr9unTrcqIUfccACzGtIk77IMlg=;
        b=ZBdZ3tBdPEuJvidAfNRnQTRNvIEJVTgGJJWBlvi+IWrXSsPTECcVnCtWN2ptlU4zZb
         tdT/AqhwldIcHEzZQ41qjNfvQe7cpVLftRL95eWmUdUR5Kd319Q5qvl0thcFMpBbtnoG
         OvH11n+nDW9+JiIxy//FxLTpFH1HTp2Lg0oUL5r+FR6ubZM1xjfmvbQURLq93GS0ikud
         a9yhtixNv4lvC8X86xgyPoMyjQoK31MHAe1YAhA9RtLflTF6LTOPUhR4OdOWeKi1pqwe
         i0ka1cYeloPFcoF1unlwE2/L+tahsLXdYpmSy+t0DWD+64K/NWk5gHJlH2xL0/xvjOmq
         OrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279233; x=1691871233;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDjosh931RMCHZK0Jr9unTrcqIUfccACzGtIk77IMlg=;
        b=Yw9QYnr/kp/SW38FXSJkSyHFRJ3tIQZG6+EHpl2O+FUSiIWDUOfhcG+1ftN6QTIx2t
         VX6DqM3WwkIaTDCD94hl47p4DcvbzLGM6Gg3AS+niOeXaVfoP8mLGEJf5MSdOi7uDwaW
         yrbzy3J6efZPytutxdCMLBVaaxTJk/2iqS4pHzibn0y9HdB9ZHI0mFB+BpNFM3527Bk4
         pPEIsk22C9FZ6KBMnfiPmEKZmJynaS/cjGVhVafvAQk0ayRfl0Mt8UulA1n96Xul9Iz8
         MlRiwXMBX8ZFnVNRou2gAirx8PUf5fbh/os0Bsft7WZvycegkqd+3p1+uR6GRf904/9M
         v0pQ==
X-Gm-Message-State: ABy/qLa9/DN8++Cf4Syh9Hy7OU+5Zx56++ihYOwtTqv41EpzW/YIlVTU
        NGjLqBqHd/M6asPwdehhuErqTUJnW6q3yXIlGxU=
X-Google-Smtp-Source: APBJJlHvmyxAvAuN8iolbMBVp9gXNJF4mThdHaxpm3KVuB7xNWrRVSkgzdLKy7InGt+vKZJ4y/2+MZlfYxv3MpNAjTc=
X-Received: by 2002:adf:f6c6:0:b0:314:1e73:d15d with SMTP id
 y6-20020adff6c6000000b003141e73d15dmr2610800wrp.11.1689279232369; Thu, 13 Jul
 2023 13:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230707151839.504494-1-cheskaqiqi@gmail.com> <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-2-cheskaqiqi@gmail.com> <xmqqjzv6w3o2.fsf@gitster.g>
In-Reply-To: <xmqqjzv6w3o2.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 13 Jul 2023 16:13:39 -0400
Message-ID: <CAMO4yUEVbeLSeOq42V=7RhcLG_4e_D2fBS72Dz-5Oq_u6-RhNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2023 at 5:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Shuqi Liang <cheskaqiqi@gmail.com> writes:
>
> > 'git check-attr' cannot currently find attributes of a file within a
> > sparse directory. This is due to .gitattributes files are irrelevant in
> > sparse-checkout cone mode, as the file is considered sparse only if all
> > paths within its parent directory are also sparse.
>
> I do not quite understand what these two sentences want to say.  If
> the attribute files are truly irrelevant then "cannot find" does not
> matter, because there is no point in finding irrelevant things that
> by definition will not affect the outcome of any commands at all,
> no?
>
> > In addition,
> > searching for a .gitattributes file causes expansion of the sparse
> > index, which is avoided to prevent potential performance degradation.
>
> Does this sentence want to say that there is a price to pay, in
> order to read an attribute file that is not part of the cones of
> interest, that you first need to expand the sparse index?  I think
> that is a given and I am not sure what the point of saying it is.
>
> > However, this behavior can lead to missing attributes for files inside
> > sparse directories, causing inconsistencies in file handling.
>
> I agree.  Not reading attribute files correctly will lead to a bug.
>
> Let me rephase what (I think) you wrote below to see if I understand
> what you are doing correctly.
>
> Suppose that sub1/.gitattributes need to be read, when the calling
> command wants to know about attributes of sub1/file.  Imagine that
> sub1/ and sub2/ are both outside the cones of interest. It would be
> better not to expand sub2/ even though we need to expand sub1/.  Not
> calling ensure_full_index() upfront and instead expanding the
> necessary subdirectories on demand would be a good way to solve it.
>
> Is that what going on?

Sorry for the confusion. I was actually trying to explain why the original
comment isn't needed anymore. Here's my updated comment - does this
make more sense=EF=BC=9F

Previously, the `read_attr_from_index()` function was structured to handle
attribute reading from a `.gitattributes` file only when the file
paths were part
of the cone-mode sparse-checkout. This was based on the fact that the
`.gitattributes` file only applied to files within its parent
directory. As a result,
we avoided loading the `.gitattributes` file if the sparse-checkout was in
cone-mode, as the file is sparse only if all paths within that directory ar=
e
also sparse.

However, this approach was not capable of handling scenarios where we
needed to read attributes from sparse directories=E3=80=82

To resolve this, revise 'git check-attr' to allow attribute reading for
files in sparse directories from the corresponding .gitattributes files:

1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
to check if a path falls within a sparse directory.

2.If path is inside a sparse directory, employ the value of
index_name_pos_sparse() to find the sparse directory containing path and
path relative to sparse directory. Proceed to read attributes from the
tree OID of the sparse directory using read_attr_from_blob().

3.If path is not inside a sparse directory=EF=BC=8Censure that attributes a=
re
fetched from the index blob with read_blob_data_from_index().



> > diff --git a/attr.c b/attr.c
> > index 7d39ac4a29..be06747b0d 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -808,35 +808,44 @@ static struct attr_stack *read_attr_from_blob(str=
uct index_state *istate,
> >  static struct attr_stack *read_attr_from_index(struct index_state *ist=
ate,
> >                                              const char *path, unsigned=
 flags)
> >  {
> > +     struct attr_stack *stack =3D NULL;
> >       char *buf;
> >       unsigned long size;
> > +     int pos;
> >
> >       if (!istate)
> >               return NULL;
> >
> >       /*
> > -      * The .gitattributes file only applies to files within its
> > -      * parent directory. In the case of cone-mode sparse-checkout,
> > -      * the .gitattributes file is sparse if and only if all paths
> > -      * within that directory are also sparse. Thus, don't load the
> > -      * .gitattributes file since it will not matter.
>
> Imagine that you have a tree with sub1/ outside the cones of
> interest and sub2/ and sub9/ inside the cones of interest, and
> further imagine that sub1/.gitattributes and sub2/.gitattributes
> give attribute X to sub1/file and sub2/file respectively.  There
> is no sub9/.gitattributes file.
>
> Then "git ls-files ':(attr:X)sub[0-9]'" _could_ have two equally
> sensible behaviours:
>
>  (1) Only show sub2/file because sub1/ is outside the cones of
>      interest and the user does not want to clutter the output
>      from the parts of the tree they are not interested in.
>
>  (2) Show both sub1/file and sub2/file, even though sub1/ is outside
>      the cones of interest, in response to the fact that the mention
>      of "sub[0-9]" on the command line is an explicit indication of
>      interest by the user (it would become more and more interesting
>      if the pathspec gets less specific, like ":(attr:X)" that is
>      treewide, though).
> The original comment seems to say that only behaviour (1) is
> supported, but I wonder if we eventually want to support both,
> choice made by the calling code (and perhaps options)?  In any case,
> offering the choice of (2) is a good thing in the longer run.
> Anyway...

If we use '--sparse' as an option, then by default we'd only apply (1).
However, if the user types '--sparse', we'd switch to (2). Do you think tha=
t's
a good approach?

> > +      * If the pos value is negative, it means the path is not in the =
index.
> > +      * However, the absolute value of pos minus 1 gives us the positi=
on where the path
> > +      * would be inserted in lexicographic order. By subtracting anoth=
er 1 from this
> > +      * value (pos =3D -pos - 2), we find the position of the last ind=
ex entry
> > +      * which is lexicographically smaller than the provided path. Thi=
s would be
> > +      * the sparse directory containing the path.
>
> That is true only if the directory containing the .gitattribute file
> is sparsified (e.g. sub1/.gitattributes does not appear in the index
> but sub1/ does; sub2/.gitattributes however does appear in the index
> and there is no sub2/ in the index).
>
> If not, there are two cases:
>
>  * sub2/.gitattributes does appear in the index (and there is no
>    sub2/ in the index).  "pos =3D - pos - 2" computes a nonsense
>    number in this case; hopefully we can reject it early by noticing
>    that the resulting pos is negative.
>
>  * sub9/.gitattributes does not belong to the project.  The pos is
>    negative and "- pos - 2" does not poihnt at sub9/ (as it is not
>    sparse).  Depending on what other paths appear in sub9/., the
>    path that appears at (-pos-2) may be inside or outside sub9/.  In
>    the worst case, it could be a sparsified directory that sorts
>    directly before sub9/ (say, there is sub8/ that is sparse, which
>    may have .gitattributes in it).  Would the updated code
>    mistakenly check S_ISSPARSEDIR() on sub8/ that has no relevance
>    when we are dealing with sub9/.gitattributes that does not exist?

I made some modifications to the code to address your points. Now, only
calculating 'pos' when the path falls outside of the cone. Moreover, we
only compute '-pos -2' when 'pos' is negative. I believe this adjustment ca=
n
effectively address the issues you've brought up.

> > -     if (!path_in_cone_mode_sparse_checkout(path, istate))
> > -             return NULL;
> > +     pos =3D index_name_pos_sparse(istate, path, strlen(path));
> > +     pos =3D - pos - 2;
> >
> > -     buf =3D read_blob_data_from_index(istate, path, &size);
> > -     if (!buf)
> > -             return NULL;
> > -     if (size >=3D ATTR_MAX_FILE_SIZE) {
> > -             warning(_("ignoring overly large gitattributes blob '%s'"=
), path);
> > -             return NULL;
> > -     }
> > +     if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <=3D po=
s) {
> > +             if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
> > +                     return NULL;
>
> So earlier, the code, given say sub1/.gitattributes, checked if that
> path is outside the cones of interest and skipped reading it.  But
> the updated code tries to check the same "is it outside or inside?"
> condition for sub1/ directory itself.  Does it make a practical
> difference that you can demonstrate with a test?

I'm not sure I understand the point. Are you suggesting that checking
(!S_ISSPARSEDIR(istate->cache[pos]->ce_mode) is unnecessary because
 we don't need to verify it as we already outside the cone?

> I do not know if the updated code does the right thing for
> sub2/.gitattributes (exists in a non-sparse directory) and
> sub9/.gitattributes (does not exist in non-sparse directory),
> though.
>
> > +             if (strncmp(istate->cache[pos]->name, path, ce_namelen(is=
tate->cache[pos])) =3D=3D 0) {
>
> Don't compare with "=3D=3D0", write !strncmp(...) instead.

Will fix!

> > +                     const char *relative_path =3D path + ce_namelen(i=
state->cache[pos]);
> > +                     stack =3D read_attr_from_blob(istate, &istate->ca=
che[pos]->oid, relative_path, flags);
> > +             }
>
> If the earlier "- pos - 2" misidentified the parent sparse directory
> entry in the index and the strncmp() noticed that mistake, we would
> come here without reading any new attribute stack frame.  Don't we
> need to fallback reading from the path in the correct directory that
> is not at "- pos - 2"?
>
> Let's imagine this case where sub/ is a directory outside the cones
> of interest, and our sparse-index may or may not have it as a
> directory in the index, and then the caller asks to read from the
> "sub/sub1/.gitattributes" file.  Even when "sub/" is expanded in the
> index, "sub/sub1/" may not and appear as a directory in the index.
>
> The above "find relative_path and read from the tree object" code
> would of course work when the direct parent directory of
> ".gitattributes" is visible in the index, but interestingly, it
> would also work when it does not.  E.g. if "sub/" is represented as
> a directory in the index, then asking for "sub1/.gitattributes"
> inside the tree object of "sub/" would work as get_tree_entry() used
> by read_attr_from_blob() would get to the right object recursively,
> so that is nice.  If that is why "'- pos - 2' must be the directory
> entry in the index that _would_ include $leadingpath/.gitattributes
> regardless of how many levels of directory hierarchy there are
> inside $leadingpath" idea was chosen, I'd have to say that it is
> clever ;-)
>
> I however find the "'- pos - 2' must be the directory entry in the
> index" trick hard to reason about and explain.  I wonder if we write
> this in a more straight-forward and stupid way, the result becomes
> easier to read and less prone to future bugs...

Here is my updated code. Is it more straightforward and less prone to bugs?

if (!path_in_cone_mode_sparse_checkout(path, istate)) {
    pos =3D index_name_pos_sparse(istate, path, strlen(path));

    if (pos < 0)
        pos =3D -pos - 2;
}

if (pos >=3D 0 && !path_in_cone_mode_sparse_checkout(path, istate) &&
S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
!strncmp(istate->cache[pos]->name, path,
ce_namelen(istate->cache[pos])) &&
!normalize_path_copy(normalize_path, path)) {
    relative_path =3D normalize_path + ce_namelen(istate->cache[pos]);
    stack =3D read_attr_from_blob(istate, &istate->cache[pos]->oid,
relative_path, flags);

    stack =3D read_attr_from_blob(istate, &istate->cache[pos]->oid,
relative_path, flags);
}
