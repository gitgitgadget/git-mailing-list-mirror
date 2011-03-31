From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 15:26:29 +0200
Message-ID: <4D948105.3050009@drmicha.warpmail.net>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net> <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Hwv-000877-8P
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546Ab1CaNaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 09:30:00 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49098 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643Ab1CaNaA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 09:30:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 44A84209CE;
	Thu, 31 Mar 2011 09:29:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 31 Mar 2011 09:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LLVFBAyZhHNOQERcLoR2pQyojF8=; b=V4yi/g7U33Okp+uTOPg75alaffu+2ihKL+8qniDAdL31Q52lF4hwRlEVkchKtvdEbKFmX5zJ947/vtzBH//4aoYZTEWyDg3lFT1TqvvNIn2ZtxdTRCY5f6h+0qbIH0gD7IbVV4YMkgSOwJoprMc7tFDtrandVCRrRDVsTipfFJ4=
X-Sasl-enc: suEdJkXILQs4gfnXtYD97RTdsGBniXdKQkqlJ+4VtFci 1301578199
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89B0E449F36;
	Thu, 31 Mar 2011 09:29:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170488>

Nguyen Thai Ngoc Duy venit, vidit, dixit 31.03.2011 14:50:
> I suggest add "commit" to the subject: do not prune commit by
> pathspec. Diff limiting is another kind of pruning and I was confused.

I know that under the name "diff limiting" only (that may be my ignorance).

> 
> On Thu, Mar 31, 2011 at 4:17 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> By design, "git show commit -- path" is not "git show commit:path", and
>> there is no reason to change that.
> 
> Even more true, now that "path" can be "*.sh".
> 
>> But "git show commit -- path" simply
>> returns nothing at all "most of the time" because it prunes by pathspec
>> even though it does not walk commits. This is pretty useless.
>>
>> So, turn off pruning (but keep diff limiting of course) so that "git
>> show commit -- path" shows the commit message and the diff that the
>> commit introduces to path (filtered by path); only the diff will be
>> empty "most of the time".
> 
> Tests please?

Heck, we don't have any to begin with, and this is marked RFC. Given our
usual reluctance to change even undocumented behavior I'm not going to
bother with tests for an RFC.

>> As an intended side effect, users mistaking "git show commit -- path"
>> for "git show commit:path" are automatically reminded that they asked
>> git to show a commit, not a blob.
> 
> Nor a tree. I don't really see how "git show commit:path" and "git how
> commit -- path" are relevant for it to be mentioned here.

"git show commit:path" is relevant because that is what the OP was
trying to do, and "git show commit:path" is relevant because that is
what the OP tried and confused him because there was no output at all.
Not to mention that this is the command this patch is about.

Someone needs a coffee, me thinks ;)

Michael
