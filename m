Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F66B20372
	for <e@80x24.org>; Thu, 12 Oct 2017 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdJLOmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 10:42:13 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:54648 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdJLOmM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 10:42:12 -0400
Received: by mail-it0-f51.google.com with SMTP id 72so7097281itk.3
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DVbeaYPrgX71znxjYMgb4Ez9xUksXQt1RfXrI+uKsRI=;
        b=HiNnovVpap4gZ5qDcFtDWn2udF20zY0fha9+ZfJEna6mCNupue7ajkhgUjlZPjoBM1
         0EcPOiwdSExHSdAZDe6TnfugODoqBoVV+YNwOdobbNNe0PlEV0PnqrasghdxUXRw6lt/
         hIwrGdc07yxl3+Rb3/ZI7j9skmnJLjaDd0nX9KKkguJN7b2GGPXV7OEsBOjtqjru4/xK
         BTuOwuek7ezYUHc6YNoogdZ9uOlOFj3n/d5aQAj2kpy/vQDFdw+bkmLzsZw3XoTFZItR
         h19oJ1kwSzxK0Sq8KLsigvfHD3RdZfIVtW33bPifqDJ/+7KgLh90kvPLpPGaZIQremWM
         lsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DVbeaYPrgX71znxjYMgb4Ez9xUksXQt1RfXrI+uKsRI=;
        b=pjsvBeJbDLGTG7lnTpSk+1Ij3dfKnYUIeBuLHd+cV4Q/m20R89T1QcTM9Z4mHx4FJT
         MDVS0Cg5v16cYg89lZTtLU6RmYTlFmnXJzdr3QfLv1d486wca5S2OPBe2jaZADSC+V+s
         f0QCma7nzk/yHZ74UW9b8YlPtrL3ARbuvfipf4jo2uTybNhxeyuIw0gCmngAzXCU9hbt
         Xxd8tLSMmr7kiZbN4P8kUw/+/g6NGrAopFXWdi2seHhwN7BaVxLvP0kh+EryxacJSs8r
         Qv+AdSjxgnERjfwmWr66aBtnDT8/UAMs8qQ4hNg1tLokNeU764t4InlbaE79cfrknpKt
         ODRQ==
X-Gm-Message-State: AMCzsaV4OJIOy+eOiv/v2FYRkddV+2o8dvL3YpZBeprz3yQlxyxPR3qH
        lMdiCs+njSQALMj2glHxOC/wG/eZFPWZmSM4D5c=
X-Google-Smtp-Source: AOwi7QBYF0Wyybw7E3S6t7kJOXRq/r8aX2JNRE2n6uUvHjkmK7M7Zhxu1L2d5lLps6YqBf258uHLrwK421bc0RmLi1s=
X-Received: by 10.36.11.197 with SMTP id 188mr3270282itd.42.1507819331191;
 Thu, 12 Oct 2017 07:42:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Thu, 12 Oct 2017 07:42:10 -0700 (PDT)
