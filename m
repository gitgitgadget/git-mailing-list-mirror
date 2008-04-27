From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use the modern syntax of git-diff-files in
 t2002-checkout-cache-u.sh
Date: Sun, 27 Apr 2008 10:21:30 -0700
Message-ID: <7viqy3gqn9.fsf@gitster.siamese.dyndns.org>
References: <20080427113123.GA3712@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:22:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAa1-00029l-IG
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbYD0RVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbYD0RVi
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:21:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbYD0RVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:21:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96ABC2C75;
	Sun, 27 Apr 2008 13:21:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EFB022C74; Sun, 27 Apr 2008 13:21:32 -0400 (EDT)
In-Reply-To: <20080427113123.GA3712@steel.home> (Alex Riesen's message of
 "Sun, 27 Apr 2008 13:31:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80457>

Alex Riesen <raa.lkml@gmail.com> writes:

> As a nice side effect it also fixes t2002-checkout-cache-u.sh on FreeBSD 4,
> /bin/sh of which has problems interpreting "! command" construction.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> To be honest - it was the other way around: I wanted to fix the test
> on FreeBSD, but ended up using --exit-code and test_must_fail

Do you mean /bin/sh there misinterprets "! cmd1 | cmd2" as "(! cmd1) |
cmd2" and always returns true or something silly like that?  I see a few
other places in t3400, t3700, t5302, t7002, etc. that use that construct
without an obvious workaround "! (cmd1 | cmd2)" which t0030 uses.

>  test_expect_success \
>  'with -u, git checkout-index picks up stat information from new files.' '
>  rm -f path0 &&
>  git read-tree $t &&
>  git checkout-index -u -f -a &&
> -git diff-files | diff - /dev/null'
> +git diff-files --exit-code'

Is this something FreeBSD 4 has trouble with as well (not a request to
drop this hunk but asking for info)?
