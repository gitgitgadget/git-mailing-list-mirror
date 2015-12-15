From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 17:42:40 +0100
Message-ID: <CAP8UFD1g_jZuZdrPs4V1w5Pgtaq9_1NeLkqA5gSGmRQz79bsQA@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
	<566FE228.8040708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 15 17:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sgb-0000sJ-3c
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbbLOQmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 11:42:44 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36554 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbbLOQmm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 11:42:42 -0500
Received: by mail-lf0-f47.google.com with SMTP id z124so6137941lfa.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gX0AJ+X+CkIZRIl7VvzsD8W8Ym54bSr787bM3Dgajjk=;
        b=TEfT0MD20IPme5c6WYT5u6yxI/OsEdlRWZQ5Z3nNlycp26pPAPbLIsWoe8DTyfYOuh
         NJbIFdwZMqZ1IEwFg/uCigfJj8Xvz7KoLQ4lH0VbybXtcr4ZuSZCFARJFJX2tbYTe1WL
         2+8f0Sjr66qPvWo9SN/KCW8PcNVihZNtV+EegnvTC9jwCurkmd8nRsAXZqS63HvnvLeI
         Zdc5oaWQwmzL5sOcXqdXvspgRj2UH5rPhV2hVsXwY7JFDO5N/1Dx9WBy/s+KDw/8hYNU
         rRwAdH0XSarnGv6JuWT70EGi2ROjRC95PPVqafF8gc2PTF9a1whO/oROrhWtQ/cdN8tx
         zh+Q==
X-Received: by 10.25.163.85 with SMTP id m82mr16097854lfe.76.1450197761080;
 Tue, 15 Dec 2015 08:42:41 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 15 Dec 2015 08:42:40 -0800 (PST)
In-Reply-To: <566FE228.8040708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282493>

On Tue, Dec 15, 2015 at 10:49 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 15.12.15 10:34, Christian Couder wrote:
>> On Mon, Dec 14, 2015 at 10:30 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>> The primary reason why I do not like your "configuration decides" i=
s
>>> it will be a huge source of confusions and bugs.  Imagine what
>>> should happen in this sequence, and when should a stale cached
>>> information be discarded?
>>>
>>>  - the configuration is set to 'yes'.
>>>  - the index is updated and written by various commands.
>>>  - more work is done in the working tree without updating the index=
=2E
>>>  - the configuration is set to 'no'.
>>>  - more work is done in the working tree without updating the index=
=2E
>>>  - the configuration is set to 'yes'.
>>>  - more work is done in the working tree without updating the index=
=2E
>>>  - somebody asks "what untracked paths are there?"
>>
>
>> As far as I understand the UC just stores the mtime of the directori=
es
>> in the working tree to avoid the need of lstat'ing all the files in
>> the directories.
>
> This is what I understand:
> UC stores the mtime of the directories in the working tree to avoid t=
he need
> opendir() readdir() closedir() to find new, yet untracked, files.
> (including sub-directories)

I think you are probably right too.

In the v2 patch series I just sent, there is:

+This feature works by recording the mtime of the working tree
+directories and then omitting reading directories and stat calls
+against files in those directories whose mtime hasn't changed.

I hope it is better.

Thanks,
Christian.
