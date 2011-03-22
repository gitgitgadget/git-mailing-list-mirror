From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 10:35:15 -0700
Message-ID: <7voc53kqi4.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25UT-00082T-MG
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab1CVRf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 13:35:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab1CVRf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 13:35:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34F4446CB;
	Tue, 22 Mar 2011 13:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X0E0eZq3kaFpV+g3YE1yBO2jV8w=; b=LZirEk
	d785DtB2gubzp2/+NgH9a4hbnBO0YP6xKWjWQ+484rpPDfz9DvX5Pv5nzE3zPldw
	PGIcQdf1qPtPqizqElwQRgbDcbHfLTtObGLr/CtvL0JDClLM3fePdYS7msvr2Hdm
	q4UNU3aGoOSsB5aeBUF3Q6wY8ydNQz+foLiBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u9z1Lyl3fX13Gw00MKPAHLVM8s47ppuw
	qdQ9kTH0KFASYq1p/2iyDEcD59rEJ+ZYYZfA3KVRXmSnLJzrUOOkIzAT1HDVBPg/
	J55oZD2Bv7XDKJcdPJRc3ox5oUj5Qsm5jXnkzNfgjJfDKKKF+NHj4fsMwvFvssqC
	zIr7ytTtvhA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5ABD46C8;
	Tue, 22 Mar 2011 13:37:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92D9246C7; Tue, 22 Mar 2011
 13:36:56 -0400 (EDT)
In-Reply-To: <20110322111844.GA32446@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 Mar 2011 07:18:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEE1F98A-54AA-11E0-AA58-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169752>

Jeff King <peff@peff.net> writes:

>> > Oh, I should have been paying a bit more attention.  I've been assuming
>> > that we were turning "!anything" into { "sh", "-c", "anything", "-" }
>> > followed by the user supplied arguments.
>
> Yeah, I think that would be more useful in general, but...
> ...
> Doesn't it also break a lot of other more garden-variety aliases that
> rely on the automagic "$@", like:

Of course, silly me.

Because the most common usage of the alias mechanism is to package the
command name and common options and allow tacking other command line
arguments after them at runtime, and it is silly to require the user to
say "$@" (i.e. 'lg = "log --oneline"' example), any alias that wants to
use positional parameter should do the 'sh -c "$str" -' packaging itself.

So there is nothing to fix after all; I was just confused by seeing the
initial report which was just a usage error.

Sorry for the noise, and thanks.
