From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v2] Add tests for .git file
Date: Wed, 06 Feb 2008 00:40:20 -0800
Message-ID: <7v7ihi32bv.fsf@gitster.siamese.dyndns.org>
References: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
	<1202284583-24478-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfq2-0004qH-Fk
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247AbYBFIka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 03:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759181AbYBFIka
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:40:30 -0500
Received: from rune.pobox.com ([208.210.124.79]:58894 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbYBFIka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 03:40:30 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 37A461941A6;
	Wed,  6 Feb 2008 03:40:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 09A0D194169;
	Wed,  6 Feb 2008 03:40:44 -0500 (EST)
In-Reply-To: <1202284583-24478-1-git-send-email-hjemli@gmail.com> (Lars
	Hjemli's message of "Wed, 6 Feb 2008 08:56:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72772>

Lars Hjemli <hjemli@gmail.com> writes:

> Verify that the basic plumbing works when .git is a file pointing at
> the real git directory.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> This updated patch replaces cut with sed and tries to do proper quoting.
>
>
>  t/t0002-gitfile.sh |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100755 t/t0002-gitfile.sh
>
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> new file mode 100755
> index 0000000..7f8ee2f
> --- /dev/null
> +++ b/t/t0002-gitfile.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description='.git file
> +
> +Verify that plumbing commands work when .git is a file
> +'
> +. ./test-lib.sh
> +
> +objpath() {
> +    echo $1 | sed -re 's|(..)(.+)|\1/\2|'
> +}

"sed -r"???  Please limit ourselves to the basics.

> +test_expect_success 'check commit-tree' '
> +	SHA=$(echo "commit bar" | git commit-tree $SHA) &&
> +	objck $SHA
> +'
> +
> +test_expect_success 'check rev-list' '
> +	echo $SHA >"$REAL/HEAD" &&
> +	test "$SHA" = "$(git rev-list HEAD)"
> +'

Nicely done.
