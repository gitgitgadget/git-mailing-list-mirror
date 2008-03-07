From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 07 Mar 2008 00:23:54 -0800
Message-ID: <7vwsof2b8l.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
 <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
 <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
 <200802010534.55925.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 09:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXXw2-0006vK-8x
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 09:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbYCGI1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 03:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbYCGI1c
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 03:27:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbYCGI1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 03:27:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B527C2927;
	Fri,  7 Mar 2008 03:27:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A059A2920; Fri,  7 Mar 2008 03:27:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76468>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Verify a few more commands and pathname variants.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  t/t7010-setup.sh |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>
> These are a few testcases from my earlier attempt at this. The
> log and commit cases succeeded with Junios version, but not 
> blame and some of the nastier versions for git add (same
> principle for all commands, just that I use add as an example)

I am very sorry about replying to an ancient topic, but I think I misread
your patch.

> +test_expect_failure 'add a directory outside the work tree' '
> +	d1="$(cd .. ; pwd)" &&
> +	git add "$d1"
> +	echo $?
> +'

What I think I misunderstood was that you _wanted_ this (after removing
the "echo", which was a mistake, which we already talked about) to fail.
Somehow I ended up committing test_expect_success, which I think was a
mistake, and I am asking for a sanity-check.

Likewise for the other two tests.  These "add outside" should fail, right?

> +test_expect_failure 'add a file outside the work tree, nasty case 1' '(
> +	f="$(pwd)x" &&
> +	touch "$f" &&
> +	git add "$f"
> +)'
> +
> +test_expect_failure 'add a file outside the work tree, nasty case 2' '(
> +	f="$(pwd|sed "s/.$//")x" &&
> +	touch "$f" &&
> +	git add "$f"
> +)'
> +
>  test_done

