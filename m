From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: treat inaccessible directories as ENOENT
Date: Fri, 30 Mar 2012 09:21:29 -0700
Message-ID: <7vmx6ym54m.fsf@alter.siamese.dyndns.org>
References: <20120330075217.GA8384@sigill.intra.peff.net>
 <CAH6sp9N=JsWp7iQ=AAdXHe0J+aB5L9cBq2_0BJgUO=Y-vgAbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	James Pickens <jepicken@gmail.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDea1-00031c-9D
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab2C3QVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:21:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab2C3QVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:21:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 529F654E5;
	Fri, 30 Mar 2012 12:21:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IK7BwxLwdjqs/GiaR+AEHPN+AKc=; b=Ot4Xex
	xV+iqvJDDujvASm17aQ8DYIL8ORDazA4dRy8AQX3/O5Z53oDvk1z+a2itxebZcC1
	enctTxtECXKFgwNQ5p3nLYJYW207jNyTaRhq6CLykODoG6og6FHMUKGugNQOT1Lx
	AFSoDuHReWz2/6DDCxtelKYZrZuru542awFVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWhhsYKHmrSlTkG3J4DCk4JhbNtkECY0
	NZNEC9TrJKdSJ3IPJ0pQ0GPpaqDuqCshtZDBbr58YAtNOp4eEKn/ER13/xw3eIKY
	2v92qyOmEuFBZpVrczCdy5ObVuZF0gJNy533HY4KrftBJDScnGMnj+1nVBP8IBFn
	/+q6hc6Srno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A0E754E4;
	Fri, 30 Mar 2012 12:21:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABF4D54E1; Fri, 30 Mar 2012
 12:21:30 -0400 (EDT)
In-Reply-To: <CAH6sp9N=JsWp7iQ=AAdXHe0J+aB5L9cBq2_0BJgUO=Y-vgAbNg@mail.gmail.com> (Frans
 Klaver's message of "Fri, 30 Mar 2012 10:23:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 689C164E-7A84-11E1-BCAA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194375>

Frans Klaver <fransklaver@gmail.com> writes:

> isn't it rather more sensible from a unit-test perspective to see
> if start_command returns 127 instead of 128 in this specific case?


You are welcome to add another test that checks lower level implementation
detail, but this specific test is to make sure the gripe "Why does git
deny my aliases when I have inaccessible directory on my PATH?" will never
come back.
