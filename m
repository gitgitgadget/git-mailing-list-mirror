From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] archive: allow remote to have more formats than we understand.
Date: Sun, 10 Sep 2006 21:02:10 +0200
Message-ID: <cda58cb80609101202y2ee1a18dwf09d6e104740777@mail.gmail.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 21:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUZa-0000M3-DZ
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWIJTCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWIJTCM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:02:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:27484 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932496AbWIJTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:02:11 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1301462wxc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 12:02:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbcDo3YMZj32j+lAvREtcjPRcehRNHHzMGhLFEFjF+ygI//YOI2Obu4Gjae20uj2H0F+pbVhmUoODvm4iyvI2+jIJCmeikgZ3SorkpdjiXTg3BIVJH+v/FyZEAgLWIGZof1b2YYQZvPsa90vsdLCBJFHxkWPD0qZqfZVivIShEQ=
Received: by 10.70.21.4 with SMTP id 4mr4333047wxu;
        Sun, 10 Sep 2006 12:02:10 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 10 Sep 2006 12:02:10 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26807>

2006/9/10, Junio C Hamano <junkio@cox.net>:
> This fixes git-archive --remote not to parse archiver arguments;
> otherwise if the remote end implements formats other than the
> one known locally we will not be able to access that format.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  * At first sight, this should not matter that much, but (1) we
>    do not really parse and validate the arguments when dealing
>    with remote site, and (2) we have no way validating them if
>    we wanted to, given that the remote end might be running
>    different version of git.
>
>    Having said that, you would realize that once we start
>    refactoring things this way, "git archive --remote=foo" is
>    not archive driver anymore.  There is nothing that prevents
>    us saying "git archive --remote=foo --command=rev-list HEAD",
>    other than that the remote archive protocol insists the
>    command invoked at the remote end to be "git archive" itself.
>

good change.

>  archive.h         |    1 -
>  builtin-archive.c |   79 ++++++++++++++++++++++++++++++++---------------------
>  2 files changed, 47 insertions(+), 33 deletions(-)
>

[snip]

>         return i;
>  }
>
> +static const char *remote_request(int *ac, const char **av)
> +{

just to be consistent with the rest of the file, I would have called
this function
"parse_remote_arg" or "extract_remote_arg"

-- 
               Franck
