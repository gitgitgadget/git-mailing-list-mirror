From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Wed, 14 May 2014 10:57:54 -0700
Message-ID: <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBP65Z2NQKGQEHSSEGGQ@googlegroups.com Wed May 14 19:58:27 2014
Return-path: <msysgit+bncBCG77UMM3EJRBP65Z2NQKGQEHSSEGGQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f184.google.com ([209.85.220.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBP65Z2NQKGQEHSSEGGQ@googlegroups.com>)
	id 1WkdRh-0008N4-1k
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 19:58:25 +0200
Received: by mail-vc0-f184.google.com with SMTP id hq16sf593821vcb.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qna7pWpIE4V5Xmzhxso7LKKIFb3Wdl2vhzusLqWYKu0=;
        b=ZtS0O94xJ9kCBi7aJjjvMbOZ6lrPo6YNZ0rgmrsKJhf2jhFQI92tyB2SoNVe5Q8sSt
         7X1mePHdcws0ul1risW0LS5nmCVBOPU6H/etf+rHRa4PyBBohlpaJivBP/3nO6t0J+fa
         u61xnMx5GE7f7zruI3oRR+nN/7zIO8Adazxha3zwLuMw+c1PeOKcoVIlNj5K2kKISFiz
         JQce1ITrtGekKLjMNZI36kH0jQww2PaG59njB3LUYXJk1BmWZyE+1D9lvR2oSfWZm0IQ
         K2Qc2QnlQc1ncMqqww0ofddDGXd+j+1Mcq/ur4QNcZvviAfpjT4LhbhegWLtQKSFLFxa
         1N/g==
X-Received: by 10.50.20.129 with SMTP id n1mr877537ige.1.1400090304283;
        Wed, 14 May 2014 10:58:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.253.11 with SMTP id zw11ls1057705igc.3.gmail; Wed, 14 May
 2014 10:58:22 -0700 (PDT)
X-Received: by 10.42.62.11 with SMTP id w11mr2095000ich.29.1400090302857;
        Wed, 14 May 2014 10:58:22 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id k3si354205qcn.2.2014.05.14.10.58.22
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 10:58:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93734179BF;
	Wed, 14 May 2014 13:58:22 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8768D179BD;
	Wed, 14 May 2014 13:58:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F7C717969;
	Wed, 14 May 2014 13:57:56 -0400 (EDT)
In-Reply-To: <20140514155010.GA4592@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 14 May 2014 17:50:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 47364F72-DB91-11E3-8D2D-DDB853EDF712-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248930>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Tue, 8 Feb 2011 00:17:24 -0600
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> Hi,
> this patch has been in msysgit for 3 1/4 years.
>   Stepan
>
>  builtin/grep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8073fbe..6c82a29 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -897,6 +897,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		if (len > 4 && is_dir_sep(pager[len - 5]))
>  			pager += len - 4;
>  
> +		if (opt.ignore_case && !strcmp("less", pager))
> +			string_list_append(&path_list, "-i");

I have a feeling that this goes against the recent trend of not
mucking with the expectation of the users on their pagers, if I
recall correctly the arguments for dropping S from the default given
to an unconfigured LESS environment variable.

>  		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
>  			struct strbuf buf = STRBUF_INIT;
>  			strbuf_addf(&buf, "+/%s%s",
> -- 
> 1.9.2.msysgit.0.335.gd2a461f
>
> -- 

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
