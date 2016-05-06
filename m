From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Fri, 6 May 2016 15:56:58 +0200
Message-ID: <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251704300.2896@virtualbox>
	<CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
	<572BA80E.3000309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 06 15:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aygFo-0003O7-IQ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915AbcEFN5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:57:01 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38119 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073AbcEFN5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:57:00 -0400
Received: by mail-wm0-f53.google.com with SMTP id g17so79379728wme.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9+sSYUGq/feIs0eeQKsm5b+FWk+zCzibmpFMtHNYdAI=;
        b=XbgltOM4bQ2RlajKS7ouIwLH1I5Lm4oDUZBT4403HE880qWOElLF1hxrPtrw9TKbVm
         BtXY72W62qHzKCMoaSkByqiGSaHrff8YDlcIWLNXLnORlQC+fVuqogtbC7dTfCQtn9sR
         cgFnja41+7KdAmHgrKMmZKZGuclBLR4s683XZECsBvNNI9MtG3Av6sY6gy7oJSEBq0vV
         dVhP24kf3kpIl8ZF6+zaRTljt2JbBQMutMt+eFFOf1hEeD6MtUcGaDt+n9id0ZIvHhSa
         olY9XawmgcQ/pidWNki1uz3qJt8XABKMLBthiHAXnIPJ2HjP4akLKDgj0Q9B4pLVaQIO
         h4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9+sSYUGq/feIs0eeQKsm5b+FWk+zCzibmpFMtHNYdAI=;
        b=isYg8dBVsis6MRgrEEcEwP6nLYbzAyStgwoDy0gEQzp4Rs0sTJe5IVL0N/RqkmUGH1
         mmOsYgIMWDsvILu+hpT0aJpN/iiWZi7FYJlbX3+9p+gfLseNmASwvl/KUEdNtuwrET47
         rzq7P3EQehUSJcqhDaUaGePfAXD8PcQfWNYIH/za5/GhLo6ZGpcUFuVL42/qB37QA26S
         M0s9unGNuUNDsbtKO+pf2oPLDFDe1DLEYjIKZF2HTQaalnfXELwNDNoetazyql/wRXRk
         XkF81hJxek+35nFG2SbnwVu3V1cuDqnl2YEOktMxsu+qDQYvzX3xMPwmEJ7WA/AamOio
         lQtw==
X-Gm-Message-State: AOPr4FVGOpRh1Gbet10dqKGgBs1y4AZfjBIcnoLifLQoc67J5OKsEIatYQHoEY+trHOgLFNEgR07KqSXHUowuQ==
X-Received: by 10.194.20.162 with SMTP id o2mr19990732wje.78.1462543019035;
 Fri, 06 May 2016 06:56:59 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 6 May 2016 06:56:58 -0700 (PDT)
In-Reply-To: <572BA80E.3000309@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293781>

On Thu, May 5, 2016 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.05.2016 um 11:50 schrieb Christian Couder:
>>
>> On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> Hi Chris,
>>>
>>> On Sun, 24 Apr 2016, Christian Couder wrote:
>>>
>>>> diff --git a/run-command.c b/run-command.c
>>>> index 8c7115a..29d2bda 100644
>>>> --- a/run-command.c
>>>> +++ b/run-command.c
>>>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>>>>   }
>>>>
>>>>   #ifndef GIT_WINDOWS_NATIVE
>>>> -static inline void dup_devnull(int to)
>>>> +void dup_devnull(int to)
>>>>   {
>>>
>>>
>>> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.
>>
>>
>> Yeah, but I must say that I don't know what I should do about this.
>> Do you have a suggestion? Should I try to implement the same function
>> for Windows?
>
> No, just remove the #ifndef brackets. There is already code in
> compat/mingw.c that treats the file name "/dev/null" specially.

Ok, I will do that in the same patch though the "#ifndef
GIT_WINDOWS_NATIVE" was already there before.

Thanks,
Christian.
