From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] reset: add option "--merge-dirty" to "git reset"
Date: Thu, 10 Sep 2009 22:34:43 -0700
Message-ID: <7vws4611u4.fsf@alter.siamese.dyndns.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
 <20090910202333.3722.37592.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:35:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlymy-0000Z6-6N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZIKFfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZIKFfG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:35:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZIKFfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:35:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7C924C8BC;
	Fri, 11 Sep 2009 01:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PjmIVCKWA8nQM1D/nt743BfcYa4=; b=FAVgvw
	lG/2LHNu49mVuYZ3QByFCKG5yxEhS6XAsedtdf720WPq5icEz/2dnQRhX12JwBwI
	aD+NbuE+lwyN9dC8tatYYoyiUOD/5NdcxckY4X/Y9qrMUSY2a3jEkCvKFUugxWgo
	5bjaj8GEMsTK//vyFTQgiuaZa+Z0nXFpz1zZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rzX2kFp4LvF4fbFrpgMcgnYGEmDzD4td
	D55IafM9zhgHKi2XcAepMaSdAIN/WGMwWttK8vVoIMusR3L7wmL4DhWhWCKYWyYl
	M+vMfXAS7jfQ4Bhz6zH7imj8KhfVtvPbZx76cSdLm7FTaPFTnuZptU6jZ3KOphVA
	wbHAc9R7P7Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87CDC4C8B9;
	Fri, 11 Sep 2009 01:34:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C10FD4C8B0; Fri, 11 Sep 2009
 01:34:44 -0400 (EDT)
In-Reply-To: <20090910202333.3722.37592.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu\, 10 Sep 2009 22\:23\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8AA89EE-9E94-11DE-88F2-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128175>

I have two comments (and I share Linus's puzzlement).

> From: Stephan Beyer <s-beyer@gmx.net>

 - Trying to give credit to Stephan is nice, but comparing this with bits
   from the previous round, I am not sure if you need to keep calling this
   Stephan's code anymore.  Perhaps it would be enough to replace the last
   three lines in your commit log message with "Uses some code from
   Stephan's GSoC work in git://repo.or.cz/git/sbeyer.git repository".

   And I would actually prefer you take the authorship, especially if
   Stephan's series does not add an option to "reset".  Then we know whom
   to forward any bug reports to ;-)

   I did not compare this with the GSoC repository, so maybe this is what
   Stephan did after all, but still I thought it is worth to ask.

> This option is nearly like "--merge" except that it is a little bit
> safer as it seems that it tries to keep changes in the index. On the
> contrary "--merge", only keep changes in the work tree.

Nearly, a little bit, seems and tries?

These words do not build confidence that this new feature is robust and
behaves predictably.

Of course, you are not adding a random number generator, but a useful mode
with a bit more complex behaviour than "--merge that _always_ discards
changes in the index."  So as the salesman, you would need to do a bit
better job to explain what the new behaviour is, and why it is better to
have that new behaviour than the behaviour of --merge, to sell that new
feature.
