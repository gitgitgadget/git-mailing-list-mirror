From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git bug?
Date: Thu, 09 Jun 2005 03:39:08 -0400
Message-ID: <42A7F21C.2040709@pobox.com>
References: <42A7E7AD.5030108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 09 09:47:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgHZa-0001QH-L6
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 09:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVFIHjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 03:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVFIHjR
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 03:39:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54228 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262320AbVFIHjK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 03:39:10 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DgHd8-0004aJ-0z
	for git@vger.kernel.org; Thu, 09 Jun 2005 07:39:10 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42A7E7AD.5030108@pobox.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik wrote:
> 
> Just upgraded to the latest git, pulled the latest Linux kernel tree, 
> and made a local modification.  Here is the strange git-diff-cache output:
> 
>> [jgarzik@pretzel libata-dev]$ git-diff-cache -p HEAD diff --git 
>> a/arch/arm/mm/minicache.c b/arch/arm/mm/minicache.c
>> deleted file mode 100644
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -3059,8 +3059,6 @@ static void __ata_qc_complete(struct ata
>>         struct ata_port *ap = qc->ap;
>>         unsigned int tag, do_clear = 0;
>>  
>> -       WARN_ON(!assert_spin_locked(&ap->host_set->lock));
>> -
>>         if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
>>                 assert(ap->queue_depth);
>>                 ap->queue_depth--;
> 
> 
> The libata-core part is correct, the arch/arm/mm part is not.
> 
> I pulled using unmodified, upstream git scripts.  No sugar added. Here's 
> what the repo looks like:
> 
>> [jgarzik@pretzel libata-dev]$ git-rev-list --pretty HEAD ^master | 
>> git-shortlog Jeff Garzik:
>>   Merge /spare/repo/linux-2.6/
>>   Automatic merge of /spare/repo/linux-2.6/.git branch HEAD
>>
>> Jens Axboe:
>>   libata: fix spinlock bug introduced by NCQ code
>>   libata: ncq support update
>>   libata-scsi: better placement of cmd completion on err
>>   SATA NCQ support
> 
> 
> It's mirroring to kernel.org right now, at 
> rsync.kernel.org://...jgarzik/libata-dev.git if somebody wants to poke 
> at it.  Top of tree is d032ec9048ff82a704b96b93cfd6f2e8e3a06b19 (when 
> fully uploaded and mirrored).


Well, after switching branches and switching back, the behavior is gone. 
  <shrug>

	Jeff


