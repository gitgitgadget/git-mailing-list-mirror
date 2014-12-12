From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 20/23] reflog_expire(): new function in the reference
 API
Date: Fri, 12 Dec 2014 09:23:05 +0100
Message-ID: <548AA5E9.9090201@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-21-git-send-email-mhagger@alum.mit.edu> <20141208233217.GL25562@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:23:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLVS-0006Yd-VF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbaLLIXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:23:16 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64675 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281AbaLLIXP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:23:15 -0500
X-AuditID: 1207440d-f79976d000005643-76-548aa5ec9136
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.B9.22083.CE5AA845; Fri, 12 Dec 2014 03:23:08 -0500 (EST)
Received: from [192.168.69.130] (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8N6dl021867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:23:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141208233217.GL25562@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqPtmaVeIQfcSc4uuK91MFg29V5gt
	3t5cwmjR2/eJ1WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFHcNkmJJWXBmel5+nYJ3BnP
	p29mK1ghU7Fw/1zWBsYvol2MnBwSAiYSe6/cY4ewxSQu3FvP1sXIxSEkcJlR4szsDlYI5yyT
	xL23j9lAqngFtCVWHulhAbFZBFQlzm5rAIuzCehKLOppZgKxRQWCJE7uuc4OUS8ocXLmE7B6
	EQE1iZmrZoNtYBaYxiix8f0qsAZhAX+J3l2HoLYtYpToPP0abCqngIHEzq9HwCYxC+hJ7Lj+
	ixXClpdo3jqbeQKjwCwkS2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzM
	Er3UlNJNjJDg5t3B+H+dzCFGAQ5GJR7eCcldIUKsiWXFlbmHGCU5mJREeb9PBgrxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4f0bBZTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnw+i4BahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWt8MTBiQVI8QHsj
	QNp5iwsSc4GiEK2nGBWlxHnbQRICIImM0jy4sbCU9YpRHOhLYd5JIFU8wHQH1/0KaDAT0ODl
	WzpABpckIqSkGhizF7a1dSw4xBq20zzlTUrfwgcHJv/57uxbb3JgWur3/3NZF73JkHIy38l9
	ZO7h766/2DML15f5Hp7FcTDufXqU56mi0DMppxW+XTJSNWh+E/PHLkuuwGTjvLyF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261310>

On 12/09/2014 12:32 AM, Stefan Beller wrote:
> On Fri, Dec 05, 2014 at 12:08:32AM +0100, Michael Haggerty wrote:
>> Move expire_reflog() into refs.c and rename it to reflog_expire().
>> Turn the three policy functions into function pointers that are passed
>> into reflog_expire(). Add function prototypes and documentation to
>> refs.h.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> With or without the nits fixed
> Reviewed-by: Stefan Beller <sbeller@google.com>
> as the nits are not degrading functionality.
> 
>> ---
>>  builtin/reflog.c | 133 +++++++------------------------------------------------
>>  refs.c           | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>>  refs.h           |  45 +++++++++++++++++++
>>  3 files changed, 174 insertions(+), 118 deletions(-)
>>
> 
> 
> 
>> +static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>> +		const char *email, unsigned long timestamp, int tz,
>> +		const char *message, void *cb_data)
> 
> Nit: According to our Codingguidelines we want to indent it further, so it aligns with
> the arguments from the first line.

Will fix.

> +static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
> +                             const char *email, unsigned long timestamp, int tz,
> +                             const char *message, void *cb_data)
> 
>> +	}
>> +	return 0;
> 
> Why do we need the return value for expire_reflog_ent?
> The "return 0:" at the very end of the function is the only return I see here.

expire_reflog_ent() is passed to for_each_reflog_ent() and therefore
must be an each_reflog_ent_fn. If it returns a nonzero value, the
iteration is ended prematurely and the value is returned to the caller
of for_each_reflog_ent(). We don't ever want to end the iteration
prematurely here, so we always return 0.

>> +enum expire_reflog_flags {
>> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
>> +	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
>> +	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
>> +	EXPIRE_REFLOGS_REWRITE = 1 << 3
>> +};
> 
> Sometimes we align the assigned numbers and sometimes we don't in git, so an alternative would be
> 
> enum expire_reflog_flags {
>      EXPIRE_REFLOGS_DRY_RUN    = 1 << 0,
>      EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
>      EXPIRE_REFLOGS_VERBOSE    = 1 << 2,
>      EXPIRE_REFLOGS_REWRITE    = 1 << 3
> }
> 
> Do we have a preference in the coding style on this one?

Both styles are used in our codebase, and I don't think the style guide
says anything about it. My practice in such cases is:

* If I'm modifying existing code, preserve the existing style (to avoid
unnecessary churn)
* If most of our code uses one style, then use that style
* If our code uses both styles frequently, just use whatever style looks
better to me

If and when somebody cares enough to build a consensus for one policy or
the other and to submit a patch to the CodingGuidelines I will be happy
to follow it.

>> + *
>> + * reflog_expiry_select_fn -- Called once for each entry in the
>> + *     existing reflog. It should return true iff that entry should be
>> + *     pruned.
> 
> Also I know how we got here, I wonder if we should inverse the logic here
> (in a later patch). "select" sounds to me as if the line is selected to keep it.
> However the opposite is true. To actually select (keep) the line we need to return
> 0. Would it make sense to rename this to reflog_expiry_should_prune_fn ?

Yes, that would be clearer. I will make the change.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
