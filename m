From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 18:19:34 +0200
Message-ID: <552D3E16.7090504@drmicha.warpmail.net>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>	<552CD4C8.2020700@drmicha.warpmail.net>	<CAHGBnuPepR11r9qpxb2G7pGhq0iiaqCCLnbt5NB_xohHi=cVxA@mail.gmail.com> <xmqq1tjn3vzs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi3Yw-000799-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 18:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbbDNQTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 12:19:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36740 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753196AbbDNQTg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 12:19:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DC57A20CB6
	for <git@vger.kernel.org>; Tue, 14 Apr 2015 12:19:35 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 14 Apr 2015 12:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ay/mbCBzKtrPAItJl0iS88EzUgs=; b=OgGNru
	ftLh3iutkEJFLFS2+Veu1lr4oF2uffECt31SamaNlVRD9d9/7wmfqDn01OMMZ10r
	UniQO17/it/DPoDYhKvkCaHpBRZ5KK0F5UGQNgRx83E3ggOv3c4ADPM+TKzGimAk
	LlkHHzGhd4QQdZwXxYkXT/bu/ceZeq3En0BCg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ay/mbCBzKtrPAIt
	Jl0iS88EzUgs=; b=jss3flhvhHDkGRER4FrgLBTCQ9You25/N30dTXwkw0LXpd9
	90a201nkgA4mx7lg2wKmqMmneCzKezCsajCEhfiqsXzBQnn2o+8QR0Do/JUEvr1V
	5tjvKzMNdcLvy7PJOPe/7ZKTWXcZPr66nVYVThFw6XSZdHJjh3Lx9sMWdWJY=
X-Sasl-enc: Ilh1BgfX5TvbdgGEYeGj/Ofr33UVUzuLqUO1Fy2OCI4i 1429028375
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4486368016C;
	Tue, 14 Apr 2015 12:19:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq1tjn3vzs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267144>

Junio C Hamano venit, vidit, dixit 14.04.2015 11:22:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
>> On Tue, Apr 14, 2015 at 10:50 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>
>>> "to dangle" means "to hang loosely".
>>>
>>> So, in the description above, "A^ dangles from A loosely" because it
>>> hangs from A (you can reach it from A) but loosely, because it would
>>> "drop" if A gets dropped and A is "likely" to be dropped (because it is
>>> unreachable by refs). But A^ is not dangling in our terminology.
>>>
>>> If you *reverse the arrows*, i.e. consider A^ pointing to A, it becomes
>>> more apparent that A is dangling: it is an unreferenced leaf node.
>>
>> That's exactly what confused me. In the very literal sense, something
>> can only "hang loosely", i.e. dangle, if it's only tied at *one* end,
>> and that's the case for A (which is only connected to A^) but not for
>> A^ (which is connected to its parent, and A). Especially when talking
>> about A as a "leaf" node, like in the leaf of a natural tree, I would
>> think that A is dangling.
> 
> I am not sure if I follow, but probably it is just me who is not
> strong at math, or whose eyesight is not keen enough to notice the
> arrow heads on links between the commits.

"git log --graph" does not show arrow heads, obviously. Many
illustrations about Git do.

The relation between commits is clearly directed: A being a parent
commit of B is different from B being a parent commit of A (and both
cannot be true simultaneously due to the "A" in "DAG")

 > I just visualize commits to be ping-pong balls with strings between
> them, and then grab the root of the graph and lift the whole thing
> up, while tips of the branches and tags are anchored.  Commit A will
> be dangling in the wind if you shake the whole thing.

If you don't have a concept of direction it is difficult to distinguish
roots from tips...

Our commit relationship is certainly a directed one. You can define it
using either "is parent of" or "is child of". They are opposite, and
lead to opposite notions of "root" (a node without predecessors) and
"tip" (a node without successors).

> But that visualization breaks down once you start thinking about
> what will happen to A^{tree} and its blobs; they are attached to A
> with thin strings and they will have to float above A (i.e. sit
> somewhere closer to the root of the tree) just like A^ will go
> closer to the root, to make A appear the "dangling" one, as the
> direction of the arrow is from A to A^{tree} just like we have an
> arrow from A to A^; just like A^ is not dangling because of A,
> A^{tree} is not dangling.
> 
