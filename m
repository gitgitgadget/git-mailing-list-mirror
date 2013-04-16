From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/33] refs: extract a function ref_resolves_to_object()
Date: Tue, 16 Apr 2013 11:27:36 +0200
Message-ID: <516D1988.5060501@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-11-git-send-email-mhagger@alum.mit.edu> <7v7gk3zqhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US2Ay-0001Bz-4s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab3DPJ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:27:40 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:43816 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755850Ab3DPJ1j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 05:27:39 -0400
X-AuditID: 12074414-b7fb86d000000905-07-516d198aa6b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 69.0B.02309.A891D615; Tue, 16 Apr 2013 05:27:38 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3G9Ras3018675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 05:27:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v7gk3zqhc.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqNslmRtocPWRjEXXlW4mi4beK8wW
	Kx/fZbb40dLD7MDi0f7+HbPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd8WD5TraC
	9zIVn3+2Mjcwdot1MXJwSAiYSEx5Jt/FyAlkiklcuLeerYuRi0NI4DKjRPO2jUwQznEmicuH
	tzCBVPEKaEvcnH6TGcRmEVCV+LZmIZjNJqArsainGaxGVCBMYtX6ZcwQ9YISJ2c+YQGxRQTU
	JCa2HWIBWcwsECNx7qoQSFhYwEdiScMFqF0rGCWa9r1nA0lwCphJzDs/FWwOs4COxLu+B1C2
	vMT2t3OYJzAKzEKyYhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0rXQy80s0UtN
	Kd3ECAlnkR2MR07KHWIU4GBU4uFdqZgTKMSaWFZcmXuIUZKDSUmUN1U8N1CILyk/pTIjsTgj
	vqg0J7X4EKMEB7OSCK/6cqBy3pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkO
	DiUJ3hgJoKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoEiNLwbGKkiKB2ivFUg7
	b3FBYi5QFKL1FKMux8orT14zCrHk5eelSonzmoMUCYAUZZTmwa2AJa9XjOJAHwvzKoJU8QAT
	H9ykV0BLmICWHFiVDbKkJBEhJdXA2CjUl1KdqeVm0FYVeMDsW6byr4zUP7Hy6hrh2qa215R3
	7br+q+f3IpkPNwykjto3n+Z6/+HEOeuNNy57MtV9mX/TdiaDcHFXj0h78dqD1xa4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221400>

On 04/15/2013 06:51 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> It is a nice unit of work and soon will be needed from multiple
>> locations.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 28 ++++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index c523978..dfc8600 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -529,6 +529,22 @@ static void sort_ref_dir(struct ref_dir *dir)
>>  #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
>>  
>>  /*
>> + * Return true iff the reference described by entry can be resolved to
>> + * an object in the database.  Emit a warning if the referred-to
>> + * object does not exist.
>> + */
>> +static int ref_resolves_to_object(struct ref_entry *entry)
>> +{
>> +	if (entry->flag & REF_ISBROKEN)
>> +		return 0;
>> +	if (!has_sha1_file(entry->u.value.sha1)) {
>> +		error("%s does not point to a valid object!", entry->name);
>> +		return 0;
>> +	}
>> +	return 1;
>> +}
>> +
>> +/*
>>   * current_ref is a performance hack: when iterating over references
>>   * using the for_each_ref*() functions, current_ref is set to the
>>   * current reference's entry before calling the callback function.  If
>> @@ -549,14 +565,10 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
>>  	if (prefixcmp(entry->name, base))
>>  		return 0;
>>  
>> -	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
>> -		if (entry->flag & REF_ISBROKEN)
>> -			return 0; /* ignore broken refs e.g. dangling symref */
>> -		if (!has_sha1_file(entry->u.value.sha1)) {
>> -			error("%s does not point to a valid object!", entry->name);
>> -			return 0;
>> -		}
>> -	}
>> +	if (!((flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
>> +	      ref_resolves_to_object(entry)))
>> +		return 0;
>> +
> 
> The original says "Unless flags tell us to include broken ones,
> return 0 for the broken ones and the ones that point at invalid
> objects".
> 
> The updated says "Unless flags tell us to include broken ones or the
> ref is a good one, return 0".
> 
> Are they the same?  If we have a good one, and if we are not told to
> include broken one, the original just passes the control down to the
> remainder of the function.  The updated one will return 0.
> 
> Oh, wait, that is not the case.  The OR is inside !( A || B ), so
> what it really wants to say is:
> 
> 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
>             !ref_resolves_to_object(entry))
> 		return 0;
> 
> that is, "When we are told to exclude broken ones and the one we are
> looking at is broken, return 0".
> 
> Am I the only one who was confused with this, or was the way the
> patch wrote this logic unnecessarily convoluted?

I find either way of writing it hard to read quickly.  I find that the
construct

    if (!(situation in which the function should continue))
        return

makes it easier to pick out the "situation in which the function should
continue".  But granted, the nesting of multiple parentheses across
lines compromises the clarity.

In projects where I can choose the coding standard, I like to use extra
whitespace to help the eye pick out the range of parentheses, like

        if (!(
                (flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
                ref_resolves_to_object(entry)
                ))
                return 0;

but I've never seen this style in the Git project so I haven't used it here.

Since you prefer the other version, I will change it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
