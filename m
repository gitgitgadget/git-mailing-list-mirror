From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 16:40:17 +0200
Message-ID: <4D909DD1.2050904@viscovery.net>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com> <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4DcL-0007v5-Be
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab1C1OkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 10:40:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29275 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754613Ab1C1OkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 10:40:21 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q4DcA-00033E-2d; Mon, 28 Mar 2011 16:40:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C50711660F;
	Mon, 28 Mar 2011 16:40:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170133>

Am 3/28/2011 16:29, schrieb Andrew Garber:
>> I'd expect this to work:
>>
>>    $ git bisect start
>>    $ git bisect good
>>    $ git bisect bad HEAD~100
> 
> So would I. I think the behavior of git bisect should be changed.
> Right now, it's trying to find the first bad commit. Instead, it
> should be trying to find the first commit where the code's good/bad
> state *changed*. IOW, it should be able to handle both of the
> following cases:
> 
> good <--- oldest
> good
> good
> bad <--- the commit we want bisect to find
> bad
> bad <--- newest
> 
> bad <--- oldest
> bad
> bad
> good <--- the commit we want bisect to find
> good
> good <--- newest
> 
> It shouldn't matter which end we start on, so long as one end gets
> marks good, and the other end gets marked bad.

Define "end" and "other end"! It's not that trivial.

      o--o--o--B
     /
  --o--o--o--o--G

When I have this history and I mark B as bad and G as good, will I now
find the first bad or the first good commit?

-- Hannes
