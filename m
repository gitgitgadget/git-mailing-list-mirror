From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: respect textconv in rewrite diffs
Date: Wed, 10 Dec 2008 00:34:26 -0800
Message-ID: <7v3agw2zu5.fsf@gitster.siamese.dyndns.org>
References: <20081209081227.GA19626@coredump.intra.peff.net>
 <20081209081321.GA19707@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAKYI-0002kH-59
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 09:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbYLJIee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 03:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbYLJIed
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 03:34:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYLJIed (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 03:34:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C9BC85A5F;
	Wed, 10 Dec 2008 03:34:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C88E85A5E; Wed,
 10 Dec 2008 03:34:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E4EC75A-C695-11DD-8680-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102672>

Jeff King <peff@peff.net> writes:

> Currently we just skip rewrite diffs for binary files; this patch makes
> an exception for files which will be textconv'd, and actually performs
> the textconv before generating the diff.
>
> Conceptually, rewrite diffs should be in the exact same format as the a
> non-rewrite diff, except that we refuse to share any context. Thus it
> makes very little sense for "git diff" to show a textconv'd diff, but
> for "git diff -B" to show "Binary files differ".

Makes sense.

> +cat >dump <<'EOF'
> +#!/bin/sh
> +perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> +EOF

I'll squash in a change to make this part use $SHELL_PATH for
consistency.  Thanks.
