From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 00/13] port tag.c to use ref-filter.c APIs
Date: Wed, 19 Aug 2015 00:55:43 +0530
Message-ID: <CAOLa=ZRHh-eDx__C=0qm+akzw5MAz0B-vAaYVwFFrqicgXV+fA@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com> <CAPig+cTauPEH5dTemwMcq0oE2WgKfcWKcK6-mvs8C7HUNqC4Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:26:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmWY-00039S-1X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbbHRT0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:26:14 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33212 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbHRT0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:26:13 -0400
Received: by oio137 with SMTP id 137so107495667oio.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m7zUF6DMknTXlSa4Em/x1R5zoqYrGqZWf2yHlt6TlcQ=;
        b=N1vZ1J/blQ/KTMYZDH20gqYwr6ATYuHRQ7yDEjcPWvgCwP6ihGqsjpaDLbCOGuZuRp
         hJJ8GzJ5udmflNIZcuEcnFXPT6ESPAAiS6h/GHB12AOkhq5ISaL+8ruaIOyGjv6WUCb5
         WxwZrC2pspuVQJaWSJLSDUQBIjHYkeWW1P1VFmgGRgdOkqTH/cvxbSH4AX3sSpl/dhQL
         6OvHgP3hZeGKYChKdzS4wk67XB4F6HtXwR/quMesajXQ5XEoWCMhFzj+q2gZ2G13rcbF
         +hb246z6O2qE4eU1fMxJn9mNiSS9t39hdWvgKD9GC3OgJtbHttKNy5WAB1fQ9kDrH2Yb
         MsYA==
X-Received: by 10.202.58.86 with SMTP id h83mr7023844oia.102.1439925972646;
 Tue, 18 Aug 2015 12:26:12 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 18 Aug 2015 12:25:43 -0700 (PDT)
In-Reply-To: <CAPig+cTauPEH5dTemwMcq0oE2WgKfcWKcK6-mvs8C7HUNqC4Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276157>

On Wed, Aug 19, 2015 at 12:48 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 18, 2015 at 2:37 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Version 11 was posted here:
>> http://article.gmane.org/gmane.comp.version-control.git/275997
>>
>> Changes in this version:
>> * Small style and formatting changes.
>> * Remove unnecessary variable from push_new_state().
>> * pop_state doesn't return a value now and attaches the buffer
>>   into the previous state.
>> * use strcmp() rather than starts_with() while checking for
>>   alignment position.
>> * Change attend to at_end
>>
>> Interdiff:
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 3099631..760d719 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -128,8 +128,8 @@ color::
>>         are described in `color.branch.*`.
>>
>>  align::
>> -       left-, middle-, or right-align the content between %(align:..)
>> -       and %(end). Followed by `:<position>,<width>`, where the
>> +       Left-, middle-, or right-align the content between %(align:..)
>> +       and %(end). Followed by `:<width>>,<position>`, where the
>
> I haven't had a chance to look closely at this version yet, but this
> popped out while quickly scanning the interdiff since the previous
> round had the same sort of problem:
>
>     s/>>/>/
>
>>         `<position>` is either left, right or middle and `<width>` is
>>         the total length of the content with alignment. If the
>>         contents length is more than the width then no alignment is

Weird, I thought I fixed that, I'll put in a squash.

-- 
Regards,
Karthik Nayak
