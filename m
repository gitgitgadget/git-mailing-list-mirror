From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 10:07:42 +0200
Message-ID: <55E016CE.3070009@kdbg.org>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
 <20150827215014.GA8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jose F. Morales" <jfmcjf@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVEhd-0001Wf-5V
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 10:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbH1IHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 04:07:50 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:6696 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbbH1IHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 04:07:46 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3n2YSc0RHsz5tlG;
	Fri, 28 Aug 2015 10:07:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CE10A52EB;
	Fri, 28 Aug 2015 10:07:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150827215014.GA8165@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276708>

Am 27.08.2015 um 23:50 schrieb Jonathan Nieder:
> Johannes Schindelin wrote:
>
>> From: jfmc <jfmcjf@gmail.com>
>
> This means the name shown by git shortlog would be jfmc instead of
> Jose F. Morales.  Intended?
>
>> The code to open and test the second end of the pipe clearly imitates
>> the code for the first end. A little too closely, though... Let's fix
>> the obvious copy-edit bug.
>>
>> Signed-off-by: Jose F. Morales <jfmcjf@gmail.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>   compat/mingw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> This is an old one --- more than 5 years old (since v1.7.0-rc0~86^2~4
> "Windows: simplify the pipe(2) implementation", 2010-01-15).  Thanks
> for catching it.

Ouch! Thanks for cleaning up the mess I left behind.

-- Hannes

>
> Regards,
> Jonathan
>
> (patch kept unsnipped for reference)
>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 496e6f8..f74da23 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -681,7 +681,7 @@ int pipe(int filedes[2])
>>   		return -1;
>>   	}
>>   	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
>> -	if (filedes[0] < 0) {
>> +	if (filedes[1] < 0) {
>>   		close(filedes[0]);
>>   		CloseHandle(h[1]);
>>   		return -1;
>>
