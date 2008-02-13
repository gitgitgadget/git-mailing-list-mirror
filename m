From: Voltage Spike <voltspike@gmail.com>
Subject: Re: Merge-Recursive Improvements
Date: Wed, 13 Feb 2008 01:21:36 -0700
Message-ID: <E105587B-9E61-4A21-91F5-6310A83C3F41@gmail.com>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <47B29EBF.7060607@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCt7-0005kP-U4
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYBMIVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYBMIVm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:21:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:22522 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759980AbYBMIVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:21:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3835594rvb.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 00:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        bh=IjSgItwNsGiTDe4uYluA9GdZPVykrLL2uaWcTv9FiX4=;
        b=d0cOXZ5ZEEvHRZ8k66evfkHp621i462ncllQUFi8MvEQb2I4aAJbG2gjCK4YC4mq6+2H56iFtroXsp18XracmiLXysq2F6owdF8HZVXeIj8zezO3MeC5xjuU5tqMygu4yM+ommLVA+qcjLhE6bVxfLKYRjxlUV2DxEpMIhGXFI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=v7GVc1Efoi/QyN2s49/wSsv9LmCqFkvY2TMpVUlVlQ6Ea/t/nwbdl/pvpG0b5ArHm/x3uWgQvzzjAbfBzQd9grS3SzT6J9KRw2dcgoOmhTN0i3A0ARZkHNi1goGLo+RzPppfOp+U6eFyGkvZq6psj++Tlk9DK+IPCZVOlOPhJ9Q=
Received: by 10.140.251.1 with SMTP id y1mr1643186rvh.102.1202890899410;
        Wed, 13 Feb 2008 00:21:39 -0800 (PST)
Received: from ?149.169.205.128? ( [149.169.205.128])
        by mx.google.com with ESMTPS id f34sm3164210rvb.3.2008.02.13.00.21.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 00:21:38 -0800 (PST)
In-Reply-To: <47B29EBF.7060607@viscovery.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73753>

On Feb 13, 2008, at 12:39 AM, Johannes Sixt wrote:

> Voltage Spike schrieb:
>> Third, git doesn't appear to have any sense of context when  
>> performing a
>> merge. Another contrived example which wouldn't be flagged as a merge
>> conflict:
>>
>>   ptr = malloc(len); // Added in HEAD.
>>   init();            // Included in merge-base.
>>   ptr = malloc(len); // Added in "merge".
>
> You seem to say that you want this to result in a merge conflict.

Yes, it appears that I wasn't clear that I see the above as a conflict.

> I'm opposed to this: It means that you would mark a conflict if  
> there is a
> single unchanged line between the two changes that come from the  
> merged
> branches. So far it has happened for me much more frequently that such
> merges were correct, and I should not be bothered with conflict  
> markers. I
> conciously prefer to pay the price that such a merge is incorrect  
> on occasion.

That is why I'm hoping to make it configurable. I know that we have  
more information than during a simple patch, but it seems odd that  
changes can be occurring all around your local modifications and  
you'll never be notified.

Which leads to a different point: does this lessen the value of  
falling back to a 3-way merge during a rebase?

> You also need to draw a border line: a single unchanged line  
> between the
> changes? Or better also conflict at 2 lines? Or 3?

I naturally assumed the default number of context lines: 3. If I  
recall correctly, this isn't typically configurable.
