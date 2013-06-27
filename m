From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 10:27:21 -0700
Message-ID: <7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit Mailinglist <msysgit@googlegroups.com>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB7HLWGHAKGQETOTUMQQ@googlegroups.com Thu Jun 27 19:27:28 2013
Return-path: <msysgit+bncBCG77UMM3EJRB7HLWGHAKGQETOTUMQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f185.google.com ([209.85.160.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB7HLWGHAKGQETOTUMQQ@googlegroups.com>)
	id 1UsFyf-0005LU-TE
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 19:27:26 +0200
Received: by mail-gh0-f185.google.com with SMTP id g22sf340954ghb.12
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=A9jswzvZAX+ucFUrLCMGJralQvBqkPQrn+ASOhtwPmo=;
        b=hbiwl+PPwPehocTJ7sOTpyqXk7QfNuIpLHujMZ6XwXx5mbO2RrQT1Q5Vlv6bPVMHL4
         E/uUCgYJLHJqpXGhERIZUh13EvfAomD5sy3hsRPztfVDD88ltQb1Eg03qIOq87C2qxj7
         DU3VW5espLF/+7vkuwuQBA4VbcNfbbHk1BGVDqwBUyX8o8oOFX8lwMrsK12BQPDda4Ju
         xb8WjQ+inbky7f5lq/q5piB9Ar2515/pfGdSOsqMKgmqRznZmAY+LZiyTO/5rVuXLwvb
         xidJFJ3XuIbKktjpgjGHP1rJAIPvIqdd0A2gisoXSsEpchLaxvGvXzZ12/u9/gkz8oLJ
         P0 
X-Received: by 10.49.120.67 with SMTP id la3mr252408qeb.35.1372354045072;
        Thu, 27 Jun 2013 10:27:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.17.98 with SMTP id n2ls923564qed.22.gmail; Thu, 27 Jun 2013
 10:27:24 -0700 (PDT)
X-Received: by 10.58.132.232 with SMTP id ox8mr1019993veb.18.1372354044444;
        Thu, 27 Jun 2013 10:27:24 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id k12si199720vdd.2.2013.06.27.10.27.24
        for <msysgit@googlegroups.com>;
        Thu, 27 Jun 2013 10:27:24 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B268293E8;
	Thu, 27 Jun 2013 17:27:24 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1047F293E6;
	Thu, 27 Jun 2013 17:27:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 618DC293E2;
	Thu, 27 Jun 2013 17:27:23 +0000 (UTC)
In-Reply-To: <CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 27 Jun 2013 18:41:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D423AC58-DF4E-11E2-AFA5-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229124>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Jun 27, 2013 at 6:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I vaguely recall that some people may have argued that git-foo is
>> one less exec(2) when we left these in our scripted Porcelains,
>> though, so on a platform with poorly performing fork/exec, this
>> change may be seen as detrimental.  I do not know it matters that
>> much.
>
> But isn't this only true for commands that are not built-ins? I.e., ...

Read "I do not know it matters that much." again ;-).

>> Git can evolve over time, and if that is really your plan, the first
>> step you have to take is to revive the old discussion we had after
>> v1.6.0:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/93511/focus=93825
>>
>> and see if it is now a good idea.  It could be in year 2014.  It was
>> not in 2008.
>
> Can I get around that discussion by adjusting the reasoning for the
> patch to mention consistency?

Taking "In principle I have no problem with this change, if nothing
other than for consistency reasons." and "I do have a huge issue
with the justification in the proposed log message." together, I
would reach the same conclusion ;-)

>> I cannot apply this exact patch for an obvious and unrelated reason;
>> it seems to have changes, e.g. "git am" option help, that do not
>> have anything to do with the topic.
>
> Well, if the topic was consistency the changes would be related, or?

The theme of the patch is "Do not call built-in aliases from scripts"
(by the way, do not call them "alias"---it is confusing as they are
not what people consider "alias").

> diff --git a/git-am.sh b/git-am.sh
> index 9f44509..ad67194 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
>  keep-non-patch  pass -b flag to git-mailinfo
> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
> independent of am.keepcr
> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
> independent of am.keepcr
>  c,scissors      strip everything before a scissors line
>  whitespace=     pass it through git-apply
>  ignore-space-change pass it through git-apply

> As you were saying yourself, we tell users to prefer the "git foo"
> form, so we should also do so in the "git am" option help, IMHO.

What does the above change to the options-help have anything to do
with that theme?  It does not seem to say anything about "git foo"
vs "git-foo"?

Confused...

>> For a future reroll of this patch with only "git-foo -> 'git foo'",
>> I would appreciate an independent review by at least one set of
>> eyes.  It is very easy to blindly do this conversion with sed/perl
>> and fail to spot misconversion before sending it out.
>
> At least the test suite (running on Linux) did not throw any failures
> at me after applying this patch.

Passing test may be a necessary condition to convince yourself that
the patch may not be so broken, but is not sufficient proof of
correctness, which can only come from careful code inspection.

In any case, thanks for working on this.

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
