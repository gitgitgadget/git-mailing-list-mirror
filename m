From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Feb 2013 14:15:58 -0800
Message-ID: <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3wF9-0004zr-N0
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 23:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947161Ab3BHWQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 17:16:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947131Ab3BHWQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 17:16:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57ECDB0DB;
	Fri,  8 Feb 2013 17:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MuFDiAztgi6MKKN6y/nRMiF4HNE=; b=DVeRhC
	PtnOPbdwvAHuRe4hAB9lYvDRtePziYcqCwTLByMN+9cPluTRLGE43474ZUIVgmw5
	cmaJlZOH4VdNWlMULGVZn1Y/MQEDR5PZbALhYKfZF2Vqld+Sji2dxvzMnvGwD8wn
	jJsb1+045ibRoSjt1ncIACkrdhFB/dnTv4NoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ULD+GYLRF3Q+mlsELlhCozDrklGn2KI2
	pM6bboeUsQur+YKmFDf4vo0z5s8khNYhPFpZHw3t0VezfgggQ2JZDpgiKKxLKV9H
	7HIfmRBxKsIo0vHRHAjsSebeoVnP8ykqsDBz7SCLeeaWe608sjAjYEIvDjC6nNav
	RzqiGHcfPYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A4DDB0DA;
	Fri,  8 Feb 2013 17:16:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFE88B0D9; Fri,  8 Feb 2013
 17:16:00 -0500 (EST)
In-Reply-To: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 9 Feb 2013 02:40:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EAFA756-723D-11E2-A580-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215822>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ...  Will Git ever
> consider using inotify on Linux?  What is the downside?

I think this has come up from time to time, but my understanding is
that nobody thought things through to find a good layer in the
codebase to interface to an external daemon that listens to inotify
events yet.  It is not something like "somebody decreed that we
would never consider because of such and such downsides."  We are
not there yet.
