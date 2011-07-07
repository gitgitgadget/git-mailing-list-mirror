From: Junio C Hamano <gitster@pobox.com>
Subject: Re: generation numbers
Date: Thu, 07 Jul 2011 12:34:37 -0700
Message-ID: <7vliw9hoky.fsf@alter.siamese.dyndns.org>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706150103.GA2693@thunk.org>
 <20110706181200.GD17978@sigill.intra.peff.net>
 <201107062046.43820.jnareb@gmail.com>
 <20110707185908.GB12044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 07 21:34:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeuLW-0003GL-Be
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1GGTel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 15:34:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab1GGTel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 15:34:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30629665B;
	Thu,  7 Jul 2011 15:34:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PAD71j8iVuldvDqbEDRAxyAZvlU=; b=PzsOws
	w1ABcPzbEdG49ARyISefAQsaqNSpaTkJ1BbPdRcg59M5E9OYlvSxMjN/lis6Jwf1
	LokmhcKGplH/Md0oX1oFAXHjW442xWD4l+s3ivlmjOgYrR7iCG0zlWjo6aBMrq78
	dSxD+MXS7AN7A0vQm1OGFdBK4aQ0cs4FIzSn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDpLqZrj3nq24gE7uOytTViKDSQepOa9
	2VjjUvjBRRY92b95jUQ7prqEmV1IAAWF2qMO7TS9wg2B4ZqgSaD0mU9QCRdvrX4U
	vQjV+MJtM4Ful3JwaDdUp/VOiw6hJ9W9PWpnjch0eyhvGf8m4nLehd+2T/bn3S1N
	iTrEEZqoJm8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 282DE665A;
	Thu,  7 Jul 2011 15:34:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78D5A6659; Thu,  7 Jul 2011
 15:34:39 -0400 (EDT)
In-Reply-To: <20110707185908.GB12044@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Jul 2011 14:59:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27CC711C-A8D0-11E0-B23E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176775>

Jeff King <peff@peff.net> writes:

> You could "cheat" and instead of storing the sha1 of a blob object in
> the notes tree, use the lower 32 bits to store an actual value. I don't
> think that currently breaks any assumptions in the notes code, but it
> definitely is against the intent of it.

I highly suspect that it would break fsck rather badly.  You may not even
be able to repack a repository with such a notes tree.

> For a local lookup cache, I would use a fixed-size binary integer just
> to keep the lookup data structure simple (then you know the width of
> each record ahead of time). For a generation commit header, obviously we
> would go with the ascii representation as we do for other headers.

Yes.
