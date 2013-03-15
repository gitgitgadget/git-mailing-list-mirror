From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Fri, 15 Mar 2013 17:23:27 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info> <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info> <7vk3p9wqh5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr> <7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, kusmabite@gmail.com,
        git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCS5LIPSQMEBBC4WRWFAKGQETA3A6GA@googlegroups.com Fri Mar 15 17:24:05 2013
Return-path: <msysgit+bncBCS5LIPSQMEBBC4WRWFAKGQETA3A6GA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f60.google.com ([209.85.161.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCS5LIPSQMEBBC4WRWFAKGQETA3A6GA@googlegroups.com>)
	id 1UGXQJ-0005iO-22
	for gcvm-msysgit@m.gmane.org; Fri, 15 Mar 2013 17:24:03 +0100
Received: by mail-fa0-f60.google.com with SMTP id x10sf992999fax.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Mar 2013 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf
         :x-authentication-warning:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:x-fromdanielhimself
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=EzkXuQOmTAcuMlHq/Z8S5jhP5QNoeZ/xVw6+sSa0RvU=;
        b=XNqDZlRtXAiCkyTepI4Qhpo9nfww0hSqN0YvADF0AAUNmdOHevAAmic15kxFnO5Hy5
         9WxvnH6H4oxHT9JMucj6d9oHgZrBqZtthEO1qXSvS/Ye9RkUImMsB0mGEd+HvHJANZjY
         wP7vRcPphpcH5Zs5R5sxn7dvOMwUi05CYth0MMZz3tPDYyLBdpCKpdx+/dSMwyU0Cglr
         VrMSuZjTm38DLxPWZVO3s5sBH9BHs2KK6psnZSmIR0ExIjYMutiNgMGLFOI6Ra0I 
X-Received: by 10.180.24.201 with SMTP id w9mr280879wif.1.1363364620318;
        Fri, 15 Mar 2013 09:23:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.14.137 with SMTP id p9ls423500wic.49.gmail; Fri, 15 Mar
 2013 09:23:39 -0700 (PDT)
X-Received: by 10.204.228.12 with SMTP id jc12mr815340bkb.2.1363364619644;
        Fri, 15 Mar 2013 09:23:39 -0700 (PDT)
Received: from giant.haxx.se (www.haxx.se. [2a00:1a28:1200:9::2])
        by gmr-mx.google.com with ESMTPS id i9si612569bki.2.2013.03.15.09.23.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 09:23:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as permitted sender) client-ip=2a00:1a28:1200:9::2;
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r2FGNUh2020271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Mar 2013 17:23:30 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r2FGNRgA020243;
	Fri, 15 Mar 2013 17:23:28 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Original-Sender: daniel@haxx.se
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as
 permitted sender) smtp.mail=daniel@haxx.se
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218249>

On Fri, 15 Mar 2013, Junio C Hamano wrote:

>> As for how ALL vs DEFAULT will act or differ in the future, I suspect that 
>> we will end up having them being the same (even when we add bits) as we've 
>> encouraged "ALL" in the documentation like this for quite some time.
>
> Thanks, then we should stick to starting from ALL like everybody else who 
> followed the suggestion in the documentation.  Do you have recommendations 
> on the conditional dropping of SSL?

Not really, no.

SSL initing is as has been mentioned alredy only relevant with libcurl if an 
SSL powered protocol is gonna be used, so if checking the URL for the protocol 
is enough to figure this out then sure that should work fine.

-- 

  / daniel.haxx.se

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
