Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA9C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAF923603
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhAHAqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 19:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHAqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 19:46:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4CCC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 16:46:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b9so12380450ejy.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAnLedsNLj/kfdw0yxZFtctPUxx2mIewClH2kefC3pM=;
        b=M/WbKwZvvdzNuBkcx9+vW4K2N2PTM/YbG3nSUlowqLohMHQQTavuO2eqcogMVElYK6
         p5yYatWvjUtgXszQ+hQM+5Gi81F+9FACkyMMJUQJy2uXJB/dsUqX2CXMPTS0Kz881sxa
         KiQR6al8k1EyHjW4ISfmSrIn0BiTDWScT/1WXtPohpYPcVl0e4bxQ0/+N3PmZ6s3MgDW
         IxP0sLilSMxhS1FidfdoHw3FUp1nY7dRC1kgFExoayhGV72p6MTj8KnxEugm06btwQRS
         NgPCC2MpHtl+ejmKyJNo3rwWgigUSNRK4VMyxETAWz5mCpvygStfeWnAK5D9jeEZH8dE
         NO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAnLedsNLj/kfdw0yxZFtctPUxx2mIewClH2kefC3pM=;
        b=eYys3GRTHeEgI9Zgl9B9uxYeiBvwQLH549Ov0py8S5cyZ6+eWjE6rI5lNmAMyUhT/W
         3/kMqoT/u/HeSyMwTzgd3QYvtm+vRJQC0NXQM3wqAd6nW3wETZJ+db5O4XL0psNwNVqP
         oMsHPuhdgbTmRaMVCURCITyWws5Q/z0b/mgXQeb9HxHBLdAGw1YYAzpJtTyGU89kZmQ5
         M/qLvOBtQg0kfeRyf4V/tqEG1CaeyKe+llBfA0x41TNPDi14cvirrNejRB7UOL4HwCXB
         hiMp/wY5W3cLxt+xmWKtR2wSevt15QFOEmFktYaZEVPdOyuMDP//49KTDOD400CJlvQ0
         9vOA==
X-Gm-Message-State: AOAM530TZthUFSyau9myYHyWDKExFgavCAYtdTU0huY+pXoxM6d4vcm4
        KURNKaaa6ISGCDINpjw6gNk5prdjVKSq5IbjzT0=
X-Google-Smtp-Source: ABdhPJztlVRoG8dNC/FZJfRC0Za9Q1Rwq7fE4fcX6izsCfyIXmjeXd999gY0l9rsGOD1Q1gsLOwIUPUbrs1+4m81xpU=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr978082ejb.551.1610066758761;
 Thu, 07 Jan 2021 16:45:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610027375.git.ps@pks.im> <e627e729e5cd14c94dcf819f4f87b1412b9a9e9b.1610027375.git.ps@pks.im>
 <xmqqtursjqva.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtursjqva.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 Jan 2021 01:45:47 +0100
