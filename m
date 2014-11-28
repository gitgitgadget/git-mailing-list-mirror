From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t0050-*.sh: mark the rename (case change) test as passing
Date: Fri, 28 Nov 2014 16:13:49 -0500
Message-ID: <CAPig+cRbdy6obKNvBWqvvEQD+MwXcNw+0T0c-f1AuPA+_c=8=Q@mail.gmail.com>
References: <5478A96E.8030706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 28 22:13:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuSrS-0004qC-Cu
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 22:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaK1VNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 16:13:50 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:58666 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbaK1VNu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 16:13:50 -0500
Received: by mail-yh0-f52.google.com with SMTP id z6so3371401yhz.11
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8TLuXr4F0XmDndADThGKa4C8MkC/36+uGQMwCzkqdLc=;
        b=mXMd8DDiuxEtDD6ECOUsdiG9fSsNXEwWzqzHjYR5ibZY4xwZo1n0Qup4CkFdKJVcCV
         jP4LOrdgMTRxDk/MES1Qih1SFNLevQLSdy6x5TZabBMFWeNoz2XGMb+J+//uwiSL77TJ
         9VL15al6yL9gByxi3F6e/RCLUvAXOfTu3jNr+UnQTU4mBHrgy1QW+r+uggi8ESOK4GXq
         OiiyNWB9Bq/zKoIyM/0iRFqzPc+bYv2tDYIJyA5LdzSGEfbpe1eQLg9RIJbCI/WlVgvX
         qW4jBYToJU1PYB9NHazRyXppuHjiZI3hBjiOzgRmbCjQwRbf0yRmgFw6T28Y7kKxVIBK
         pQ6A==
X-Received: by 10.170.41.131 with SMTP id 125mr7523787ykj.85.1417209229358;
 Fri, 28 Nov 2014 13:13:49 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Fri, 28 Nov 2014 13:13:49 -0800 (PST)
In-Reply-To: <5478A96E.8030706@ramsay1.demon.co.uk>
X-Google-Sender-Auth: 92PQJ15iRJ8utI3Q3b5rEQDcUAM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260376>

On Fri, Nov 28, 2014 at 11:57 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Since commit baa37bff ("mv: allow renaming to fix case on case
> insensitive filesystems", 08-05-2014), the 'git mv' command has
> been able to rename a file, to one which differs only in case,
> on a case insensitive filesystem.
>
> This results in the 'rename (case change)' test, which used to fail
> prior to this commit, to now (unexpectedly) pass. Mark this test as
> passing.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> I noticed this last week while testing on cygwin. I have only tested
> this on (64-bit) cygwin/ntfs, but I would assume that other case
> insensitive filesystems would be OK, since there have been no complaints
> about t6039-merge-ignorecase.sh not working.

I tested and verified that this patch is also needed on Mac OS X (as expected).

> Note that I didn't remove $test_case, despite having removed its last
> use in this test, in case there will be a future need. I'm not sure
> there will be a future need, of course, so if you would rather I got
> rid of it, just let me know.
>
> ATB,
> Ramsay Jones
>
>  t/t0050-filesystem.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 6b3cedc..988c392 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -64,7 +64,7 @@ test_expect_success "setup case tests" '
>         git checkout -f master
>  '
>
> -$test_case 'rename (case change)' '
> +test_expect_success 'rename (case change)' '
>         git mv camelcase CamelCase &&
>         git commit -m "rename"
>  '
> --
> 2.1.0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
