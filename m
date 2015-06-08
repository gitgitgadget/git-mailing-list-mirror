From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 5/9] ref-filter: implement '--merged' and '--no-merged'
 options
Date: Tue, 09 Jun 2015 00:23:10 +0530
Message-ID: <5575E496.9030102@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-5-git-send-email-karthik.188@gmail.com> <vpqeglmrsut.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22Ai-00037a-6T
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbFHSxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:53:16 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35024 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbFHSxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:53:15 -0400
Received: by pdbnf5 with SMTP id nf5so110867756pdb.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PiLzBHH4PRJX1e5GTqPKkQAwdJVXBBdSriaiwZbYYBM=;
        b=DeWSnnsorz5KTs9JN/1LF2ZMW/30uRqU+kcuazQPqB0VAfLTLrp5Ja4fVDZA2rtBOk
         CyCEbEfPqNWwWoSKSWMjRRUJKiOqry/JoMyTIkmHoVgmxmLy5GknLOYPwCvraGWUTLek
         JJMqZ/PWKm6pMJyGJpDD3L491Fpae3dREwex28ETBoTuP89C6w/aPPHAe6mlnPNAtkWk
         WBrGyDJw0EZM9/CGYrwLr/ScBSD+ByMvfdddgswqytSi5Rf9mR7q3hRAcIwypq7ziR+W
         e5Lg30iF8rY9r8wE0cDQn1iZNArIzYKSrNSm/ypdhsCs0fUUpBvpVl6o3utcjRUIlkS9
         aRRg==
X-Received: by 10.66.141.231 with SMTP id rr7mr32354311pab.86.1433789594683;
        Mon, 08 Jun 2015 11:53:14 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id bs3sm3288465pbd.47.2015.06.08.11.53.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:53:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqeglmrsut.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271108>

On 06/08/2015 11:21 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +	if(filter->merge_commit) {
>
> space after if.
>
>> @@ -938,7 +991,13 @@ void ref_array_clear(struct ref_array *array)
>>    */
>>   int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
>>   {
>> -	return for_each_ref_fn(ref_filter_handler, data);
>> +	int ret;
>> +
>> +	ret = for_each_ref_fn(ref_filter_handler, data);
>> +	if (data->filter.merge_commit)
>> +		do_merge_filter(data);
>
> Reading this, I first wondered why you did not do the merge_filter as
> part of ref_filter_handler. It seems weird to fill-in an array and then
> re-filter it. I think it would make sense to add a few comments, like
>
> /* Simple per-ref filtering */
> ret = for_each_ref_fn(ref_filter_handler, data);
>
> /* Filters that need revision walking */
> if (data->filter.merge_commit)
> ...
>

Thanks! will add the space and comments as suggested.

-- 
Regards,
Karthik
