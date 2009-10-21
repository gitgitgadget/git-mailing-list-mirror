From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 00:23:53 -0700
Message-ID: <7vzl7l8b1y.fsf@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
 <7v63a9n5i6.fsf@alter.siamese.dyndns.org> <4ADEA93E.7060907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0VYP-0004IM-V7
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZJUHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbZJUHYH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:24:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZJUHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:24:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA26611AE;
	Wed, 21 Oct 2009 03:24:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z/iW93CzNmZUCp3dav5iKkUZAqs=; b=PMRweH
	8BGGVDRF0ztinp0Q54PsxZY4jFu+8ThgHgWeqqfLVTO5/Rl5K+PptLo2Y9nFPrI9
	5FS5g8subIES+hoAUNkbWOwXic/n1KvEVv6VANE3lTyBO6pXQrCv0A2lt5cfSUXf
	WcDUGRydERIzekCkZ60wwRb0PLewnQvkZOvUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZWP22yqlIyjvRCL51GmBY1x50UmCQFL
	q4xmXDt6NMuLlSv8ss1Gdoy5J4H2+G7mR93DJdAVr1vn27Th773vFKaYRt8XtfJ1
	2i2LXl63bx/baAIU930lvPbRol8Y40pHdNE0YvtuR9q/1ObIGu4O7v4hOHRJ+gv3
	iYKpXTtotuo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4026611AA;
	Wed, 21 Oct 2009 03:24:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B727D611A9; Wed, 21 Oct
 2009 03:23:54 -0400 (EDT)
In-Reply-To: <4ADEA93E.7060907@viscovery.net> (Johannes Sixt's message of
 "Wed\, 21 Oct 2009 08\:25\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B550A490-BE12-11DE-9945-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130892>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> +		if (auto_gc) {
>> +			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
>> +			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>
> Am I correct that this will produce progress output? If git-daemon runs
> receive-pack, then this output will go to the syslog. Do we care?

We do, and we don't want that.  Thanks for spotting.

Would adding "--quiet" to the mix be enough?
