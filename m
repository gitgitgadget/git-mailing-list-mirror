From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Mon, 24 Nov 2014 11:15:34 +0100
Message-ID: <54730546.7000200@drmicha.warpmail.net>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net> <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Git Mailing List <git@vger.kernel.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:15:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsqgH-0004jd-Am
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 11:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaKXKPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 05:15:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41110 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbaKXKPg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 05:15:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3858A208CD
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 05:15:36 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 24 Nov 2014 05:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=VZc9byXJ1jkeOUpqFX9G67
	iyZQ8=; b=hdz78L8oNRbm16udZopqomYjNC1XmRxjruO2iy82kPysxdslcDmU6N
	L8cloe56XnJnKYMpub5EbxkT3VQT3tQPDyjzFkUOXfaaKTvVOHcRdooq56EaPwFa
	ze/hOOMBAMm5xGNauyDZnvmG8MzP059aErk2lmHsJlrSnk6ByMUEo=
X-Sasl-enc: s45fbquDLKDNArd+w7InwxJ5gYjKqTavOTbgA758zK2c 1416824135
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 32392C00284;
	Mon, 24 Nov 2014 05:15:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260119>

Duy Nguyen schrieb am 24.11.2014 um 02:23:
> On Tue, Nov 18, 2014 at 4:26 AM, Jeff King <peff@peff.net> wrote:
>> Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
>> only a SHA-1 hash. If somebody can find a collision with a hash you have
>> signed, they can substitute the colliding data for the data you signed.
> 
> I wonder if we can have an option to sign all blob content of the tree
> associated to a commit, and the content of parent commit(s). It's more
> expensive than signing just commit/tag content. But it's also safer
> without completely ditching SHA-1.
> 

This amounts to hashing the blob content with whatever hash you told
your gpg to use (hopefully not sha1 ;) ) and signing that.

You're free to do that now and store the signature wherever your
toolchain deems fit, say in a note or an annotated tag. But that
approach won't sign the history, that is: If you are concerned about the
breakability of sha1, then history is "possibly broken" no matter how
you sign a commit object whose "parent" entry is based on the sha1 of
its parent object.

Cheers
Michael
