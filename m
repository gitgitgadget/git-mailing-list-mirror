From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Thu, 17 Jan 2013 16:07:05 -0500
Message-ID: <CABVa4NhK3FR-NsTq6Vt6yrgneQmMxF5ANmN6pF8k3fHeOLd0JA@mail.gmail.com>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-3-git-send-email-greened@obbligato.org>
	<7v623ga8vs.fsf@alter.siamese.dyndns.org>
	<87sj6kfsbz.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Thu Jan 17 22:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvwgM-0004oP-Qi
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 22:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab3AQVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 16:07:08 -0500
Received: from mail-vb0-f41.google.com ([209.85.212.41]:35605 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab3AQVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 16:07:07 -0500
Received: by mail-vb0-f41.google.com with SMTP id l22so3018978vbn.28
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DnbLMlkp5XqJkzI5/4g76ZvTNcIuWP69Y8OWmDcqDWU=;
        b=PAji8m01DNIC6RY/OuTSqJEVWDP56fNJZ3mkfzarggN5Il3i0Ea2C3UC+Z13KkuGaB
         s6ZVcXm672Ll9U3/cojqysm6h3y2NeO/T5Uiv589GU7wDvASZjo7AhVUPy64OD/Q5vYu
         kBI7lvDslNeNE6vF78loNQhKUYqZudXxpNu1wz4NuszxA/6siB9kob2lrXamWV+StLK9
         DFUWld90JeHcmtMXOEhKR40MtoesmDX692xYsYsrOsuYhNU5CRuYme7eGSHTrIogD2ZM
         F9Tslzs+ugedByftzmeqnRX30HrE4sejkg9D5vJ5wzcoh5w8krqvh6ferwASMk5lSiKe
         obOQ==
X-Received: by 10.52.76.170 with SMTP id l10mr6215291vdw.83.1358456825836;
 Thu, 17 Jan 2013 13:07:05 -0800 (PST)
Received: by 10.220.125.65 with HTTP; Thu, 17 Jan 2013 13:07:05 -0800 (PST)
In-Reply-To: <87sj6kfsbz.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213880>

On Tue, Jan 1, 2013 at 5:31 PM,  <greened@obbligato.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "David A. Greene" <greened@obbligato.org> writes:
>>
>>> From: James Nylen <jnylen@gmail.com>
>>>
>>> Teach git-subtree about --unannotate.  This option strips a prefix
>>> from a commit message when doing a subtree split.
>>
>> Hrm.  This looks like a workaround for a short-sighted misdesign of
>> the annotate option that only allowed prefixing a fixed string.  I
>> have to wonder if it is better to deprecate --annotate and replace
>> it with a more general "commit log rewriting" facility that can
>> cover both use cases?
>
> That's not a bad idea.  I'd have to think a bit about a sensible design.
> Do you have any ideas, James?

I just now saw these emails.  I'm having a hard time thinking of any
good use case other than:

 - add "fancylib" as a subtree of "myprog"
 - commit to myprog repo: "fancylib: don't crash as much"
 - split these commits back out to fancylib's main repo, and remove
the "fancylib: " prefix

You could potentially have something like "Don't crash as much
(fancylib)" but that's awkward.  What might you want to do with a
pattern-based rewrite that doesn't involve removing a prefix when
splitting commits?

In fact, I don't see the use of the original --annotate option at all,
since it causes more detailed commit messages in the smaller of the
two repositories.
