From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Mon, 09 May 2005 15:50:32 -0700
Message-ID: <427FE938.7050904@zytor.com>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>	<20050509212842.GC15712@pasky.ji.cz>	<7iu0lc129m.fsf@lanthane.pps.jussieu.fr> <427FE248.7040403@zytor.com> <7ipsw010i5.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Tue May 10 00:44:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGyU-0001mG-7K
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVEIWuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVEIWuv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:50:51 -0400
Received: from terminus.zytor.com ([209.128.68.124]:58308 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261254AbVEIWuo
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 18:50:44 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49MoWlW002099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 15:50:33 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7ipsw010i5.fsf@lanthane.pps.jussieu.fr>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Juliusz Chroboczek wrote:
>>>I see.  Let me know if you decide to use a different name for the
>>>lock file so I can switch to using the same one as yours.
> 
> 
>>Are you using flock(), or some other contraption that breaks if a
>>process dies unexpectedly?
> 
> No, I'm using a file that is created by the NFS-safe equivalent of
> open(O_CREAT | O_EXCL).  This is what Darcs has been doing basically
> forever.
> 
> Darcs usually doesn't die unexpectedly -- it's a Haskell program, so
> bugs usually manifest themselves with an exception being thrown
> allowing Darcs to clean-up after itself.
> 
> The one exception is when Darcs gets killed by the OOM killer (which,
> as you doubtless know, doesn't give any advance warning to a process,
> thus making it impossible for a process to deal with it gracefully).
> In such cases, manual intervention is necessary anyway -- a file could
> have been written half-way.
> 

In the case of git, it should not be necessary even then; there might be 
a broken file in the repository but nothing would reference it so it 
shouldn't have any effect.  Functionally speaking, operations on the git 
repository are in themselves atomic.

	-hpa
