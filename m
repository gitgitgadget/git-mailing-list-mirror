From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Advices to imlement update hook
Date: Wed, 09 Feb 2011 17:42:43 +0100
Message-ID: <4D52C403.30501@viscovery.net>
References: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com> <4D52C2FA.2030103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 17:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnD7z-00042r-1x
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab1BIQmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 11:42:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20091 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753246Ab1BIQmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 11:42:44 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PnD7r-00025y-Jr; Wed, 09 Feb 2011 17:42:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5D7421660F;
	Wed,  9 Feb 2011 17:42:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D52C2FA.2030103@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166430>

[Sorry, sent too early - fat fingers :-(]

Am 2/9/2011 17:38, schrieb Johannes Sixt:
> Am 2/9/2011 17:27, schrieb Francis Moreau:
>> Hi !
>>
>> I'd like to restrict access to one of my repos: the project tracked by
>> it has several directories: a/ b/ c/ and I'd like to allow only
>> modifications happen in b/ directory.
>>
>> I'm planning to use git hooks, not sure which one I should use: if the
>> check should happen at the commit or push time or both.
...
>> I also tried:
>>
>>    git diff-tree <oldref> <newref> -- ^b || exit 1
>>
>> but it doesn't work.
> 
>   git diff-tree --quiet <oldref> <newref> -- b

should do it; it sets the exit code.

But don't you also want to inspect all commits between oldref and newref?
Someone could have modified the directory, and then reverted the
modification in a later commit. If these commits arrive in a single push,
the above code wouldn't notice this.

-- Hannes
