From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v9 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 10 May 2016 17:31:34 +0700
Message-ID: <CACsJy8DLmcxmw5aGT3FszccW3UNujBcr8uZzJuJoWxvASKnpPg@mail.gmail.com>
References: <1462826929-7567-4-git-send-email-dturner@twopensource.com> <20160510101315.32403-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 12:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b04xZ-0006YZ-JS
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 12:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbcEJKcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 06:32:07 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35553 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcEJKcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 06:32:06 -0400
Received: by mail-lf0-f52.google.com with SMTP id j8so9618663lfd.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JQqb3AI1s/QV4gCSeNtBdZvsPR8SLGD2aS/aALxET50=;
        b=xR2MC0f8seY6WdoelwITnoh6jP+7Ytz5qEQwhnenFNtnPJ5jJp6UOQ7GbR/vKL7gyR
         YMsxFvJXf3bjUYzCgBTdxxuAxPMPE+BvtQ4fAmA8mIDzaAnV10T76jciVeYVe+L64CEw
         2tiAgplhyWep1n22/KfATHYPQ4VBYHyNj9M6q8kAEC4ayOl7YNEBx5jieQjeybhAJyUW
         WUScP383wu7Psn5xpPkD44dU6lPC815SWCgaau3vbaFPNvgtrh6tgGrVwS48bZQ+vS0E
         S+LybIRg/j2tBuHdnI4J6+tvmBox3+4wjMwb0TEYn4Xkt9E+GApBwBH5d0cnTrUTYESf
         phxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JQqb3AI1s/QV4gCSeNtBdZvsPR8SLGD2aS/aALxET50=;
        b=lCpwPrhCFt85cxAb1jKdz67cHqp6EzHmAi6bswspIrKsMcRG3g30OG56vOO3deyxHR
         Xedqsd5/VvWWiAwG/r61xplqlM16YKPtJL0zrvLnPa2UmuryZ8Lf4Bx4l3AorNhj++XT
         KxC3u+Bqdn68mK9SVCq5Zx7sbHDB4E8oYlZN0+dskByTneSEHvtHUs3Fd7zoS//1/Wzw
         D93x4syqFUyNqf45tJIJqQoYqmU7bEOrNMU0YSvrcOHeuo34Jv6Rqm8ffuDzFmc3qVGN
         wMhzgt/lvqFuB+j5w0ix8F+Q9hBr6lUZjyJ7DHZ/VmE7LxfBoya34hBCNtcCD8V7/wWy
         QHyw==
X-Gm-Message-State: AOPr4FXtKJDIZfwHZSRu3Nox2VVTc9VH871s3FSMKAvnvKPftLrw+OqCA372KaWBbNti3ikV5NG1qOFA/92EQw==
X-Received: by 10.25.42.147 with SMTP id q141mr16872583lfq.94.1462876323807;
 Tue, 10 May 2016 03:32:03 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 03:31:34 -0700 (PDT)
In-Reply-To: <20160510101315.32403-1-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294117>

This reminds me, we need to update command-list.txt as well. I guess
it belongs to purehelpers? Back to the patch..

On Tue, May 10, 2016 at 5:13 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> This patch adds a new plumbing command, which then will show up in
> completion after 'git <TAB>'.  Could you please squash in this
> oneliner to exclude index-helper from porcelain commands in the
> completion script?

I don't think the user should run this command explicitly a lot.
Usually it should be run automatically (with config key
indexhelper.autorun) and die when idle for some time. You just don't
care about it (until performance degrades and you have to
investigate). Occasionally you may have to "git index-helper --kill".
Is there any other reason it should be run often enough to justify
this change?

>
>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 34024754d929..9264ab919a6a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -684,6 +684,7 @@ __git_list_porcelain_commands ()
>                 for-each-ref)     : plumbing;;
>                 hash-object)      : plumbing;;
>                 http-*)           : transport;;
> +               index-helper)     : plumbing;;
>                 index-pack)       : plumbing;;
>                 init-db)          : deprecated;;
>                 local-fetch)      : plumbing;;
> --
> 2.8.2.356.ge684b1d
>
--=20
Duy
