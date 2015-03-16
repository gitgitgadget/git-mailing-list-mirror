From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3 v2] t3700-add: added test for --exclude option
Date: Sun, 15 Mar 2015 20:35:24 -0400
Message-ID: <CAPig+cShxOpS9W9Fp7BXM66SCRdZaJ4hpWbW9ruqCQeK8eSEBw@mail.gmail.com>
References: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
	<1426446428-6279-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 01:35:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXJ0F-0001Gr-62
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 01:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbbCPAf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 20:35:26 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33261 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbCPAfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 20:35:25 -0400
Received: by ykek76 with SMTP id k76so12072859yke.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SYvGXNwunD+3omweNP2n2pOIvZuTaTFVXt1ntrsKJpU=;
        b=hlQwFr4nC4/i/eV4k85AzXJ41Ei0/VIAIw2xEnkH3UU4p9QmorIKUF6i4UyKPsyMEV
         TZDZCxpyS421+Y2s4yM3EBNSUaa8cLUJMfRgwxl/XexgisVeg6pvphnYNIyy5KS/xf9N
         +h5m4AQJzymtoJ+qd151He0ckwl96haL6315GMi2CsZ8k7RgtLMh1MQuWLkEouKvZqYn
         iN05zC5lQVd43pHB6AYn3UVGaoOXTR1p/cbSqwX7eruGbpL022ZBXA8FzBh31WdW/C3b
         785TpkxpEMCfSmazGlH5VasPSai59wOlssua2JKGGFIICAtOLzqnqLT/sEBQ7BJhoWAE
         uTkg==
X-Received: by 10.236.10.5 with SMTP id 5mr58543284yhu.148.1426466124694; Sun,
 15 Mar 2015 17:35:24 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 17:35:24 -0700 (PDT)
In-Reply-To: <1426446428-6279-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: J5pK43ue3aB4n6226usTWRcZIH4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265537>

On Sun, Mar 15, 2015 at 3:07 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> t3700-add: added test for --exclude option

s/added/add/

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f7ff1f5..6f71c67 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -332,4 +332,22 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>         test_i18ncmp expect.err actual.err
>  '
>
> +test_expect_success 'Test that "git add --exclude" works' '

Rather than inventing a new title style, try to match the style of the
existing tests titles in this file.

> +       >foo &&
> +       >bar &&
> +       git add --exclude=bar . &&
> +       ! (git ls-files | grep bar)

Broken &&-chain.

> +       (git ls-files | grep foo)

Unnecessary additional git-ls-files invocation. You could just save
the output to a file and then process that file.

> +'
> +
> +test_expect_success 'Test multiply --exclude' '

s/multiply/multiple/

Ditto: Match existing title style.

> +       >foo &&
> +       >bar &&
> +       >"b a z" &&
> +       git add --exclude="bar" --exclude="b a z" . &&
> +       (git ls-files | grep foo)
> +       ! (git ls-files | grep "b a z")
> +       ! (git ls-files | grep "baz")

Broken &&-chain throughout.

Ditto: Unnecessary git-ls-files invocations.

> +'
> +
>  test_done
> --
> 2.3.3.472.g20ceeac.dirty
