From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Tue, 16 Apr 2013 12:02:00 -0700
Message-ID: <7vip3ml2on.fsf@alter.siamese.dyndns.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
 <7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
 <79879228B71A45A48A961F5B1880B61F@PhilipOakley>
 <7vli8k4lnj.fsf@alter.siamese.dyndns.org>
 <99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley>
 <7v8v4imjji.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7WKwt10sCRTbm8gdhwEUKSYuQxtPDVm7usTm2ZHryk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USB8s-0004c9-8R
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934963Ab3DPTCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:02:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3DPTCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:02:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BDD1436E;
	Tue, 16 Apr 2013 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUAiHoGxTBvz9wq+5HmvtIDuHIA=; b=wLN+KH
	pI0+xggb8V4rGFsCYqXVbHOdWtT/NV8dMyL5JYQtGJGZENO5/hgsq/O+0l4EEKw7
	A/PMajxRW51qWDbseY21RIqrI1YmCBFKWZihbMj4bmFQZ0VZUSQPUatewhUdsZOv
	Q/bVMPu0QvaytU1D83NEXcc18EMGbAhr7JBF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sCm9eyDCefXLHrSK/hV4xti+WOuMHe2p
	hzdq6ANJodcWZW/USypgKd1IyGZtUBk+ns3/WzV13X54pqtPGp8hnTIFsKQgMuxI
	V8fVhjoCZQpEgscIglc5fBQmEaU/SmpC/o9XFXK2pMES3PxV6baHRFS2+X3z9VHk
	fjj47MnR+zY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E88311436C;
	Tue, 16 Apr 2013 19:02:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EC8114367; Tue, 16 Apr
 2013 19:02:02 +0000 (UTC)
In-Reply-To: <CAJDDKr7WKwt10sCRTbm8gdhwEUKSYuQxtPDVm7usTm2ZHryk9g@mail.gmail.com> (David
 Aguilar's message of "Tue, 16 Apr 2013 11:24:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F2E373C-A6C8-11E2-97B4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221451>

David Aguilar <davvid@gmail.com> writes:

> The "regression" is that there are scripts and tools in the wild that
> need to know the git version when deciding whether or not to use some
> new feature.
>
> e.g. "git status --ignore-submodules=dirty" did not appear until git 1.7.2.
> A script may want to use this flag, but it will only want to use it
> when available.
>
> If this string started saying "The Git Version Control System v2.0" then these
> scripts would be "broken" since they would no longer recognize this as a
> "post-1.7.2 Git".

Blacklisting known-bad version and hoping all other versions
including the ones you have never seen to behave in the way you
expect usually works but there is a limit.

A change to say "The Git Version Control System %s" will not happen
willy-nilly, but when there is a good reason to do so, we would.

I do not think a test that hardcodes the output is a good way to
make sure a change is being done with a good reason.  After all, a
patch that updates the "git version %s" string can just update the
expected output in the same patch.  The only reason such a change
will be caught is because during the review, somebody notices that
the change touches the expected output of a test; for that to
reliably protect the output, the test *has* to be commented to say
that this expected output should be changed very carefully.

A much better solution would be to leave that "very carefully"
comment next to the in-code string to warn people about ramifiations
of changing it.
