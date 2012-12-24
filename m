From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Sun, 23 Dec 2012 20:57:12 -0800
Message-ID: <7vr4mgnj2v.fsf@alter.siamese.dyndns.org>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121220144813.GA27211@sigill.intra.peff.net>
 <20121220150252.GA24387@thyrsus.com>
 <7vsj7060nj.fsf@alter.siamese.dyndns.org>
 <7vk3sc2hx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Dec 24 05:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn06Y-0005O6-RE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 05:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2LXE5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 23:57:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2LXE5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 23:57:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 850A0AA88;
	Sun, 23 Dec 2012 23:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I5yGbtKsqLTby5TIVWrRmtMS4H8=; b=v9dihN
	rakc9nGMTMKoh2hYLimQ7tiyxUL3jfzECOXDgXZLFkohkkKFDNDe/AuqUcTS106N
	h+Fn085tH42lgXhGpJLRBzPcCvfAYpI4P8fMQhoIjfMsWvVzEk7GJbrEwtMuYRL3
	1bRZYFRttQytebdUpppPDZ2utcXBusPj7iH78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJRsfQHMDE5rFqVihMoAdmi7qlQT7v6G
	2ntt1rf1r1ZcNH0Yp5+s15VFUZjRBOZJc+SM0Mu0XQ9kVjqG/oKKEOlOdba8F59W
	zCRb5x/Spi9zCbB4iAzaDvc5Od6nap+407LG8Tvk2sVLUV17AzhkQdoAYFEGKTDO
	AkgRd+pWNvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71EC6AA86;
	Sun, 23 Dec 2012 23:57:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E19AEAA85; Sun, 23 Dec 2012
 23:57:13 -0500 (EST)
In-Reply-To: <7vk3sc2hx9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Dec 2012 19:38:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61FADCB4-4D86-11E2-8371-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212095>

Junio C Hamano <gitster@pobox.com> writes:

> I needed something like this on top of it to get it pass t5800.
>
> diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
> index 776e891..5047fd4 100644
> --- a/git_remote_helpers/git/__init__.py
> +++ b/git_remote_helpers/git/__init__.py
> @@ -1,3 +1,5 @@
> +import sys
> +
>  if sys.hexversion < 0x02040000:
>      # The limiter is the subprocess module
>      sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.")

Ping?  Is the above the best fix for the breakage?

If it weren't __init__, I'd silently squash it in, but the filename
feels a bit more magic than the ordinary *.py files, so I was worried
there may be some other rules involved what can and cannot go in to
such a file, hence I've been waiting for an ack or alternatives.

Thanks.
