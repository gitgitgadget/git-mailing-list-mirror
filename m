From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] teach --progress to transport-related builtins
Date: Thu, 18 Feb 2010 17:26:02 -0800
Message-ID: <7veikiyq1h.fsf@alter.siamese.dyndns.org>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, "Sebastian Thiel" <byronimo@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 02:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiHdQ-0001KL-L4
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 02:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab0BSB0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 20:26:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab0BSB0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 20:26:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED2A9BB46;
	Thu, 18 Feb 2010 20:26:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dDbmuWSFq7msuM6eUCRrx30Is5k=; b=A0NSZNj+9OuWQ2CYOeO7TIs
	b+WqaO+331sllL9lZDNqxRXgFnlc2zLnjwwdmHLQgRTDCe3TDVRAqdqcyeZvvbTY
	56aiT2ltJ2mGg+gzxeD3L1DLavV+VYsu/l0Xdz4EoKWsLlQsNy3CMbcY+5nNdUU8
	OIc9zb/tqiXuWe9UXWTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=e79+elAjfh336H9Zhg79err8arpHUvpE0Fna2xQdxOLmwjBge
	sIbPa4qsu+PO6AJKWQOXNuOs0nXkBQup7r9C9BaC6lPGVVuaDdP2iSVasn7B9a2Z
	vxJ6Se+cV0F+lX9MEe9ti57m1e/hRMYyCxcoABNXbd4DaB+3UvdDL2aI8Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4955A9BB44;
	Thu, 18 Feb 2010 20:26:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F8ED9BB3F; Thu, 18 Feb
 2010 20:26:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C298499A-1CF5-11DF-9630-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140401>

Tay Ray Chuan <rctay89@gmail.com> writes:

> This patch series adds --progress to:
>
>   - git-fetch
>   - git-pull
>   - git-push
>
> I suspect the most contentious issue in this patch series would be the
> logic that determines whether progress reporting is done. This is found
> in patch 6 for transport.c::transport_set_verbosity().
>
> As a guide, I used Jeff's message (gmane#121065). The rules used are as
> follows (processing aborts when a rule is satisfied):
>
>   1. Report progress, if force_progress is 1 (ie. --progress).
>   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet).
>   3. Report progress if isatty(2) is 1.
>
> This changes the current implementation such that if both --progress
> and --quiet are specified, progress is reported. I don't think this is
> a very significant change, but I think it makes sense, since I expect
> --progress to be mostly used by script writers or IDE integrators (to
> force progress reporting even if stderr is not a terminal).

I gave a cursory look and they all looked sensible (except for 1/10
on which I already commented separately).  Thanks.
