From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 15:45:10 -0700
Message-ID: <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com,  git@vger.kernel.org,  msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRB6NFRGFAKGQE5HY7OHY@googlegroups.com Thu Mar 14 23:45:38 2013
Return-path: <msysgit+bncBCG77UMM3EJRB6NFRGFAKGQE5HY7OHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f183.google.com ([209.85.214.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB6NFRGFAKGQE5HY7OHY@googlegroups.com>)
	id 1UGGu1-0003DO-I5
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 23:45:37 +0100
Received: by mail-ob0-f183.google.com with SMTP id un3sf1032010obb.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:from:to:cc:subject
         :references:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=zPVi5MNkyls7KN40XzuEUpwQohG6XitbWzL7lqmDF4c=;
        b=sgqfHiz7kDw9rOQqrkBJ3e4TGvOA6KayKYPBqEQ0rUppxpkaVCMxApyz0RwMTV/Lh0
         wg0470GcBn972KlK4dBWv93qsD1oOB04VdOKv6I0LKpknOxSxdor52Ava32T01VQ4S11
         LKp8lgYb4dJYMrvaFCYAItjVxv+nmsbbGzXyVRpCRVBv35ystzyOcWWEaXUkaG1PyAnD
         6/voKq/oi7v9twlYZ49dmFIQ+V3X3V/imEUB2O01nMlg06ERAGHeVSma9j6zbOVAZDTa
         RLiEV5EKDbQFpGPZOTpS7c3XeFT1VZ1fIoJ 
X-Received: by 10.50.6.135 with SMTP id b7mr724425iga.9.1363301114259;
        Thu, 14 Mar 2013 15:45:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.140.102 with SMTP id rf6ls3856309igb.10.canary; Thu, 14 Mar
 2013 15:45:13 -0700 (PDT)
X-Received: by 10.68.125.229 with SMTP id mt5mr2020845pbb.1.1363301113617;
        Thu, 14 Mar 2013 15:45:13 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ka10si1595587pbb.2.2013.03.14.15.45.13;
        Thu, 14 Mar 2013 15:45:13 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD520CF5C;
	Thu, 14 Mar 2013 18:45:12 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20CCCF5B;
	Thu, 14 Mar 2013 18:45:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31DAFCF59; Thu, 14 Mar 2013
 18:45:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Thu, 14 Mar 2013 23:35:03 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4A88250-8CF8-11E2-902A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218179>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Apparently, ftps is also handled by cURL and most likely requires SSL.
>
> How about optimizing for the common case and instead of prefixcmp(url,
> "https:")) ask for !prefixcmp(url, "http:")?

I think that is a very sensible way to go.

As to ALL vs DEFAULT, given that its manual page is riddled with a
scary warning:

    This function must be called at least once within a program (a
    program is all the code that shares a memory space) before the
    program calls any other function in libcurl. The environment it sets
    up is constant for the life of the program and is the same for every
    program, so multiple calls have the same effect as one call.  ... In
    normal operation, you must specify CURL_GLOBAL_ALL. Don't use any
    other value unless you are familiar with it and mean to control
    internal operations of libcurl.

I think we should stick to ALL.  So

	flags = CURL_GLOBAL_ALL;
	if (!prefixcmp(url, "http:"))
		flags &= ~CURL_GLOBAL_SSL;

would be the way to go.

But this is assuming that nobody feeds our client a http:// URL to
the server that redirects us to the https:// version (or we do not
follow such a redirect).  I offhand do not know if that is a valid
assumption, though.

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
