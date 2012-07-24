From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 13:27:00 -0500
Message-ID: <20120724182700.GI2939@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:27:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StjpB-0003Xb-7i
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 20:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab2GXS1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 14:27:07 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37641 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab2GXS1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 14:27:05 -0400
Received: by ghrr11 with SMTP id r11so6990789ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+3gJWZspgr8BXZdYxWzzOqgLU9h1rQNpx1UHZ+0vBq8=;
        b=Gk9obaO8yJjWZnmwwHzw/QXwFbCr+7siIR66hJ8yQ38uqSND9pKH4vPxnTDKJy1w8S
         hel4NUL4eSUvZ3VIRGxfX+gqA8NieKwZNwBxcHU77AQYvIR4UteAxf4CJ/XDBCMYjaL0
         fOCCUvmLfP/LaOqYTT1BSLEYQN0dpcjgPYziHqyRjXhReSggXjvZLLA0akUU9RtYKfPM
         iJHMFjHE8j5FtJo4Or7BFdrO0O4hN4nrK2C0gU1nVBXAk4x+JmyEFzVONM0EDIe47tUT
         jNA2czI6A2nhsFQjn0hRzRbRA1taSZrBm+ULEjS2Fj2l+et2CuasI5cmXsFYc68lhT97
         89Zw==
Received: by 10.42.61.134 with SMTP id u6mr17307858ich.11.1343154424432;
        Tue, 24 Jul 2012 11:27:04 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id g5sm2594900ign.4.2012.07.24.11.27.03
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 11:27:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202051>

Hi,

Jiang Xin wrote:

> Gettext message should not start with '-' nor '--'. Since the '-d' and
> '--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
> remove the block.

The above justification is not a sufficient reason to stop giving
helpful advice when someone uses an option that was historically
supported:

> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore.")
>  		abort=t ;;
>  	--rebasing)
>  		rebasing=t threeway=t ;;
> -	-d|--dotest)
> -		die "$(gettext "-d option is no longer supported.  Do not use.")"
> -		;;

Luckily the support was removed 4 years ago and I don't think anyone
is going to run into this, so a different justification could apply.

	Support for the git am -d/--dotest option was removed four years ago
	(see e72c7406, "am: remove support for -d .dotest", 2008-03-04) and
	presumably no one is trying to use it any more.  Simplify the
	code and free the short-and-sweet "-d" option for other uses by
	no longer parsing it.

	The motivation: xgettext copes poorly with messages starting
	with '-'.  Rather than fixing this ancient message, let's take
	this as a reminder to remove it.

See http://thread.gmane.org/gmane.comp.version-control.git/75896 for
context.  Though also see
http://thread.gmane.org/gmane.comp.security.selinux/1424/focus=1430

Hope that helps,
Jonathan
