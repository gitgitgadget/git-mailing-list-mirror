From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable rule
Date: Sun, 26 Oct 2014 13:45:10 -0400
Message-ID: <CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
References: <87mw8iag72.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 18:45:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiRsV-00038C-KX
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 18:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaJZRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 13:45:12 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:47689 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaJZRpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 13:45:11 -0400
Received: by mail-yh0-f43.google.com with SMTP id z6so3744317yhz.30
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mq9g+0/VddV1cUEClKoP9zjD8/yJXQiM+eALUC/ILAw=;
        b=VqR+AXMsVLR+JPgT3wCM841hdlS1UmT4gAr2FZLwFqt0WWEg70EGK5c8FbpXuPXOmN
         ZW0V6drq7A+sOiKC1L8p2ri/dWhFs9iUDJmE859VEE/ew8nxOKYTWEy+MpmYih5U78Rw
         IjkOkjVDX/iXQxe/6Lgm9n554fRipo4puZNAo4lupsIcZ741xFwTMcwRx2LC9Q7abBjv
         3cgNOrBzepFtcg6J+Lfuq+Fu7fVRlLkm74W79wyQe8EGITHA2X/RKE0JeetR5r3AMwXT
         v7tY2uQnWCAGdlRHg0+P/860Y4OGuyly0RlwQ3GGcV5E5/nw45YMV7a7kZXJMBEwFQzF
         RyAA==
X-Received: by 10.170.197.150 with SMTP id o144mr20804511yke.103.1414345510903;
 Sun, 26 Oct 2014 10:45:10 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Sun, 26 Oct 2014 10:45:10 -0700 (PDT)
In-Reply-To: <87mw8iag72.fsf@gmail.com>
X-Google-Sender-Auth: zRU4eSh0OwhTKxvTmgyLQ2uGdBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 1:33 PM, David Michael <fedora.dm0@gmail.com> wrote:
> The XL C compiler can fail due to mixing library path and object

Can you explain in the commit message the actual nature of the failure
so that readers can understand more precisely how this change helps?

> file arguments, for example when linking git while building with
> "gmake LDFLAGS=-L$prefix/lib".  This moves the ALL_LDFLAGS variable
> expansion in the git executable rule to be consistent with all the
> other linking rules.
>
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index fcd51ac..827006b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1610,8 +1610,8 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
>         '-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
>
>  git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
> -       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
> -               $(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
> +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) git.o \
> +               $(BUILTIN_OBJS) $(LIBS)
>
>  help.sp help.s help.o: common-cmds.h
>
> --
> 1.9.3
