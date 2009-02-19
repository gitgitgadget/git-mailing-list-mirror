From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries	marked
 CE_REMOVE
Date: Thu, 19 Feb 2009 10:06:59 +0100
Organization: private
Message-ID: <86ocwy3ido.fsf@broadpark.no>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
 <81b0412b0902190024t3fc7ab20r9a23c72270ac1033@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La4tW-000620-VR
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbZBSJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 04:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZBSJHG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:07:06 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:53317 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbZBSJHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 04:07:01 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB007ND2NOY270@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 10:07:00 +0100 (CET)
Received: from localhost ([80.203.78.205]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFB001SY2NNG670@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 19 Feb 2009 10:07:00 +0100 (CET)
In-reply-to: <81b0412b0902190024t3fc7ab20r9a23c72270ac1033@mail.gmail.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110648>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/2/18 Kjetil Barvik <barvik@broadpark.no>:
>> If we can trust the numbers from oprofile in this case, we saved
>> approximately ((7710 - 46) * 20000) / (2 * 1000 * 1000 * 1000) = 0.077
>> seconds CPU time with this fix for this particular test.  And notice
>> that now the CPU did only 46 / 15 = 3.1 cycles/instruction.
> ...
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index e3c3fa1..273b5da 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -93,11 +93,9 @@ static int check_updates(struct unpack_trees_options *o)
>>                        display_progress(progress, ++cnt);
>>                        if (o->update)
>>                                unlink_entry(ce);
>> -                       remove_index_entry_at(&o->result, i);
>> -                       i--;
>> -                       continue;
>>                }
>>        }
>> +       remove_marked_cache_entries(&o->result);
>>        remove_scheduled_dirs();
>>
>
> What commit is this change based on? It does not apply to any
> of Junio's master, next, or pu...

  It was based on 'pu', and not a uptodate one.  Sorry about that, I
  will update the patch based on master, and include it together with
  the 2 'USE_NSEC'-patches, which I posted some few days ago.

  -- kjetil
