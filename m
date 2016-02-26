From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 02/16] bisect: add test for the bisect algorithm
Date: Fri, 26 Feb 2016 07:53:42 +0100
Message-ID: <CAP8UFD2szf46skWmgZi3kSkh3D0aeMPw4TagUQa7KZ-z6pHdAA@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-3-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 07:53:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZCHg-0005AA-8u
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 07:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbcBZGxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 01:53:47 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36134 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbcBZGxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 01:53:44 -0500
Received: by mail-lf0-f47.google.com with SMTP id l83so471435lfd.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 22:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FFt+stUSHQVgHKg9z+Sa2bdnB4Yo2csdw9/nQrMkhqA=;
        b=sHxS108dsTqh3Ml9rkE0UWZBd2y8A+7VSufZ+H3dSUxq92g44+fCv3+kg2/ZSj+6fS
         dyI6vk3lZbUnbLKGDGlsKHkJbyh9PBiz/ZL8jbxEs4c8bWR4GO9SzfN80bF/IM24qVoy
         9EsstxRcYGvIghIph029ZfjNX4+M41fGs5oOf40o60cSKPvhZZqxY/Q2bH/VmvpQKTz+
         pU1AObMbhn6dHIfDnjZBP1xRd0qMDKGK02UuzgbNR4ZKzqFft9p0ZQxMu2U8J+eAbyBs
         u20+dToH63Ccpey8FccnIXyXRaUOmN0SXvCWUPSWDxWPkIHeq0bPwotSeHQLWtjE9KM/
         TnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FFt+stUSHQVgHKg9z+Sa2bdnB4Yo2csdw9/nQrMkhqA=;
        b=YgPtEF/chItvvk/cXimFlj3FF2rhjbvk0DByDmwM4hGnhmw+2+jiceTFIwiu5q5kM2
         LWBlTU6AqO3VPH+CeYNeBHtlx3qRZ1ak1H3q06tlu8FXPsgnpVT+pJP6zz19SKavjPAi
         IUW49hk3jzm/BWIXCtW21kC9gB0H5mdtKTq8MPcSzIPF9ZCuUlAe78WCSPZ8mGwEIxrR
         WpCj81mMjjBlIAIqBqXugjbEjvShWhrWesfVC03o95Vi6sJ3JDVeBe0DZVoBOCNQajnO
         Aak21DMQ2ShbODXp/4Y82Q8hGqrPnGIi+LUjz6BSG4NCW92PhVRim83f+J4z2IHjZ4sJ
         4DhQ==
X-Gm-Message-State: AG10YOTf5mnAx4UJijFF/5wTBtsrA71OtZakS97Gtkh05fPJ8YzGixXFSBYr8uZ5SGrHhay4BHa7P/Iqoev6Qg==
X-Received: by 10.25.26.83 with SMTP id a80mr18505050lfa.36.1456469623024;
 Thu, 25 Feb 2016 22:53:43 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Thu, 25 Feb 2016 22:53:42 -0800 (PST)
In-Reply-To: <1456452282-10325-3-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287539>

On Fri, Feb 26, 2016 at 3:04 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> To be honest: the test could be better, it could be more "targeted",
> i.e. the example commit history could be smaller and just consider
> all the cases and corner cases and whatever.
> However, I made it first to understand the algorithm and verify the
> description of it in the documentation. Then I was too lazy to
> improve it. I am sorry that this is no better advertising text. ;)
>
> Moreover, the test does not test one important thing that is
> always cared about in the bisect code: TREESAME commits.
> Perhaps I got the concept wrong. I tried to obtain TREESAME commits
> using 'git commit --allow-empty -m "same tree"'. However, those
> commits were never considered being TREESAME. So I gave up (I did
> not care much.)

I didn't care enough to test TREESAME either.

> Anyone has an idea how to obtain them?
> Or is this a bug that should be fixed?
>
> (Also UNINTERESTING commits are never found by the DEBUG_BISECT
> output, but I think this is because they are just filtered out.)

Yeah, I think so.

>  t/t8010-bisect-algorithm.sh | 162 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100755 t/t8010-bisect-algorithm.sh
>
> diff --git a/t/t8010-bisect-algorithm.sh b/t/t8010-bisect-algorithm.sh
> new file mode 100755
> index 0000000..bda59da
> --- /dev/null
> +++ b/t/t8010-bisect-algorithm.sh
> @@ -0,0 +1,162 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Stephan Beyer
> +#
> +test_description='Tests git bisect algorithm'
> +
> +exec </dev/null
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a history for the test' '
> +       test_commit A1 A 1 &&
> +       test_commit A2 A 2 &&
> +       test_commit A3 A 3 &&
> +       test_commit A4 A 4 &&
> +       test_commit A5 A 5 &&
> +       test_commit A6 A 6 &&
> +       git checkout -b b A5 &&
> +       test_commit B1 B 1 &&
> +       git checkout master &&
> +       test_commit A7 A 7 &&
> +       git checkout b &&
> +       test_commit B2 B 2 &&
> +       git checkout master &&
> +       test_commit A8 A 8 &&
> +       test_merge Bmerge b &&
> +       git checkout b &&
> +       test_commit B3 B 3 &&
> +       git checkout -b c A7 &&
> +       test_commit C1 C 1 &&
> +       git checkout -b d A3 &&
> +       test_commit D1 D 1 &&
> +       git checkout c &&
> +       test_commit C2 C 2 &&
> +       git checkout d &&
> +       test_commit D2 D 2 &&
> +       git checkout c &&
> +       test_commit C3 C 3 &&
> +       git checkout master &&
> +       git merge -m BCDmerge b c d &&
> +       git tag BCDmerge &&
> +       test_commit A9 A 9 &&
> +       git checkout d &&
> +       test_commit D3 &&
> +       git checkout master
> +'
> +
> +test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
> +       git bisect start A7 &&
> +       git bisect next &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
> +         -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"

I thought that we should not use "-o" and "-a" but instead "|| test"
and "&& test".

> +'
> +
> +test_expect_success 'bisect algorithm works in linear history with an even number of commits' '
> +       git bisect reset &&
> +       git bisect start A8 &&
> +       git bisect next &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
> +'
> +
> +test_expect_success 'bisect algorithm works with a merge' '
> +       git bisect reset &&
> +       git bisect start Bmerge &&
> +       git bisect next &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A5)" &&
> +       git bisect good &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A8)" &&
> +       git bisect good &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse B2)" \
> +         -o "$(git rev-parse HEAD)" = "$(git rev-parse B1)"

Here and in other places too...
