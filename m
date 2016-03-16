From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Wed, 16 Mar 2016 09:17:45 -0700
Message-ID: <xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pickfire@riseup.net, peff@peff.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:18:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agE95-0007CI-U9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbcCPQRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:17:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752119AbcCPQRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:17:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C2DA4BD43;
	Wed, 16 Mar 2016 12:17:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lwl58Vznjt6PBV/nIR+/XVMXplE=; b=CaQQKg
	ruhnGyyvgTRmlLIt2p6ZXky1TqNMBpYwf8y+POOJaE2q6sS8j4SxCFZOiawxdwHx
	RLB9PMHVFBFJwgSXVjryoDRStN8QaE7Nh84XOmhvmRh2JhiXGiXfYVX728uWWwat
	kqb5/k8Sn7DYw/6miSxQ+/6nIFn9MRmUOweBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0C+vwn9rI/sda+zBvmSJy9WOnVCELAp
	z9KRnM7IRvUsjqvz8cWe6tRceDM12b45PLgxoJ3uLOQeIpkQGoMd5mSAlAZ6wBvu
	BVqRqqKMK1xQ5E/x+4BKHDwWvDGP3WdlmM8iy9Ivp+F2XXXoa2LiZ1Ze+dQhWH9T
	IGRutxjsVlg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19D5F4BD42;
	Wed, 16 Mar 2016 12:17:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DD434BD40;
	Wed, 16 Mar 2016 12:17:46 -0400 (EDT)
In-Reply-To: <1458122865-29447-3-git-send-email-huiyiqun@gmail.com> (Hui
	Yiqun's message of "Wed, 16 Mar 2016 18:07:45 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EC1F896-EB92-11E5-B7C7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288985>

Hui Yiqun <huiyiqun@gmail.com> writes:

> t0301 now tests git-credential-cache support for XDG user-specific
> runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:
>
> * if $XDG_RUNTIME_DIR exists, use socket at
>   `$XDG_RUNTIME_DIR/git/credential-cache.sock`.
>
> * otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.

Is it better to have the fallback in /tmp, and not in
~/.git-credential-cache/, and why?

Is it because the wish is to always use /tmp/git-$uid/ as a fallback
for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
is specific to the credential-cache and would look strange if we
used it for other "runtime" things)?

Just being curious, and wanting to see the reasoning behind the
design decision the patch series makes in the log message of one of
these patches.

Thanks.
