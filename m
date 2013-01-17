From: David Lang <david@lang.hm>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 16:21:41 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvdGV-0006UG-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 01:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740Ab3AQAXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 19:23:12 -0500
Received: from mail.lang.hm ([64.81.33.126]:33074 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637Ab3AQAXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 19:23:11 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0H0N6UG028091;
	Wed, 16 Jan 2013 16:23:06 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213828>

On Wed, 16 Jan 2013, Matt Seitz (matseitz) wrote:

> "David Lang" <david@lang.hm> wrote in message news:<alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>...
>> But if you try to have one filesystem, with multiple people running git on their
>> machines against that shared filesystem, I would expect you to have all sorts of
>> problems.
>
> What leads you to think you will have problems?
>
> Why would there be more of a problem on a network file system as opposed to 
> local file system that can be accessed by multiple users?

There are safety checks and synchronization primitives that work between 
mulitiple users on one machine (where you can see what other processes are 
running for example) that don't work with separate machines using a filesystem

> Linus seemed to think it should work:
>
> http://permalink.gmane.org/gmane.comp.version-control.git/122670

well, he knows git better than I do, but using git over NFS/CIFS is not the same 
as saying that you have multiple users on different systems making changes.

In the link you point at, he says that you can have problems with some types of 
actions. He points out things like git prune, but I would also say that there 
are probably race conditions if you have two git processes that try to change 
the HEAD to different things at the same time.

> And "git init" specifically has a "shared" option:
>
> --shared[=(false|true|umask|group|all|world|everybody|0xxx)]
>
> Specify that the git repository is to be shared amongst several users. This 
> allows users belonging to the same group to push into that repository. When 
> specified, the config variable "core.sharedRepository" is set so that files 
> and directories under $GIT_DIR are created with the requested permissions. 
> When not specified, git will use permissions reported by umask(2).
>

I think this is dealing with multiple users _reading_ a repository, not making 
updates to it at the same time.

David Lang
