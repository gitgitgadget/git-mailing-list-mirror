Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA8C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA184206F4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfX/Z5UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgK0KSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK0KSR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:18:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C08C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:18:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so4657690wmd.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdJjOROwxs0zgB3dkUuAXiRVPeRUhSJH3tmj2NIHf7c=;
        b=XfX/Z5UTX3AomWiumC87q6JbkcY0jGfFzEM17llYHZsUDYzpuRGU658Q1Q0tuXuDbj
         YvadrZ0rFb6ShrioqiewkltMLhnXc5FEk8tZuHsPONyxiMdJaN7m1hBrNReChr0o5b2E
         OZk1iAvzzU6c770lZqlrGvZssLaARJCI5MjRgN6wTocWCvvElRff6DaeYUHX9+B2xtDC
         U4kBdsLQeSt/YEHUlhRP7VB7RqTppAWqLtI3YggbVLgwoq1fqm6RSINnX5pdtIQz+9Y/
         5zy+QUoYwn1y2wdsb5VEwV/1MXMOD0iFdcZCcgzGSm4ZLpKRUlfy0PPy9mCJ7GsdQCOJ
         60IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdJjOROwxs0zgB3dkUuAXiRVPeRUhSJH3tmj2NIHf7c=;
        b=uM6eREvbUZt7ODDm62aDGM5Lh4y0Ze9Xbca6OdrPjFzFCLOXYL8t6Lg3US6Q1TOk8s
         u+HXcO8cG+SYzCWYMuigHlL6/iAuJjzLaKUelFTosSbAcO3+odPP3T6mfSjDdi24WcIz
         eoLs/AeKCDs7TH25G8qWEyi4yAQAWUuGX5+j+IiSqrska3dpej0zOi4drtnl6UyfeYPf
         dOgBe28dE8USQXKO+GN4Y4Z/m21nBCSZ6efVwhfSGkXAOOlBMCX+UGEJWlM7qyLtLjGD
         1StAUq5Zw8xkyV1KLK0k04et/R753TmrV5z0kFtNJ33BfBbSvJWm2UJIIykUxKYVP6C6
         OT9Q==
X-Gm-Message-State: AOAM530KkgkkMqqbx4yxaPOdHsbTIkxOtUHiyqFA95uVCPDOYcjqbthL
        dU5fTMNC0aiI/Ngwm7W4ot69jqvjOl36kC89To4=
X-Google-Smtp-Source: ABdhPJxvuJvn0gMgpUj4fc52Dp/QzF/ruxWr1duALNmu3slAmNRcg4v8hOTnHxj20JskpO6/A1M+kdgr8DIUDZtN+l0=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr8074553wml.100.1606472295838;
 Fri, 27 Nov 2020 02:18:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <987d1d186fd68d604268f9a66118b7f276094daf.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <987d1d186fd68d604268f9a66118b7f276094daf.1606419752.git.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 27 Nov 2020 04:18:04 -0600
Message-ID: <CAMP44s1EEwmJtQiPx=NkZdJ-7LOm+S55Hdukf+Oz1aBV1MREEg@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] reftable: utility functions
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 2:42 AM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
> +{
> +       size_t lo = 0;
> +       size_t hi = sz;

Is there anything wrong with:

  size_t lo = 0, hi = sz;

> +       /* invariant: (hi == sz) || f(hi) == true
> +          (lo == 0 && f(0) == true) || fi(lo) == false
> +        */

This doesn't follow the multi-line format. And perhaps English would be better.

> +       while (hi - lo > 1) {
> +               size_t mid = lo + (hi - lo) / 2;
> +
> +               int val = f(mid, args);
> +               if (val) {
> +                       hi = mid;
> +               } else {
> +                       lo = mid;
> +               }

Unnecessary braces are frowned upon. Also, why store the value if you
are not going to use it later?

if (f(mid, args))
  hi = mid;
else
  lo = mid;

> +       }
> +
> +       if (lo == 0) {

if (!lo)

> +               if (f(0, args)) {
> +                       return 0;
> +               } else {
> +                       return 1;
> +               }

return f(0, args) ? 0 : 1;

Or just:

return !f(0, args);

> +       }
> +
> +       return hi;

It would be much clearer to just do:

if (lo)
  return hi;
else
  return !f(0, args);

> +}
> +
> +void free_names(char **a)
> +{
> +       char **p = a;
> +       if (p == NULL) {
> +               return;
> +       }

Once again:

  if (!p)
    return;

> +       while (*p) {
> +               reftable_free(*p);
> +               p++;
> +       }

This is the same thing as:

  if (!a)
    return;

  for (p = a; *p; p++)
    reftable_free(*p);

> +int names_length(char **names)
> +{
> +       int len = 0;
> +       char **p = names;
> +       while (*p) {
> +               p++;
> +               len++;
> +       }
> +       return len;
> +}

Is there any need to keep track of len? It's always p - names.

This should do it:

  char **p;
  for (p = names; *p; p++);
  return p - names;

> +void parse_names(char *buf, int size, char ***namesp)
> +{
> +       char **names = NULL;
> +       size_t names_cap = 0;
> +       size_t names_len = 0;
> +
> +       char *p = buf;
> +       char *end = buf + size;
> +       while (p < end) {

Yet another while that can be a for:

  for (p = buf; p < end; p = next + 1)

> +               char *next = strchr(p, '\n');
> +               if (next != NULL) {
> +                       *next = 0;
> +               } else {
> +                       next = end;
> +               }

if (next)
  *next = 0;
else
  next = end;

> +               if (p < next) {

Or just:

  if (p >= next)
    continue;

> +                       if (names_len == names_cap) {
> +                               names_cap = 2 * names_cap + 1;
> +                               names = reftable_realloc(
> +                                       names, names_cap * sizeof(char *));

sizeof(*names);

> +                       }
> +                       names[names_len++] = xstrdup(p);
> +               }
> +               p = next + 1;
> +       }
> +
> +       if (names_len == names_cap) {
> +               names_cap = 2 * names_cap + 1;
> +               names = reftable_realloc(names, names_cap * sizeof(char *));
> +       }

This is repeated, maybe a macro like ALLOC_GROW(), or literally ALLOC_GROW().

> +       names[names_len] = NULL;
> +       *namesp = names;
> +}
> +
> +int names_equal(char **a, char **b)
> +{
> +       while (*a && *b) {
> +               if (strcmp(*a, *b)) {
> +                       return 0;
> +               }
> +
> +               a++;
> +               b++;
> +       }

Again:

  for (; *a && *b, a++, b++) {
    if (strcmp(*a, *b)
      return 0;
  }

But instead of moving multiple pointers:

  for (i = 0; a[i] && b[i], i++) {
    if (strcmp(a[i], b[i])
      return 0;
  }

> +int common_prefix_size(struct strbuf *a, struct strbuf *b)
> +{
> +       int p = 0;
> +       while (p < a->len && p < b->len) {

Once again, this can easily be a for.

> +               if (a->buf[p] != b->buf[p]) {
> +                       break;
> +               }
> +               p++;
> +       }
> +
> +       return p;
> +}

Cheers.

-- 
Felipe Contreras
