From: tsuna <tsunanet@gmail.com>
Subject: Re: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 23:10:12 -0700
Message-ID: <CAFKYj4dRFvTwM_x0mXsOLQCTuw9nAvh3b4bZ+Omg7M5DVNnVzA@mail.gmail.com>
References: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
 <51EA7D58.3050800@web.de> <7vr4essbkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 08:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0mqr-0003ko-Ar
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 08:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3GUGKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 02:10:33 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42832 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3GUGKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 02:10:32 -0400
Received: by mail-ie0-f169.google.com with SMTP id at20so1716940iec.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zCEdytAj9L6s889rfjnWSnJ6F/5lQl7d3+DZXPtoohU=;
        b=yxTRYjpRILGwsAQxLRvejWZS9jseX8dh3rUdRrkNBs37a1K0fs4TWwLh+uP9M62tUp
         OR+KOuLSET/9D0cipBEI2xg0vLoHlpeRHGloisFlqw5tilZFzUMFueMr0UE3kHvtmNyA
         oLJuXjKyN+UiReZ6ju8/wWeP6CmbLNA+9CaVUNtr2s9Wm7JOHFRlg7ybHy1DBaNyMir6
         vY5Uozqr+agz/50AguBcT3j+zc09cNhvnhYzCbvGy7gMXPxHlJzkg40jRHU+FVpVGFAn
         WBjJrD0z2xptO3w0nLbUqN7HJjBOxRWCZxyOCzYbP79my3JcwSh5U0VC6xYQYMJ1Flkw
         ttRA==
X-Received: by 10.50.109.161 with SMTP id ht1mr15797940igb.60.1374387032255;
 Sat, 20 Jul 2013 23:10:32 -0700 (PDT)
Received: by 10.64.34.148 with HTTP; Sat, 20 Jul 2013 23:10:12 -0700 (PDT)
In-Reply-To: <7vr4essbkv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230917>

On Sat, Jul 20, 2013 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Actually, it is _wrong_ for us to rely on system header files to
> define this symbol for us.  Declaring "extern char **environ" is
> responsibility of the user programs (like us).

Actually, that's right.  The C99 standard doesn't mention anything
about `environ' (only 7.20.4.5 defines `getenv') and POSIX explicitly
states "the [environ] variable, which must be declared by the user if
it is to be used directly"
(http://pubs.opengroup.org/onlinepubs/9699919799/functions/environ.html)

> When _GNU_SOURCE is defined glibc header (I think it is unistd.h)
> seem to define it for us.
>
> Perhaps the correct fix is to revert ec535cc2 for everybody, and if
> MinGW needs such a workaround, do it inside #ifndef MINGW?

That sounds right.

-- 
Benoit "tsuna" Sigoure
