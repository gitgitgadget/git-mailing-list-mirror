From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Wed, 13 Apr 2016 01:56:29 -0400
Message-ID: <CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 07:56:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqDn1-0003Pp-6x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 07:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318AbcDMF4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 01:56:31 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33386 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbcDMF4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 01:56:30 -0400
Received: by mail-ig0-f196.google.com with SMTP id nt3so5225263igb.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pGbjqnwUZJU6fcyEvWqCRvJwQQg7YU/vxkZEzPQjxRo=;
        b=yk2m0rIVjpnjI1pwucADwgxrWVcve1l60vfTanqXs2rUS8cvopqZz4lI/y6mg4VI9L
         ZTZp6vINkge4vk86cSfOkcSo+ezV0dhGqQEr21twsTYcYCT8M3gHuKecqKvTcTkTzWgW
         gCNiAZm3XEq3UIDwAS0OD6cs62nimyZM7QW4ydwFSYUUUUToSv4PE3Fz10RgfgdL0FLC
         NwfGry8MTNi4JQSg04VqXOtTd0tK5nK2NOG+WtY7SEDDjStmaRbum8lqi90hBwRaTPhX
         rIu7T627w5v+iY3RWLUatPffGAVOW3c0bJgWvDXL/zCzf4FQUt0ezoDczgBKuDs+rTdD
         zd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pGbjqnwUZJU6fcyEvWqCRvJwQQg7YU/vxkZEzPQjxRo=;
        b=RbH1YfoA+4dLtCrKiLbEYiDCGMtG+vmygAWVMS2aTbequO25TP/vzOz9itviOKj2H5
         jo5/kcamrbo9tvfpMnqZJY1QQaLySpclVJvJk8p8RREakKHGM3RoYwS0NTIyul2qbh6X
         OhpeA9NRHr5sGsVHKjR3zLwTYy1ifi97heOy7Xpe4AA4VuU60Ty5i1HU5xEzOgPuykIq
         mdXlS83PqPgmu29ugUCPeOnjYsBycDTD0UTVKQ21Im6CtttdxeQIq6yjyLc24IK63eqw
         uoZ5VUuyvpciqo2dlWaDl4lUiqCfd7P+ZaXmGXGVlRF/UpDzLcMvcQ0K8eSd1UqJnL5Q
         F1Zw==
X-Gm-Message-State: AOPr4FWSUTuSVNl1sxHSDHJVFU+iEmI9OwMi47hskJx6Bw8vHELYoJu75Zgwg1Qnwleuyj6OJAx9fdqwKCxOfw==
X-Received: by 10.50.40.101 with SMTP id w5mr8262459igk.17.1460526989644; Tue,
 12 Apr 2016 22:56:29 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 22:56:29 -0700 (PDT)
In-Reply-To: <010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: wl2dnCnyIz2EcKYyGFBg4EKcV_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291372>

On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> OPT_COUNTUP() merely increments the counter upon --option, and resets it
> to 0 upon --no-option, which means that there is no "unspecified" value
> with which a client can initialize the counter to determine whether or
> not --[no]-option was seen at all.
>
> Make OPT_COUNTUP() treat any negative number as an "unspecified" value
> to address this shortcoming. In particular, if a client initializes the
> counter to -1, then if it is still -1 after parse_options(), then
> neither --option nor --no-option was seen; If it is 0, then --no-option
> was seen last, and if it is 1 or greater, than --option was seen last.

Nit: I'm pretty sure that when I wrote this commit message for you[1]
the "if" following the semicolon was correctly lowercase. It's not
clear why it got incorrectly capitalized here.

More below...

> This change does not affect the behavior of existing clients because
> they all use the initial value of 0 (or more).
>
> Note that builtin/clean.c initializes the variable used with
> OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
> to either 0 or 1 by reading the configuration before the code calls
> parse_options(), i.e. as far as parse_options() is concerned, the
> initial value of the variable is not negative.
>
> To test this behavior, in test-parse-options.c, "verbose" is set to
> "unspecified" while quiet is set to 0 which will test the new behavior
> with all sets of values.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> @@ -144,8 +144,12 @@ There are some macros to easily define options:
>  `OPT_COUNTUP(short, long, &int_var, description)`::
>         Introduce a count-up option.
> -       `int_var` is incremented on each use of `--option`, and
> -       reset to zero with `--no-option`.
> +       Each use of `--option` increments `int_var`, starting from zero
> +       (even if initially negative), and `--no-option` resets it to
> +       zero. To determine if `--option` or `--no-option` was set at

Repeating from [1]: s/was set/was encountered/

> +       all, set `int_var` to a negative value, and if it is still

Repeating from [1] and [2]: s/set `int_var`/initialize `int_var`/

> +       negative after parse_options(), then neither `--option` nor
> +       `--no-option` was seen.
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -454,6 +454,25 @@ dry run: no
> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '

What is "--no- flag"?

> +       test-parse-options --no-verbose >output 2>output.err &&
> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'

In my v12 review, I noticed that neither --no-verbose nor --no-quiet
was being tested by t0040 (which is conceptually independent of the
OPT__COUNTUP change) and suggested[3] that you add a new patch to
address that shortcoming. This idea was followed up by [1] saying that
this test (here) could then be dropped since the case it checks would
already be covered by the new patch. My impression was that you
agreed[4] that that made sense, however, this test is still here. Did
I misunderstand your response[4]?

[1]: http://article.gmane.org/gmane.comp.version-control.git/290662
[2]: http://article.gmane.org/gmane.comp.version-control.git/289991
[3]: http://article.gmane.org/gmane.comp.version-control.git/290655
[4]: http://article.gmane.org/gmane.comp.version-control.git/290787
