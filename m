From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Thu, 5 May 2016 22:07:42 +0200
Message-ID: <572BA80E.3000309@kdbg.org>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
 <alpine.DEB.2.20.1604251704300.2896@virtualbox>
 <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPYs-0002zg-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913AbcEEUHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:07:48 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:13679 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756836AbcEEUHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:07:47 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3r15YW4hB7z5tlH;
	Thu,  5 May 2016 22:07:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id DC7575264;
	Thu,  5 May 2016 22:07:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293674>

Am 05.05.2016 um 11:50 schrieb Christian Couder:
> On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Chris,
>>
>> On Sun, 24 Apr 2016, Christian Couder wrote:
>>
>>> diff --git a/run-command.c b/run-command.c
>>> index 8c7115a..29d2bda 100644
>>> --- a/run-command.c
>>> +++ b/run-command.c
>>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>>>   }
>>>
>>>   #ifndef GIT_WINDOWS_NATIVE
>>> -static inline void dup_devnull(int to)
>>> +void dup_devnull(int to)
>>>   {
>>
>> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.
>
> Yeah, but I must say that I don't know what I should do about this.
> Do you have a suggestion? Should I try to implement the same function
> for Windows?

No, just remove the #ifndef brackets. There is already code in 
compat/mingw.c that treats the file name "/dev/null" specially.

-- Hannes
