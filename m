From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: Demonstrate breakage with --ancestry-path
 --all
Date: Thu, 25 Aug 2011 16:49:50 -0700
Message-ID: <7vhb55gig1.fsf@alter.siamese.dyndns.org>
References: <20110824213205.GI45292@book.hvoigt.net>
 <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> <7v4o15hyxx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwjgN-0002PP-4S
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1HYXty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:49:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1HYXtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:49:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CDF5F1C;
	Thu, 25 Aug 2011 19:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mztPFUbvVNpD+067YuCUXwHAPYo=; b=Qq+v7l
	K0nqPQh3fEM6FIedb9po+Tm2/uyi9BEHMywaLTA6E001ipsbRAY9q7cRYPhX52A+
	/aMZ6XrM/JQKShirEp4zvCe5ls5C4WGaJyCdxMnD6fRFkP5N+dl6V/IcVPyH/fHj
	Unx8RZ+++SJEA8jWn+rfvuiqqopGq/o16cW2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PRfgAQMBglP1zqAe5ra8lNb6gK1xz9PW
	GHBrmQ72VuB3Q47xvteW7mmpcAL7MZQ9k/kMXwosWl+JezD0KIQE6m2dXjIjOVBb
	HK+rjCenOPxvrcypMuPysOXzgqao1nrZRik4lVYEp0Q/CxGv6n4ji8UIM96KA0kz
	K9iRuWLTHKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEEE25F1B;
	Thu, 25 Aug 2011 19:49:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 513005F1A; Thu, 25 Aug 2011
 19:49:52 -0400 (EDT)
In-Reply-To: <7v4o15hyxx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 25 Aug 2011 16:08:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED2D484E-CF74-11E0-99E2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180140>

Junio C Hamano <gitster@pobox.com> writes:

> Brad King <brad.king@kitware.com> writes:
>
>> The option added by commit ebdc94f3 (revision: --ancestry-path,
>> 2010-04-20) does not work properly in combination with --all, at least
>> in the case of a criss-cross merge:
>>
>>     b---bc
>>    / \ /
>>   a   X
>>    \ / \
>>     c---cb
>
> Hmm, what should --ancestry-path do given more than one positive commit to
> begin with, let alone --all?

I actually think that this does not have much to do with "criss-cross"-ness. 
Instead of computing those that can be reached from cb, we are computing
those that can be reached from either b, c or cb.

This needs fixing, but it takes a bit more than a quick hack. Stay tuned
;-)

Thanks.
