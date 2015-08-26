From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 15:37:07 +0530
Message-ID: <CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com> <CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
 <xmqq8u904ix0.fsf@gitster.dls.corp.google.com> <xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 12:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUXcU-0002TR-6x
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 12:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbHZKHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 06:07:38 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36423 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbHZKHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 06:07:37 -0400
Received: by obkg7 with SMTP id g7so166678628obk.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JaksuExRl55uAw+Qy/9gdH2WlMIo22lwT0gLXqDhKng=;
        b=W+wHZPNgjmg6prkfUlVnAstScupMnRDi9QC/0e8U92cafm707Knur0CWxEE31BfnqM
         HPQvIRfM1qF4dT1ncNeZpX77qPfHqLeaeO1gke0loylEK5xvPH44pVsBkNUOPuMab+bn
         kA8GQzmypKvXp+kkncUkXSO5wAh8MVHOOR4okr/2AfgwhvzapgRTHfc6QqGOnHSPcW/u
         A/cFugI7x7wY3Shh7AbxUomPaLb8iJoO2ntsgIC5DRtNi8U1GrkW2IoekM2fZ93npbFZ
         cuEimZ2XhU0E3eFf0CPzHjrQB+w86IY4jtM/V2zEFvJTm14L5FtKbVYLYpzlNvH/x8en
         +yFg==
X-Received: by 10.182.153.161 with SMTP id vh1mr31051608obb.34.1440583656914;
 Wed, 26 Aug 2015 03:07:36 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 26 Aug 2015 03:07:07 -0700 (PDT)
In-Reply-To: <xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276604>

On Tue, Aug 25, 2015 at 4:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>> ...
>>>>> +     performed. If used with '--quote' everything in between %(align:..)
>>>>> +     and %(end) is quoted.
>>> ...
>>> I might have misunderstood you, But based on the discussion held here
>>> (thread.gmane.org/gmane.comp.version-control.git/276140)
>>> I thought we wanted everything inside the %(align) .... %(end) atoms
>>> to be quoted.
>>
>> Perhaps I misunderstood your intention in the doc.
>>
>> I took "everything in between %(align:...) and %(end) is quoted" to
>> mean that
>>
>>       %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>
>> can never satisfy %(if:empty), because %(align)%(end) would expand
>> to a string that has two single-quotes, that is not an empty string.
>>
>> If that is not what would happen in the "branch --list" enhancement,
>> then the proposed behaviour is good, but the above documentation would
>> need to be updated when it happens, I think.  It at least is misleading.
>
> OK, now I checked the code, and I _think_ the recursive logic is
> doing the right thing (modulo minor nits on comment-vs-code
> discrepancy and code structure I sent separately).
>

For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
would print non-empty, I guess the documentation holds in that case.
Not sure if we require it to print non-empty.

-- 
Regards,
Karthik Nayak
