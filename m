From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 10:28:52 -0700
Message-ID: <7vip4tyjor.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <7vy5dqx913.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303141756100.3794@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,  git@vger.kernel.org, 
 msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBWERRCFAKGQEVFBY4YY@googlegroups.com Thu Mar 14 18:29:24 2013
Return-path: <msysgit+bncBCG77UMM3EJRBWERRCFAKGQEVFBY4YY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBWERRCFAKGQEVFBY4YY@googlegroups.com>)
	id 1UGBxw-0003kC-R8
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 18:29:20 +0100
Received: by mail-yh0-f64.google.com with SMTP id z6sf964880yhz.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:from:to:cc:subject
         :references:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=EK2YID39R+PnEIsJuAUaRsiBgOZ34g4WRIOjdq8BVlw=;
        b=VfENakxPmlP5+WuqBzVMAgPRqgE2mlO+anUmIxg00oK+PNrBMGy5rc5EMKSMqaoc3F
         mKf75POe83H/M2ahlpcJZvMpChRqQt/2EJJle0SaRqztl/7/cUFg5Z/tYv1jqAvOE/HD
         3zywaymzmeghXX/wfFV4RZ9IdKtMRjRT4CUy/MsDTHu3il9Xa8L2s/tHduHUqRKUVwTD
         H9T4LsdHS3hKeUvbnnP11zgd/UM3KdqkBcSG51yGn87Y6LXX4T2pKV/abDGMJq++0o2W
         RsQ9bGZ3IzHxyX/fpOBVivHyO4PmzduSxMG 
X-Received: by 10.50.160.132 with SMTP id xk4mr524308igb.7.1363282137601;
        Thu, 14 Mar 2013 10:28:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.195.129 with SMTP id ie1ls95779igc.35.gmail; Thu, 14 Mar
 2013 10:28:55 -0700 (PDT)
X-Received: by 10.68.196.134 with SMTP id im6mr1863384pbc.5.1363282135731;
        Thu, 14 Mar 2013 10:28:55 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id tj3si1297915pbc.0.2013.03.14.10.28.55;
        Thu, 14 Mar 2013 10:28:55 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B6CB8DD;
	Thu, 14 Mar 2013 13:28:54 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A27B8DC;
	Thu, 14 Mar 2013 13:28:54 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C6ADB8DA; Thu, 14 Mar 2013
 13:28:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1303141756100.3794@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Thu, 14 Mar 2013 17:57:43 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4FE149C-8CCC-11E2-89A5-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218155>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hence my earlier suggestion (with the obvious tyop '^' instead of '~').
> You will also find the information in my mail (unless you plonk my mails)
> that ...

Our mails simply crossed.  Comparing the two messages I think we are
in complete agreement.

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
