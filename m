From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] systemd socket activation support
Date: Wed, 8 Apr 2015 16:26:42 +0200
Message-ID: <CABPQNSa-45ZsUX54Ym3dQa+HU63abcQ9O3v8maRe9e_-38Ef+Q@mail.gmail.com>
References: <1427954951-17649-1-git-send-email-shawn@churchofgit.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Shawn Landden <shawnlandden@gmail.com>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 16:27:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfqx3-0004d1-J6
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 16:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbbDHO12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 10:27:28 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34624 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbbDHO1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 10:27:24 -0400
Received: by iedfl3 with SMTP id fl3so84904553ied.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mv9X2Wn0WHuFqty3x6B0wcmfOkW8Y47PESBWlNjJdAA=;
        b=RiEuat92ys6bCj+ugoUXfAautYBVQr67MgrnaTBgPufjeMDXFkvYIgN/AB1QiXeyOt
         znalraw8vDaNHgISjajdzuFumLKgf054JJcqiN+NtQCKkMgON958oYaAqcNDRmG7laTA
         SSbtCJ5GUjPuimnUseK1WzS2rZOidnC6SRFnnO/qxkzuJLH0q4TfritLyk1EZ5OaFM0e
         sZ3CKVlETCuswxE7XJsjzFGlLpUXRhV1c6z+M5+oPfZqJkGCqzFtlvcjmEiEJKz2n5im
         J0jW2/rxuOtntqblQvDPvtLJc/z+l7cOYTw6HZcb2aVXNqC6zeIlcL2XRq3bQ5bGwXJa
         LcpQ==
X-Received: by 10.50.43.130 with SMTP id w2mr12256480igl.30.1428503242731;
 Wed, 08 Apr 2015 07:27:22 -0700 (PDT)
Received: by 10.64.88.165 with HTTP; Wed, 8 Apr 2015 07:26:42 -0700 (PDT)
In-Reply-To: <1427954951-17649-1-git-send-email-shawn@churchofgit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266960>

On Thu, Apr 2, 2015 at 8:09 AM, Shawn Landden <shawn@churchofgit.com> wrote:
> From: Shawn Landden <shawnlandden@gmail.com>
>
> v1.1: actually test...
>
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
>  daemon.c           |  35 +++++++++++---
>  git-daemon.service |   7 +++
>  git-daemon.socket  |   9 ++++
>  sd-daemon.c        | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sd-daemon.h        |  91 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 268 insertions(+), 6 deletions(-)
>  create mode 100644 git-daemon.service
>  create mode 100644 git-daemon.socket
>  create mode 100644 sd-daemon.c
>  create mode 100644 sd-daemon.h
>
> diff --git a/daemon.c b/daemon.c
> index 9ee2187..4677058 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -5,6 +5,8 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>
> +#include "sd-daemon.c"
> +

You meant "sd-daemon.h", no?
