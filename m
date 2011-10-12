From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #04; Wed, 12)
Date: Wed, 12 Oct 2011 12:05:43 -0700
Message-ID: <7v62ju9gjc.fsf@alter.siamese.dyndns.org>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
 <20111012190213.GA19578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE47j-00007q-E9
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab1JLTFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:05:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab1JLTFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:05:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4AE44CCB;
	Wed, 12 Oct 2011 15:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oCA6EDq3qrGwSktNEZOCchmDJnw=; b=sFQ1Ht
	yCDPP9p11CvtNZcPgSNekT4D+7A7aoVM6iqUHTPfPYIqN8FFgRfKwhvducynq8/+
	ALa+9SMojaNXpU/UcZNsaVzDr813yP3IUqoLr6O1vy4YOvca5L6LSNZQbYfoZk4Q
	QUXBe6u+brWrgEqoh7jdXdmaLKrGNLK/hzfZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lILqfj+5Yt8df+/fpZlirIz/o5rAvJPd
	mko74bCD2JRUhmgt2FTkAucUpY2SOaYBpb2b9/eJXcbh76nqfYswY3gumGPW989v
	GN7yumvAysgDzbuIoxtjdFpz2TnvciDXStu1m4DvgWG9AvDi/Yl3wj4InicQYiak
	v2RG9LNzIsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4924CCA;
	Wed, 12 Oct 2011 15:05:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54F394CC8; Wed, 12 Oct 2011
 15:05:45 -0400 (EDT)
In-Reply-To: <20111012190213.GA19578@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Oct 2011 15:02:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3035DC5E-F505-11E0-9A86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183400>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 12, 2011 at 11:48:48AM -0700, Junio C Hamano wrote:
>
>> * jk/name-hash-dirent (2011-10-07) 1 commit
>>   (merged to 'next' on 2011-10-11 at e2ea68b)
>>  + fix phantom untracked files when core.ignorecase is set
>
> I didn't see any comment on the original patch, so I assume you're OK
> with the few extra bytes added to each cache entry? Otherwise, I can try
> to retool it to keep the directory entries in a separate hash, so only
> case-insensitive people pay the extra price.
>
> I did a few trivial timings, and the extra bytes didn't seem to make any
> difference.

I tend to agree with you that 8 extra bytes per cache entry wouldn't hurt.
I also suspected that the cost of code complexity coming from both
maintaining and conditionally looking up a separate hash would outweigh
the benefit.
