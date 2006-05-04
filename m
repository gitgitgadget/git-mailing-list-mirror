From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix linking with OpenSSL
Date: Thu, 04 May 2006 15:38:30 -0700
Message-ID: <7vwtd12z6h.fsf@assigned-by-dhcp.cox.net>
References: <20060504222550.GA7236@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 00:38:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbmSx-0008Vn-Ib
	for gcvg-git@gmane.org; Fri, 05 May 2006 00:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWEDWic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 18:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWEDWic
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 18:38:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41123 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751040AbWEDWic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 18:38:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504223831.ZFAF27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 18:38:31 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20060504222550.GA7236@mipter.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Fri, 5 May 2006 02:25:50 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19580>

Alexey Dobriyan <adobriyan@gmail.com> writes:

> For those who put it into interesting (read: default) place.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>
> --- a/Makefile
> +++ b/Makefile
> @@ -559,7 +559,7 @@ git-http-push$X: revision.o http.o http-
>  
>  git-rev-list$X: rev-list.o $(LIB_FILE)
>  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(OPENSSL_LIBSSL)
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
>  
>  init-db.o: init-db.c
>  	$(CC) -c $(ALL_CFLAGS) \

We used to depend on bignum from openssl for rev-list
(merge-order), and if I remember correctly that was the only
reason built recipe for rev-list is different from other
programs.  I wonder if we can just get rid of this thing, and
have it built with git-%$X rule like everybody else.

Can somebody try that out and report what happens?
