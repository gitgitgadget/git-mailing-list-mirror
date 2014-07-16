From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] config: use chmod() instead of fchmod()
Date: Wed, 16 Jul 2014 07:33:16 +0200
Message-ID: <53C60E9C.3020604@kdbg.org>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com> <53C5B126.6020404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>,
 Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCJYV6HBKQIJ3HMYTYCRUBD4TS7Q4@googlegroups.com Wed Jul 16 07:33:22 2014
Return-path: <msysgit+bncBCJYV6HBKQIJ3HMYTYCRUBD4TS7Q4@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIJ3HMYTYCRUBD4TS7Q4@googlegroups.com>)
	id 1X7HqA-0004fM-RL
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 07:33:18 +0200
Received: by mail-wg0-f61.google.com with SMTP id x12sf38527wgg.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=WyH8+h+wZzLNRovoLCZ4miZVRD1PPUHDFLoqTz3KclE=;
        b=Btz+lB77G1bWdI2V5vTM3WqxPr9+L6wjPb57jW7lilGpZdrZQmtF94JIK5OyuxXBmM
         oZgAXMnfOnY/L0Ca+ZqabUjmPqNPXbYs9YRQ5uIjgyyrChYLTdca3aCASFncm7KME+yB
         aXNLPnRKQMuy8HWGk0n92yqmqFNTaaTi1Cb0PF3XmWBaBBS9BAlbPbSl9dbXnE90/1FG
         gILJLQkyFVTfV8mE8y+dDOO9p5i46GqmP5WiMG/PdkEyU/npzPCP4UbeJUzKxXNCdnZv
         2o0g6QaHv0arI8V65TJNPAgfu8duu+Nwg6XBd0zQRpShjdUQWGx1fH3M2xfC4nV402eG
         f25Q==
X-Received: by 10.180.75.148 with SMTP id c20mr43250wiw.9.1405488798525;
        Tue, 15 Jul 2014 22:33:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.168 with SMTP id gf8ls200515wib.35.gmail; Tue, 15 Jul
 2014 22:33:17 -0700 (PDT)
X-Received: by 10.194.92.167 with SMTP id cn7mr2555417wjb.1.1405488797580;
        Tue, 15 Jul 2014 22:33:17 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTPS id o6si298836wij.1.2014.07.15.22.33.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 22:33:17 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.15;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 92E3713005B;
	Wed, 16 Jul 2014 07:33:16 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 418FD19F459;
	Wed, 16 Jul 2014 07:33:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C5B126.6020404@gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253655>

Am 16.07.2014 00:54, schrieb Karsten Blees:
> There is no fchmod() on native Windows platforms (MinGW and MSVC), and the
> equivalent Win32 API (SetFileInformationByHandle) requires Windows Vista.
> 
> Use chmod() instead.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  config.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/config.c b/config.c
> index ba882a1..9767c4b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1636,8 +1636,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  			MAP_PRIVATE, in_fd, 0);
>  		close(in_fd);
>  
> -		if (fchmod(fd, st.st_mode & 07777) < 0) {
> -			error("fchmod on %s failed: %s",
> +		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +			error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  			ret = CONFIG_NO_WRITE;
>  			goto out_free;
> @@ -1815,8 +1815,8 @@ int git_config_rename_section_in_file(const char *config_filename,
>  
>  	fstat(fileno(config_file), &st);
>  
> -	if (fchmod(out_fd, st.st_mode & 07777) < 0) {
> -		ret = error("fchmod on %s failed: %s",
> +	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +		ret = error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  		goto out;
>  	}
> 

I assume you tested this patch on Windows. I am mildly surprised that
(on Windows) chmod() works on a file that is still open.

-- Hannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
