From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC/PATCH] rebase -i: use full onto sha1 in reflog
Date: Thu, 9 Aug 2012 10:04:07 -0700
Message-ID: <CAOeW2eESQyT0xzy8KjAdhgr45MGosY86cQOy2VsN6TtJqeEYjA@mail.gmail.com>
References: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzW9f-00039k-BM
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab2HIREJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:04:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41269 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2HIREI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:04:08 -0400
Received: by pbbrr13 with SMTP id rr13so1180445pbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hR2a/2e8T+EzxEZ+7TkD5c9G5pBT4Ub48asOSbRQcHk=;
        b=DKhspOmv0Ubuwo9h+MWn33qCAcXn+/Sj0TcFY99HWpBk+7gio/5p3YTm9SlsaZz3cy
         UmnE4zjoaLe+QqaKfCDqGmpdd+nInDPIKIQofNFVZ2KGSG6iX25ygUEprMym/3WkQB6o
         zK+zW3MnkweN72Mj/wYzPhXl9iViDG/LC9GK0cauTfOi02ymNRp80DOVPU74vURQv02t
         f+nWCclOV28rDxVXCmm/mFgc+09J1mEXD3iIpN+bQyFLHqP+u8Mq1KdhhUz1EKwhSlnN
         a5ZQYZweWtnNjZpYK63UlkVczxVFJpTrm0VtzeLzLNf4BcDL/sBvyy84bXjs2GaUMu4h
         NH+A==
Received: by 10.68.241.99 with SMTP id wh3mr5698941pbc.16.1344531848021; Thu,
 09 Aug 2012 10:04:08 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Thu, 9 Aug 2012 10:04:07 -0700 (PDT)
In-Reply-To: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203167>

On Thu, Aug 9, 2012 at 9:05 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0d2056f..dbc9de6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -573,7 +573,7 @@ do_next () {
>         newhead=$(git rev-parse HEAD) &&
>         case $head_name in
>         refs/*)
> -               message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
> +               message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&

After this patch, is there any point in the

 shortonto=$(git rev-parse --short $onto) &&

line just before the context? (I can't see any.)
