From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 03 Sep 2015 12:11:57 -0700
Message-ID: <xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com>
References: <1441298147-83601-1-git-send-email-garga@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: garga@FreeBSD.org
X-From: git-owner@vger.kernel.org Thu Sep 03 21:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXZvY-0004aa-H7
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbbICTMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:12:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35454 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbICTL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:11:59 -0400
Received: by pacfv12 with SMTP id fv12so56124934pac.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HdJ2XVxZOkOJn83Xnd7tBNlUYIdweB3C55X75qpnK2s=;
        b=buBcVnojSBEY3vNawUvNnfgI+U+kQknWjOsh3OsdumLl1ygHRBM0q7R8Duw/zlzHVg
         Xoz2ft/ojVvuZZZWfDd2JeUamC1e6j3s90QpWDHpKCRwGwLvHJw5IS5NHbb4gqVhBuk+
         UJocyxrqan4H9vBvKum/HZ3deRaSlbdjH9e+Ja5dP7lEgdLYG/4gL8Bbe+1kZ6Q6oUdh
         Agp3l/q57tM4dXswl8HbS4H5cq/rY3N1VMeh8aUSx4MSE4XgoTIwoI7ixxer0hEj10nl
         h/759QIyg3ukqy3vv1HTfiIWoQwigDZSp3ppUdXKg+F9hH9eW+TCh1bMHCxbt0o87mUK
         pAFg==
X-Received: by 10.66.100.234 with SMTP id fb10mr66550836pab.119.1441307518758;
        Thu, 03 Sep 2015 12:11:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id cs6sm11898829pdb.40.2015.09.03.12.11.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 12:11:58 -0700 (PDT)
In-Reply-To: <1441298147-83601-1-git-send-email-garga@FreeBSD.org>
	(garga@freebsd.org's message of "Thu, 3 Sep 2015 13:35:47 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277240>

garga@FreeBSD.org writes:

> From: Renato Botelho <garga@FreeBSD.org>
>
> git-submodule and git-request-pull are written in sh but use perl
> internally. Add them to be replaced by unimplemented.sh when NO_PERL
> flag is set
> ---

Missing sign-off.

You also may want to hold off the "git-submodule" bit, as I expect
http://thread.gmane.org/gmane.comp.version-control.git/277128/focus=277129
would be one of the first changes to be in 'master' after the
upcoming release 2.6 (that is, it is likely that perl dependency
would be removed in 2.7).

>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index e326fa0..4dae0ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1795,7 +1795,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
>  	chmod +x $@+ && \
>  	mv $@+ $@
>  else # NO_PERL
> -$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
> +$(SCRIPT_PERL_GEN) git-instaweb git-submodule git-request-pull: % : unimplemented.sh
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
