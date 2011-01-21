From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Fri, 21 Jan 2011 08:51:47 -0800
Message-ID: <7vsjwmp5cs.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 21 17:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgKDi-0002b8-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 17:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab1AUQwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 11:52:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab1AUQwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 11:52:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8BEE24B7;
	Fri, 21 Jan 2011 11:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=w+cLpr3m1ETq7GuJDeVWz5CghRg=; b=KQq8Tz
	X/PBsOgQ8cN88oJMfZ3iSV9Tog+bgZA8deY9lprEwoCLHMBaybnCM6ORRrnQMrv4
	H6ey3/QUE8YCVvSluOhFqxG6WZlShmpxGj9gYXH8TPgTiuHYeu6Yf84baF0bzh3r
	4baKLmOn9oOEBU48weOqyvSN2x0w6BILEzCaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gRN6kII26981F/uvs6Fyp03VZCu3Uhx6
	EXaIlrgwNUGMUn2z5wBeoVZ5gVFuQ9t2bTVLV+zhN1a0vHiwGQxRTo8CEm4sSRy6
	/bN+Qrf9coNsabIcipNh1fMVVho25fT3xncyy0FKFwjZpMPEDv6gh6hfQOApW43q
	r+aaO6JWwlQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33BF824B2;
	Fri, 21 Jan 2011 11:52:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 937B8247D; Fri, 21 Jan 2011
 11:52:36 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 21 Jan 2011 08\:04\:07 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0612158-257E-11E0-828B-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165381>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Wouldn't that suggest us that if we were to do anything to this message 
>> it would be a good idea to teach the user to "reset --hard" the branch 
>> if no commits truly needs to be replayed on top of the onto-commit?
>
> The important difference between rebase -i && noop on the one, and reset 
> --hard on the other hand is that the latter is completely unsafe. I mean, 
> utterly completely super-unsafe. And I say that because _this here 
> developer_ who is not exactly a Git noob lost stuff that way.

I think "rebase" already checks that the index and the working tree is
clean before starting, so referring to "reset --hard" when "rebase -i"
notices there is absolutely nothing to do is _not_ unsafe, no?
