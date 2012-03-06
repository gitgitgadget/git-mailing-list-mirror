From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] configure.ac: Add --with-gcc-warnings configure option
Date: Tue, 06 Mar 2012 16:51:58 +0100
Message-ID: <4F56329E.9050506@gmail.com>
References: <1331044385-14796-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 16:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wgL-0007qx-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 16:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab2CFPwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 10:52:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50414 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab2CFPwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 10:52:03 -0500
Received: by bkcik5 with SMTP id ik5so4327985bkc.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 07:52:01 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.151.217 as permitted sender) client-ip=10.204.151.217;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.151.217 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.204.151.217])
        by 10.204.151.217 with SMTP id d25mr4344434bkw.89.1331049121976 (num_hops = 1);
        Tue, 06 Mar 2012 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=qDn/ftdkZCf1jBqTG4QhR/c5pVlBNlazLyvnU/gKgVY=;
        b=0vAx2mAbqtKzJIAnZpcOJ/iz+UanTjCShoThkB/2T+WrFfwopP9G6cuU5gKhwobPl4
         SQlGcu2Dr7LJ6xAN1dLs+wfZ1cELCjeZ9zS49VouS8SGhAWeI+3CZbwTtu3abD4N+JET
         DFTLGCm0SqN7rUGgOLjU5tiqNN6VkPmoEn7SwlWCIfFBv4iKbh2qNMoRFfxmv+15vOT9
         8tCSLRrOm24kW9v8l4vs23ptQMs5d+LGwvwyef8jrGhKxNk2BohMgpritdvuJKTL5XKH
         OXHtxdaeZmPVbr/TP4rAQA6Zqv5hFNQ4ERrX0Xl0DFzpEC0J6xM8b3RcRuJxPTU5aFWu
         ZZQw==
Received: by 10.204.151.217 with SMTP id d25mr3256662bkw.89.1331049121878;
        Tue, 06 Mar 2012 07:52:01 -0800 (PST)
Received: from [79.7.94.193] (host193-94-dynamic.7-79-r.retail.telecomitalia.it. [79.7.94.193])
        by mx.google.com with ESMTPS id ew15sm32953094bkc.10.2012.03.06.07.51.59
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 07:52:00 -0800 (PST)
In-Reply-To: <1331044385-14796-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192357>

On 03/06/2012 03:33 PM, Elia Pinto wrote:
> Introduce a new --with-gcc-warnings configure option
> using a new autoconf macro that check if the compiler
> know the option passed or not in a portable way, as
> it not depends from the gcc version or from the
> other compiler used.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the version 2 of the patch, in which i have
> slightly changed the commit message for
> clarify the purpose. To activate the
> patch is of course necessary to do a autoreconf -vfi after
> applying the patch.
> 
> 
>  Makefile      |    2 +-
>  config.mak.in |    1 +
>  configure.ac  |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index be1957a..d0aef0f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -310,7 +310,7 @@ endif
>  
>  CFLAGS = -g -O2 -Wall
>  LDFLAGS =
> -ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) $(AM_CFLAGS)
>
Wouldn't it be better to use $(WARN_CFLAGS) here?  It makes the purpose
of the variable clearer, and don't give the wrong impression that Automake
is involved (as the 'AM_' prefix might suggest).

>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
>  
> diff --git a/config.mak.in b/config.mak.in
> index b2ba710..5b7dbfd 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -2,6 +2,7 @@
>  # @configure_input@
>  
>  CC = @CC@
> +AM_CFLAGS = @GIT_CFLAGS@
>
Accordingly here: s/AM_CFLAGS/WARN_CFLAGS/ and s/GIT_CFLAGS/WARN_CFLAGS/.

> +# GIT_CFLAGS_ADD(PARAMETER, [VARIABLE = GIT_CFLAGS])
> +# ------------------------------------------------
>
And here as well: s/GIT_CFLAGS/WARN_CFLAGS/.  Ditto for the rest of the
M4 file.

Regards,
  Stefano