Message-ID: <CAP8UFD1YxHGHLEHd_Bx1awSskjM6fHgM52nPWpTG2UHOmaOT9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch: allow passing a transaction to `s_update_ref()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 12:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >  static int s_update_ref(const char *action,
> >                       struct ref *ref,
> > +                     struct ref_transaction *transaction,
> >                       int check_old)
> >  {
> >       char *msg;
> >       char *rla = getenv("GIT_REFLOG_ACTION");
> > -     struct ref_transaction *transaction;
> > +     struct ref_transaction *transaction_to_free = NULL;
> >       struct strbuf err = STRBUF_INIT;
> > -     int ret, df_conflict = 0;
> > +     int ret, df_conflict = 0, commit = 0;
>
> > @@ -597,26 +598,38 @@ static int s_update_ref(const char *action,
> >               rla = default_rla.buf;
> >       msg = xstrfmt("%s: %s", rla, action);
> >
> > -     transaction = ref_transaction_begin(&err);
> > -     if (!transaction ||
> > -         ref_transaction_update(transaction, ref->name,
> > +     /*
> > +      * If no transaction was passed to us, we manage the transaction
> > +      * ourselves. Otherwise, we trust the caller to handle the transaction
> > +      * lifecycle.
> > +      */
> > +     if (!transaction) {
> > +             transaction = transaction_to_free = ref_transaction_begin(&err);
> > +             if (!transaction)
> > +                     goto fail;
> > +             commit = 1;
> > +     }
>
> The idea is that we still allow the caller to pass NULL in which
> case we begin and commit a transaction ourselves, but if the caller
> is to pass an already initialized transaction to us, we obviously
> do not have to "begin" but also we won't commit.
>
> Which makes sense, but then do we still need the "commit" variable
> that reminds us "we are responsible for finishing the transaction we
> started"?

Yeah, I think we also don't need the df_conflict variable, and I don't
like the duplication of the following clean up code:

        ref_transaction_free(transaction_to_free);
        strbuf_release(&err);
        free(msg);

Patrick's patch didn't introduce them, but we might still want to get
rid of them (see below).

> If we rename "transaction_to_free" to a name that makes it more
> clear that it is a transaction that we created and that we are
> responsible for seeing through to its end (after all, "to-free"
> captures only one half of that, i.e. before returning, we are
> responsible for calling ref_transation_free() on it), then we do not
> need such an extra variable that can go out of sync by mistake, no?
> The block that protects the call to ref_transaction_commit() can
> just check if the transaction_to_free variable (with a better name)
> is non-NULL, instead of looking at the commit variable.
>
> Just my attempt to come up with an alternative name for
> transaction_to_free:
>
>  - "our_transaction" because it is ours?
>
>  - "auto_transaction" because it is automatically started and
>    committed without bothering the caller?

"our_transaction" looks fine.

Here is a suggested refactoring patch that could come before Patrick's patch:

-------------------------------------------------------------------------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..8017fc19da 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -581,6 +581,22 @@ static struct ref *get_ref_map(struct remote *remote,
#define STORE_REF_ERROR_OTHER 1
#define STORE_REF_ERROR_DF_CONFLICT 2

+static int do_s_update_ref(struct ref_transaction *transaction,
+                          struct ref *ref,
+                          int check_old,
+                          struct strbuf *err,
+                          char *msg)
+{
+       if (!transaction ||
+           ref_transaction_update(transaction, ref->name,
+                                  &ref->new_oid,
+                                  check_old ? &ref->old_oid : NULL,
+                                  0, msg, err))
+               return TRANSACTION_GENERIC_ERROR;
+
+       return ref_transaction_commit(transaction, err);
+}
+
static int s_update_ref(const char *action,
                       struct ref *ref,
                       int check_old)
@@ -589,7 +605,7 @@ static int s_update_ref(const char *action,
       char *rla = getenv("GIT_REFLOG_ACTION");
       struct ref_transaction *transaction;
       struct strbuf err = STRBUF_INIT;
-       int ret, df_conflict = 0;
+       int ret = 0;

       if (dry_run)
               return 0;
@@ -598,30 +614,19 @@ static int s_update_ref(const char *action,
       msg = xstrfmt("%s: %s", rla, action);

       transaction = ref_transaction_begin(&err);
-       if (!transaction ||
-           ref_transaction_update(transaction, ref->name,
-                                  &ref->new_oid,
-                                  check_old ? &ref->old_oid : NULL,
-                                  0, msg, &err))
-               goto fail;

-       ret = ref_transaction_commit(transaction, &err);
+       ret = do_s_update_ref(transaction, ref, check_old, &err, msg);
       if (ret) {
-               df_conflict = (ret == TRANSACTION_NAME_CONFLICT);
-               goto fail;
+               error("%s", err.buf);
+               ret = (ret == TRANSACTION_NAME_CONFLICT)
+                       ? STORE_REF_ERROR_DF_CONFLICT
+                       : STORE_REF_ERROR_OTHER;
       }

       ref_transaction_free(transaction);
       strbuf_release(&err);
       free(msg);
-       return 0;
-fail:
-       ref_transaction_free(transaction);
-       error("%s", err.buf);
-       strbuf_release(&err);
-       free(msg);
-       return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
-                          : STORE_REF_ERROR_OTHER;
+       return ret;
}

static int refcol_width = 10;
-------------------------------------------------------------------------

After the above patch, Patrick's patch would become:

-------------------------------------------------------------------------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8017fc19da..d58805c03d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -584,6 +584,7 @@ static struct ref *get_ref_map(struct remote *remote,
static int do_s_update_ref(struct ref_transaction *transaction,
                          struct ref *ref,
                          int check_old,
+                          int commit,
                          struct strbuf *err,
                          char *msg)
{
@@ -594,16 +595,17 @@ static int do_s_update_ref(struct
ref_transaction *transaction,
                                  0, msg, err))
               return TRANSACTION_GENERIC_ERROR;

-       return ref_transaction_commit(transaction, err);
+       return (commit) ? ref_transaction_commit(transaction, err) : 0;
}

static int s_update_ref(const char *action,
+                       struct ref_transaction *transaction,
                       struct ref *ref,
                       int check_old)
{
       char *msg;
       char *rla = getenv("GIT_REFLOG_ACTION");
-       struct ref_transaction *transaction;
+       struct ref_transaction *our_transaction = NULL;
       struct strbuf err = STRBUF_INIT;
       int ret = 0;

@@ -613,9 +615,16 @@ static int s_update_ref(const char *action,
               rla = default_rla.buf;
       msg = xstrfmt("%s: %s", rla, action);

-       transaction = ref_transaction_begin(&err);
+       /*
+        * If no transaction was passed to us, we manage the
+        * transaction ourselves. Otherwise, we trust the caller to
+        * handle the transaction lifecycle.
+        */
+       if (!transaction)
+               transaction = our_transaction = ref_transaction_begin(&err);

-       ret = do_s_update_ref(transaction, ref, check_old, &err, msg);
+       ret = do_s_update_ref(transaction, ref, check_old, !!our_transaction,
+                             &err, msg);
       if (ret) {
               error("%s", err.buf);
               ret = (ret == TRANSACTION_NAME_CONFLICT)
@@ -623,7 +632,7 @@ static int s_update_ref(const char *action,
                       : STORE_REF_ERROR_OTHER;
       }

-       ref_transaction_free(transaction);
+       ref_transaction_free(our_transaction);
       strbuf_release(&err);
       free(msg);
       return ret;
...
-------------------------------------------------------------------------

You can find these patches, with Patrick as the author, there:

https://gitlab.com/gitlab-org/gitlab-git/-/commits/cc-improve-s-update-ref/
