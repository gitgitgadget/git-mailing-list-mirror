From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 14:56:34 +0100
Message-ID: <CABPQNSZXAwQp-8M-6WQ_RdZMxwr_pm7EXOvrU3O8J4jaMWoegw@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBOVOQ6FAKGQE6RRYZ5A@googlegroups.com Thu Mar 14 14:57:43 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBOVOQ6FAKGQE6RRYZ5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qe0-f63.google.com ([209.85.128.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBOVOQ6FAKGQE6RRYZ5A@googlegroups.com>)
	id 1UG8f5-000528-5w
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 14:57:39 +0100
Received: by mail-qe0-f63.google.com with SMTP id q19sf844049qeb.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=rQpmKpt6YLesDvwNl0gc1CZ1mY+N0I6cEpCBc1xlRnU=;
        b=GcLRtAx+p5rzy1k0jfSOzHgeQSCmkpUidrcD2ZvKo/NDpRoHWJrb2P1AIqgklo1bNp
         O+Y8y0hxd6aF7ziT62NtcNJhuXKoNSnzkWStzNesSpSatx2H7K8YXgiX/tvs/FzGRShv
         LDy8EJK2Z+joRMBThVVbTN56JZLql56WWYGobd8yb3urh1GTvMwtvQtayU5lUJnCiqye
         uVuRZ77VbOo5N7yt6HHACedgnO9M9biYnHTEEnlsoOS1NNeXHR/Usc+9599h/SfTNwty
         fTVMTXO87HKc9OjlBNvRNWLgHY3D1PYc/9uqPtZCi7d 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=rQpmKpt6YLesDvwNl0gc1CZ1mY+N0I6cEpCBc1xlRnU=;
        b=lKC4EV+9YcFLbgHLPfwx8yWSNFmkKFbzMzqnYKEbRBlNkAIGr5I8hUzJVa/KOA9Pbx
         ZWpoJ1k2ewhqBl8XjzZJjotAJzLyBq4h9p3yR4GeEriw01vKeS2rbUIiim7vRfEAyYON
         Aw0PFeKF6vyK+5L4De0xLZyZZEkALQgTwB7XqplouKJqYwcO0TAMK0WdT7Tvr1TB/yyr
         h5mAHT19UWUgyIvMba3gidcgJVahbamh+ysKU4pKQ93Wi5BvLtgqGHs2rbxkdJsnICLd
         cfkzwabDO4L1k36lujynEqJ874E+Jga57u+0mcl5J4IsUtMvoj 
X-Received: by 10.50.33.175 with SMTP id s15mr3243490igi.8.1363269435963;
        Thu, 14 Mar 2013 06:57:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.217.137 with SMTP id oy9ls3388708igc.20.gmail; Thu, 14 Mar
 2013 06:57:14 -0700 (PDT)
X-Received: by 10.50.151.138 with SMTP id uq10mr18373165igb.1.1363269434430;
        Thu, 14 Mar 2013 06:57:14 -0700 (PDT)
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com [2607:f8b0:4001:c03::230])
        by gmr-mx.google.com with ESMTPS id m3si135286iga.2.2013.03.14.06.57.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 06:57:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::230 as permitted sender) client-ip=2607:f8b0:4001:c03::230;
Received: by mail-ie0-f176.google.com with SMTP id k13so2994452iea.35
        for <msysgit@googlegroups.com>; Thu, 14 Mar 2013 06:57:14 -0700 (PDT)
X-Received: by 10.50.88.228 with SMTP id bj4mr2259464igb.85.1363269434295;
 Thu, 14 Mar 2013 06:57:14 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Thu, 14 Mar 2013 06:56:34 -0700 (PDT)
In-Reply-To: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::230
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218138>

On Thu, Mar 14, 2013 at 2:51 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Since ancient times, we have been calling curl_global_init with the
> CURL_GLOBAL_ALL-flag, which initializes SSL (and the Win32 socket
> stack on Windows).
>
> Initializing SSL takes quite some time on Windows, so let's avoid
> doing it when it's not needed.
>
> timing of echo "" | ./git-remote-http.exe origin http://localhost
>
> before
>
> best of 10 runs:
> real    0m1.634s
> user    0m0.015s
> sys     0m0.000s
>
> worst of 10 runs:
> real    0m2.701s
> user    0m0.000s
> sys     0m0.000s
>
> after
>
> best of 10 runs:
> real    0m0.018s
> user    0m0.000s
> sys     0m0.000s
>
> worst of 10 runs:
> real    0m0.024s
> user    0m0.000s
> sys     0m0.015s
>
> Signed-off-by: Erik Faye-Lund <erik.faye-lund@hue.no>

Sorry, that sign-off has my wrong e-mail address. Please replace it with this:

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

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
