From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 12/14] Fix pointer -> integer casts on IL32P64 systems
Date: Tue, 30 Sep 2014 10:29:48 +0400
Message-ID: <20140930062947.GA17170@seldon>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
 <1411910670-31285-13-git-send-email-marat@slonopotamus.org>
 <5429C47D.3050903@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, marat@slonopotamus.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCE7TAPITACRBYU3VGQQKGQEATRWEHQ@googlegroups.com Tue Sep 30 08:29:57 2014
Return-path: <msysgit+bncBCE7TAPITACRBYU3VGQQKGQEATRWEHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBYU3VGQQKGQEATRWEHQ@googlegroups.com>)
	id 1XYqwe-0004Qx-Cg
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 08:29:56 +0200
Received: by mail-la0-f55.google.com with SMTP id hz20sf235934lab.20
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Sep 2014 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=r54QAH890TYiokyYB1SkzDYuCCFv1J5XQQOaNEzahGA=;
        b=GXJVKbrYaLIxGVjUQDIz9HycaVg9a7SGkOUniaJ5GeWodB0ANXUpzralHH9cszjonH
         yLN4E99o9/96fUJtz8WsALaF3fRJDWdrBe+TYQ1UHGUm9qIJt2S1aJFGYhq1AErW8/6B
         071n5ygUeLcCRBDslz0pYNB3KceiXJ5hy7W7TXhf7ulvaOnagOupNhZodC0nKbsAKDae
         LGYfutBlNJbQO0I5yFroeEIGlvkqWsWmeY05oL20cLl9VqyMSfohVwm7SiOtuxIAij8Z
         YAoKiG5ThTPsb94VyD14w5EhPk42bYoTEMZkn3sXqvr246tySvIBOyWxiBbar8iN9MqR
         S8/Q==
X-Received: by 10.152.30.1 with SMTP id o1mr4545lah.10.1412058596235;
        Mon, 29 Sep 2014 23:29:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.70 with SMTP id q6ls685204lah.62.gmail; Mon, 29 Sep
 2014 23:29:54 -0700 (PDT)
X-Received: by 10.112.184.197 with SMTP id ew5mr6570057lbc.0.1412058594349;
        Mon, 29 Sep 2014 23:29:54 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id f9si489943wib.2.2014.09.29.23.29.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2014 23:29:54 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYqwW-0004T7-Hi; Tue, 30 Sep 2014 10:29:49 +0400
In-Reply-To: <5429C47D.3050903@kdbg.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257646>

On Mon, Sep 29, 2014 at 10:43:41PM +0200, Johannes Sixt wrote:
> Am 28.09.2014 um 15:24 schrieb Marat Radchenko:
> > This commit touches regcomp.c and poll.c from Gnulib,
> > both were fixed upstream in 2012 the same way.
> > 
> > Wrt ShellExecute, see [1].
> > 
> > [1]: http://blogs.msdn.com/b/oldnewthing/archive/2006/11/08/1035971.aspx
> 
> Please do not force readers to visit a web site; provide at least a summary.

No problem, will expand commit message.

> This breaks with
> 
> In file included from compat/regex/regex.c:77:
> compat/regex/regcomp.c: In function 'parse_dup_op':
> compat/regex/regcomp.c:2580: error: 'intptr_t' undeclared (first use in
> this function)
> 
> when compiled using the msysgit environment.

Aargh! No idea how this slipped through. Will reroll.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
