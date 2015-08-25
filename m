From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Tue, 25 Aug 2015 18:55:31 +0530
Message-ID: <CAOLa=ZQUANdHoKU5=MP8sGhh1ZSH_93zFWY2=Fpf--ru3Q03NA@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com> <CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
 <xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUEEt-0003ps-6e
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbbHYN0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 09:26:05 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36803 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbbHYN0C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 09:26:02 -0400
Received: by oiev193 with SMTP id v193so100346216oie.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lNKeDapd6LKr1z5a/tYapSHn3P5iXYGek/Y5fcA3e9s=;
        b=tcQCL74NtQ1JzmnGoMJYtYQs6wJS3iCER6wjquOLpHwLIQ4DMBhQIYmnxpCknUFoB3
         FCXf3wt8O4grE78JvVtvLiLMuLmL/cScde2mFUV5pU72W6rXQDET+Tle9Gal/DIIfmz3
         CoeQFdv7WE8N4OByYBxmu8PJIY9i/UOLrOp0cCNKfvO/PYuYkJ6gueSCzlQGv2fCyeRU
         Zb84i/9OxZqm0oERScFfHcGTWlHezi6jx8sCrrPMSs5QNYeUd2QmT7bxiG7aYRgBaErF
         Z9Gq1gO1lk1GACn95lZKbu59pmqqfQgujfak/mDThI/v7M2XNAD7KZANC0MsdSc6Y3yK
         hcKA==
X-Received: by 10.202.200.75 with SMTP id y72mr25582255oif.111.1440509161151;
 Tue, 25 Aug 2015 06:26:01 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 06:25:31 -0700 (PDT)
In-Reply-To: <xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276525>

On Tue, Aug 25, 2015 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>> ...
>>>> +     performed. If used with '--quote' everything in between %(align:..)
>>>> +     and %(end) is quoted.
>> ...
>> I might have misunderstood you, But based on the discussion held here
>> (thread.gmane.org/gmane.comp.version-control.git/276140)
>> I thought we wanted everything inside the %(align) .... %(end) atoms
>> to be quoted.
>
> Perhaps I misunderstood your intention in the doc.
>
> I took "everything in between %(align:...) and %(end) is quoted" to
> mean that
>
>         %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>
> can never satisfy %(if:empty), because %(align)%(end) would expand
> to a string that has two single-quotes, that is not an empty string.
>
> If that is not what would happen in the "branch --list" enhancement,
> then the proposed behaviour is good, but the above documentation would
> need to be updated when it happens, I think.  It at least is misleading.
>
> Thanks.

I'm not sure I checked this condition, will have a look at this, thanks for
pointing it out.

> OK, now I checked the code, and I _think_ the recursive logic is
> doing the right thing (modulo minor nits on comment-vs-code
> discrepancy and code structure I sent separately).

I'm not so sure about that, I'll get back on this. (I didn't think about empty
string alignment and its effect on %(if:empty) and so on).

-- 
Regards,
Karthik Nayak
