From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] clone: allow --no-local to turn off local
 optimizations
Date: Wed, 30 May 2012 15:10:37 -0700
Message-ID: <7vmx4pxqua.fsf@alter.siamese.dyndns.org>
References: <20120530110305.GA13445@sigill.intra.peff.net>
 <20120530111016.GB15550@sigill.intra.peff.net>
 <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
 <20120530215912.GC3237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 00:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZr6U-00008u-OG
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 00:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab2E3WKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 18:10:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757053Ab2E3WKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 18:10:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A696788A7;
	Wed, 30 May 2012 18:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuteQW/6Du+HE1QCke95hcRFtb0=; b=xyFS0F
	y9TJq6Qazhom4ydt/erSMJXmaaNdQ1lgVxkNlr3MjFELXDE73q7pd7J6jVopspfn
	zLr6N+09lfwE3J5NRcu5GaMDD7dllHQrFhWZhFLXrAA72/gv1tlTaSYqMzZmQjhT
	sgoJtFbjW8ANp05ChjSK4O+ofTLnppaw2N2zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSAyCwznfZOJnJLq9DYRc4GqwsQXKn8s
	Sy4eYlfd/D914d73zEH8ilYEoQyybKbj5D8+bKr2J/qk7gz5AbKjt1p1icWO1EdF
	Cct21f8u+bD7/SHIaTr8uYckb7i303ccEtFuVuVjtMj5bQdmTGV3E/RxImkViTeS
	nYAw+Gsm8/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC2788A5;
	Wed, 30 May 2012 18:10:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 394CF88A4; Wed, 30 May 2012
 18:10:39 -0400 (EDT)
In-Reply-To: <20120530215912.GC3237@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 17:59:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A1ACB20-AAA4-11E1-B9CC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198844>

Jeff King <peff@peff.net> writes:

> Similarly, I find it a little odd that "git clone file:///foo.git" will
> actually find a file named "file:/foo.git" before checking the URL (IOW,
> the argument is a path first, and then fallback to URL). I suspect
> nobody actually cares about either, as they are very unlikely corner
> cases.

Yeah, if anything, I would have expected --no-local to mean "I might
have a local file that happens to be the same as this URL, but I am
not cloning from there; just go straight to the URL using transports".
