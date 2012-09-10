From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: quiet shell commands when "make --silent"
Date: Sun, 09 Sep 2012 17:35:40 -0700
Message-ID: <7voblepvdv.fsf@alter.siamese.dyndns.org>
References: <20120909230921.GA23806@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 02:36:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TArzN-0001B0-01
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 02:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab2IJAfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 20:35:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab2IJAfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 20:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB2F999B;
	Sun,  9 Sep 2012 20:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFtQP5D4ndG6a5UPfCwYj6xH7H4=; b=QMxW+D
	ZfnteBmAcNiU+oePhKjHZHsaTfodBy7rJvFn1tXVET0OhwtF7+B+nZfRzIwXPKrK
	tX/El8QYWP68y8SJyXkfeIbrjhl67+WOPljnVX3/8jw1xn3wJ4+bo51q56jeieC1
	81fqIA/iHq5xA+e2zB2mhxoRLaWrMG179tMBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YSK2LhOMZoUz8T6AqVBwl3PEV8tUWwe0
	qlBkFPEs3WOB/qGerplyp/HWPAUFuaUoBy3wBXS/A2kMYaD+hCz+gsSZo5ixtgec
	IKUwmuBYpmcGCX8qP4ymuy+sz9BctVrskkICFjBgRR+K2F0A0M7p9YOEed28UIYd
	lut67UJq2ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C738999A;
	Sun,  9 Sep 2012 20:35:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1B559999; Sun,  9 Sep 2012
 20:35:41 -0400 (EDT)
In-Reply-To: <20120909230921.GA23806@padd.com> (Pete Wyckoff's message of
 "Sun, 9 Sep 2012 19:09:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7353EC20-FADF-11E1-B964-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205107>

Pete Wyckoff <pw@padd.com> writes:

> Option "--silent", "--quiet" or "-s" to make prevents
> echoing of commands as they are executed.  However, there
> are some explicit "echo" commands in the Makefile and in
> the two GIT-VERSION-GEN scripts that always echo.

"make -s clean"?

I am not very enthused, especially if the primary motivation is
about "check-docs".  Such a script must be prepared to filter out
cruft from the output of $(MAKE) and to pick out the bits that
interests it and that has been the way of life with $(MAKE) way
before Git started as a project ;-).

In order to make it more robust, targets like "print-man1" can (and
should) arrange their output in such a way that interesting parts
are easily findable.
