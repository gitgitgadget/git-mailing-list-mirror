From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: remove ternary operator evaluating always to true
Date: Mon, 12 Aug 2013 10:15:48 -0700
Message-ID: <7vzjsmzv7f.fsf@alter.siamese.dyndns.org>
References: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com>
	<20130810072114.GD30185@sigill.intra.peff.net>
	<7vli471mxy.fsf@alter.siamese.dyndns.org>
	<52089D81.5010506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:16:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8vin-0005sW-RF
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466Ab3HLRPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:15:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757343Ab3HLRPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:15:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C382D38755;
	Mon, 12 Aug 2013 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0eyOg98XdnGbAF9TtL6XwDxewFE=; b=w9/y75
	KjrFBbGc/SvRPoxVkFnYaIP6exmegvw7mTvI1aBljIEtnCQ7XMthugT8Fa/3t2Zy
	BG/4olffKRxMXNAXrwJAkplkjUmqPe4wi/uvI5T6GmZjq9PWzcjpmGt8eifZf7wn
	5Zd2brAzvsqkffYYl6lQpvvGAa/d88bcDIEC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpkMBpR8SBYpYw9vVLOZdSc2GyNn57eQ
	8GWWr9bldS7663MiBRkm/2Xr7xL866Epm4HsO6R1eI8v9U+rmzdVC0ghkh3CJZY7
	6bPRUn1Z/MB2yxqPfJiKf5w4S8PlAAEbhJ6A66biLBwTysaeoiC925Syx90JLZuF
	o9TU06V7IH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC3038754;
	Mon, 12 Aug 2013 17:15:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A3A63874E;
	Mon, 12 Aug 2013 17:15:50 +0000 (UTC)
In-Reply-To: <52089D81.5010506@googlemail.com> (Stefan Beller's message of
	"Mon, 12 Aug 2013 10:32:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6348C40-0372-11E3-BAF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232200>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 08/12/2013 07:46 AM, Junio C Hamano wrote:
>> I think that is an overall improvement, especially if we also update
>> the checks of {one,two}->mode made for the block that deals with
>> submodules to use DIFF_FILE_VALID().
>> 
>> Thanks.
>> 
>
> So, do I understand your reasoning, when proposing this patch?

I meant the condition in the "if" statement, not the parameters to
show_submodule_summary().  There are checks on ->mode fields that
bypass the DIFF_FILE_VALID() macro, hurting readability.
