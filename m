From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads
 is  available
Date: Tue, 23 Mar 2010 13:44:43 -0700
Message-ID: <7v7hp2rcn8.fsf@alter.siamese.dyndns.org>
References: <cover.1267889072.git.j6t@kdbg.org>
 <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com>
 <201003232119.19430.j6t@kdbg.org> <201003232125.49933.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 21:45:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuAyI-0002xH-0S
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 21:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0CWUo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 16:44:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab0CWUo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 16:44:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0DBA4780;
	Tue, 23 Mar 2010 16:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9XUpEpG/I+GR5QT55tW9b9qD654=; b=Uayvsv
	VPajcYBOwPwjqI4YFWnzfVuhHId9Gyw+7NeYpehxssKk0f5r4Cy07Y1LLCEdbyTD
	+AavFLMpkt4k/doCjZ5mqnfvrzPLSkUO89dS9q/9kpZRPJvqQJY6JGzjtN7JaPoy
	FYBMCvaglPLtEBUGT4pvtZx6h0sUutXtoaAAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tniVdD0wlCt342+e+zUSkfoU1UDVOA7b
	I8TN3oL1Qw1yEUA3qzMJDTRpEj7s9HZtHxpQtt2Xa1n65QKRZS488dz9WrKjv1dl
	FBpiA7lSjT1CbJMDxI3+WVCTteKhWWGMphqKzR0XoXaGvQMPhDSxLPoillkzE0vY
	sLdngwicHDk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 878F5A477E;
	Tue, 23 Mar 2010 16:44:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 141D6A477B; Tue, 23 Mar
 2010 16:44:44 -0400 (EDT)
In-Reply-To: <201003232125.49933.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue\, 23 Mar 2010 21\:25\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED279FF4-36BC-11DF-87ED-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143049>

Johannes Sixt <j6t@kdbg.org> writes:

> BTW, the real fix for this potentially problematic case is to teach 
> pack-objects to create a pack file for a shallow clone. Then we don't need 
> this instance of an async procedure.

I keep hearing "shallow clone" here, but doesn't "bundle -n 1" essentially
do something quite similar using pack-objects?  Do they make a call into
pack-objects in a different way, and if so can we update "clone" to mimic
how "bundle" drives pack-objects?
