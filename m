From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] Consolidate code to close a pack's file descriptor
Date: Tue, 06 Oct 2015 15:42:34 +0200
Organization: gmx
Message-ID: <fb0ee65afcb4087de1137d27991dc896@dscho.org>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
 <a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
 <xmqqio6lxcci.fsf@gitster.mtv.corp.google.com>
 <b7d0f89bb94f88cb8d600a461dfe7ea1@dscho.org>
 <xmqq1td9x8pz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSVw-0002I5-Kh
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbbJFNml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:42:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:56904 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbbJFNmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:42:40 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzKQf-1aeDwQ3p9F-014Sbb; Tue, 06 Oct 2015 15:42:35
 +0200
In-Reply-To: <xmqq1td9x8pz.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:fxvHLxrFBZDmzqDsVI7HwNr4MYBH5o6ovu9AGai9dzCuvhx3LE3
 R1AvB5h7xCWerralElRvHo4VXlC8zQRQrcNCOf3w+87d9wwivd3GbBEmmN97+MUw1M+de/8
 yozSzwEbgGazGLUC6F0mmmPWM4P/qFkfyvRT2DZr7YfaawhdZ3EvdmDIF4VB0SC4X98mcVM
 FuYryfdxr7TQDd7vBEWDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OLMTlnV9V4Y=:ji3rHaJ1pbTWw/Hq5dyrfs
 rLGDawA4xLkmJIe8AaF104ZCCZTqrNxRcjvUufh9PWDACCXIL/mjw1RoxgylTI1R4cuNdlyg9
 LPpLGD9XxOKfptHRh+QGi2jyhit6VboDju0hvDCnJJshUZnWxfGL+y/8Q3amkYC2mzDun3HkH
 hvGV2ws54Krn5kZuVE2d14lvqMFdaZ1rdr2oNxWLWfjtySEdniwhCObyw75kBZicJk+fZk9O+
 fHPadWbLp0mrXaFFak/5oQL80cpob9BI7Im8seuCPRtV7B80dlpxGmCJPTaFWYo6CTLcKMs0i
 dwy1ZiftB0m5cXuhEckJhzHZ40rzL9e/wJr3bIfLC5yyA25Q+fF56/Fs6FzrI0vtHQcUTgjW4
 KlQJbHj30mZlQo2+mIYO2HUBCEairxXYeRE5gePeEDghheLX8IeqVXItHtU/eSIflHiWqCFMp
 sRJucCMs/PMfF8qoJMnGDkEXRNnBnrKpbonX8OJy1Hyd07mnfy4fy/aISaGHDVZAkZY6Up+ix
 93HkxVDGkmuY3TkEBG0QqduWP4UyxAdA7KMd5oGhg4dZcjPg1zGhHwXaCfVV6TP8wcEz5s3iL
 g5IaRMXB80YM2DyD5Xx1xQjYzAxUyjTG86a8MW3U5roDBR01jPSL+oNezJFCFIImWcmudHPDw
 6nZua0XIXV30ZBXbniFYjfW9W2oEzffRriG2obhObsytvdoQvHemPabrfL18SwIzaOfqIhZYV
 VNaMgWeuG0CoA2zH5SlRHgvAovQWphWnn4wdlrqTnH0PXzQhcX0HXezLVwM3wY5f+zXFZ2ti 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279142>

Hi Junio,

On 2015-10-06 00:15, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>>> +				&& !p->do_not_close)
>>>> +				close_pack_fd(p);
>>>
>>> I wonder how this do_not_close bit should interact with "we are
>>> shutting down (or we are spawning another to do the real work, while
>>> we won't do anything useful anymore), so close everything down".
>>
>> The `close_all_packs()` function is meant for the use case where you
>> really close all the packs, no question asked.
>>
>> I cannot think of a use case where it would make sense to try to be
>> gentle, yet still ask for *all* of the packs to be closed. Maybe you
>> can think of one to convince me that it might make sense to respect
>> the `do_not_close` flag in such a function? Because so far, I am
>> totally unconvinced.
> 
> Do not wait for being convinced forever, as I am not interested in
> convincing you either way.  Decision by made-up examples or lack of
> imagination is a waste of time ;-).
> 
> My earlier "I wonder" leads me to totally different conclusion,
> which is "we declare that it is a bug for any caller to call
> close-all-packs while marking any open pack with do_not_close bit".
> 
> Which merely means that while iterating over packs in the
> "close-all" loop, we should throw a die("BUG") at the caller if that
> bit is on.  That way, we won't have to rely on "we did not think of
> a good use case so we unconditionally closed the packs without
> telling the remainder of the system, hopefully we broke nothing."

I just sent another iteration out that adds this sanity check.

Ciao,
Dscho
