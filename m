From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 12:14:34 -0700
Message-ID: <7v39eez1ph.fsf@alter.siamese.dyndns.org>
References: <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 27 21:14:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJVPW-00040A-Ni
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab1J0TOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 15:14:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab1J0TOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 15:14:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A244B25;
	Thu, 27 Oct 2011 15:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiqMQuaWFdXKe6DbRwtZVa4UtIY=; b=I+tnvB
	/aRGZcJVebDlMCpg3Qv5fy489w6pt5HFRZ2vOpeG23XTY+4gKh0XIJr6CmL6yUlZ
	3pZUV4AgO4remRI9iPru1KJdWEMdO0aaFEp9OCblmTxTh5HXqmVrsz6mWLIWlqxH
	ShrgCzSTx9UJqScyE+oww1W+ncMP4TDu2UXyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n1utxC6UE+Z8u2SotlLR6Gg0XkPXw05b
	SaHd62cnbP2Z84vpcxcGul6as2A7mw067RnoAuBYY/OTZRv6KaeNsN4C0GwhocBb
	5maf26ZPVM/DQrUrDhacOiINHIuZfPfSodbxefz5mzyPsvi4+geh8OJWV0rB986L
	XN93GI8TEOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1BA4B24;
	Thu, 27 Oct 2011 15:14:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E7744B22; Thu, 27 Oct 2011
 15:14:36 -0400 (EDT)
In-Reply-To: <20111027185220.GA26621@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Oct 2011 11:52:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E43086-00CF-11E1-AE3B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184317>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 27, 2011 at 11:47:27AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I'm tempted to detect the UTF-{16,32}{LE,BE} by their BOM, reencode them
>> > to utf8, and then display them in utf8. Is that too gross for us to
>> > consider?
>> 
>> I tend to think so; it is entirely a different matter if the user
>> instructed us to clean/smudge UTF-16 payload into/outof UTF-8.
>
> Minor nit, but this is just for diff, so it is not about clean/smudge
> but rather about doing something like textconv.

I can understand if some tools in the Windows land prefer to work with
these encodings, so clean/smudge to have the checkout in these encodings
would be a reasonable thing not just diff but things like grep. On the
other hand, I do doubt the sanity of these people if they want to have
in-repository representation also in these encodings.

So I do not think "it is just for diff" is any improvement.
