From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: share object storage for multiple clones of different
 repositories
Date: Sat, 05 Nov 2011 08:37:24 +0100
Message-ID: <op.v4gp4mai0aolir@keputer.lokaal>
References: <j91rcq$1uo$1@dough.gmane.org>
 <7vobwr9uf0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gelonida N" <gelonida@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 08:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMaoo-00072R-C0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 08:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab1KEHh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 03:37:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42923 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1KEHh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 03:37:26 -0400
Received: by eye27 with SMTP id 27so2631478eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=eOzT4SWXogZSms5O1MOyu2vkTJszRXvGAhUcf0f5A8s=;
        b=KBsf9aVysfg/9BfqZhqPjLHwT7qcvVUTMwu+mm5hiYNTqraWzl4SmNMwU7pCN8ihGd
         GBoo8/5DgDJT8Dp8FKhHB/EPybWZbwp5XtPe/whGYOxTfl5Nt9nuy65izNk3CJ3G8dqg
         qTfRCsAnQil/KI5W39NDMJ8IyIqTrYSj1h45g=
Received: by 10.213.14.135 with SMTP id g7mr1866126eba.6.1320478644792;
        Sat, 05 Nov 2011 00:37:24 -0700 (PDT)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 49sm31933074eec.1.2011.11.05.00.37.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 00:37:24 -0700 (PDT)
In-Reply-To: <7vobwr9uf0.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184833>

On Sat, 05 Nov 2011 03:26:11 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> Gelonida N <gelonida@gmail.com> writes:
>
>> SHARED_STORAGE=$HOME/shared_storage
>> mkdir $SHARED_STORAGE
>>
>> git clone remotehost1:repo1
>> cd repo1
>> rsync -av .git/objects $SHARED_REPO
>
> Up to this part it is probably OK.  Repeat that for all your local
> repositories to collect all objects in $HOME/shared_storage.
>
> After doing that, do this in all of your local repositories:
>
> 	rm -rf .git/objects
>         mkdir -p .git/objects/info
>         echo $HOME/shared/storage >.git/objects/info/alternates
>
> The reason why nobody should follow your original recipe is because any
> "git gc"/"git repack" in any of your local repositories would break  
> others
> with that approach.


Alternatively there's the git-new-workdir script in contrib/workdir in  
git.git. Haven't tested it, but it seems like it does what you want.

Frans
