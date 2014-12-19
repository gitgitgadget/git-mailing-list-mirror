From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Fri, 19 Dec 2014 17:30:15 +0100
Message-ID: <54945297.3010409@drmicha.warpmail.net>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info> <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com> <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info> <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anastas Dancha <anapsix@random.io>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 19 17:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20Rb-0001K5-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaLSQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:30:19 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44499 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751218AbaLSQaS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2014 11:30:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B676320D78
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:30:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 19 Dec 2014 11:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=YuN4OuC2hrkRmnFf9HI90g
	r2xZU=; b=adnaxY1HrZ6maZCHMZQYqhiXoiBCKQMy+zLFP5FOsjpUR3FCSQrHOE
	qOYiN8UKxsoG5wI+Ewf1rkbbo/BLFcfdLVvSgfZRTQwclaPz8Rpii2E2wum+lwWR
	dytZ2kJb37KQJMLIiU3Y5uD7If3N/8MlsnFIa5j8aPjl7UKAhsyKU=
X-Sasl-enc: pV8Eo7ewY0MLs1OovJcW6c3pr9IyhIm0xirRTN3G6xwu 1419006617
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 22754C00281;
	Fri, 19 Dec 2014 11:30:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261581>

Anastas Dancha schrieb am 19.12.2014 um 16:44:
> Hello Johannes,
> 
> On Fri, Dec 19, 2014 at 4:37 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> [...]
>> There is one bit left to clarify: let me guess, you have a $HOME/.gitconfig
>> like this:
>>
>>         [url "anastas@company.com"]
>>                 insteadOf = backup
>>                 pushInsteadOf = backup
>>
>> and then you want to add the "backup" remote in a Git working directory
>> like this:
>>
>>         git remote add backup me@my-laptop.local
>>
>> but my suggested fix will still disallow this because the URL does not
>> match the url.anastas@company.com.insteadOf?
>>
>> Ciao,
>> Johannes
> 
> Precisely that. In fact, it will not work even if you do any of these:
> 
>     git remote add backup anastas@company.com
>     git remote add backup anything@anyhost.com
>     git remote add backup backup
> 
> The original / current code and your suggested fix - both exhibit
> similar behaviour with the use cases I've described above.
> 
> Thanks,
> Anastas
> 

OK, I'll repeat it again: We cannot allow that.

"git push" can take a url or a remote as a parameter. Which one is it if
you have a remote and a url (alias) with the same name?

Michael
