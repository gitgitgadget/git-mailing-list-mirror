From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Fri, 24 Oct 2014 17:36:19 +0200
Message-ID: <544A71F3.1020607@drmicha.warpmail.net>
References: <cover.1413990838.git.git@drmicha.warpmail.net>	<13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net> <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 17:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhguf-0002bP-PW
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 17:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbaJXPgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 11:36:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41496 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751907AbaJXPgV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 11:36:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BFC4E206D2
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 11:36:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Oct 2014 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=U7OyTzeiU16jp4cw/vz1WG
	H8M2w=; b=XYudcNUHy1z5vRFX5TYLCqgyzoRgZJwKd6zXnvXsY9c3iYk6Acm27J
	4HxlNtneLdKatTa+RskvzlMw9V6AasoFnlGYxOarJ9gwvUp3k9x47iUOj/a62tLc
	NMtagtUZdR5eePwQ8zhuXCpTlgTBkR489UBkCMB9GNAxzrgZeSp88=
X-Sasl-enc: XneXoCtPZt5g6kvI08b2BoO9HMk8ct6CcDT6RrrROb4q 1414164980
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 37731C00014;
	Fri, 24 Oct 2014 11:36:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb am 22.10.2014 um 21:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Various formats for storing signatures have accumulated by now.
>> Document them to keep track (and maybe avoid yet another one).
> 
> I haven't looked at the description closely, but it is a good thing
> to describe signature in a tag and in a commit in detail, which we
> failed to do so far.
> 
> The principle is essentially the same between the signature on a tag
> and on a commit: a detached PGP signature over the remainder of the
> object data is created, and then the signature is inserted into an
> appropriate place in the resulting object.  That "appropriate place"
> is influenced by the type and nature of the object.

Yes, the detached signature can't easily be appended to a commit object
the way it follows a tag object. Conversely, signed tag could easily
look like signed commits do (sig in header), but that would require a
migration procedure.

> A mergetag is not fundamentally a "signature" in the above sense,
> though.  It is just a dump of the object content in a regular object
> header field (hence indented by one SP), and its contents having PGP
> SIGNATURE is merely a natural consequence of the object recorded
> being a signed tag.  So the description of it in the same place as
> description for signed tags and signed commits feels a little bit
> out of place, but I do not think of a better place to describe it.

I guess referencing the tag object (like other objects do) rather than
embedding it would have had its merits, but that is beating up a dead
horse. On the other hand, we could migrate to "mergetag sha1" rather
than "mergetag object foo" which is easily distinguished, but only
embedded objects are "safe" against non-aware gits.

> Thanks.

Thanks, Jakub and Junio.

I will correct the wording for the multiline header and put the mergetag
last to make it clearer that it's related but different.

Michael
