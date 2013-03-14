From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 09:04:24 -0700
Message-ID: <7vy5dqx913.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBC7KQ6FAKGQEBZZAHJY@googlegroups.com Thu Mar 14 17:04:55 2013
Return-path: <msysgit+bncBCG77UMM3EJRBC7KQ6FAKGQEBZZAHJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f184.google.com ([209.85.160.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBC7KQ6FAKGQEBZZAHJY@googlegroups.com>)
	id 1UGAeA-0002mq-VU
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 17:04:51 +0100
Received: by mail-gh0-f184.google.com with SMTP id f11sf940890ghb.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:from:to:cc:subject
         :references:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LnA78S/90jXLYzzFA5zQhYhqTA1Ar9CKWevAYHfs+4Y=;
        b=v/NYfMUEcJn3T6cGWHkI5GA1mrMkDpcWEF+pjvDdCtR76nLnkA/B3TLsHNP7rczfNK
         jf22b1V3gl7a4G4aJwfECMkN/o2VsWg0R4THGaHe/9ESd+NrQcCIimSHvMYPL0O+Q6o/
         NZmYcfLj+v55CWcEWq6HUHVxm7IB9l8ehNuiRWwKi3XgPsjffKbjKeUvI7lXluybDjQo
         vsrVN94haz7BUDxwleXKbIwGF7Joq/FDOY8UAHsw0+uBHWqoEvcV6XYhSjfvxTDUbrWs
         5JwNb0cvVbwhtABHA2WEWwXOeZPaP/kyO5h 
X-Received: by 10.50.5.197 with SMTP id u5mr3883573igu.0.1363277067849;
        Thu, 14 Mar 2013 09:04:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.152.165 with SMTP id uz5ls40902igb.34.gmail; Thu, 14 Mar
 2013 09:04:26 -0700 (PDT)
X-Received: by 10.68.132.73 with SMTP id os9mr1711377pbb.4.1363277066950;
        Thu, 14 Mar 2013 09:04:26 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id tj3si1209665pbc.0.2013.03.14.09.04.26;
        Thu, 14 Mar 2013 09:04:26 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C7EBC0C;
	Thu, 14 Mar 2013 12:04:26 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 289A9BC0B;
	Thu, 14 Mar 2013 12:04:26 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F89CBC09; Thu, 14 Mar 2013
 12:04:25 -0400 (EDT)
In-Reply-To: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Thu, 14 Mar 2013 14:51:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C1FF80-8CC0-11E2-8CA6-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218151>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> diff --git a/http.c b/http.c
> index 3b312a8..528a736 100644
> --- a/http.c
> +++ b/http.c
> @@ -343,7 +343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	git_config(http_options, NULL);
>  
> -	curl_global_init(CURL_GLOBAL_ALL);
> +	curl_global_init(CURL_GLOBAL_WIN32 | (prefixcmp(url, "https:") ? 0 :
> +	    CURL_GLOBAL_SSL));

The first and obvious question is what the symbol with a name
specific to one single platform doing in this generic codepath.
In order to get convinced that the patch does not regress, one
somehow need to know that bits in ALL other than WIN32 and SSL
do not matter (or there is no such bit).

I'd understand if it were "ALL & ~SSL" though.

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
