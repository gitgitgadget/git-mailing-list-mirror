From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] log --grep: honor grep.patterntype etc.
 configuration variables
Date: Thu, 04 Oct 2012 12:09:47 -0700
Message-ID: <7v7gr6yryc.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-7-git-send-email-gitster@pobox.com>
 <20121004081732.GD31305@sigill.intra.peff.net>
 <7vehle18y5.fsf@alter.siamese.dyndns.org>
 <20121004180122.GB2623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgC-00033L-4m
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab2JDTJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:09:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781Ab2JDTJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:09:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF0AC9977;
	Thu,  4 Oct 2012 15:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vz6bkVi4zadnVHx6Y8vswG9QZ/E=; b=OOxEic
	t0D7fopWtxTb4Xw+KcNig2saxddSkjfs9eh5n/h1zOO4FEd/NWkt7B5bc+B1YgWT
	rKUHMK0JNu8HfxT1IonFP1XndIKNOkcpAemHiNKOE6XhJ/3m2l+D0PEtmdHjtJ/O
	/XdZnMkXFr8+vc1NucE+AO6we2l1U8MDtkJ68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fsP3H8uN0zplMn6Iyij0AJM4yYlGjYGq
	iALKKa3Bq++scgUqjSOyd+1s9DcjFm7eXSr1lQG65YGs694i5vaNPpAbO5qS4qif
	EeWIOVK91Oxv/Gk1Ff9Ft1k8h/Dph/CZ/AezPUMOd1zRW/rOsx0bEk1h+MPzVt5p
	8YJymXkooTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC5DE9976;
	Thu,  4 Oct 2012 15:09:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2918D9973; Thu,  4 Oct 2012
 15:09:49 -0400 (EDT)
In-Reply-To: <20121004180122.GB2623@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 14:01:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 116C1574-0E57-11E2-86FA-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207011>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 04, 2012 at 09:46:42AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Hmm. So I think this is a nice feature for some people, but I wonder if
>> > we would run into any plumbing compatibility issues. People do tend to
>> > use "log" as plumbing (since rev-list is not as capable). On the other
>> > hand, I'd think most internal uses of "log --grep" would be passing
>> > something along from the user, and the user would be happy to have it
>> > interpreted by their chosen set of rules.
>> 
>> This does make "rev-list --grep" aware of the configuration but at
>> the same time --basic-regexp and friends are also available to it.
>
> Does it?

Ah, it doesn't.

You can still say "rev-list --perl-regexp --grep=pcre" but that is
not what 6/6 does.
