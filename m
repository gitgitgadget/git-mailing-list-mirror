From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 12:05:38 -0700
Message-ID: <7vvdiftb0d.fsf@alter.siamese.dyndns.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 21:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mys7o-0003LN-NH
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 21:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbZJPTFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbZJPTFz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 15:05:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbZJPTFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 15:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E12CD5BD3F;
	Fri, 16 Oct 2009 15:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ml2hpQqYhUYc
	y1RBk6FIRZZ4Ul0=; b=AdDkiQoZNkVLyHtlETKuTHYy/rcdN2qCYCTqawwUbvOv
	65vwFKudnEyLtaZJToT7p0OvpDChJQcFRwlt636iJRd4UpEQWupA67MXyT+tbJj6
	yRIoB694khJfOLHwn+sYI2qIhJFjC4E+J6TLw12HhwnYmFY1FtIWCFbWceo4LXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IzE/Hh
	8P7ZJuUZNJVCp90NiaFcB/PULyBjg1joncOTK5QRIkKPXN6CLjUl0hg2QRgY3Kvc
	czPadVEoQLiL34xKkxHPSk3MX4Ux0KAZrMN0VJeJcu1XKYNZEyQk7GsnVDUQiYdn
	GqUC4pA+d1r85Lw1jJR1oqwCRff89V+FHvucU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 746D95BD3B;
	Fri, 16 Oct 2009 15:05:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A3415BD3A; Fri, 16 Oct
 2009 15:05:39 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 (Julian Phillips's message of "Fri\, 16 Oct 2009 18\:31\:23 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB57FCDA-BA86-11DE-B5AB-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130522>

Julian Phillips <julian@quantumfyre.co.uk> writes:

>> And such uncommitted changes would be lost in the big "undo the fetc=
h
>> update" diff. So you'd have to do:
>> git reset --soft HEAD@{1}
>> git checkout --merge HEAD@{1}
>>
>> to keep them, while updating to the new state of the remote tracking
>> branch. Not quite intuitive, is it?
>
> I don't care what git has to do, I'm talking about the user experienc=
e

But Bj=C3=B6rn is showing two commands the _user_ has to type, iow, the=
 comment
is about the user experience.
