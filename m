From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Thu, 9 Jun 2016 17:33:05 -0400
Message-ID: <CAPig+cRC_y9MBSsrLEs0OxL4=FMfU-=ACwhESUiECrWrDNvaCw@mail.gmail.com>
References: <20160608152415.7770-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:35:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7Zk-0007UZ-JH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbcFIVdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:33:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34996 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbcFIVdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:33:07 -0400
Received: by mail-it0-f65.google.com with SMTP id z123so6773278itg.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YsqY0+zWlLWedzFUji8KGOe8qLFHy5wa/Hcbw7byA0g=;
        b=MJcI/LjQn16FAQarGWgIHYNPBxQ+T6ZKqTukU6I+oUHDLcV3iSYBOxFzGjmu8kwdFp
         WdNIsYWHEteyfMWldc5U7vqsbka6P29bbtN1rhnzvtjEbgJCrEsTSmUVVO+Fhqj28m1p
         nwzfZhVkavaPOtUcUUFkFsitN+lO9ShgUJqD6iszJYMGO13PHz+E81YbGdlfxEU1U7U9
         cxkg/zNiEiFN6dgooGUZUwVcrM4YPiLmDdhsSd+UTDunII5H4K2l5osDWfklI52jZigD
         8Azd/cLwyRDANnQbwS2NB4s6YrP1u7GkO46iPSrbR9IjhkFJU+q1TguTqNSHIOJflP18
         FqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YsqY0+zWlLWedzFUji8KGOe8qLFHy5wa/Hcbw7byA0g=;
        b=lV36Qzohz2umrHOV1lOAQ0Rk5udzclDXGqN7TJWWZxQjkwRy16jVXh0oTC4zcVo9Eb
         Roq6QrG0xE0bXhxrNqsPx4jzNYzYrtjHzG3uTfJMF+g2Ys32qV5lXoBbgBUM+ML1IK+C
         Qwc7tQKrr/Etd/pXOGHA6HF+jWnUDfKnmD9Kvp3g/5Lu3QTiMESu8XoRGG/JH1dtdmCQ
         TsH0ohHgL2X9VQ9khkfBQyd1U7riIU4obbiNhVCeeaouOsxTr1eLUlN6MpP6ijH6B79D
         liGyYtmdoQf7DjegqFgh6tqDl9bAvBh1y22Mim5mmJ9NTOpfinAAnXD7QJ3+Sm3HuwCR
         lV3g==
X-Gm-Message-State: ALyK8tJtxk+JN+axpyDtSNHkqk23sW1Fjc0TcoeDnJld6U0sd/FzFeEjfOHt2ovwixnEdSn/Nf2eg7CBu8yCfg==
X-Received: by 10.36.112.81 with SMTP id f78mr21879691itc.32.1465507986303;
 Thu, 09 Jun 2016 14:33:06 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Thu, 9 Jun 2016 14:33:05 -0700 (PDT)
In-Reply-To: <20160608152415.7770-1-pranit.bauva@gmail.com>
X-Google-Sender-Auth: CRYeHdxvA29HibvpY6kCq_o0C2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296930>

On Wed, Jun 8, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `is_expected_rev` shell function in C. This will further be
> called from `check_expected_revs` function. This is a quite small
> function thus subcommand facility is redundant.

This patch should be squashed into patch 2/2, as it is otherwise
pointless without that patch, and merely adds dead code.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -160,6 +160,20 @@ int bisect_reset(const char *commit)
> +static int is_expected_rev(const char *expected_hex)
> +{
> +       struct strbuf actual_hex = STRBUF_INIT;
> +
> +       if (!file_exists(git_path_bisect_expected_rev()))
> +               return 0;

Invoking file_exists() seems unnecessarily redundant when you can
discern effectively the same by checking the return value of
strbuf_read_file() below. I'd drop the file_exists() check altogether.

> +       if (!strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0))
> +               return 0;

What exactly is this trying to do? Considering that strbuf_read_file()
returns -1 upon error, otherwise the number of bytes read, if I'm
reading this correctly, is_expected_rev() returns false if
strbuf_read_file() encounters an error (which is fine) but also when
it successfully reads the file and its content length is non-zero
(which is very odd).

> +       strbuf_trim(&actual_hex);
> +       return !strcmp(actual_hex.buf, expected_hex);

Thus, it only ever gets to this point if the file exists but is empty,
which is very unlikely to match 'expected_hex'. I could understand it
if you checked the result of strbuf_read_file() with <0 or even <=0,
but the current code doesn't make sense to me.

Am I misunderstanding?

> +}
