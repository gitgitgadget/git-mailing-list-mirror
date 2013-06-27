From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 11:05:09 -0700
Message-ID: <7vmwqbsa3u.fsf@alter.siamese.dyndns.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
	<7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,  Git Mailing List <git@vger.kernel.org>,  msysGit Mailinglist <msysgit@googlegroups.com>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: John Szakmeister <john@szakmeister.net>
X-From: msysgit+bncBCG77UMM3EJRBWX5WGHAKGQEY3ZEAGY@googlegroups.com Thu Jun 27 20:05:17 2013
Return-path: <msysgit+bncBCG77UMM3EJRBWX5WGHAKGQEY3ZEAGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qe0-f56.google.com ([209.85.128.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBWX5WGHAKGQEY3ZEAGY@googlegroups.com>)
	id 1UsGZJ-0000Z4-BR
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 20:05:17 +0200
Received: by mail-qe0-f56.google.com with SMTP id 5sf172703qeb.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=/zXcfSwiXHs7kvkww6G2+JOLRNxCzqmiWmYgbKLyMrY=;
        b=zFS2EMlXMB/TNgX4M1OQjHHiK1Yak1FXKUmBYjcnhzd+gqcnBTS7A1ofq8cPWsPIP8
         NSt9cNfH0t/zUArWEHkAF7w4LPYEV9vQpISnOIKp8O/cEKFuuSAMOGgHsHxBE0H/F4Lo
         I/P4MfdAjdZnFCrpKtuZgwFJ++KFALbIFjVQ/aQvn58QFNbnPfx3vune+L1EdwmZirDZ
         2zdLYOJ59vmV7svWwj5j70ZeerTnJC/9VplrA9ddkt+wT1midDqbEg8vx0PGtjqBYTGy
         CSRIg9dnTSaDqwg7arPFWLjdki0qdw1cM8msfygonrKbTmWM7A7yj8QJdIiUwsTs3W/0
         d/ 
X-Received: by 10.50.126.67 with SMTP id mw3mr1375843igb.15.1372356316114;
        Thu, 27 Jun 2013 11:05:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.141.161 with SMTP id rp1ls4189igb.19.canary; Thu, 27 Jun
 2013 11:05:14 -0700 (PDT)
X-Received: by 10.66.27.17 with SMTP id p17mr3927246pag.1.1372356314497;
        Thu, 27 Jun 2013 11:05:14 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id sd8si681580pac.2.2013.06.27.11.05.14
        for <msysgit@googlegroups.com>;
        Thu, 27 Jun 2013 11:05:14 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 391272A91F;
	Thu, 27 Jun 2013 18:05:12 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3142A91D;
	Thu, 27 Jun 2013 18:05:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 362792A91C;
	Thu, 27 Jun 2013 18:05:11 +0000 (UTC)
In-Reply-To: <CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
	(John Szakmeister's message of "Thu, 27 Jun 2013 14:02:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BE1EAF0-DF54-11E2-9A91-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229137>

John Szakmeister <john@szakmeister.net> writes:

> On Thu, Jun 27, 2013 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
>>> diff --git a/git-am.sh b/git-am.sh
>>> index 9f44509..ad67194 100755
>>> --- a/git-am.sh
>>> +++ b/git-am.sh
>>> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>>>  u,utf8          recode into utf8 (default)
>>>  k,keep          pass -k flag to git-mailinfo
>>>  keep-non-patch  pass -b flag to git-mailinfo
>>> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
>>> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
>>> independent of am.keepcr
>>> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
>>> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
>>> independent of am.keepcr
>>>  c,scissors      strip everything before a scissors line
>>>  whitespace=     pass it through git-apply
>>>  ignore-space-change pass it through git-apply
>>
>>> As you were saying yourself, we tell users to prefer the "git foo"
>>> form, so we should also do so in the "git am" option help, IMHO.
>>
>> What does the above change to the options-help have anything to do
>> with that theme?  It does not seem to say anything about "git foo"
>> vs "git-foo"?
>
> I initially missed it too, but `git-mailsplit` changed to `git
> mailsplit` in the help.

Ahh, OK.

>  Now that I look at it more, I see that
> `git-mailinfo` was missed and there's a `git-apply` towards the
> bottom.  So I'm not sure it's helping the consistency argument.

Hmph, true.

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
