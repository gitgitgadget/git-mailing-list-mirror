Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF15C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E636103E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhE1PGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhE1PGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 11:06:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082BC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:05:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o10so3537597ilm.13
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v5xkiHrQk5VWPkAvWKvYHPSpsSQrxsyD4tiHrGyMTXY=;
        b=MT0Qc/8014mV7P93EBf+YEGHACvqOZ9INMGP27mLZW9Z8S3VSC2/3VVWFEOMCiD7IB
         VygQ5jRXTs77wGiZHSalLulWrdo6R5oXbXMySL3vT+y0l7ZX7KUtIBWboNanWoUZiQKx
         Zd01OMHh2T9e2cz5lDMw9FWaiGOQ5F4+hV62X6pddsN3qC07HmnVFcHEE5T2SCSE0e8Y
         VlyEOBfASh2SUR01Zg366YSwfY5d11CRm3VPzcli8syWzfR8MhdR2R2hN4mzosCxVjO2
         y4x6MDtMS/x/jxyrtcDKLAASl7ugfjmZU/pu+kgeR9SZJmOxCt+krymVwMPRG2QWMnhO
         SNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v5xkiHrQk5VWPkAvWKvYHPSpsSQrxsyD4tiHrGyMTXY=;
        b=XO35Q/rE4ANAEqYPBZEKEJcGXC683GkU5TOfdu4HocVFuYbhweO8Qc1KIniUGgWNF1
         ZqXUW2OrJvMDpy0uraK4q9rS1HQO0EPWNq5i8F4MsInuzvEYb1NFdANgGj+nNAHNsI8l
         nGINR86bL65nGeLxUO/OMssAEnMuBYNginLBrxeWNcwMljkaLq8pAo++BaxddWmz4z/q
         88fFModIKTBeIJUDv1s5Vwp9/2FImMHCB7q9Xhfv11CufwVSoBevBOc2tJXklXXNk3nV
         kau2x38/8yYzJ8FZ9cfVjLZLWXztKEvpDy3Wm1h/uiO2EkV6JXkUX+uXmT3JivaGWDDz
         i2RA==
X-Gm-Message-State: AOAM533avnDvht7zCmIa1XgTNBHPNiei8USuz+Hy/8OVJHccZHFP/PYq
        Q7p9g5Hfzmduzay3blypZK8pgHlQ1X9PxEJXkGg=
X-Google-Smtp-Source: ABdhPJxRjIAxAdbEQaUUPjG0ONa2oJmMM6L99APo3AeXNqP3cemnJk36j96MebN3+qsHCSvEl46S20h5vCXpPb0woBs=
X-Received: by 2002:a05:6e02:1302:: with SMTP id g2mr7289240ilr.259.1622214314384;
 Fri, 28 May 2021 08:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <xmqq1r9r8spu.fsf@gitster.g>
In-Reply-To: <xmqq1r9r8spu.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 28 May 2021 23:04:59 +0800
Message-ID: <CAOLTT8SLLgZnF0SV2FPPBJkB=ybeh8mamTPqc-M6CXQeepooOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:04=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The raw data of blob, tree objects may contain '\0', but most of
> > the logic in `ref-filter` depands on the output of the atom being
> > a structured string (end with '\0').
>
> Text, yes, string is also OK.  But structured?  Probably not.
>
>     ... being text (specifically, no embedded NULs in it).
>

OK.

> > Beyond, `--format=3D%(raw)` should not combine with `--python`, `--shel=
l`,
> > `--tcl`, `--perl` because if our binary raw data is passed to a variabl=
e
> > in the host language, the host languages may cause escape errors.
>
> OK.  I think at least --perl and possibly --python should be able to
> express NULs in the "string" type we use from the host language, but
> I am perfectly fine with the decision to leave it to later updates.
>

Yes, for the time being, unified processing --<lang> will be easier.

> > +Note that `--format=3D%(raw)` should not combine with `--python`, `--s=
hell`, `--tcl`,
>
> "should not combine" -> "cannot be used" would make it read more
> naturally (ditto for the phrase used in the proposed log message).
>

OK, so the wording is better.

