Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78B0211B4
	for <e@80x24.org>; Tue,  4 Dec 2018 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLDXMf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 18:12:35 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38017 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXMe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 18:12:34 -0500
Received: by mail-ed1-f54.google.com with SMTP id h50so15429126ede.5
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKLrsTbLL6Vf4ianaU50XrA9QclLoL2iZUA7D6Cm0HQ=;
        b=s2tUoHsldRuBYh0/Jis2LxUFpwHtO2Jr1UeGQpbX8Og0HGaG+kYn2tY24Y3d6nPYZs
         uQqWqhSkq+ceTu6STs6uwW67LbrbZoKzXuBswosSjgjepDgNQuDi/or0q4VsmWXi8dFG
         OJUBd/b3fcoPb3/rt9T+CAdu+7UG+kShzlx9KhC+tOy6g9zePJxAz0MwgpiS0ieCYmrA
         qEk6MJjZ6CDlI9yu5+BTZiUIXON5tCS3HNmWonbyJ8hSVBGIoce6cXpFG5OSjvcSjTfS
         w/Mx/Ml+nUsoIklfwyTU0WOIEBZcaUkTv2OohAw1bGTpY+vWHq17U77NVeOPl5Wlxd5D
         tXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKLrsTbLL6Vf4ianaU50XrA9QclLoL2iZUA7D6Cm0HQ=;
        b=dcj2SFSX1Rb2mpgnO1wuYMPtGtK7VkrARePTGHZacx5nK7Mr1OQyBOErBdeMuhJ5T2
         xeOTFZQDohWoiEdhsiy88F9BYnwpyKgpY3xs5edV2xNR1Op5dWf/cqSXm51R6rg6m8rt
         g4eEcYaf1Rj7hmcjlnAVNpD5sVIHVmvg6UCsOq9MbYwl7A2E9TDfq3hu/93CF16XVuSn
         vl1hnZsi58MgYhjqdAJb5iGOuyPen3sucGzOv1RfllYlBWsnYUygP3JodMqO1pnET50N
         p/q6/mytupWFqDNSAUDb/AVay9JWJOnNBp0J75OwprO9hXAzVSxeuhmBcyUpLKVnbOHt
         6LEg==
X-Gm-Message-State: AA+aEWbODhOEHQzLYukmYP198wwpFwIDG2WSfo4sj6hEdbzw3A9RFtM+
        HiTzFCnDkNxdpH0+sTXiAZZ5QICCI+cNAu5qciDXsQ==
X-Google-Smtp-Source: AFSGD/XNbpqdAp5ecHolNY7XjC4hoJnsOQFhIC5LETs4LSHAEeW5n8tA8HJnjNfNGeTKmsdxml6ElW2Ev1njvUq4aZA=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr17253911eji.106.1543965152113;
 Tue, 04 Dec 2018 15:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20181204224238.50966-1-jonathantanmy@google.com>
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Dec 2018 15:12:21 -0800
Message-ID: <CAGZ79kYOOk2ODYgRcSZgDUqBfx2HeywnEGpbJB9BrrVzEUi_JA@mail.gmail.com>
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in get_reference()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 2:42 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When fetching into a repository, a connectivity check is first made by
> check_exist_and_connected() in builtin/fetch.c that runs:
>
>   git rev-list --objects --stdin --not --all --quiet <(list of objects)
>
> If the client repository has many refs, this command can be slow,
> regardless of the nature of the server repository or what is being
> fetched. A profiler reveals that most of the time is spent in
> setup_revisions() (approx. 60/63), and of the time spent in
> setup_revisions(), most of it is spent in parse_object() (approx.
> 49/60). This is because setup_revisions() parses the target of every ref
> (from "--all"), and parse_object() reads the buffer of the object.
>
> Reading the buffer is unnecessary if the repository has a commit graph
> and if the ref points to a commit (which is typically the case). This
> patch uses the commit graph wherever possible; on my computer, when I
> run the above command with a list of 1 object on a many-ref repository,
> I get a speedup from 1.8s to 1.0s.
>
> Another way to accomplish this effect would be to modify parse_object()
> to use the commit graph if possible; however, I did not want to change
> parse_object()'s current behavior of always checking the object
> signature of the returned object.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is on sb/more-repo-in-api because I'm using the repo_parse_commit()
> function.

This is a mere nicety, not strictly required.
Before we had parse_commit(struct commit *) which would accomplish the
same, (and we'd still have that afterwards as a #define falling back onto
the_repository). As the function get_reference() is not the_repository safe
as it contains a call to is_promisor_object() that is repository
agnostic, I think
it would be fair game to not depend on that series. I am not
complaining, though.

> A colleague noticed this issue when handling a mirror clone.
>
> Looking at the bigger picture, the speed of the connectivity check
> during a fetch might be further improved by passing only the negotiation
> tips (obtained through --negotiation-tip) instead of "--all". This patch
> just handles the low-hanging fruit first.
> ---
>  revision.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index b5108b75ab..e7da2c57ab 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -212,7 +212,20 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  {
>         struct object *object;
>
> -       object = parse_object(revs->repo, oid);
> +       /*
> +        * If the repository has commit graphs, repo_parse_commit() avoids
> +        * reading the object buffer, so use it whenever possible.
> +        */
> +       if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
> +               struct commit *c = lookup_commit(revs->repo, oid);
> +               if (!repo_parse_commit(revs->repo, c))
> +                       object = (struct object *) c;
> +               else
> +                       object = NULL;

Would it make sense in this case to rely on parse_object below
instead of assigning NULL? The reason for that would be that
when lookup_commit returns NULL, we would try more broadly.

AFAICT oid_object_info doesn't take advantage of the commit graph,
but just looks up the object header, which is still less than completely
parsing it. Then lookup_commit is overly strict, as it may return
NULL as when there still is a type mismatch (I don't think a mismatch
could happen here, as both rely on just the object store, and not the
commit graph.), so this would be just defensive programming for
the sake of it. I dunno.

    struct commit *c;

    if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT &&
        (c = lookup_commit(revs->repo, oid)) &&
        !repo_parse_commit(revs->repo, c))
            object = (struct object *) c;
    else
        object = parse_object(revs->repo, oid);


So with all that said, I still think this is a good patch.

Thanks,
Stefan

> +       } else {
> +               object = parse_object(revs->repo, oid);
> +       }
> +
>         if (!object) {
>                 if (revs->ignore_missing)
>                         return object;
> --
> 2.19.0.271.gfe8321ec05.dirty
>
