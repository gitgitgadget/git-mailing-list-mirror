From: "Yann Droneaud" <yann@droneaud.fr>
Subject: Re: [sshfs] inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 12:54:43 +0100
Message-ID: <7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
    <E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Yann Droneaud" <yann@droneaud.fr>,
	fuse-sshfs@lists.sourceforge.net, fuse-devel@lists.sourceforge.net,
	git@vger.kernel.org
To: "Miklos Szeredi" <miklos@szeredi.hu>
X-From: git-owner@vger.kernel.org Thu Feb 17 12:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2RT-00073n-N4
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 12:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab1BQLyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 06:54:35 -0500
Received: from mx-out.ocsa-data.net ([194.36.166.37]:49709 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1BQLye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 06:54:34 -0500
Received: from [192.168.111.12] (helo=webmail.ocsa-data.net)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Pq2RK-00049U-7z; Thu, 17 Feb 2011 12:54:32 +0100
Received: from 80.12.80.40
        (SquirrelMail authenticated user meuh@meuh.org)
        by webmail.ocsa-data.net with HTTP;
        Thu, 17 Feb 2011 12:54:43 +0100
In-Reply-To: <E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
User-Agent: SquirrelMail/1.4.21
X-Priority: 3 (Normal)
Importance: Normal
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167067>

> On Wed, 16 Feb 2011, Yann Droneaud wrote:
>> Hi,
>>
>> For some days, my usage of git is not as seamless as before.
>>
>> I'm using git along sshfs/fuse (don't blame me for that), and
>> each time I try to rebase one of my branch, I have a conflict when
>> applying
>> the third commit. Doing the same operation on a local filesystem works
>> without any problem.
>
> Yann, thanks for looking into this.
>
> Your findings are not surprising: unlike NFS, sshfs doesn't provide
> inode numbers and the fuse library also doesn't guarantee stable inode
> numbers by default.
>

But why does it have such behavior when trying to rmdir() a non empty
directory ?

> Fuse version 2.8.x has a "noforget" option that should provide stable
> inode numbers, at the cost of unbounded memory use.  Could you please
> try if this option fixes these issues?
>

Yes, this option seems to fix the problem.

I will try it for a while to see if this is stable enough for a full day
of git working. (How can I check memory usage ?)

BTW, the [no]forget option did not appears in sshfs --help output.

Regards.

-- 
Yann Droneaud