> >
> >  struct atom_value {
> >       const char *s;
> > +     size_t s_size;
>
> OK, so everything used to be a C-string that cannot hold NULs in it,
> but now it is a counted <ptr, len> string.  Good.
>

This suddenly reminded me of strbuf...
I don't know if it is worth replacing all s, s_size with strbuf.

> > @@ -588,6 +607,10 @@ static int parse_ref_filter_atom(const struct ref_=
format *format,
> >               return strbuf_addf_ret(err, -1, _("malformed field name: =
%.*s"),
> >                                      (int)(ep-atom), atom);
> >
> > +     if (format->quote_style && starts_with(sp, "raw"))
> > +             return strbuf_addf_ret(err, -1, _("--format=3D%.*s should=
 not combine with"
> > +                             "--python, --shell, --tcl, --perl"), (int=
)(ep-atom), atom);
>
> Don't we want to allow "raw:size" that would be a plain text?
> I am not sure if this check belongs here in the first place.
> Shouldn't it be done in raw_atom_parser() instead?
>

You are right: "raw:size" should be keep, but I can't this check to
raw_atom_parser(), becase "if I move it to raw_atom_parser(), when we
use:

`git ref-filter --format=3D%raw --sort=3Draw --python`

Git will continue to run instead of die because parse_sorting_atom() will
use a dummy ref_format and don't remember --language details, next time
format_ref_array_item() will reuse the used_atom entry of sorting atom in
parse_ref_filter_atom(), this will skip the check in raw_atom_parser()."

> Another idea is to teach a more generic rule to quote_formatting()
> to detect NULs in v->s[0..v->s_size] at runtime and barf, i.e. a
> plain-text blob object can be used with "--shell --format=3D%(raw)"
> just fine.
>

The cost of such a check is not small. Maybe can add an option
such as "--only-text" to do it.

> > @@ -652,11 +675,14 @@ static int parse_ref_filter_atom(const struct ref=
_format *format,
> >       return at;
> >  }
> >
> > -static void quote_formatting(struct strbuf *s, const char *str, int qu=
ote_style)
> > +static void quote_formatting(struct strbuf *s, const char *str, size_t=
 len, int quote_style)
> >  {
> >       switch (quote_style) {
> >       case QUOTE_NONE:
> > -             strbuf_addstr(s, str);
> > +             if (len !=3D ATOM_VALUE_S_SIZE_INIT)
> > +                     strbuf_add(s, str, len);
> > +             else
> > +                     strbuf_addstr(s, str);
>
> It probably is a good idea to invent a C preprocessor macro for a
> named constant to be used when a structure is initialized, but it
> would be easier to read if the rule is "len field is negative when
> the value is a C-string", e.g.
>
>                 if (len < 0)
>

I do not recognize such an approach because we are deal
with "size_t s_size", if (len < 0) will never be established.
I use -1 is because it's equal to 18446744073709551615
and it's impossible to have such a large file in Git.

> > @@ -785,14 +814,16 @@ static int if_atom_handler(struct atom_value *ato=
mv, struct ref_formatting_state
> >       return 0;
> >  }
> >
> > -static int is_empty(const char *s)
> > +static int is_empty(struct strbuf *buf)
> >  {
> > -     while (*s !=3D '\0') {
> > -             if (!isspace(*s))
> > -                     return 0;
> > +     const char *s =3D buf->buf;
> > +     size_t cur_len =3D 0;
> > +
> > +     while ((cur_len !=3D buf->len) && (isspace(*s) || *s =3D=3D '\0')=
) {
> >               s++;
> > +             cur_len++;
> >       }
> > -     return 1;
> > +     return cur_len =3D=3D buf->len;
> >  }
>
> Assuming that we do want to treat NULs the same way as whitespaces,
> the updated code works as intended, which is good.  But I have no
> reason to support that design decision.  I do not have a strong
> reason to support a design decision that goes the opposite way to
> treat a NUL just like we treat an 'X', but at least I can understand
> it (i.e. "because we have no reason to special case NUL any more
> than 'X' when trying to see if a buffer is 'empty', we don't").
> This code on the other hand must be supported with "because we need
> to special case NUL for such and such reasons for the purpose of
> determining if a buffer is 'empty', we treat them the same way as
> whitespaces".
>

Something like "\0abc", from the perspective of the string, it is empty;
from the perspective of the memory, it is not empty; I don't know any
absolutely good solutions here.

> Can the change in this commit violate the invariant that
> if_then_else->str cannot be NULL, which seems to have been the case
> forever as we see an unchecked strcmp() done in the original?
>
> If so, perhaps you can check the condition upfront, where you
> compute str_len above, e.g.
>
>         if (!if_then_else->str) {
>                 if (if_then_else->cmp_status =3D=3D COMPARE_EQUAL ||
>                     if_then_else->cmp_status =3D=3D COMPARE_UNEQUAL)
>                         BUG(...);
>         } else
>                 str_len =3D strlen(...);
>
> If not, then I do not see the point of adding this (and later) check
> with BUG to this code.
>
> Or is the invariant that .str must not be NULL could have been
> violated without this patch (i.e. the original was buggy in running
> strcmp() on .str without checking)?  If so, please make it a separate
> preliminary change to add such an assert.
>

The BUG() here actually acts as an "assert()". ".str must not be NULL" is
right, it point to "xxx" in "%(if:equals=3Dxxx)", so it seems that these BU=
G()
are somewhat redundant, I will remove them.

> >  /* See grab_values */
> > -static void grab_sub_body_contents(struct atom_value *val, int deref, =
void *buf)
> > +static void grab_raw_data(struct atom_value *val, int deref, void *buf=
, unsigned long buf_size, struct object *obj)
> >  {
> >       int i;
> >       const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
> > @@ -1307,10 +1349,22 @@ static void grab_sub_body_contents(struct atom_=
value *val, int deref, void *buf)
> >                       continue;
> >               if (deref)
> >                       name++;
> > -             if (strcmp(name, "body") &&
> > -                 !starts_with(name, "subject") &&
> > -                 !starts_with(name, "trailers") &&
> > -                 !starts_with(name, "contents"))
> > +
> > +             if (starts_with(name, "raw")) {
> > +                     if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> > +                             v->s =3D xmemdupz(buf, buf_size);
> > +                             v->s_size =3D buf_size;
> > +                     } else if (atom->u.raw_data.option =3D=3D RAW_LEN=
GTH)
> > +                             v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t)b=
uf_size);
> > +                     continue;
> > +             }
>
> I can understand that "raw[:<options>]" handling has been inserted
> above the existing "from here on, we only deal with log message
> components" check.  But
>
> > +             if ((obj->type !=3D OBJ_TAG &&
> > +                  obj->type !=3D OBJ_COMMIT) ||
>
> I do not see why these new conditions are added.  The change is not
> justified in the proposed log message, the original did not need
> these conditions, and this does not concern the primary point of the
> change, which is to start supporting %(raw[:<option>]) placeholder.
>
> If it is needed as a bugfix (e.g. it may be that you consider "if a
> blob has contents that looks very similar to 'git cat-file commit
> HEAD', %(body) and friends parse these out, even though it is not a
> commit" is a bug and the change to add these extra tests is meant as
> a fix), that should be done as a preliminary change before adding
> the support for a new atom.
>

Almost what I means: Make a strong guarantee that blob and tree
will never pass the check so that we can don't worry about incorrect
parsing in find_subpos(). The reason I put it in this patch is that only
commit and tag objects will execute `grab_sub_body_contents()` before,
but in the current patch it has changed.

> > +                 (strcmp(name, "body") &&
> > +                  !starts_with(name, "subject") &&
> > +                  !starts_with(name, "trailers") &&
> > +                  !starts_with(name, "contents")))
> >                       continue;
> >               if (!subpos)
> >                       find_subpos(buf,
> > @@ -1374,25 +1428,30 @@ static void fill_missing_values(struct atom_val=
ue *val)
> >   * pointed at by the ref itself; otherwise it is the object the
> >   * ref (which is a tag) refers to.
> >   */
> > -static void grab_values(struct atom_value *val, int deref, struct obje=
ct *obj, void *buf)
> > +static void grab_values(struct atom_value *val, int deref, struct obje=
ct *obj, struct expand_data *data)
> >  {
> > +     void *buf =3D data->content;
> > +     unsigned long buf_size =3D data->size;
> > +
> >       switch (obj->type) {
> >       case OBJ_TAG:
> >               grab_tag_values(val, deref, obj);
> > -             grab_sub_body_contents(val, deref, buf);
> > +             grab_raw_data(val, deref, buf, buf_size, obj);
>
> It is very strange that a helper that is named to grab raw data can
> still process pieces out of a structured data.  The original name is
> still a far better match to what the function does, even after this
> patch teaches it to also honor %(raw) placeholder.  It is still
> about grabbing various "sub"-pieces out of "body contents", and the
> sub-piece the %(raw) grabs just happens to be "the whole thing".
>

Well, I can't think of a better name, My original idea was grab_raw_data()
can grab itself, header, contents, It is more general than
grab_sub_body_contents(),
raw data is not a part of "subject" or "body" of "contents"...

> > +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> > +{
> > +     size_t i;
> > +     const char *s1 =3D (const char *)vs1;
> > +     const char *s2 =3D (const char *)vs2;
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             unsigned char u1 =3D s1[i];
> > +             unsigned char u2 =3D s2[i];
> > +             int U1 =3D toupper (u1);
> > +             int U2 =3D toupper (u2);
>
> Does toupper('\0') even have a defined meaning?
>
> > +             int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
> > +                     : U1 < U2 ? -1 : U2 < U1);
>
> Looks crazy to worry about uchar wider than int.  Such a system is
> not even standard compliant, is it?
>

Forget about this inelegant help function. As I said in my reply to Felipe,
this is copied from gunlib...

> > @@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s,=
 struct ref_array_item *a, stru
> >       int cmp_detached_head =3D 0;
> >       cmp_type cmp_type =3D used_atom[s->atom].type;
> >       struct strbuf err =3D STRBUF_INIT;
> > +     size_t slen =3D 0;
> >
> >       if (get_ref_atom_value(a, s->atom, &va, &err))
> >               die("%s", err.buf);
> > @@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *=
s, struct ref_array_item *a, stru
> >       } else if (s->sort_flags & REF_SORTING_VERSION) {
> >               cmp =3D versioncmp(va->s, vb->s);
> >       } else if (cmp_type =3D=3D FIELD_STR) {
> > -             int (*cmp_fn)(const char *, const char *);
> > -             cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > -                     ? strcasecmp : strcmp;
> > -             cmp =3D cmp_fn(va->s, vb->s);
>
> > +             if (va->s_size =3D=3D ATOM_VALUE_S_SIZE_INIT &&
> > +                 vb->s_size =3D=3D ATOM_VALUE_S_SIZE_INIT) {
> > +                     int (*cmp_fn)(const char *, const char *);
> > +                     cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > +                             ? strcasecmp : strcmp;
> > +                     cmp =3D cmp_fn(va->s, vb->s);
> > +             } else {
> > +                     int (*cmp_fn)(const void *, const void *, size_t)=
;
> > +                     cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > +                             ? memcasecmp : memcmp;
>
> Why not introduce two local temporary variables a_size and b_size
> and initialize them upfront like so:
>
>                 a_size =3D va->s_size < 0 ? strlen(va->s) : va->s_size;
>                 b_size =3D vb->s_size < 0 ? strlen(vb->s) : vb->s_size;
>
> Wouldn't that allow you to do without the complex "if both are
> counted, do this, if A is counted but B is not, do that, ..."
> cascade?
>

Sorry, such code would be really ugly for reading.

> I can sort-of see the point of special casing "both are traditional
> C strings" case (i.e. the "if" side of the "else" we are discussing
> here) and using strcasecmp/strcmp instead of memcasecmp/memcmp, but
> I do not see much point in having the if/elseif/else cascade inside
> this "else" clause.
>

I will try to modify its logic.

> Thanks.

Your reply is very accurate.

Thanks.
--
ZheNing Hu
