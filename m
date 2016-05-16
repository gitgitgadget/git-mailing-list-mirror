From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Ignore dirty submodule states during stash
Date: Sun, 15 May 2016 23:37:20 -0700
Message-ID: <CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com>
References: <20160516020735.GA7884@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 08:37:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2C9g-0007YG-NG
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 08:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbcEPGhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 02:37:22 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36371 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcEPGhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 02:37:21 -0400
Received: by mail-io0-f176.google.com with SMTP id i75so193722136ioa.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ixdbKskVoXkN3bkiKMBeymnuI6/pRs7vOj9vNmqFLBo=;
        b=Yvc7CIL0OeIBrd+7XskTxydCWhM4w9m/0kSmQDKPeXwABuG5+ib2OaAOSbZ8pwZEXK
         w9yOjgZytaFnoWF2NZi8XkJv4ly5Zbz3ugDboWLASarfvEP7sWuzXUgNUXXOGlA8f+PH
         qdmgaOnJD7wLZ1hi6+aaRoyQ54m+/GQReM4iJFuBrRwVoYlIidbzDBoGnh8t6dyjhiER
         TyeIQjHrHQJay4KQzfqRDL44CkX3dU3SO92B02/S94JVV8xprDV6bULWYcQ5Cx33+ap6
         Qln7P8m/uhFA7EBkinOvrqocb4+bX1QpbpvfDRTCw8fabskrv0ojtlBd87EZ0+9DYMh6
         05DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ixdbKskVoXkN3bkiKMBeymnuI6/pRs7vOj9vNmqFLBo=;
        b=OtUfA1YRp8EwFnER0FED+ZBmxU20i2sD60KbgAiMd6sGsPiUPKPGQ0vYn6uraeGd/G
         4/MCuOxRItC2YGmPR9q0/6UVnWtIcbj6gwDyQ/G57fayVQS3trkQAqVTh3K9E9QZabx+
         M+WQJyewo7c8z8bGpD4VnGtpt5BSz4agPxlM5s2e92eEIWOB9POQbSUlPmEMlQFv+qEO
         +0wDJ6ctn7ErlhegnzS6uDAQN7E62BNsu9AzH/JLb37IIZ2O4mpaGYZzRhZ3KKy43g4n
         llU87n+h3sJPBpA/jK0rMFZcC0vTNgRiBBH0Hd8+Oi6YaUm21LSXG0zkTa7l/vb661KQ
         lRRQ==
X-Gm-Message-State: AOPr4FUKUfDhdpyyqp5JTnIfuLGSlqaqfnfMUPUson8baSWpdNtNNO6R+4N+otO6xzyP4DYcj1EE0cYhVedlw30A
X-Received: by 10.36.107.129 with SMTP id v123mr7687362itc.52.1463380640563;
 Sun, 15 May 2016 23:37:20 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Sun, 15 May 2016 23:37:20 -0700 (PDT)
In-Reply-To: <20160516020735.GA7884@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294725>

On Sun, May 15, 2016 at 7:07 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> Do not save states of submodules as stash should ignore it.

Can you explain why this is a good idea?
(It is not obvious to me either way.)

Do we need a test/documentation updates for this?

>
> Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
> ---
>  git-stash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index c7c65e2..b500c44 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -116,7 +116,7 @@ create_stash () {
>                         git read-tree --index-output="$TMPindex" -m $i_tree &&
>                         GIT_INDEX_FILE="$TMPindex" &&
>                         export GIT_INDEX_FILE &&
> -                       git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
> +                       git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
>                         git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
>                         git write-tree &&
>                         rm -f "$TMPindex"
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
