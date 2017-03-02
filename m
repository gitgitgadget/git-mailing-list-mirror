Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E314F1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 13:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdCBNQz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 08:16:55 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34207 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdCBNQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 08:16:53 -0500
Received: by mail-ot0-f195.google.com with SMTP id x37so997532ota.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5nZr7pb3zYdOzOlKlH71gsvErRsRCaJb849ofANU4JQ=;
        b=VbRzlX/bXhTqjAXLmeJ+jjZJLL0RYB9V+t1tbzY9CrBrlJnlIAxVDMizrqzVflBC6d
         SuL5CmVTPhuVbqEMbFFy5CS0G6gn36kcGAsvWy+VTDLgwwmH8Kkm2u2qFvEKGO+tBeae
         quVgHupwiKrYbYUccplI63qkfoUleR4ijn3hZYK/O2XFEVubi7nE3Nt6kiJ5XayOGsaf
         AYRrdjHErSadc+KmzXfYlqfEknJG17kckZ9yURmyfRNlO27ETEdcJxZ7V+8tJk2cFZt2
         F9NbyKYCS6c4UiFeoeGXWGDlBnblhfn9nuteKpZXQEPkEdEd3T6hNpZrj+wj+TU71R/X
         ycdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5nZr7pb3zYdOzOlKlH71gsvErRsRCaJb849ofANU4JQ=;
        b=H8IDUnA/h8QSUuxCUvvKfWrID0B9nWl/GgfeETHKh+ZxU1SI6gUKVtAWpWFolfiC5c
         6HezvWKWbp6iO9uK7LAxsl/VMgazT/CJ1cJUzdYBtBKF9iuQn6y/ZLiN+2AMwahpnnFv
         X8KDxeWIYYy+x8Ptb3PGJqTpdLKLl3NlBly3MFdrQa0EeKqwdZsTc4YEy4iQcexa7pHH
         MaEMs5bE9WnFT80Aul8zq6EVwrM0+41P0fCBdajym2dKH7CnNS9wGBQIjxbO0taPv3TY
         LmSpW31QUgMMM4DSGXiAndY6XhayFHAJnPjyX+uBOX/O68eY/wFut5ZGLZqFhiPVKfRb
         YY4Q==
X-Gm-Message-State: AMke39lG4M+/Egrd1bg0ak+xIRytcFKGaQxlZLRYIKiSSixz7Dq2GEsavfUW8ASkMq2o2j3lD2xny5VwPXBjyg==
X-Received: by 10.157.46.137 with SMTP id w9mr7651424ota.225.1488458847907;
 Thu, 02 Mar 2017 04:47:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 04:46:57 -0800 (PST)
In-Reply-To: <beef528b-66cd-e104-4c02-b07ddfa7e6d7@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-8-pclouds@gmail.com> <beef528b-66cd-e104-4c02-b07ddfa7e6d7@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 19:46:57 +0700
Message-ID: <CACsJy8CC=DSHyOk2qpdprUTt_3HGK7Wi0VSs4N-0wTUQ-xR8Lw@mail.gmail.com>
Subject: Re: [PATCH v5 07/24] files-backend: add and use files_refname_path()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:41 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/22/2017 03:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Keep repo-related path handling in one place. This will make it easier
>> to add submodule/multiworktree support later.
>>
>> This automatically adds the "if submodule then use the submodule version
>> of git_path" to other call sites too. But it does not mean those
>> operations are sumodule-ready. Not yet.
>
> s/sumodule/submodule/
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs/files-backend.c | 45 +++++++++++++++++++++++++--------------------
>>  1 file changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 7b4ea4c56..72f4e1746 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1180,6 +1180,18 @@ static void files_reflog_path(struct files_ref_st=
ore *refs,
>>       strbuf_git_path(sb, "logs/%s", refname);
>>  }
>>
>> +static void files_refname_path(struct files_ref_store *refs,
>> +                            struct strbuf *sb,
>> +                            const char *refname)
>> +{
>> +     if (refs->submodule) {
>> +             strbuf_git_path_submodule(sb, refs->submodule, "%s", refna=
me);
>> +             return;
>> +     }
>> +
>> +     strbuf_git_path(sb, "%s", refname);
>> +}
>
> Maybe it's just me, but I find it odd to exit early here when the first
> exit isn't due to an error. For me, structuring this like `if ()
> call1(); else call2();` would make it clearer that the two code paths
> are equally-valid alternatives, and either one or the other will be
> executed.

Its original version probably looked better. This is another case of
future patches influencing back the past ones: I structure the patch
so that in future we mostly add lines, or delete whole (in this case,
I believe), not modify a lot of lines. I think the readability does
not degrade too much though, so it's probably ok.
--=20
Duy
