From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] filter-branch: strip pgp signature in commit messages
Date: Thu, 8 Oct 2015 10:43:02 +0200
Message-ID: <56162C96.80108@drmicha.warpmail.net>
References: <20151008050122.GA21369@freya.jamessan.com>
 <56162634.2010800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: James McCoy <vega.james@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 10:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk6nQ-00045y-Ao
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 10:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbbJHInP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 04:43:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53240 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754764AbbJHInG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 04:43:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7B3C520229
	for <git@vger.kernel.org>; Thu,  8 Oct 2015 04:43:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 08 Oct 2015 04:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=+ObUJR1nBSoKyyeqGiZA/t0zgk0=; b=eis7M+
	muZXVtz/gUweka9s57ierqzYCn93K9QBHEivH3pbK/oQvJzBE2s2tWvYpPpj7H78
	kccs8mG2odmEhdHu4YmyHY5OFNuMWvuaLLDqjfVqeltAb2X7lWwYaNHLQ1gxIziF
	EoCJSARQtQTrPTDtWT0os8If+g4yFVj7Z8ViI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+ObUJR1nBSoKyye
	qGiZA/t0zgk0=; b=bBVhzoEk+qtMftWzYaL3gTvGpoazE5YKGd4CRpkoKb3b+Wx
	YCHoUDsmsiaGafAXelaFOPm4qMZo5X4tu52SMHng4BcFVBG/3wePG7qnHryEsC/N
	kI75ZK7S9WTMWlcjZ5eYGyRbSQ92q4u61+G2xL+qeAonddIgQ5SN/fKignFc=
X-Sasl-enc: v8mEvhGQ0k15KOD4KKt0EiV8eng1FrkT0yMleklHSEYd 1444293784
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C53E76801B9;
	Thu,  8 Oct 2015 04:43:03 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56162634.2010800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279223>

Michael J Gruber venit, vidit, dixit 08.10.2015 10:15:
> James McCoy venit, vidit, dixit 08.10.2015 07:01:
...
> [No, this does not alleviate my dislike for the commit signature
> implementation, and I have not checked the patch - the test looks good
> to me, though.]

OK, now grumpy ol' Mike actually tested the patch with all our tests
that filter-branch something. All is good, and the new test catches the
regression when run without the patch.

I do think that the parser still has a problem that it had before
already: it does not distinguish between an empty line and an all white
space line (or else we didn't have a problem here at all).

In that sense, the patch is wrong, it does not correct the parser
deficiency. But it alleviates it for the special case of embedded
signatures, which currently is the only exceptional case that I am aware
of. It's not guaranteed to stay like that, of course. So maybe, one
should amend the commit message by saying that.

Michael
