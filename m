From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 13:46:34 +0530
Message-ID: <556AC362.80805@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-6-git-send-email-karthik.188@gmail.com> <CAPig+cTyy5ai0O4BAG+3+_6x-8OC5SoUDR=swCq-bNFP3DfxUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:16:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyQH-0007j2-4H
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbbEaIQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:16:41 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33726 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbbEaIQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:16:39 -0400
Received: by padj3 with SMTP id j3so22261376pad.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+bXn7jzWqbQhtoM6wpwIIubzAqIrVeJF0j1uqQvMxhA=;
        b=x7+NpdDOdDl77B6gwQj4gvDbakNswGnS7fKwPrJGbixDIlPutT3R8IvejHYvDPnEea
         IrSEltRYLy29lhNixuB/mXkna3YJAm93Iahi+favYkubnq8CYDTgutvxvsKkXhKvDBEj
         7SWQ5ftD5TPTzd31NN8kp8hH/8iLWCAMivmKfQwBl6tmYJ8GRKB45hyTj/7kS/mGlh4n
         YuIypdKlmO6WWzOh1p5m5xy5I0k7jiXjGqXrszGkdHHYpbb0DhBDy2caUxhQ0QtGhLjt
         gr1efRBw/ZUPL0hP57t2tKoSRJyfh/l+3GamN/8O6wzYZNskFcakfI3aLBQancRrpBsp
         0Lkg==
X-Received: by 10.68.204.133 with SMTP id ky5mr30023946pbc.67.1433060198654;
        Sun, 31 May 2015 01:16:38 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id sl5sm5804839pbc.72.2015.05.31.01.16.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 01:16:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cTyy5ai0O4BAG+3+_6x-8OC5SoUDR=swCq-bNFP3DfxUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270320>

On 05/31/2015 08:51 AM, Eric Sunshine wrote:
> On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Rename some of the functions and make them publically available.
>
> s/publically/publicly/
>
>> This is a preparatory step for moving code from 'for-each-ref'
>> to 'ref-filter' to make meaningful, targeted services available to
>> other commands via public APIs.
>>
>> Based-on-patch-by: Jeff King <peff@peff.net>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index f896e1c..8fed04b 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -882,10 +882,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>>   }
>>
>>   /*
>> - * A call-back given to for_each_ref().  Filter refs and keep them for
>> + * A call-back given to for_each_ref(). Filter refs and keep them for
>
> Sneaking in whitespace change?
>
>>    * later object processing.
>>    */
>> -static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>> +int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>>   {
>>          struct ref_filter_cbdata *ref_cbdata = cb_data;
>>          struct ref_filter *filter = &ref_cbdata->filter;


Noted. Will fix!

-- 
Regards,
Karthik
