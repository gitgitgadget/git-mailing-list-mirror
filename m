From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 3/4] fetch-pack: test cases for the new --stdin
 option
Date: Tue, 27 Mar 2012 16:43:08 -0700
Message-ID: <7vsjgty5ir.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715DBF.6030909@gmx.net> <7v4ntaj61t.fsf@alter.siamese.dyndns.org>
 <4F724F0D.7000602@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCg2o-0000TU-5L
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab2C0XnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:43:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229Ab2C0XnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:43:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9405060;
	Tue, 27 Mar 2012 19:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3r88b25InqwwiKkhwIM4qeR3ABw=; b=mr77Ds
	v0n8DUyM4L45OSMzYkGZqUD/msm8jVvR7o90ZNS2tSojOdM7JsFrt9H4TwjpPXeU
	wYJE+RvwDj47q9Ey9gFpUlr/SvQBaJx6O6wfFI2cctpZOkJYLT124nrxvW6svoGj
	LVS79VmHt079kpnn+zODIXywHitDYqej3cFQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bjmcnPKdIMhlbHuU5KvKnvYzkbFH1mGp
	GNHI2Chcz6xH1VeVODa9xkZ2fQeQkHUAYdj6Kwcyu+FlBSZvnBxqbZ1c51j4xr9h
	ZjSHYrscxVYuG1gEMvkA/eMnE8NPuUZCYoHpfi071vPQVDTh0wdd0shafpyvxdb3
	BXK8W2I6TLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6221A505F;
	Tue, 27 Mar 2012 19:43:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B8D0505E; Tue, 27 Mar 2012
 19:43:10 -0400 (EDT)
In-Reply-To: <4F724F0D.7000602@gmx.net> (Ivan Todoroski's message of "Wed, 28
 Mar 2012 01:36:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C56CEF4-7866-11E1-A216-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194098>

Ivan Todoroski <grnch@gmx.net> writes:

> On second thought, maybe we can just drop these two --stateless-rpc
> tests from this patch? The "git clone" test in the next patch also
> exercises the packetized refs in --stateless-rpc mode and if there was
> anything wrong with them it would fail.

Yeah, I was thinking about the same.

>>> +
>>> +test_expect_success 'fetch refs from cmdline, make sure it still works OK' '
>>> +	cd client &&
>>> +	git fetch-pack --no-progress .. $(cat ../stdin.exp) |
>>> +	cut -d " " -f 2 > ../stdin.act &&
>>> +	cd .. &&
>>> +	test_cmp stdin.exp stdin.act
>>> +'
>>
>>  - Do not chdir around without being in a subprocess ();
>
> Sorry, I didn't realize the tests were eval-ed in the current
> environment. I will correct all such problems in the next version.
>
>>  - Do not place the command you are testing that might crash on the
>>    upstream of the pipe;
>>
>>  - style;
>
> Noted.
>
>> 	(
>> 		cd client &&
>>                 git fetch-pack ... <../stdin.exp >stdin.raw
>> 	) &&
>> 	cut -d " " -f 2 <stdin.raw | sort >stdin.act &&
>> 	test_cmp stdin.exp stdin.act
>>
>> By the way, why are these not called "expect" and "actual" like most other
>> tests?
>
> The test files I worked with used the shorter exp/act convention so I
> followed that.
>
> Or are you wondering about the "stdin." prefix I added?

No.  I was referring to just that these two files were not literally named
"expect"/"actual", and I was lazy to look beyond what was in the patch
context ;-).  If the surrounding tests uses exp/act, mimicking them in
this patch is a good idea (we may want to fix them later but that is a
separate topic, and should not be done in this patch).

Thanks.
