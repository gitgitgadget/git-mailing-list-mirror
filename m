From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 12/23] query_refspecs(): move some constants out of the loop
Date: Wed, 30 Oct 2013 16:35:03 +0530
Message-ID: <CALkWK0m-qNcCe_Zmn6PeN91JEM-7Ki0F0b0Fp+1bhQTWdmR7EA@mail.gmail.com>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu> <1383111192-23780-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 30 12:05:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbTau-0003NH-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 12:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab3J3LFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 07:05:44 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57960 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab3J3LFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 07:05:44 -0400
Received: by mail-ie0-f180.google.com with SMTP id e14so1881346iej.25
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6WV+F/yAEr23fwx0Hww1YfJBXw7DyJ9PREm2A7+7Aaw=;
        b=jlZrAIWwuypw1GMICO/LEwKf/mIFp7YRFgY9ns7tRN9z4M7/VeFuC8pgDSZmfoRwJY
         Z0uF2CUrKHSiQ+0MVqfS6nMY1ghF23dmLYTAUvUeFv1tOpQFdSEmujsps1yyb0tA664G
         8f8Br3H7l7fkRX5znP12Xq7xylbZsiQ8ZkWj3+2o/fPhQ0Vqy4kAf5duKFraWfZK6VSg
         6kXmydl+rP5HdFl/yyUPIWTpFq0o84kbSR+z/0KfJ1ce3lEIwBZvG/3UIKgmQlDwEcS7
         vA6b1BY2+ObwGibDbsORxKN80csaL3ntPJqOn3/Lm14XS24laGmGNMzOgfB3BXwNodaH
         7KVA==
X-Received: by 10.42.82.196 with SMTP id e4mr579694icl.58.1383131143817; Wed,
 30 Oct 2013 04:05:43 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Wed, 30 Oct 2013 04:05:03 -0700 (PDT)
In-Reply-To: <1383111192-23780-13-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237013>

Michael Haggerty wrote:
> diff --git a/remote.c b/remote.c
> index e42daa8..a5e6c7f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -825,6 +825,8 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
>  {
>         int i;
>         int find_src = !query->src;
> +       const char *needle = find_src ? query->dst : query->src;
> +       char **result = find_src ? &query->src : &query->dst;
>
>         if (find_src && !query->dst)
>                 return error("query_refspecs: need either src or dst");
> @@ -833,8 +835,6 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
>                 struct refspec *refspec = &refs[i];
>                 const char *key = find_src ? refspec->dst : refspec->src;
>                 const char *value = find_src ? refspec->src : refspec->dst;
> -               const char *needle = find_src ? query->dst : query->src;
> -               char **result = find_src ? &query->src : &query->dst;
>
>                 if (!refspec->dst)
>                         continue;

Why? Is it used in some later patch?
