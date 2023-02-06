Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEDEC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBFXm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFXmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:42:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2532123
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:42:46 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so9868211wmo.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cUyLblaLuIhGbocvIyRGwmg5BM52Hx9CCT+TUuKetk=;
        b=ZEtqZRnIwj6EuyuY4pJPqm69d8DXqct9g158ZWBLNG6ZEuYNZbpX/terwHyRMywvCT
         y+Gxjq01tZVfdloPEU03Myu+KylR6kvbiOCz7PlRHlTvjDHuDp5dh/V5j+jvHmo1+Sqx
         j4S4SEQ/CKZKzs/4KnbzB0ZhVPV3TViJGSVCwT94Cgh6Ly4St1/eiXdA+x0gUL0dSjXq
         JYRE6CgadHOLsjuu4hpO03zECNgHzmAim4rjD/JdBAkQOYstg1iEJRYoq/ewg8VGHf+a
         KM+H99itzG4DyH/pgSo8s3hrvMzgCNRxZXTKcvdUk1HHsKbx+z+vR7JIjH1RdqM1xsoH
         dZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cUyLblaLuIhGbocvIyRGwmg5BM52Hx9CCT+TUuKetk=;
        b=GuXlLSKzMJxazUgK2AoWeW2gmQlz+c2/Y0wtc7390ORhuITNLkd4eO8iDPo9br9mgx
         l8URtiT14WT96rqRApvgQQxbvYQ3BL41vTHcUK9SRSjtPY36ocOP8GvGyHBHjY/3zXdW
         gSMeD1vF9zky6GjdQHXTbRcZV74ZR3w32RktxB3G2FygsUxNQRJ3cxLGO7/Khl8FDO7n
         fjk2fgOaujilvDlB/eNOOIEgNo3jxiXcbYycbWsayfkDptyIDYv/CwdB5Pg4eG9TSzN7
         DrwvK7jji0tYDAMqO31T4SRcdlmvvSmzhz/WHsmGZia0GN51Qi4RAb6iqKMKoBLMqZVX
         e9YA==
X-Gm-Message-State: AO0yUKUMkA4+lT6FNy7kRowdAS0ZUUYojtrwvjUIbiqP0SiAKVnXQa9X
        TJmugBZRB02MDPmNJkSEqkSIOE1qnHXpRxCQoiY77dp3zHCwQA==
X-Google-Smtp-Source: AK7set9188w+ssvv6PLpE3+QVDlYi6I3HHRYvIQ01hXunzm5EXNp0Uy324pbriEfMndHsPny1DoSO10lt9asTeDB9og=
X-Received: by 2002:a05:600c:444a:b0:3dc:5956:9619 with SMTP id
 v10-20020a05600c444a00b003dc59569619mr1422251wmn.7.1675726964917; Mon, 06 Feb
 2023 15:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
In-Reply-To: <xmqqlela2z3p.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 6 Feb 2023 18:42:33 -0500
Message-ID: <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2023 at 5:44 PM Junio C Hamano <gitster@pobox.com> wrote:

> Have you run the resulting test?

My apologies for not testing after V1. That was a major oversight on
my part.  I'll make sure to thoroughly test before each submission to
avoid any issues with the code in the future.


> This creates a "test-patch" file with lines 'a' and 'b' that are
> common context lines without any whitespace before them, no?  The
> original left the necessary single space in front of them (see the
> line removed above).

I try to change the code to(left the necessary single space in front
of 'a' and 'b':

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index ab5ecaab7f..ef61a3187c 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -14,8 +14,8 @@ test_expect_success setup '
--- a/file
+++ b/file
@@ -1,2 +1,3 @@
- a
- b
+ a
+ b
+c
EOF

Here I only show one part ,but I fix two same issue in the V4 patch
and it still can not pass the test .
It say :

Test Summary Report

-------------------

t4113-apply-ending.sh (Wstat: 256 Tests: 0 Failed: 0)

  Non-zero exit status: 1

  Parse errors: No plan found in TAP output

Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.05 cusr
0.02 csys =  0.09 CPU)

Result: FAIL.

I'm stumped as to why it's still failing. I've tried searching for
answers on StackOverflow, but I still can't figure it out.
----------------
Thanks,
Shuqi
