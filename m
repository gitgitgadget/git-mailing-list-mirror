From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 21/22] lockfile: extract a function reset_lock_file()
Date: Wed, 02 Apr 2014 15:37:14 +0200
Message-ID: <533C128A.9020406@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>	<1396367910-7299-22-git-send-email-mhagger@alum.mit.edu> <CAPig+cTEC6kgmgCcpcjaRNMf3gQVQGzBQx5i5A+EuDppH9VQxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:36:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeP2-0000xS-5k
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730AbaDBNhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 09:37:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63459 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758676AbaDBNhS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 09:37:18 -0400
X-AuditID: 1207440d-f79d86d0000043db-4a-533c128d7594
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D4.FB.17371.D821C335; Wed,  2 Apr 2014 09:37:17 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32DbEuX032027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 09:37:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <CAPig+cTEC6kgmgCcpcjaRNMf3gQVQGzBQx5i5A+EuDppH9VQxg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqNsrZBNscO+gkEXXlW4mi4beK8wW
	P1p6mC3OvGlkdGDxeNa7h9Hj4iVlj8UPvDw+b5ILYInitklKLCkLzkzP07dL4M542iZZMJWz
	4vK/O2wNjJvYuxg5OSQETCROvtgLZYtJXLi3nq2LkYtDSOAyo8T1KSuYIZxzTBLzdh1kAani
	FdCWmHj6PiOIzSKgKvFx2j1mEJtNQFdiUU8zE4gtKhAkcXjDKVaIekGJkzOfgPWKAPV+2LAJ
	rJdZIEvi+ZNZYPXCAp4SHza9hNp8kFHixOrFYCdxCgRKrDnwDKiZA+g8cYmexiCIXh2Jd30P
	mCFseYntb+cwT2AUnIVk3SwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZ
	opeaUrqJERLkvDsY/6+TOcQowMGoxMN78LxVsBBrYllxZe4hRkkOJiVRXjVgjAjxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4Z30yTpYiDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwftOEGioYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCiC44uBMQyS4gHa
	ywVyE29xQWIuUBSi9RSjLseGbWsamYRY8vLzUqXEeWtBdgiAFGWU5sGtgKW0V4ziQB8L8z4G
	qeIBpkO4Sa+AljABLeFeZwWypCQRISXVwNiYLjljipfHPNXVF6I3LkvYE/Dg3RGJvq2BwsXp
	5jVpJ/cvVF1+912w20FdQ8O/9l9F/UXOnLaRUH7Mdm918c6wJ/IPXuialIXHuU5M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245686>

On 04/02/2014 09:06 AM, Eric Sunshine wrote:
> On Tue, Apr 1, 2014 at 11:58 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  lockfile.c | 31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/lockfile.c b/lockfile.c
>> index 852d717..c06e134 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -85,6 +85,14 @@ static void remove_lock_file_on_signal(int signo)
>>         raise(signo);
>>  }
>>
>> +static void reset_lock_file(struct lock_file *lk)
>> +{
>> +       lk->fd = -1;
>> +       strbuf_setlen(&lk->filename, 0);
>> +       strbuf_setlen(&lk->staging_filename, 0);
> 
> strbuf_reset() perhaps?

Thanks, Eric.  For some reason I always have it in the back of my head
that strbuf_reset() frees the memory associated with the strbuf, but of
course that is strbuf_release() that I'm thinking of.

I just fixed all strbuf_setlen(..., 0) -> strbuf_reset(...) throughout
the patch series.  The fix will be in the re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
