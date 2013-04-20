From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Sat, 20 Apr 2013 15:38:53 +0200
Message-ID: <51729A6D.3030501@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net> <20130420040643.GB24970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZCk-00022x-6L
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab3DTOzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:55:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34417 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302Ab3DTOze (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 10:55:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 48F8420347;
	Sat, 20 Apr 2013 10:44:26 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 20 Apr 2013 10:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3FMA10T1dNhdF3mjlpfg0K
	hIPhc=; b=NP0YYn6Rjbuj8eOhquwhU5lj8KnDgQR2yVJeC/40iiAvgwRuOWEUwU
	64qgFqxOx2Mr1HEkbUeuCHrmryxgtjApy1lK7SLevIi+m4moTjzfCN9a2ejdtp0G
	SudHCpffpiYDpL9g8FDBGIrmzqnGVc7EcEns1MTL54M8qAkTnAFQE=
X-Sasl-enc: UPVgDT8aavCHbaTH1KyrJ/I33FKpl+o/h3uU6qJulgro 1366469066
Received: from localhost.localdomain (unknown [88.70.147.219])
	by mail.messagingengine.com (Postfix) with ESMTPA id 99AFEC80005;
	Sat, 20 Apr 2013 10:44:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130420040643.GB24970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221858>

Jeff King venit, vidit, dixit 20.04.2013 06:06:
> On Fri, Apr 19, 2013 at 06:44:45PM +0200, Michael J Gruber wrote:
> 
>> Currently, "diff" and "cat-file" for blobs obey "--textconv" options
>> (with the former defaulting to "--textconv" and the latter to
>> "--no-textconv") whereas "show" does not obey this option, even though
>> it takes diff options.
>>
>> Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
>> default and "--no-textconv" when given.
> 
> Wait, this does the opposite of the last patch. If we do want to do
> this, shouldn't the last one have been an "expect_failure"?

The last patch just documents the status quo, which is not a bug per se.
Therefore, no failure, but change in the definition of "success".

> I'm not convinced this is the right thing to do, though. It would break:
> 
>   git show HEAD:file.c >file.c
> 
> Admittedly, such people should be using "checkout" or "cat-file", so I
> do not mind too much breaking them if there is a good reason. But I am
> not sure what that reason is.

My reasoning is twofold:

- consistency between "git show commit" and "git show blob"

- "git show" is a user facing command, and as such should produce output
consumable by humans; whereas "git cat-file" is plumbing and should
produce raw data unless told otherwise (-p, --textconv).

(Sorry for the repeat.)

Michael
