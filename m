From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/3] index-helper: fix UNIX_PATH_MAX redefinition error on
 cygwin
Date: Mon, 11 Apr 2016 14:30:23 +0100
Message-ID: <570BA6EF.7020202@ramsayjones.plus.com>
References: <570ADAEE.20201@ramsayjones.plus.com> <570B2605.4040305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 15:31:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apbvg-00072X-JT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 15:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbcDKNac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2016 09:30:32 -0400
Received: from avasout08.plus.net ([212.159.14.20]:41507 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbcDKNa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 09:30:29 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id h1WR1s0032D2Veb011WS4f; Mon, 11 Apr 2016 14:30:26 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=WlEEpt_-WZdgcFzQKRQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <570B2605.4040305@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291213>



On 11/04/16 05:20, Torsten B=C3=B6gershausen wrote:
> On 04/11/2016 12:59 AM, Ramsay Jones wrote:
> The header mentions cygwin, but changes it for linux, BSD and Mac OS =
as well.
> Is this intentional ?

Yes. I only compile on 32/64-bit linux and 64-bit cygwin these days, so=
 I only
noticed the warnings (yes I wrote error, but it should be warning) on c=
ygwin.
Other systems may suffer the same warnings, of course.

>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>   git-compat-util.h | 17 -----------------
>>   index-helper.c    |  4 ++--
>>   read-cache.c      |  2 +-
>>   3 files changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 0e35c13..c90c8c6 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1043,21 +1043,4 @@ struct tm *git_gmtime_r(const time_t *, struc=
t tm *);
>>   #define getc_unlocked(fh) getc(fh)
>>   #endif
>>   -#ifdef __linux__
>> -#define UNIX_PATH_MAX 108
>> -#elif defined(__APPLE__) || defined(BSD)
>> -#define UNIX_PATH_MAX 104
>> -#else
> Can we use a #elif __CYGWIN__ here to fix the re-definition just for =
cygwi ?

As I said in the cover letter, that is an option - but why bother with
UNIX_PATH_MAX at all?

ATB,
Ramsay Jones
