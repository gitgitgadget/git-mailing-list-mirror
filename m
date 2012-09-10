From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/6] string_list: add function string_list_append_nodup()
Date: Tue, 11 Sep 2012 00:03:29 +0200
Message-ID: <504E63B1.2070100@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu> <1347311926-5207-2-git-send-email-mhagger@alum.mit.edu> <7vpq5tleyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBC50-000563-G8
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab2IJWDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:03:35 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:47825 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765Ab2IJWDe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 18:03:34 -0400
X-AuditID: 1207440c-b7f616d00000270b-ad-504e63b3d833
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A4.79.09995.3B36E405; Mon, 10 Sep 2012 18:03:31 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8AM3TPm022091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 18:03:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vpq5tleyo.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqLs52S/A4NJ/DYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bk7dk5gLTjJWfHy+Dr2BsYf
	7F2MnBwSAiYSb768hrLFJC7cW8/WxcjFISRwmVFi6vo97BDOaSaJbzuOMIFU8QpoS8yf/5wF
	xGYRUJX4f2o1G4jNJqArsainGaxGVCBEYsblycwQ9YISJ2c+AasXEVCTmNh2CMjm4GAWMJKY
	d7oeJCwsECBx/dEUqMVLGSXuTzrECpLgFDCTOL13FpjNLKAj8a7vATOELS+x/e0c5gmMArOQ
	rJiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUKCl2cH47d1
	MocYBTgYlXh4NXn8AoRYE8uKK3MPMUpyMCmJ8u6MBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS
	4Y3XBMrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4uYFRKiRYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitX4YmC0gqR4gPYeSwLZW1yQmAsUhWg9xajL
	cffjivuMQix5+XmpUuK8L0GKBECKMkrz4FbAUtUrRnGgj4V5X4FU8QDTHNykV0BLmICW+Hr4
	gCwpSURISTUwTjwhrqGjJjzxE9Pu8PUhrvcM3v4U5vnB7te9YOLvznl6jBd4GF/oHVyYEv7O
	K7aM5UjyRRvt8+6OFWJmE9hEp8pefvFlsvY03hdXtqi2LrdZFdX0cH7KKhPdMrlH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205201>

On 09/10/2012 11:56 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> diff --git a/string-list.c b/string-list.c
>> index d9810ab..5594b7d 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -148,13 +148,23 @@ void print_string_list(const struct string_list *p, const char *text)
>>  		printf("%s:%p\n", p->items[i].string, p->items[i].util);
>>  }
>>  
>> -struct string_list_item *string_list_append(struct string_list *list, const char *string)
>> +struct string_list_item *string_list_append_nodup(struct string_list *list,
>> +						  char *string)
>>  {
>> +	struct string_list_item *retval;
>>  	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
>> -	list->items[list->nr].string =
>> -		list->strdup_strings ? xstrdup(string) : (char *)string;
>> -	list->items[list->nr].util = NULL;
>> -	return list->items + list->nr++;
>> +	retval = &list->items[list->nr++];
>> +	retval->string = (char *)string;
> 
> Do you still need this cast, now the function takes non-const "char *string"?

Good catch.  Do you want to fix this in your repo or should I re-roll?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
