From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 13:25:09 +0530
Message-ID: <CALkWK0m46SR3C6R_pjYouu7LkHjL_gPGb1A3S94d0nx8227-UA@mail.gmail.com>
References: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 09:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0S1D-0000V9-LB
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 09:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab3GTHzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 03:55:52 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45421 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3GTHzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 03:55:51 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so10937935iee.6
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8FJTy+U5W7+ZtXq+LYodVAiuf3nruySdu7nWUOETcxM=;
        b=AUgBq2GqtIihTpWMFqY+jLc7ncB+KBgB38uTvsOZiGRZGisAFwwqqza1CqOYQaA6Z6
         UlbiR/PQ1Ocy7dJiG1OEDhrBMfp+wjFHj0QzGwdHvJHeRuGtqa0y06mmXIs1P0E761ZG
         iz7SrZpEsV9A52Deo+aP+PR0Mr5UHblcnico+6wdIwptMpkTp1nd58GbRF0+C5adwhjU
         FloIyIOPshZ1Afa8BvG8VPiwgx7T23ZEe9vC3to0zJtvpGl42SXK8U7Jni8x3del83Dr
         9uF3CoOonbNWnSz7qDp1J994lzfJ11xRGMHg4qq0sRnIkDt5sMwPDt6IvkWOXImd8wum
         98dw==
X-Received: by 10.42.76.5 with SMTP id c5mr13129571ick.91.1374306951095; Sat,
 20 Jul 2013 00:55:51 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 20 Jul 2013 00:55:09 -0700 (PDT)
In-Reply-To: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230876>

Benoit Sigoure wrote:
> diff --git a/compat/unsetenv.c b/compat/unsetenv.c
> index 4ea1856..addf3dc 100644
> --- a/compat/unsetenv.c
> +++ b/compat/unsetenv.c
> @@ -1,5 +1,10 @@
>  #include "../git-compat-util.h"
>
> +#ifdef __APPLE__
> +// On OS X libc headers don't define this symbol.
> +extern char **environ;
> +#endif
> +

Shouldn't this go into git-compat-util.h, since there may be other
files depending on this variable?
