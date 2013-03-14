From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 09:46:37 -0700
Message-ID: <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org, 
 msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB4H5Q6FAKGQEHFA25TQ@googlegroups.com Thu Mar 14 17:47:05 2013
Return-path: <msysgit+bncBCG77UMM3EJRB4H5Q6FAKGQEHFA25TQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f187.google.com ([209.85.128.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB4H5Q6FAKGQEHFA25TQ@googlegroups.com>)
	id 1UGBJ2-0008Iu-BO
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 17:47:04 +0100
Received: by mail-ve0-f187.google.com with SMTP id oz10sf957359veb.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:from:to:cc:subject
         :references:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=VSmsx5yX/0wHDcQnKHHE+1L5/QndFgf8Y8Dyy3w6hDI=;
        b=YjtrWZrfXqdSiCRg/kZp6cZYvNq8VnZZjcaHZaDhQ6lseA3FyRD7XbNISJVrMSIQWX
         pseGKRTOPPRjFvEjzNSLP61kl+5c4mkFYbz++RLa2B+DDyzX8GYZTCzCMXYUZZntWCMn
         eKosQ9QKXIPo7vbJyWCqLn5RubfNGtxrgMGN/q7EhIehjNHUHLy07vN3QKikvx3toWeY
         I1aRZKNHgdD9UT6cDADEnztoqscgOf9nOgSx9KKO6Y+xkDRECnwEcmcbFA950v/laLR2
         K/muWUz0JkL0NFSwcxcVHcrPD8x1erUhmk7 
X-Received: by 10.49.86.40 with SMTP id m8mr297523qez.30.1363279601163;
        Thu, 14 Mar 2013 09:46:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.75.106 with SMTP id b10ls47560qew.51.gmail; Thu, 14 Mar
 2013 09:46:40 -0700 (PDT)
X-Received: by 10.52.16.140 with SMTP id g12mr1524106vdd.7.1363279599974;
        Thu, 14 Mar 2013 09:46:39 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id wc4si338173vdb.1.2013.03.14.09.46.39;
        Thu, 14 Mar 2013 09:46:39 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D904B8A7;
	Thu, 14 Mar 2013 12:46:39 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90FE6B8A6;
	Thu, 14 Mar 2013 12:46:39 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF8BEB8A3; Thu, 14 Mar 2013
 12:46:38 -0400 (EDT)
In-Reply-To: <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 14 Mar 2013 16:36:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDB32BD6-8CC6-11E2-B033-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218152>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> I wonder whether we want to have something like this instead:
>>
>>         flags = CURL_GLOBAL_ALL;
>>         if (prefixcmp(url, "https:"))
>>                 flags &= ^CURL_GLOBAL_SSL;
>>         curl_global_init(flags);
>>
>> I do see that CURL_GLOBAL_ALL is #define'd as CURL_GLOBAL_WIN32 |
>> CURL_GLOBAL_SSL in curl.h, but that might change in the future, no?
>
> Good suggestion. But perhaps we'd want to use CURL_GLOBAL_DEFAULT
> instead?

That as a follow-up suggestion may be fine but if you go that route,
you would need to explicitly flip SSL on when you know it is going
to an SSL destination.

The way to determine SSL-ness has to be rock solid and that is much
more important than ALL vs DEFAULT.  Is prefixcmp(url, "https://")
the right way to do so?  Do we use this codepath only for HTTPS, or
does anybody use other protocol cURL supports over SSL with this,
too?

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
