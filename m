From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 14:44:34 -0700
Message-ID: <7vehsctn7h.fsf@alter.siamese.dyndns.org>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino> <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <7vzkb0tq10.fsf@alter.siamese.dyndns.org>
 <20120328210407.GC10174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:44:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0fZ-0001bW-UN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193Ab2C1Voh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:44:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933180Ab2C1Vog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:44:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4964E73F5;
	Wed, 28 Mar 2012 17:44:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BKHKElT4Gzf5JqNcqZlQjBSVOu0=; b=IWkYcG
	3yTKNc/T484jcxBmismEIcmjxbRRRY2hXNKjUs1BmCMrQ7N3cBy+BYDR7O72el0A
	uxCeskwHNe0rZn2KSC9C0vOZLy2+unrmGWTdqhm+ble9xbCzuOrpvw3cOQJBtydl
	jsfB3K0wL+6kxx3zqUcHNtYCVO4SulAaSJpSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQX39ol3Rv5OYs4UaWWwTda8BMBvQ+D3
	TFU6gPTc2/TcnvnMzOp0SGiH4SB8lTeRT27Rh+6dH16AdDNe4dPtSqAEA23V52sN
	d/NGf4aiHeKHbcMwOCNA2jY17CKFsCBvkn+ARPDSmv+mNs4dGW5P1a1dxf3NyJfX
	zMnXdKvAej8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4082D73F4;
	Wed, 28 Mar 2012 17:44:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C90F973F2; Wed, 28 Mar 2012
 17:44:35 -0400 (EDT)
In-Reply-To: <20120328210407.GC10174@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Mar 2012 17:04:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3637033C-791F-11E1-A9BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194204>

Jeff King <peff@peff.net> writes:

> Regarding the name, I pulled it from the linux-manpages execvp(3), since
> this is supposed to be compatible. POSIX uses the even worse "path" as
> the first element. But there is no reason we have to follow those naming
> conventions.

Let me take that back.  We are checking if there is a non-command in a
directory that is somewhere on the PATH, so calling it file like you did
is a lot saner than calling it cmd.
