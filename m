From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 11:10:01 -0700
Message-ID: <7vehbns9vq.fsf@alter.siamese.dyndns.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
	<7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
	<7vmwqbsa3u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,  Git Mailing List <git@vger.kernel.org>,  msysGit Mailinglist <msysgit@googlegroups.com>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: John Szakmeister <john@szakmeister.net>
X-From: msysgit+bncBCG77UMM3EJRB7H7WGHAKGQENMJMEXA@googlegroups.com Thu Jun 27 20:10:07 2013
Return-path: <msysgit+bncBCG77UMM3EJRB7H7WGHAKGQENMJMEXA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f183.google.com ([209.85.216.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB7H7WGHAKGQENMJMEXA@googlegroups.com>)
	id 1UsGdy-0005Lw-23
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 20:10:06 +0200
Received: by mail-qc0-f183.google.com with SMTP id a10sf349606qcx.20
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=IO56WoOvXBjbZL72d2Zl1IbZF9MfUk1vF6dun/b3zXE=;
        b=WPrtnVF8VzTUXRpQnNyPwAalvmZLgrsYYNt+xcD5G83Gx6nCmR1La5t73QCHuDDTnL
         jAKJT7qsFKJNSE+ALGvMYS2qsQcTE1MoxKmZn+KNy/vqAH66jhWaW/wDDigxfsyp2u7p
         DQFLrtFWL062HKFaTyZ70B7ZkGO9OjaoMsUW6itsOQKTTgF22bfykM8FX7i6ibMPF/sd
         0jyAZFqSRKbfh4t4LnojrV0Zzx3mJNPiUSqoSpJx72lVPwH0Jygg9aVt46g5w9twrxdS
         s65SWj8nz/43zwBp3IK0k8/2304yq3rEgIAH+OPgKEf5Xa2/fLJS+TGKVYWDT3lG0Vfy
         uw 
X-Received: by 10.49.35.109 with SMTP id g13mr258797qej.1.1372356605270;
        Thu, 27 Jun 2013 11:10:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.49.38 with SMTP id r6ls967425qen.91.gmail; Thu, 27 Jun 2013
 11:10:04 -0700 (PDT)
X-Received: by 10.58.220.131 with SMTP id pw3mr1149761vec.21.1372356604622;
        Thu, 27 Jun 2013 11:10:04 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id zg9si209348vdb.1.2013.06.27.11.10.04
        for <msysgit@googlegroups.com>;
        Thu, 27 Jun 2013 11:10:04 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42D782AB08;
	Thu, 27 Jun 2013 18:10:04 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 363722AB06;
	Thu, 27 Jun 2013 18:10:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CDD72AB02;
	Thu, 27 Jun 2013 18:10:02 +0000 (UTC)
In-Reply-To: <7vmwqbsa3u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Jun 2013 11:05:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9895F76-DF54-11E2-B3C5-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229139>

Junio C Hamano <gitster@pobox.com> writes:

> John Szakmeister <john@szakmeister.net> writes:
>
>> On Thu, Jun 27, 2013 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [snip]
>>>> diff --git a/git-am.sh b/git-am.sh
>>>> index 9f44509..ad67194 100755
>>>> --- a/git-am.sh
>>>> +++ b/git-am.sh
>>>> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>>>>  u,utf8          recode into utf8 (default)
>>>>  k,keep          pass -k flag to git-mailinfo
>>>>  keep-non-patch  pass -b flag to git-mailinfo
>>>> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
>>>> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
>>>> independent of am.keepcr
>>>> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
>>>> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
>>>> independent of am.keepcr
>>>>  c,scissors      strip everything before a scissors line
>>>>  whitespace=     pass it through git-apply
>>>>  ignore-space-change pass it through git-apply
>>>
>>>> As you were saying yourself, we tell users to prefer the "git foo"
>>>> form, so we should also do so in the "git am" option help, IMHO.
>>>
>>> What does the above change to the options-help have anything to do
>>> with that theme?  It does not seem to say anything about "git foo"
>>> vs "git-foo"?
>>
>> I initially missed it too, but `git-mailsplit` changed to `git
>> mailsplit` in the help.
>
> Ahh, OK.
>
>>  Now that I look at it more, I see that
>> `git-mailinfo` was missed and there's a `git-apply` towards the
>> bottom.  So I'm not sure it's helping the consistency argument.
>
> Hmph, true.

Having said that, I'd still prefer to see documentation changes in a
patch separate from a "do not call git-foo form" patch.

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
