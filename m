From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Tue, 11 Aug 2009 20:26:58 -0700
Message-ID: <7vljlpaf0d.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
 <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
 <20090811214849.GA3868@sigill.intra.peff.net>
 <20090812075914.6117@nanako3.lavabit.com>
 <20090811230233.GA25642@coredump.intra.peff.net>
 <alpine.DEB.1.00.0908120212500.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 05:27:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb4Uu-0006wR-W5
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 05:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbZHLD1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 23:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755682AbZHLD1L
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 23:27:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799AbZHLD1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 23:27:10 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E97D7C63;
	Tue, 11 Aug 2009 23:27:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 456FD7C5F; Tue, 11 Aug
 2009 23:27:00 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908120212500.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 12 Aug 2009 02\:14\:12 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 052644F2-86F0-11DE-8D01-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125652>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I have no problem with that, and I think it makes it even more visually
>> obvious what is going. For example:
>> 
>>   svn::http://server/path/to/repo
>> 
>> makes the "svn" prefix jump out a bit more.
>
> ... and http:://repo.or.cz/r/git.git ?  Thanks.  But no, thanks.

Huh?

If you meant a "canonical format that always spells out the name of the
helper, and then whatever string the chosen helper uses to identify the
repository", that would be spelled as:

	libcurl::http://repo.or.cz/r/git.git/

and will be handled by a single helper, git-remote-libcurl, that is
essentially what Linus and Daniel ejected from the builtin.

And in fact, that would be vastly more sensible than "we have one helper
that uses libcurl, but we hide the implementation detail and call the
helper with three names git-remote-{http,https,ftp}, so you would spell
the repository http://repo.or.cz/r/git.git/", which is what we have queued
in 'next/pu'.

And of course the use of "canonical format" for transports that git
traditionally has known about is only for consistency; we would want to
give shortcut for them.  Obviously we would want "http://<anything>" to be
a short-hand for "curl::http://<anything>".
