From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/14] tempfile: add several functions for creating temporary
 files
Date: Mon, 10 Aug 2015 05:08:46 +0200
Message-ID: <55C815BE.4070309@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>	<a922fa6cfcc948d541b638d99e2413865ff051e2.1433751986.git.mhagger@alum.mit.edu> <xmqqmw07laio.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 05:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOdSk-0004US-73
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 05:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbbHJDI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 23:08:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45266 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752305AbbHJDI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2015 23:08:57 -0400
X-AuditID: 12074411-f797e6d000007df3-52-55c815c02c48
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 25.22.32243.0C518C55; Sun,  9 Aug 2015 23:08:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A38knx005569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 9 Aug 2015 23:08:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqmw07laio.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1D0oeiLU4EG1RdeVbiaLht4rzBY/
	WnqYHZg9nvXuYfS4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujOkTu9gLGvgrXhx8xtjAOJun
	i5GTQ0LAROLzmW2MELaYxIV769m6GLk4hAQuM0o8u76RFcI5xyRxs+kiC0gVr4C2xJMrU4A6
	ODhYBFQlrh1VAAmzCehKLOppZgIJiwoESbx+mQtRLShxcuYTsE4RATWJiW2HWEBKmAWMJOad
	rgcJCwtEShz/sRBq01ZGiU3fP7KBJDgFrCUaf15hBrGZBfQkdlz/xQphy0tsfzuHeQKjwCwk
	K2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJCwFdzBOOOk
	3CFGAQ5GJR7eGZuPhwqxJpYVV+YeYpTkYFIS5bUUPBEqxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYTX7yxQOW9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgjdKBGioYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChO44uBkQqS4gHaWwPSzltckJgLFIVoPcWo
	KCXOWwqSEABJZJTmwY2FJaNXjOJAXwrzLgWp4gEmMrjuV0CDmYAGh4cdARlckoiQkmpg5F3R
	2252MLO/5Z5gubZy0zGuDQ5huYzPwxSU9boVlLdMs5qh6vTwX+VxRb6I7E25W37M/1Pr8Vnq
	3rX1F0vehXJ/FPQxj1jeeDCITZUjUaeg71LLdBbveD6BhjZlU22HWs6ZGRnB2n69 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275560>

On 06/10/2015 07:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Add several functions for creating temporary files with
>> automatically-generated names, analogous to mkstemps(), but also
>> arranging for the files to be deleted on program exit.
>>
>> The functions are named according to a pattern depending how they
>> operate. They will be used to replace many places in the code where
>> temporary files are created and cleaned up ad-hoc.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  tempfile.c | 55 ++++++++++++++++++++++++++++++++++-
>>  tempfile.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 150 insertions(+), 1 deletion(-)
>>
>> diff --git a/tempfile.c b/tempfile.c
>> index f76bc07..890075f 100644
>> --- a/tempfile.c
>> +++ b/tempfile.c
>> @@ -48,7 +48,7 @@ static void register_tempfile_object(struct tempfile *tempfile, const char *path
>>  		tempfile->fp = NULL;
>>  		tempfile->active = 0;
>>  		tempfile->owner = 0;
>> -		strbuf_init(&tempfile->filename, strlen(path));
>> +		strbuf_init(&tempfile->filename, 0);
>>  		tempfile->next = tempfile_list;
>>  		tempfile_list = tempfile;
>>  		tempfile->on_list = 1;
> 
> This probably could have been part of the previous step.  Regardless
> of where in the patch series this change is done, I think it makes
> sense, as this function does not even know how long the final filename
> would be, and strlen(path) is almost always wrong as path is likely to
> be relative.
> 
> I notice this change makes "path" almost unused in this function,
> and the only remaining use is for assert(!tempfile->filename.len).
> Perhaps it is not worth passing the "path" parameter?

These are both good points. I will implement them in the upcoming v2.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
