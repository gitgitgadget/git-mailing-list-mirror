From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 12:27:13 +0100
Message-ID: <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwc7z-0007Zk-CN
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 12:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbXKZL1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 06:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbXKZL1T
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 06:27:19 -0500
Received: from wincent.com ([72.3.236.74]:38328 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbXKZL1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 06:27:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQBRE94004612;
	Mon, 26 Nov 2007 05:27:15 -0600
In-Reply-To: <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66064>

El 26/11/2007, a las 10:32, Benoit Sigoure escribi=F3:

> On Nov 26, 2007, at 10:02 AM, Wincent Colaiuta wrote:
>
>> In using "git-rebase --interactive" to re-order commits you =20
>> occasionally get conflicts and will see a message like this:
>>
>> 	When commiting, use the option '-c %s' to retain authorship and =20
>> message
>>
>> I was thinking that it might be nice to stash away this commit id =20
>> somewhere in GIT_DIR so that the user didn't have to explicitly =20
>> remember it, and add a new switch to git-commit that could be used =20
>> to automatically use that stashed commit id, something like:
>>
>> 	git commit --retain
>>
>> Although I most often see this kind of message in interactive =20
>> rebasing, the message is generated in builtin-revert.c when cherry-=20
>> picking, so you can also see it in any other situation where you're =
=20
>> cherry picking and there's a conflict.
>>
>> What do people think? Would this be a nice usability improvement? =20
>> Or is it adding clutter?
>
>
> I'm not sure but I think this message is just some unwanted =20
> (misleading) noise, since when you rebase, once you solve the =20
> conflicts, you git-rebase --continue, you don't git-commit.

Looks like you're right. I just did a simple test and it turns out =20
that after a conflict, this:

	git commit -c ...
	git rebase --continue

Produces exactly the same history as this:

	git rebase --continue

So I think that misleading noise needs to be suppressed or reworded =20
when rebasing. Will look into it.

Cheers,
Wincent
