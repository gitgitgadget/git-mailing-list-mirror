From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query filenames with spaces
Date: Fri, 02 Aug 2013 09:41:52 -0700
Message-ID: <7vtxj8oxin.fsf@alter.siamese.dyndns.org>
References: <20130801201842.GA16809@kitenet.net>
	<20130802064003.GB3013@elie.Belkin>
	<20130802105402.GA25697@sigill.intra.peff.net>
	<20130802115906.GA9183@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 02 18:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5IQS-0000gb-Vg
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 18:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab3HBQl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 12:41:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab3HBQl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 12:41:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B353934ACC;
	Fri,  2 Aug 2013 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rb51aIaQfzCCwpNRcFbhk50gBqM=; b=nJMACh
	m+wlY0U+W5ese15NKXOeETxEDCqKQH9RyYy6Yy2gAMo+OahG/TFa/iNUKV/sts5R
	X5XgkjDwN/rTsN6hm9l6v6wbqN6uvAiV0aiHcyZ38ncBnBIWHt3X67DReRuSzIRO
	iE3WtVtfB4kdat813es+Y/BHayqzx99+ZrQps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MvI5PIu3u8iwr4B6D1mrs7xf8xLKJYxh
	N7c6AC59Ssj3qX+bQo5ZtCl8LJwj5kUJzWU4aaGn12gVPlK5xrl2S7h/LjASQMCf
	d7Ve5NWnuX729C/Cpk67nzLOAJ0rdRDN8hx75aXG0cppKtVEIvcgTUtLEwTTSUHC
	pvRwx60NoTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A56A134ACA;
	Fri,  2 Aug 2013 16:41:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 446EC34AC7;
	Fri,  2 Aug 2013 16:41:54 +0000 (UTC)
In-Reply-To: <20130802115906.GA9183@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 2 Aug 2013 04:59:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7065E34C-FB92-11E2-A184-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231531>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 02, 2013 at 03:54:02AM -0700, Jeff King wrote:
>
>> We need to revert that commit before the release. It can either be
>> replaced with:
>> 
>>   1. A "--split" (or similar) option to use the behavior only when
>>      desired.
>> 
>>   2. Enabling splitting only when %(rest) is used in the output format.
>
> Of the two, I think the latter is more sensible; the former is
> unnecessarily placing the burden on the user to match "--split" with
> their use of "%(rest)". The second is pointless without the first.
>
> A patch to implement (2) is below.

As I'd queue this on top of the revert, I had to wrangle it a bit to
make it relative, i.e. "this resurrects what the other reverted
patch did but in a weaker/safer form".

This will be kept outside this cycle.  Thanks for a quick fix.
