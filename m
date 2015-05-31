From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out
 of grab_single_ref()
Date: Sun, 31 May 2015 23:18:04 +0530
Message-ID: <556B4954.6040903@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-1-git-send-email-karthik.188@gmail.com> <xmqqvbf8abwi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7M4-0001nt-BK
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976AbbEaRsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:48:12 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33227 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbbEaRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:48:10 -0400
Received: by pdbqa5 with SMTP id qa5so90856544pdb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jsaqNjRGkAaNgXiybPZFnloRFBa1eGy1WywxUp4tkK8=;
        b=PRRY8T7LIjzJ3qnNo6zi+HHE94+snk9AIYmZGnUluhYnzJXDJ87Hofpe/37YRUt1RN
         SZy6dYCzVtG4LAhhFE+POrPVblCTP6XvpJAzEZl8vyh5OBbNLPHuQio/40sLDztDL6BQ
         c37RItA3e7dMf4frbgb3Ej6psIpHtHvadhNtVVJx73m1vQtJAoCsM2uOnO2sbOGVU848
         nWm4j1sdOd5/R2GNRcBAWJCiIC9KNJ1Fk6fGu8LA3TzyvOtmLrlFCmYWCq/Pni+fEiX0
         Oxgv2hJGPZUIBhd5X8K0baKja4WR681jXNNl8jfoCAukLoZWeCAq5uMFDzeb+E8zqBIc
         TbHQ==
X-Received: by 10.68.125.130 with SMTP id mq2mr32883851pbb.121.1433094489790;
        Sun, 31 May 2015 10:48:09 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id c10sm11786481pbu.81.2015.05.31.10.48.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 10:48:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqvbf8abwi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270336>

On 05/31/2015 11:04 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>   /*
>> + * Given a refname, return 1 if the refname matches with one of the patterns
>> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
>> + * and so on, else return 0. Supports use of wild characters.
>> + */
>> +static int match_name_as_path(const char **pattern, const char *refname)
>> +{
>
> I wonder why this is not "match_refname", in other words, what the
> significance of "as path" part of the name?  If you later are going
> to introuce match_name_as_something_else() and that name may not be
> a refname, then this naming is perfectly sane.  If such a function
> you will later introduce will still deal with names that are only
> refnames, then match_refname_as_path() would be sensible.  Otherwise
> this name seems overly long (i.e. "as_path" may not be adding value)
> while not being desctiptive enough (i.e. is meant to be limited to
> refnames but just says "name").
>
> Just being curious.
>

Good Question, This is because in the future I'll eventually add pattern
matching for 'tag -l' and 'branch -l' which wont match as path, but
would be a regular string match (with wild character support). Hence
keeping that in mind I included 'as_path()' in the function name.

>
> The comment still is a good reminder for those who will later touch
> this grab_single_ref() function to make them think twice.
>
> Thanks.
>

Yes! It was removed it by mistake.

-- 
Regards,
Karthik
