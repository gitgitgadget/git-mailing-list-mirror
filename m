From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 13/14] git-compat-util.h: fix integer overflow
 on IL32P64 systems
Date: Thu, 9 Oct 2014 09:05:41 +0400
Message-ID: <20141009050540.GB17479@seldon>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
 <1412791267-13356-14-git-send-email-marat@slonopotamus.org>
 <xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
 <xmqqfvey8h4t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCE7TAPITACRBKVP3CQQKGQEXXDQLEA@googlegroups.com Thu Oct 09 07:05:49 2014
Return-path: <msysgit+bncBCE7TAPITACRBKVP3CQQKGQEXXDQLEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBKVP3CQQKGQEXXDQLEA@googlegroups.com>)
	id 1Xc5vA-0004Ns-Jc
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 07:05:48 +0200
Received: by mail-wi0-f192.google.com with SMTP id r20sf53616wiv.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 22:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=vwfO6oLxC2Gpz/AQH1NhgWXgVjw45zY6HD2L9TvNwq4=;
        b=ofIQz/c5XCbN6KGpkxWziAE6XQwB5sDFe2mI8pzm4FrUPJIZkAiR2OMpoEagORl0/b
         mE8J4B2+iRo6TyZfNON80Tx+vxvqxD/rymMQmjZb/1Jtoa+s3kcycsApD4r4vXTopNAE
         nWPRz5SZGFYraOyFA/VGj4fyOj58wcOr9W+rbrbwko3ii8kWrU0+9RXMEL0GBuTeC+TF
         o0lUMKDww0rsgXU5SmuvtkASIABQn0efv/DLIT1exs6zzzbxFLTZkeXoYldc4iei99U1
         qcjmZkQKkR3uB9iTajnFLabaGS9mUZ1tPA5rlK084YVtruuN6fdTn8BGyecBccg7OhI2
         iFYw==
X-Received: by 10.152.20.98 with SMTP id m2mr3674lae.25.1412831148299;
        Wed, 08 Oct 2014 22:05:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.229 with SMTP id h5ls134306lam.4.gmail; Wed, 08 Oct
 2014 22:05:46 -0700 (PDT)
X-Received: by 10.152.19.131 with SMTP id f3mr2218566lae.0.1412831146222;
        Wed, 08 Oct 2014 22:05:46 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id rb5si335767lbb.0.2014.10.08.22.05.46
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 22:05:46 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Xc5v3-0004a6-GG; Thu, 09 Oct 2014 09:05:42 +0400
In-Reply-To: <xmqqfvey8h4t.fsf@gitster.dls.corp.google.com>
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

On Wed, Oct 08, 2014 at 01:02:10PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Marat Radchenko <marat@slonopotamus.org> writes:
> >
> >> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> >> ---
> >>  git-compat-util.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/git-compat-util.h b/git-compat-util.h
> >> index b338277..101c9d7 100644
> >> --- a/git-compat-util.h
> >> +++ b/git-compat-util.h
> >> @@ -474,7 +474,7 @@ extern int git_munmap(void *start, size_t length);
> >>  #endif
> >>  
> >>  #define DEFAULT_PACKED_GIT_LIMIT \
> >> -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> >> +	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> >
> > 1024 * 1024 * 8192 overflows 32-bit unsigned, but is size_t always
> > large enough?  Just checking.
> 
> Heh, I was being silly.  This gives the default value for a variable
> whose type is size_t, so it would better fit.  So please throw 13 in
> the list of changes I found sensible in the other message.

Is it an Acked-by?

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
