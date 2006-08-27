From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problem with pack
Date: Sun, 27 Aug 2006 19:45:09 +0200
Message-ID: <44F1DA25.3050403@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 19:46:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHOhv-0004Yx-Lk
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 19:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWH0Rpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 13:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWH0Rpo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 13:45:44 -0400
Received: from arces.unibo.it ([137.204.143.6]:10146 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S932203AbWH0Rpn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 13:45:43 -0400
Received: from [192.168.1.99] (adsl-ull-160-6.41-151.net24.it [151.41.6.160])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7RHwjUj000333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 27 Aug 2006 19:58:47 +0200
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: git@vger.kernel.org
X-Spam-Status: No, score=-95.0 required=5.0 tests=BAYES_60,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL,USER_IN_WHITELIST autolearn=no version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1736/Sun Aug 27 18:33:34 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26105>

>
> I do think that your synchronization using unison is _somehow_ part of the 
> reason why bad things happened, but I really can't see why it would cause 
> problems, and perhaps more importantly, git should have noticed them 
> earlier (and, in particular, failed the repack). So a git bug and/or 
> misfeature is involved somehow.
>   
Glad if my broken pack can help finding out!
> One thing that may have happened is that the use of unison somehow 
> corrupted an older pack (or you had a disk corruption), and that it was 
> missed because the corruption was in a delta of the old pack that was 
> silently re-used for the new one.
>
> That would explain how the SHA1 of the pack-file matches - the repack 
> would have re-computed the SHA1 properly, but since the source delta 
> itself was corrupt, the resulting new pack is corrupt.
>   
There is something that I still do not understand... (sorry if I ask 
stupid questions)...
Since packs have an sha signature too, if there was a data corruption 
(disk or transfer), shouldn't that have been detected at the repack? 
I.e. doesn't repack -d verify the available data before cancelling anything?
> If you had used git itself to synchronize the two repositories, that 
> corruption of one repo would have been noticed when it transfers the data 
> over to the other side, which is one reason why the native git syncing 
> tools are so superior to doing a filesystem-level synchronization.
>   
I think I learnt the lesson!
> With a filesystem-level sync (unison or anything else - rsync, cp -r, 
> etc), a problem introduced in one repository will be copied to another one 
> without any sanity checking.
>   
Idem!
> but in the meantime, when you find a place to put the corrupt pack/index 
> file, please include me and Junio at a minimum into the group of people 
> who you tell where to find it (and/or passwords to access it). I'll 
> happily keep your data private (I've done it before for others).
>
>   
Sure... I have already sent an email to Junio to arrange this.

Thanks,
Sergio
