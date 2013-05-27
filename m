From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 14/21] remote-hg: show more proper errors
Date: Mon, 27 May 2013 18:30:25 +0200
Message-ID: <CALWbr2wATbq8o4kcdyAq1zt_+fbvyxUQov04xHDTXuoKYecAQw@mail.gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
	<1365682997-11329-15-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 18:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0Ja-0001DU-Is
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3E0Qa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:30:26 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:57955 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3E0QaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:30:25 -0400
Received: by mail-qa0-f44.google.com with SMTP id hu16so1069164qab.10
        for <git@vger.kernel.org>; Mon, 27 May 2013 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bAPKUEgi70ixjT0gZYYNLUsWU6q0qUMmMPRR8H2K7OY=;
        b=nj6yvwxlJQbF53Zi3KL9GqkSZmz1ytmGmN+59Tekz8lb3ql3u8ehFbBlgFfGAmYOZR
         RNhzWcrHMbJIUmKejwSuWqvYUebaIUXlmeZXEmHkC83r9FcfJLJRXJ3RUGHLNbNrbkAE
         4h2mqPr+pJ3b4RtHGLRZNMP8IvGifvLdIvnFjjSkUSX8h/zWwirmH3TfYLVKUjif6epe
         xyRHbiPZMeGLY/TfhG5sKNttFjaD0IG+2iRFjcRaaFJXKHMnz7gqanPKg9ilifBJApkD
         DKyADZmwxileVlf0QaFSuJopUAcli+rop8uAep2/YbJL5ZAN5ypWnAzNGD96lKjjzW+D
         TAmA==
X-Received: by 10.224.68.10 with SMTP id t10mr18800601qai.24.1369672225078;
 Mon, 27 May 2013 09:30:25 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Mon, 27 May 2013 09:30:25 -0700 (PDT)
In-Reply-To: <1365682997-11329-15-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225605>

Hey Felipe,
I know that has been integrated a while ago.

On Thu, Apr 11, 2013 at 2:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> When cloning or pushing fails, we don't want to show a stack-trace.
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index ff89725..3ae3598 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -284,11 +284,17 @@ def get_repo(url, alias):
>      else:
>          local_path = os.path.join(dirname, 'clone')
>          if not os.path.exists(local_path):
> -            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
> +            try:
> +                peer, dstpeer = hg.clone(myui, {}, url, local_path, update=True, pull=True)
> +            except:
> +                die('Repository error')
>              repo = dstpeer.local()

Can you explain why "update" went from False to True ? That can be a
problem if the repository is BIG (two working directories instead of
one can raise space issues).

The commit message is not so helpful here ;)
