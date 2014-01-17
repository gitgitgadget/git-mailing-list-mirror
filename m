From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 12:02:36 -0800
Message-ID: <20140117200236.GA18964@google.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
 <20140117182148.GY18964@google.com>
 <xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBD6LRKOE4AIRBYEY42LAKGQEWLCX7CA@googlegroups.com Fri Jan 17 21:02:42 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBYEY42LAKGQEWLCX7CA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f60.google.com ([209.85.212.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBYEY42LAKGQEWLCX7CA@googlegroups.com>)
	id 1W4Fcn-0005Ku-C8
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 21:02:41 +0100
Received: by mail-vb0-f60.google.com with SMTP id i3sf615349vbh.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=Z8KCD9zVa6uwenNAu3CLSHKnqkoww10pzICQrSHnCz0=;
        b=B1ZO7zbXlpWE48cHea5bw2M7EA8vwbxlheHr0RyYjG4eLIggMs2L9QaqhN2ahd2tGN
         60hzDZGnFwF8Xy9gYX30BjPP6GOodGcPRh+AzSBrxbj3SgD0DYfY01xdPutoude9e2la
         FLxxec8L3QojO76kD8iZ/CzNBgWYgbkSuBx/4UC5xbNbjP4RbJ6Hyg8dNnLUXziRyIAo
         C3nSOlqAubjZnv5J3VTQVni71nD1V8ZbyvVuBy48aXFlyKRxGpSy5mVpHrAh0yFT5oFT
         PHc8ceNCHhOBqAbLKVX1n2iw6PNDKQOSACeLVRuOsDYLRs2GHJjwqUWdqJWcE1JZc6Ko
         K2+A==
X-Received: by 10.50.13.7 with SMTP id d7mr4067igc.16.1389988960498;
        Fri, 17 Jan 2014 12:02:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.117.2 with SMTP id ka2ls581827igb.20.canary; Fri, 17 Jan
 2014 12:02:39 -0800 (PST)
X-Received: by 10.66.26.132 with SMTP id l4mr1433926pag.2.1389988959816;
        Fri, 17 Jan 2014 12:02:39 -0800 (PST)
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com [2607:f8b0:4002:c07::232])
        by gmr-mx.google.com with ESMTPS id l41si3988246yhi.5.2014.01.17.12.02.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 12:02:39 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c07::232 as permitted sender) client-ip=2607:f8b0:4002:c07::232;
Received: by mail-yk0-f178.google.com with SMTP id 79so621172ykr.9
        for <msysgit@googlegroups.com>; Fri, 17 Jan 2014 12:02:39 -0800 (PST)
X-Received: by 10.236.134.46 with SMTP id r34mr3597425yhi.62.1389988959580;
        Fri, 17 Jan 2014 12:02:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 23sm20034353yhj.5.2014.01.17.12.02.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 12:02:38 -0800 (PST)
In-Reply-To: <xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c07::232
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240621>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Shouldn't this use write_in_full() to avoid a silently truncated result? (*)
>
> Meaning this?  If so, I think it makes sense.
[...]
> -	if (xwrite(fd, out.buf, out.len) < 0)
> +	if (write_in_full(fd, out.buf, out.len) != out.len)

Yes.  Either '< 0' or '!= out.len' would work fine here, since
write_in_full is defined to always either write the full 'count'
bytes or return an error.

Thanks,
Jonathan

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
For more options, visit https://groups.google.com/groups/opt_out.
