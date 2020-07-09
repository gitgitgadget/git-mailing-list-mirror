Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F937C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDCC2070E
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRFDuuem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGIIKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGIIKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 04:10:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46CC061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 01:10:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so1301445ejd.13
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBiNp5V1adIGgge2jBTrJvCkWwaMPI/1PM2SaqqpDn4=;
        b=IRFDuuemA5q2BRpZRWUgveh1A/x2OX/9pPadFjCenptz3DwkWudDJYK6hqelJBsJuN
         84vnMadWnzIpuj4eg3Kkws+2vn6BV+ahd5xC57XEtR/chYzEuwQGxkCartmUyFP1kOjR
         rIUrDYJvdCv2n24DYsQu45OcvdgfB/E59+NhD7sJ9/TifwwnyGJNiprNoY7A4/3E3/N9
         yeznZkeevkHk/7C82h9pqF9r+LZp9OkTX6AyAQIhxtyRzPLxM8bTQSZWlxbf8pECSZ98
         +QJnhcA0EZ4Yn31rZQD+tRa1z3KXIRDBUstXcJY+j7veVYFFNA8G60FmD29zgylQXUY0
         oiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBiNp5V1adIGgge2jBTrJvCkWwaMPI/1PM2SaqqpDn4=;
        b=JEfDTne7Cr6DQQxWGhMxZIvLQSSbYAY9HjAUgTIubOdfYpqWb6MIyt8M0Iz4AFRh+N
         fiisVDKxayH4E4ygRyXh+IcgZG3gg+GvCUjgk1rIwkb2Wd3kiOE77XE9EZoBOp2rMhrw
         VI2LVWymluUB6Jrfh2Sr6hsd8CGyrSba+nk8cjy5lZTu2UqAXv+37R7HUJ2EJIAlUn8k
         jxdp/IWVnLOtEwWAANfqSKHdiwxg80p6qMprfCSdKwAoOKxgv6BbakGigbfO3Dneilsc
         5J5krEpSFL8qYgWByEyN1JoEQr+EmhKZ34cM5FVFp755hPmCmzRp9CRmm2r1qn+lbkhV
         56xw==
X-Gm-Message-State: AOAM531wg7j47imwcNsxz7iz8SsA1AlB+mnQ2MsEC4kKteeBe9Q3a2BM
        GHrw/2Qy9Lfv6v6Q7f/jz9qCGQJE5M3OJKukKFw=
X-Google-Smtp-Source: ABdhPJzL+LbyS4xOsxX908c0aYbZYAp42I64iYs2k/LCNLnnflwrYjIW4hBXuwFF+3GmSCNhMtCUJMEUIEy7rt85QPQ=
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr10895892ejj.197.1594282241086;
 Thu, 09 Jul 2020 01:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
 <20200707174049.21714-5-chriscool@tuxfamily.org> <xmqqk0zf3y8s.fsf@gitster.c.googlers.com>
 <xmqqtuyhzgro.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuyhzgro.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Jul 2020 10:10:29 +0200
Message-ID: <CAP8UFD2tUUgwjhkizihhqHc0LUYN_gS=wZCtXroLVtT3kMyqLw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 9, 2020 at 2:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Of course, we _could_ update the test_atom to do something magic
> > only when the 'contents' atom is being asked.  We notice that $2 is
> > 'contents', do the usual test_expect_success for 'contents', and
> > then measure the byte length of $3 ourselves and test
> > 'contents:size'.  That way, all the above test updates would become
> > unnecessary (and the last two hunks of this patch can also go).
> >
> > That approach may even allow you to hide the details of sanitize-pgp
> > in the updated test_atom so that the actual tests may not have to get
> > updated even for signed tags.
>
> After seeing the "wc -c" portability issues, I am now even more
> inclined to say that the above is the right direction.  The
> portability worries can and should be encapsulated in a single
> test_atom helper function, just as it can be used to hide the
> differences between signed tags, annotated tags and commits.

Yeah, I have been working on that and will send a new patch series soon.
The current test_atom() change looks like this:

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 371e45e5ad..e514d98574 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -52,6 +52,26 @@ test_atom() {
                sanitize_pgp <actual >actual.clean &&
                test_cmp expected actual.clean
        "
+       # Automatically test "contents:size" atom after testing "contents"
+       if test "$2" = "contents"
+       then
+               case "$1" in
+               refs/tags/signed-*)
+                       # We cannot use $3 as it expects sanitize_pgp to run
+                       git cat-file tag $ref | tail -n +6 | \
+                               wc -c | sed -e 's/^ *//' >expected ;;
+               refs/mytrees/*)
+                       echo >expected ;;
+               refs/myblobs/*)
+                       echo >expected ;;
+               *)
+                       printf '%s' "$3" | wc -c | sed -e 's/^ *//' >expected ;;
+               esac
+               test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
+                       git for-each-ref --format='%($2:size)' $ref >actual &&
+                       test_cmp expected actual
+               "
+       fi
 }

I am wondering if it's worth adding a preparatory patch to introduce
an helper function like the following in test-lib-functions.sh:

+# test_byte_count outputs the number of bytes in files or stdin
+#
+# It is like wc -c but without portability issues, as on macOS and
+# possibly other platforms leading whitespaces are emitted before the
+# number.
+
+test_byte_count () {
+       wc -c "$@" | sed -e 's/^ *//'
+}

Not sure about the name of this helper function as it works
differently than test_line_count().
