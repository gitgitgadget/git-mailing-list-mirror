Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D518F1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 00:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNAwU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 19:52:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42605 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 19:52:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so2862954pfh.9
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbKrGiribdPsNGklGVs4eIG6hzDb01y4odK7wIlR6WY=;
        b=rOceye4vcDPJn5cGNlVllSS2Jhh8W78s4HfIFR90t/MIMsxF9oDZbrOmRBtUfFJei+
         pxm4PdfWbwdyUsyrtKVo/zV2WwAcxj1HrtXmc5aNMGogt6bAkw8JCC9EDwC4CjIBFsjG
         ecDR2Y1Ly3lm+jOkgBY0kj0MkQsMW5po4p6oDUofLxitwxCx4rUbMSWeLpnAY/bKi3K1
         1v1Uj1mN07bVdif50u7PLVXiP7FAc7WzjW+GUEHE00pFV2zXaU2MwzfNvoBWhaGyZDtn
         gqHM6B8tZpp/xuCC/32492fapGP4F9tK3PDRmNj2Vzj6nuDLsL+Mzvkp+YkzYmCdgTjZ
         JQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbKrGiribdPsNGklGVs4eIG6hzDb01y4odK7wIlR6WY=;
        b=hU+A3KE5atT2BaITNdJvz2n5wCbPwwNW83C/5NwYuYQESWbBsU8v6PHQl/53iBg7Ep
         vbDf9obRjJZMLUFqZN5kEzRY4mPJkzFT6CdEXI95mB5OMwOE7615rfxOkxiyxB0OXXTx
         le1U5qPCwm1g25+YTzwwukPXbA8aHBnCOSes09MSyuIFOckveEg8Maaspd4/htod4gFo
         6RvDjfDPQJfDuUGEsB+mgmqWeXTwv59gDZYCYdM/LH/Mj5R1k1yKpue+9Nprx+yEojSo
         1k/zb0BfNOPJO3SmIZ7hdNTW7Y+mHFvaFWyQSeftYRF3Vg6wnc9nk3+dTGt2tu3Icaia
         Lc8A==
X-Gm-Message-State: APjAAAVHgjzGsZjsWDMrWxheyHFoxpZmiEEtm8+cSik3SX9yGbhiwZKj
        MBh7tcdADR7fc1S73lIBvD4=
X-Google-Smtp-Source: APXvYqxrs0Yrb/+2I2751e43139jYTVz8EVLGABSIfL46pLHVYNiodePpL9dNuawvIw2/u1oH5Z7OA==
X-Received: by 2002:a17:90a:3ac8:: with SMTP id b66mr9026356pjc.9.1573692737955;
        Wed, 13 Nov 2019 16:52:17 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k13sm3769491pgl.69.2019.11.13.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:52:16 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:52:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 01/14] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <20191114005215.GA24527@generichostname>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
 <0532847787dfd48fbe4b41a4a7d2783748f3bd7f.1573595985.git.liu.denton@gmail.com>
 <xmqqmud0czch.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmud0czch.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Nov 13, 2019 at 10:57:34AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +# Tests that its two parameters refer to the same revision, or if '!' is
> > +# provided first, that its other two parameters refer to different
> > +# revisions.
> >  test_cmp_rev () {
> > +	local op wrong_result
> > +	op='='
> > +	wrong_result='different'
> > +	if test $# -ge 1 && test "x$1" = 'x!'
> > +	then
> > +	    op='!='
> > +	    wrong_result='the same'
> > +	    shift
> > +	fi
> On the other hand, if we want to insist that the form without '!' is
> the norm, then
> 
> 	local op='=' wrong_result='different'
> 
> 	if test $# -ge 1 && test "x$1" = 'x!'
> 	then
> 	    op='!='
> 	    wrong_result='the same'
> 	    shift
> 	fi
> 
> would be shorter (yes, I made sure we already use assignment to a
> variable on the same line where it is declared "local"; we used to
> avoid "local" that is outside POSIX so I want to make sure our use
> is safe).

I'd prefer this form. Unless anyone else objects, you can squash it in.

You bring up a good point about us _already_ using inline assignments
with `local`, though. In fact, it looks like we already test for this in
the very first test case of t0000 so I comfortable with this change.

However, I'd feel _more_ comfortable with this change if we also queued
the following patch. (This change can either live on a separate branch
or become the first patch in this series.)

-- >8 --
Subject: [PATCH] t0000: test multiple local assignment

According to POSIX enhancement request '0000767: Add built-in
"local"'[1],

	dash only allows one variable in a local definition; it permits
	assignment though it doesn't document that clearly.

however, this isn't true since t0000 still passes with this patch
applied on dash 0.5.10.2. Needless to say, since `local` isn't POSIX
standardized, it is not exactly clear what `local` entails on different
versions of different shells.

We currently already have many instances of multiple local assignments
in our codebase. Ensure that this is actually supported by explicitly
testing that it is sane.

[1]: http://austingroupbugs.net/bug_view_page.php?bug_id=767

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0000-basic.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d3f7ba295..a4af2342d1 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -20,9 +20,9 @@ modification *should* take notice and update the test vectors here.
 
 . ./test-lib.sh
 
-try_local_x () {
-	local x="local" &&
-	echo "$x"
+try_local_xy () {
+	local x="local" y="alsolocal" &&
+	echo "$x $y"
 }
 
 # Check whether the shell supports the "local" keyword. "local" is not
@@ -35,11 +35,12 @@ try_local_x () {
 # relying on "local".
 test_expect_success 'verify that the running shell supports "local"' '
 	x="notlocal" &&
-	echo "local" >expected1 &&
-	try_local_x >actual1 &&
+	y="alsonotlocal" &&
+	echo "local alsolocal" >expected1 &&
+	try_local_xy >actual1 &&
 	test_cmp expected1 actual1 &&
-	echo "notlocal" >expected2 &&
-	echo "$x" >actual2 &&
+	echo "notlocal alsonotlocal" >expected2 &&
+	echo "$x $y" >actual2 &&
 	test_cmp expected2 actual2
 '
 
-- 
2.24.0.346.gee0de6d492

