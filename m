From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 3 Mar 2014 16:29:32 -0500
Message-ID: <CAPig+cTm-JXXC7raFmHWrG5fc54a7u4V9E5Zj71DTwWxZbb9OA@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
	<xmqqsiqznhpb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: He Sun <sunheehnus@gmail.com>, Faiz Kothari <faiz.off93@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKaQb-0007dI-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbaCCV3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:29:33 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:41259 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbaCCV3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:29:33 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so10559871ykp.6
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uL7SEMF1Menn+63XGQ+1dds1dzb63fcEQPAInxDc1yg=;
        b=F0bkwSxlmZIArZ85QQpnCgoA9vxmE5XYjVH6zuWUMu2u4e/5XP/YdN+QITbtkIQ6NY
         aot6e8J373XlpD8Rj9dkdLcJnS1Rf5wdmRZElRgg+vzzfKytr5js1PqS5FwOx7SqR0Z2
         3k4u4Y7Dmb+EcBzTsVzMaXalE33MlaPNM/1wegtvR85RjBoio3asX6YBasy98zuoBrak
         1AVhnf7zG1d/KYpaj23ez9HMXif4c8xV4WYK+wCjuVxleL2SFIh5Tawdrv8shkllF4vV
         DL5LHbvmeyi3UWxxaZx/uv2TtpDHJz6GsDa9Be6RFwq1pH0tzLlmkhgIEb3bERpVn2gQ
         sECA==
X-Received: by 10.236.126.81 with SMTP id a57mr4104026yhi.95.1393882172444;
 Mon, 03 Mar 2014 13:29:32 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 13:29:32 -0800 (PST)
In-Reply-To: <xmqqsiqznhpb.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: lzQhDNnXQnnax358ctGBuI1HIFI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243273>

On Mon, Mar 3, 2014 at 3:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Mon, Mar 3, 2014 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> It's not obvious from the patch fragment, but 'heads' is not a strbuf,
>>>> so Faiz correctly left this invocation alone.
>>>
>>> That is a very good sign why this change is merely a code-churn and
>>> not an improvement, isn't it?  We know (and any strbuf user should
>>> know) that ->buf and ->len are the ways to learn the pointer and the
>>> length the strbuf holds.  Why anybody thinks it is benefitial to
>>> introduce another function that is _only_ for writing out strbuf and
>>> cannot be used to write out a plain buffer is simply beyond me.
>>
>> As a potential GSoC student and newcomer to the project, Faiz would
>> not have known that this would be considered unwanted churn when he
>> chose the task from the GSoC microproject page [1]. Perhaps it would
>> be a good idea to retire this item from the list?
>
> I don't think I saw this on the microproject suggestion page when I
> last looked at it, and assumed that this was on the student's own
> initiative.

I also had not seen it earlier on the microprojects page and had the
same reaction until I re-checked the page and found that it had been
added [1].

The microprojects page already instructs students to indicate that a
submission is for GSoC [2] (and many have followed the advice), but
perhaps we can avoid this sort of misunderstanding in the future by
making it more explicit: for instance, tell them to add [GSoC] to the
Subject:.

[1]: https://github.com/git/git.github.io/commit/f314120a2b5e831459673c612a3630ad953d9954
[2]: https://github.com/git/git.github.io/blame/master/SoC-2014-Microprojects.md#L83

>> On the other hand, it did expose Faiz to the iterative code review
>> process on this project and gave him a taste of what would be expected
>> of him as a GSoC student, so the microproject achieved that important
>> goal, and thus wasn't an utter failure.
>>
>> [1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md
>
> Surely.
>
> I would have to say that this is not a good sample exercise to
> suggest to new students and I'd encourage dropping it from the list.
> You could argue that it is an effective way to cull people with bad
> design taste to mix suggestions to make the codebase worse and see
> who picks them, but I do not think it is very fair ;-)

Agreed. The item should be dropped from the list.
