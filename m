From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref namespaces: tests
Date: Fri, 15 Jul 2011 12:37:42 -0700
Message-ID: <7vhb6n1gjd.fsf@alter.siamese.dyndns.org>
References: <20110714205055.GA26956@leaf>
 <7v1uxs3177.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoCs-0006Mn-86
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1GOThp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:37:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1GOThp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AAD547E8;
	Fri, 15 Jul 2011 15:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xs1yyvqqHn2qILOWov70rh7tsgQ=; b=ZM+3WG
	kSWoaYoNFsmg5+Ntg8acG6IDJSSILYmy0OhRlw9HOK1ggCEkhB4snM2l8Vd71lYk
	etinICPKcrFxubpRZNQOTjPoOeuzZB2DJjVSxw2Fii/ZMGhRY6KrrMud39raHd5w
	mfaJRgoi1NVC4LAJMBRyVEPvf++GPVM2aHHBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PqO3R8JG5BpDau3/VLoAADzJZYB+JdWd
	x6CZSY7wfq/U8MHFPzEKBDfMlW7xOckU1XU3VJ+xT1FPypWAdfbYO4Lr9cT9bYem
	ZOIxWX33ismHG01HBAkkG8zGP3KCDu75aU1bkZRdCkxc+1DfiIM1XHzx38Vc8GMo
	0aMvolfx9po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 400CF47DD;
	Fri, 15 Jul 2011 15:37:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A00A147DB; Fri, 15 Jul 2011
 15:37:43 -0400 (EDT)
In-Reply-To: <7v1uxs3177.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Jul 2011 16:13:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DD305E-AF19-11E0-96EF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177217>

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'pushing into a repository using a ref namespace' '
>> +	(
>> +		cd original &&
>> +		git push pushee-namespaced master &&
>> +		git ls-remote pushee-namespaced > actual &&
>> +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba\trefs/heads/master\n" > expected &&
>
> Could you avoid hardcoding the exact object names here?  Your script knows
> what object should appear at refs/heads/master at "pushee-namespaced" (as
> you have pushed from the repository "original" you are in), so it may be
> something like:
>
> 	printf "%s\trefs/heads/mater\n" $(git rev-parse master) >expect
>
> Same comment applies for all the other hardcoded object names.

Just FYI, I did a sample fix-up for earlier tests in this patch and pushed
it out in 'pu'; hopefully it may save your time.

Thanks.
