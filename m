From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Thu, 27 Aug 2015 14:50:14 -0700
Message-ID: <20150827215014.GA8165@google.com>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jose F. Morales" <jfmcjf@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV54W-0000pv-WF
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 23:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbH0Vuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 17:50:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34100 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbbH0VuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 17:50:21 -0400
Received: by pabzx8 with SMTP id zx8so38641781pab.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=juq8W4Qe+g4WEHfveNbCEtzyh/ERHbGZgkKPM0qsraQ=;
        b=SK4U9cVuLKejtxcc+7HqM2hvi1aGsPLecAEIiFx5yd9aG+3QuAqrn7T8MSXPXxhqoe
         LD6EXY+WBC/KLAvsl7A0d64yDhaFTmel4vy6ByS9zxfiNTnMvd/FzswtjdXumSh4gNJH
         95pAr9ajnjEgKyYsj67op0fAG6zNbXNgB9iOG2FxWuxuVRr6qQqXvj9Od4KOwJCdsbOa
         D9WNOw973RzrXUapCvT8JPRM1Ylr5q5w+QpHfWbrGZAK0wc/M3VPOE/xNi4njtETP+BE
         05nesb5W+RSvCv9/mCs1p6byDlhwdm9X3yStzEBcIVbJ21BUkve/nnipVrfbu4Ke3m6i
         m7pA==
X-Received: by 10.68.254.136 with SMTP id ai8mr9875061pbd.98.1440712220631;
        Thu, 27 Aug 2015 14:50:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id gh5sm3444678pbc.87.2015.08.27.14.50.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Aug 2015 14:50:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276687>

Johannes Schindelin wrote:

> From: jfmc <jfmcjf@gmail.com>

This means the name shown by git shortlog would be jfmc instead of
Jose F. Morales.  Intended?

> The code to open and test the second end of the pipe clearly imitates
> the code for the first end. A little too closely, though... Let's fix
> the obvious copy-edit bug.
>
> Signed-off-by: Jose F. Morales <jfmcjf@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This is an old one --- more than 5 years old (since v1.7.0-rc0~86^2~4
"Windows: simplify the pipe(2) implementation", 2010-01-15).  Thanks
for catching it.

Regards,
Jonathan

(patch kept unsnipped for reference)

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 496e6f8..f74da23 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -681,7 +681,7 @@ int pipe(int filedes[2])
>  		return -1;
>  	}
>  	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
> -	if (filedes[0] < 0) {
> +	if (filedes[1] < 0) {
>  		close(filedes[0]);
>  		CloseHandle(h[1]);
>  		return -1;
> 
> --
> https://github.com/git/git/pull/168
