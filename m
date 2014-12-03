From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 3 Dec 2014 15:24:24 -0800
Message-ID: <20141203232424.GI6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051911.GP6527@google.com>
 <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJHc-0008Vy-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaLCXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:24:29 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:38666 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaLCXY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:24:28 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so9755189ier.20
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YOIkiscniGuAmzTypA1lG+bYbCGeD8Ov7Gh+Ltu82HM=;
        b=xn7Ar/mVjcyqCU6OxW9KKT4qfjnKdoz3cOxbn58ZY5RHh0iwWzQLqDSLv2L/wRv84z
         k5x0HEba8frdwCLq7UtV1XMZ1aWnSDQj4PDl7P6ICZZqSBhT6BxyE7eCHSK+b2ESwsLA
         lvJVdp15iF+FswQ+bJHRUQMHWUY7iqBFJEksNU/JrfhRPKCMa97XqwfMU51v9joHGnP8
         ffSaui4QAOZgDqoOpYIfabRcH3F2nn9il5SXFf/5HqVKSonylT7xU9nuCmAwQZ7z6ORy
         kYcWn/voNjrYZFdIm+jYgstHzuV5MUCXpSM/WxtpNYCyL1eMS60z2q2XxliOLmR85pTz
         Fmnw==
X-Received: by 10.107.131.102 with SMTP id f99mr7018174iod.31.1417649067470;
        Wed, 03 Dec 2014 15:24:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id d4sm2789563ioe.38.2014.12.03.15.24.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:24:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260708>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/refs.c b/refs.c
>> index 917f8fc..39e43cf 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2326,7 +2326,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  			 */
>>  			goto retry;
>>  		else
>> -			unable_to_lock_die(ref_file, errno);
>> +			unable_to_lock_die(ref_file, lflags, errno);
>>  	}
>
> This has unfortunate interaction with 06839515 (lock_ref_sha1_basic:
> do not die on locking errors, 2014-11-19).

I'll add that patch to the series.  06839515 becomes a little simpler
with the updated API.

Thanks,
Jonathan
