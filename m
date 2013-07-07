From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Sat, 6 Jul 2013 17:50:34 -0700
Message-ID: <20130707005034.GH30132@google.com>
References: <1373013686-2137-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvdBb-00018H-3g
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab3GGAuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:50:39 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44277 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3GGAui (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:50:38 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so2949364pdi.7
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6LiP/uLwJCwaFOTqMgc0kXTlmcWUa7IBjZuS5a8M/bM=;
        b=R2vvdpm5gmjMv7LU1yZWJfiQD+smiJ/a4HBuBk7ooeKY+HLMx96ABDXXixRlVb/JMZ
         QwFpjO8yhsPX7Aul3JeaT6EjLiUhv3Me7qje9xfZD0uR1sHb7r4Z7xBjsKp5jCIIDdUf
         RHFpZqnlXrZX50akBCpdO4/W1nyVcZRr+F+kQlYH4rvXyNSotp4x5VlBD0HWVSO2MhfC
         gJVY4HOMdccKn4kjQCJxxctWRjE23NPg5SvRldqRl+u8PgrY2JMb7AmvPvQ9b7Gscx9r
         GiDiIDlriFjEEsWh2ph7nntVLlGEB+Rf71J5XCtrsxWJFHlMe76Jux/TCFiKBT2YbKfc
         Lmhg==
X-Received: by 10.68.209.196 with SMTP id mo4mr15430729pbc.114.1373158237972;
        Sat, 06 Jul 2013 17:50:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ry2sm14381332pbc.41.2013.07.06.17.50.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:50:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373013686-2137-1-git-send-email-frase@frase.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229710>

Hi,

Fraser Tweedale wrote:

> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -11,6 +11,9 @@ and ftps can be used for fetching and rsync can be used for fetching
>  and pushing, but these are inefficient and deprecated; do not use
>  them).
>  
> +The git transport does not do any authentication and should be used
> +with caution on unsecured networks.

How about the something like the following?  I'm starting to think it
would make more sense to add a SECURITY section to git-clone(1),
though.

-- >8 --
Subject: doc: clarify git:// transport security notice

The recently added warning about the git protocol's lack of
authentication does not make it clear that the protocol lacks both
client and server authentication.  The lack of non IP-based client
auth is obvious (when does user enter her credentials?), while the
lack of authentication of the server is less so, so emphasize it.

Put the warning in context by making an analogy to HTTP's security
properties as compared to HTTPS.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks,
Jonathan

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9ccb246..bd0058f 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -11,8 +11,8 @@ and ftps can be used for fetching and rsync can be used for fetching
 and pushing, but these are inefficient and deprecated; do not use
 them).
 
-The native transport (i.e. git:// URL) does no authentication and
-should be used with caution on unsecured networks.
+Like HTTP, the native protocol (used for git:// URLs) does no server
+authentication and should be used with caution on unsecured networks.
 
 The following syntaxes may be used with them:
 
