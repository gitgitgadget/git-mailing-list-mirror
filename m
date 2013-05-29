From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Tue, 28 May 2013 22:33:15 -0700
Message-ID: <CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZ0j-0005pM-2W
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab3E2FdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:33:17 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45526 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3E2FdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:33:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so6343759wgh.24
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KjZlNOeptY4IkktfykWKc/SEdwtKhnuvTbNRsFPeAVc=;
        b=ING1Ks1lBivFsQCvRhLeLXK+JCElkDZFzN3yu9rfxnrYAvkAgyDk3Pvq2X9SjkRHHN
         mUhVXUsQU5nLWmbiKLp5VFi1ljWb/J+t+TsMQQX+ZPx6Lm0OlMuj7n6ODRsIyWTS3EUn
         f/aQf9P6BhLtgYifPUTBxjZrDAoLwZIuFUY7LKMZQpy9wID6wiRnrGXyZ/utrtfa/vmU
         ZbTXalDvkr9lihnLG4g9YhiOn1+4/HGWn0JhAwMSba/uIljlWNDwH+4To51k+lJcnNd7
         bXT58ZFAMA9ULTNBP+slVDU67jCFav+b9r4D6Qp7GHjlAtKDI9ZpTy0T20wDXXv8/7Ow
         kJFg==
X-Received: by 10.194.120.134 with SMTP id lc6mr768894wjb.55.1369805595671;
 Tue, 28 May 2013 22:33:15 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 22:33:15 -0700 (PDT)
In-Reply-To: <1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225738>

 As Junio asked in the previous iteration, shouldn't this have been in
the first patch?

On Tue, May 28, 2013 at 9:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> We are not in am mode.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase--cherrypick.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
> index 51354af..2fa4993 100644
> --- a/git-rebase--cherrypick.sh
> +++ b/git-rebase--cherrypick.sh
> @@ -5,13 +5,15 @@
>
>  case "$action" in
>  continue)
> -       git am --resolved --resolvemsg="$resolvemsg" &&
> -       move_to_original_branch
> +       git cherry-pick --continue &&
> +       move_to_original_branch &&
> +       rm -rf "$state_dir"
>         exit
>         ;;
>  skip)
> -       git am --skip --resolvemsg="$resolvemsg" &&
> -       move_to_original_branch
> +       git cherry-pick --skip &&
> +       move_to_original_branch &&
> +       rm -rf "$state_dir"
>         exit
>         ;;
>  esac
> --
> 1.8.3.rc3.312.g47657de
>
