From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 09:01:53 -0700
Message-ID: <7vsj2pf8ni.fsf@alter.siamese.dyndns.org>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
	<20130407170201.GH2222@serenity.lan>
	<CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
	<20130407175210.GI2222@serenity.lan>
	<CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
	<20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
	<CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
	<5161D3C5.9060804@web.de>
	<CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
	<20130407212342.GA19857@elie.Belkin>
	<CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 18:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUo5-0003IU-4d
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 18:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab3DQQB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 12:01:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3DQQB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 12:01:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C721464D;
	Wed, 17 Apr 2013 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rT1Swh5PXnsZRyZ3wfYFDt66B2g=; b=fUFOQS
	342WeOag4xi5UdFFwtBzxxZAWH8t3xBJ7XL7CebfIrk/km4qnHc7qvmLVeveZP0J
	Y2Y/FQV7awbGR1Uxfbl4tBXGaZQupIh92G6764YeBHaIYczynLLBA9yLCmMx73O6
	m1LvPKxRaaVrN7qHpC7xceFFrE29XIo88pyGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZk5dZOdrXBUKcwnFRUJZUnULfeSoTNv
	/YW2ObUmzjTaBfVouYOIJSPwSyx6y5W9YaqAm6z4Qt9X0o7acLU4ucyjsQP2tGaT
	ANYRx59caxF1+SV01nq1vs/yORQp39jo/QSUdUpoxpryAltfIdFXDuEZ12Ad6otq
	+VFf5KfR3sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 387FB1464C;
	Wed, 17 Apr 2013 16:01:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7A11464A;
	Wed, 17 Apr 2013 16:01:54 +0000 (UTC)
In-Reply-To: <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 17 Apr 2013 20:37:46 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FEBE8B2-A778-11E2-B219-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221551>

Duy Nguyen <pclouds@gmail.com> writes:

> Somewhat related to the topic. Why can't .gitattributes be used for
> storing what's currently in .gitmodules?

You _could_ use gitattributes to encode, but it goes against what a
gitattributes file does or is for.  It is a mechanism to associate
groups of paths (that may not even exist) to a set of attributes.
You could list a single pattern that happens to match a single path
and at the implementation level you may be able to make it work, but
at the design/philosophical level, it is wrong.

We need info on each submodule and we need to key it with the name
of the submodule, not with its path.  At any given time, a single
submodule lives at (at most) one path, so you could still use path
as a key in the .gitattributes, but when you need to move the
submodule path, you would need to update the entry for the submodule
in .gitattributes file by finding a pattern that match the old path
and making it a pattern that match the new path.

We have a much more suitable file format that we use to associate
various values to keys: the config format.  Also having a file that
is only about submodules and nothing else means we could write a
content-aware smart ll-merge driver that can take advantage of the
knowledge that it is written in the config format and it talks about
submodules.

The answer to "why can't" question is "no".  No, there is no reason
why you can't use it. We don't do it, because it just does not make
sense.
