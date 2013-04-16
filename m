From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] i18n: branch: mark strings for translation
Date: Mon, 15 Apr 2013 19:40:21 -0700
Message-ID: <20130416024021.GG3262@elie.Belkin>
References: <CACsJy8DK5U3XErjDYZJZ+RBywDypuDotc-cH=CYGcd9Pu=V4PQ@mail.gmail.com>
 <b841ddcc538f77c89859efe867fc638005dc13f9.1365861788.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URvou-0003i4-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935256Ab3DPCk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:40:28 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:53947 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935183Ab3DPCk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:40:27 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so16243dan.24
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jCrd7d9/EVmEutaccyIqDBzlJgHF55XHqiw+yylfyUc=;
        b=dSbQld2NXHx9eeiZvE/94Kw+dQu9bH+bxNTCObI28S/9/ICaocqFTclEuV8yQlHXBd
         WiJUzIx2dUwgWNzmZZmAhl4p0hpdtLjuatLiwtkD3ZHkbB0aue9Tt2P8uuIX3Fs/oE2G
         QsRJv1m4ctJdhPk+LVAQhbfvYNvPZe8t05fEtBLjqay95ci4wLT68QYzBh59s5n5HW5b
         sovOTuqXK8qpzAnJ1i5THZTJH0xnCOgBUvoL43wbxN4r0iQ95yId7QxmPs3RaAbH+QdB
         NhjmvtOJMFmcPqEW9SKRBJg9Led4/uPHHhAmZamxJytY0u1upAf+hfn+PYEjvVzdPudw
         n4lA==
X-Received: by 10.68.218.34 with SMTP id pd2mr370751pbc.204.1366080027143;
        Mon, 15 Apr 2013 19:40:27 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id tx9sm11690pbc.27.2013.04.15.19.40.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 19:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b841ddcc538f77c89859efe867fc638005dc13f9.1365861788.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221347>

Jiang Xin wrote:

> --- a/branch.c
> +++ b/branch.c
[...]
> @@ -79,23 +79,23 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
>  		if (remote_is_branch && origin)
>  			printf(rebasing ?
> -			       "Branch %s set up to track remote branch %s from %s by rebasing.\n" :
> -			       "Branch %s set up to track remote branch %s from %s.\n",
> +			       _("Branch %s set up to track remote branch %s from %s by rebasing.\n") :
> +			       _("Branch %s set up to track remote branch %s from %s.\n"),

Micronit: it would be nicer to use printf_ln to save translators the
trouble of worrying about the final newline.

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Here's a patch making that change for squashing in.

diff --git i/branch.c w/branch.c
index 4ddd69f3..c67b97d1 100644
--- i/branch.c
+++ w/branch.c
@@ -78,24 +78,24 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
-			printf(rebasing ?
-			       _("Branch %s set up to track remote branch %s from %s by rebasing.\n") :
-			       _("Branch %s set up to track remote branch %s from %s.\n"),
+			printf_ln(rebasing ?
+			       _("Branch %s set up to track remote branch %s from %s by rebasing.") :
+			       _("Branch %s set up to track remote branch %s from %s."),
 			       local, shortname, origin);
 		else if (remote_is_branch && !origin)
-			printf(rebasing ?
-			       _("Branch %s set up to track local branch %s by rebasing.\n") :
-			       _("Branch %s set up to track local branch %s.\n"),
+			printf_ln(rebasing ?
+			       _("Branch %s set up to track local branch %s by rebasing.") :
+			       _("Branch %s set up to track local branch %s."),
 			       local, shortname);
 		else if (!remote_is_branch && origin)
-			printf(rebasing ?
-			       _("Branch %s set up to track remote ref %s by rebasing.\n") :
-			       _("Branch %s set up to track remote ref %s.\n"),
+			printf_ln(rebasing ?
+			       _("Branch %s set up to track remote ref %s by rebasing.") :
+			       _("Branch %s set up to track remote ref %s."),
 			       local, remote);
 		else if (!remote_is_branch && !origin)
-			printf(rebasing ?
-			       _("Branch %s set up to track local ref %s by rebasing.\n") :
-			       _("Branch %s set up to track local ref %s.\n"),
+			printf_ln(rebasing ?
+			       _("Branch %s set up to track local ref %s by rebasing.") :
+			       _("Branch %s set up to track local ref %s."),
 			       local, remote);
 		else
 			die("BUG: impossible combination of %d and %p",
