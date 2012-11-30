From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 2/5] compat/terminal: factor out echo-disabling
Date: Fri, 30 Nov 2012 18:59:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBBPI4OCQKGQENGKNJZA@googlegroups.com Fri Nov 30 18:59:56 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBBPI4OCQKGQENGKNJZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBBPI4OCQKGQENGKNJZA@googlegroups.com>)
	id 1TeUsL-0001Gf-5s
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 18:59:45 +0100
Received: by mail-ea0-f186.google.com with SMTP id c1sf434765eaa.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=TU9i/30sHW3uCK4pOCCLVBqkO8f/58NbQXIbGZsmbjg=;
        b=cpSSA0UtYIEQvrUDUA8Zw2AxCEkMoWUVcbeyov8V7ccUt4FxZCWoYOUrY1ropV57lp
         Zelauz7y8W2tjouI8w8mptqBKBTbHm8zYf/IOX5ThDUQ+PFssdnSkRH6qhAkTK5phXNz
         FXRYS5chgJ9axjWBJfRM56A5QP/6j+9yteFHDqIEt+X99okOLEG/uA0o8TvnENPwobv1
         lxM/Tfn7b2DP+BYYuU9N6V0aaP1eYBrDFCApA7WwKa8eJaWn10+lJRyyKhfGFc7DUHCh
         zGqEU6t52NdBjXYfqt 
Received: by 10.180.97.225 with SMTP id ed1mr478743wib.0.1354298373851;
        Fri, 30 Nov 2012 09:59:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.77.228 with SMTP id v4ls3553338wiw.0.canary; Fri, 30 Nov
 2012 09:59:33 -0800 (PST)
Received: by 10.14.0.196 with SMTP id 44mr2522837eeb.6.1354298373062;
        Fri, 30 Nov 2012 09:59:33 -0800 (PST)
Received: by 10.14.0.196 with SMTP id 44mr2522836eeb.6.1354298373050;
        Fri, 30 Nov 2012 09:59:33 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id u8si1328819een.1.2012.11.30.09.59.32;
        Fri, 30 Nov 2012 09:59:33 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 30 Nov 2012 17:59:32 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp020) with SMTP; 30 Nov 2012 18:59:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vKhQDs57vsmJhv/JQ4ZgkGRqrM+QSAbpJdtLtbx
	6EiSKjGS/krtHu
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1352815447-8824-3-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210932>

Hi,

On Tue, 13 Nov 2012, Erik Faye-Lund wrote:

> By moving the echo-disabling code to a separate function, we can
> implement OS-specific versions of it for non-POSIX platforms.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  compat/terminal.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/compat/terminal.c b/compat/terminal.c
> index bbb038d..3217838 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -14,6 +14,7 @@ static void restore_term(void)
>  		return;
>  
>  	tcsetattr(term_fd, TCSAFLUSH, &old_term);
> +	close(term_fd);
>  	term_fd = -1;
>  }

That looks like an independent resource leak fix... correct?

Rest looks awsomely fine.
Dscho

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
