From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 13:19:32 -0700
Message-ID: <4509B954.60101@gmail.com>
References: <4509A7EC.9090805@gmail.com> <7vu03a2po8.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 22:19:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxgQ-0000jO-Ml
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWINUTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWINUTg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:19:36 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:6665 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751126AbWINUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 16:19:35 -0400
Received: by py-out-1112.google.com with SMTP id n25so3739575pyg
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 13:19:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UU6ualkhQ0xwirZau0MtfPW/m7vZWGibNvh+DdUqzxp6PjbjQmRjgn3n7RBKR+eO/b+RI5O2UEUy/Wi1UK3lzfmgoIeOu0tKxT1H6Mj2+bFZRM41jjTh9k/GHYn0mrH4RMZj0jr+8viiJrsP0TA11J9bN9ab+TTL2nQlw4OpV7o=
Received: by 10.35.102.1 with SMTP id e1mr15707017pym;
        Thu, 14 Sep 2006 13:19:34 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id b43sm5886823pyb.2006.09.14.13.19.33;
        Thu, 14 Sep 2006 13:19:34 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu03a2po8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27039>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
...
> 
> While this may be a good start, you need a lot more than this if
> you want to do (1) and (2):
> 
> The tree object contained by a commit is by definition a full
> tree snapshot, so if you want to do a WD_Prefix, you somehow
> need a way to come up with the final tree that is a combination
> of what write-tree would write out from such a partial index
> (i.e. an index that describes only a subdirectory) and the rest
> of the tree from the current HEAD.  I think you can more or less
> do this change to Porcelain using today's git core.  The
> sequence to emulate it with the today's git would be:

I think you misunderstood, the index file would list all of the tree 
entries of the the checked out commit, same as the current index, but 
would flag the entries that are actually present in the working 
directory. The WD_Prefix is to identify which index entries _can not_ be 
part of the working directory, and where the working directory fits in 
the full index. That way, all the information needed by the top level 
write-tree is still in the index and the cache-tree extension.
