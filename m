From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/6] string_list: add function string_list_append_nodup()
Date: Wed, 12 Sep 2012 15:32:49 +0200
Message-ID: <50508F01.1030001@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu> <1347311926-5207-2-git-send-email-mhagger@alum.mit.edu> <7vpq5tleyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 15:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBn3t-0004jf-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 15:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2ILNcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 09:32:53 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:61447 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab2ILNcw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 09:32:52 -0400
X-AuditID: 12074411-b7fa36d0000008cc-c9-50508f046e2e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.4D.02252.40F80505; Wed, 12 Sep 2012 09:32:52 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8CDWnlR020349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2012 09:32:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vpq5tleyo.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqMvSHxBgsGMdv0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7owNR9ayF6zkrFiz4CZjA+Mj
	9i5GTg4JAROJyTNmMEHYYhIX7q1n62Lk4hASuMwosWTmfmaQhJDAcSaJzg5GEJtXQFvi/5E7
	YDaLgKrE8mk7wGrYBHQlFvU0gw0SFQiRmHF5MjNEvaDEyZlPWEBsEQE1iYlth4BsDg5mASOJ
	eafrQcLCAgES1x9Ngdq7lFHi/qRDrCAJTgEzidN7Z4HZzAI6Eu/6HjBD2PIS29/OYZ7AKDAL
	yYpZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkdAV3MM44
	KXeIUYCDUYmHlyHBP0CINbGsuDL3EKMkB5OSKK9BT0CAEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRHeDbpAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBK9sH1CjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS4gHaqwjSzltckJgLFIVoPcWo
	y3H344r7jEIsefl5qVLivEwgRQIgRRmleXArYInqFaM40MfCvK4gVTzAJAc36RXQEiagJRPW
	+oMsKUlESEk1MG7Z/umB/4byt+I/hC4+Y3n4Y+mEXYyXe6VWW3ZwGt09JmjTw/Eil032h+Ps
	edcmHX0bz/nTYvqsIpV123fUPJ7edf91pv45OcOKd8t/OXf79f/0NhcWWKG6qMZy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205287>

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

Thanks.  Fixed in forthcoming re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