In-Reply-To: <5a9242024013345d7a3b0f63580360cdc8cc1c43.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com> <5a9242024013345d7a3b0f63580360cdc8cc1c43.1506714999.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Oct 2017 16:42:10 +0200
Message-ID: <CAP8UFD2THRj7+RXmismUtUOpXQv4wM7aZsejpd_FHEOycP+ZJA@mail.gmail.com>
Subject: Re: [PATCH 07/18] sha1_file: support lazily fetching missing objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 10:11 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index b4a67bb83..77aa0ffdf 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -29,6 +29,7 @@
>  #include "mergesort.h"
>  #include "quote.h"
>  #include "packfile.h"
> +#include "fetch-object.h"
>
>  const unsigned char null_sha1[GIT_MAX_RAWSZ];
>  const struct object_id null_oid;
> @@ -1149,6 +1150,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>         return (status < 0) ? status : 0;
>  }
>
> +int fetch_if_missing = 1;
> +
>  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
>  {
>         static struct object_info blank_oi = OBJECT_INFO_INIT;
> @@ -1157,6 +1160,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>         const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
>                                     lookup_replace_object(sha1) :
>                                     sha1;
> +       int already_retried = 0;
>
>         if (!oi)
>                 oi = &blank_oi;
> @@ -1181,28 +1185,36 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>                 }
>         }
>
> -       if (!find_pack_entry(real, &e)) {
> -               /* Most likely it's a loose object. */
> -               if (!sha1_loose_object_info(real, oi, flags))
> -                       return 0;
> +retry:
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
>
> -               /* Not a loose object; someone else may have just packed it. */
> -               if (flags & OBJECT_INFO_QUICK) {
> -                       return -1;
> -               } else {
> -                       reprepare_packed_git();
> -                       if (!find_pack_entry(real, &e))
> -                               return -1;
> -               }
> +       /* Most likely it's a loose object. */
> +       if (!sha1_loose_object_info(real, oi, flags))
> +               return 0;
> +
> +       /* Not a loose object; someone else may have just packed it. */
> +       reprepare_packed_git();
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
> +
> +       /* Check if it is a missing object */
> +       if (fetch_if_missing && repository_format_partial_clone &&
> +           !already_retried) {
> +               fetch_object(repository_format_partial_clone, real);
> +               already_retried = 1;
> +               goto retry;
>         }
>
> +       return -1;
> +
> +found_packed:
>         if (oi == &blank_oi)
>                 /*
>                  * We know that the caller doesn't actually need the
>                  * information below, so return early.
>                  */
>                 return 0;
> -
>         rtype = packed_object_info(e.p, e.offset, oi);
>         if (rtype < 0) {
>                 mark_bad_packed_object(e.p, real);

Instead of adding labels and gotos, I would suggest adding a new
function like the following does on top of your changes:

diff --git a/sha1_file.c b/sha1_file.c
index cc1aa0bd7f..02a6ed1e9b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1171,18 +1171,40 @@ static int sha1_loose_object_info(const
unsigned char *sha1,
        return (status < 0) ? status : 0;
 }

+int try_find_packed_entry_or_loose_object(const unsigned char *real,
struct object_info *oi,
+                                         unsigned flags, struct
pack_entry *e, int retry)
+{
+       if (find_pack_entry(real, e))
+               return 1;
+
+       /* Most likely it's a loose object. */
+       if (!sha1_loose_object_info(real, oi, flags))
+               return 0;
+
+       /* Not a loose object; someone else may have just packed it. */
+       reprepare_packed_git();
+       if (find_pack_entry(real, e))
+               return 1;
+
+       /* Check if it is a missing object */
+       if (fetch_if_missing && repository_format_partial_clone && retry) {
+               fetch_object(repository_format_partial_clone, real);
+               return try_find_packed_entry_or_loose_object(real, oi,
flags, e, 0);
+       }
+
+       return -1;
+}
+
 int fetch_if_missing = 1;

 int sha1_object_info_extended(const unsigned char *sha1, struct
object_info *oi, unsigned flags)
 {
        static struct object_info blank_oi = OBJECT_INFO_INIT;
        struct pack_entry e;
-       int rtype;
+       int rtype, res;
        const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
                                    lookup_replace_object(sha1) :
                                    sha1;
-       int already_retried = 0;
-
        if (!oi)
                oi = &blank_oi;

@@ -1206,30 +1228,10 @@ int sha1_object_info_extended(const unsigned
char *sha1, struct object_info *oi,
                }
        }

-retry:
-       if (find_pack_entry(real, &e))
-               goto found_packed;
-
-       /* Most likely it's a loose object. */
-       if (!sha1_loose_object_info(real, oi, flags))
-               return 0;
-
-       /* Not a loose object; someone else may have just packed it. */
-       reprepare_packed_git();
-       if (find_pack_entry(real, &e))
-               goto found_packed;
-
-       /* Check if it is a missing object */
-       if (fetch_if_missing && repository_format_partial_clone &&
-           !already_retried) {
-               fetch_object(repository_format_partial_clone, real);
-               already_retried = 1;
-               goto retry;
-       }
-
-       return -1;
+       res = try_find_packed_entry_or_loose_object(real, oi, flags, &e, 1);
+       if (res < 1)
+               return res;

-found_packed:
        if (oi == &blank_oi)
                /*
                 * We know that the caller doesn't actually need the
