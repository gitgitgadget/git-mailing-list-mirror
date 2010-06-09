From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/ PATCH 4/5] t3030: update porcelain expected message
Date: Wed, 09 Jun 2010 22:40:20 +0200
Message-ID: <vpq1vcgym6j.fsf@bauges.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:43:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMS7X-00063B-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220Ab0FIUnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:43:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:36955 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757371Ab0FIUnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 16:43:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o59KeLNR020732
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 22:40:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMS4T-0002QQ-4y; Wed, 09 Jun 2010 22:40:21 +0200
In-Reply-To: <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Wed\,  9 Jun 2010 14\:44\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 Jun 2010 22:40:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148812>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> From: Diane <diane.gasselin@ensimag.imag.fr>

You did something strange with git format-patch or send-email. This
From header should appear in the header of your email, but not in the
body.

> As porcelain messages have been changed, the expected porcelain message
> tested in this test needs to be changed.

We usually try to have the test-suite pass for each commit (so that
"git bisect" can be used easily among other reasons). So, you probably
want to squash this patch with the one that actually changes the
message. Also, I think it eases reviewing: the changes to the
test-suite can be seen as a specification (particularly clear here: we
know what the rest of the patch serie does reading this patch).

Another trick is to set the tests as "test_expect_failure" before
introducing the feature, and mark them as "test_expect_success" when
appropriate. This way, you can add new tests before adding the
feature, without introducing broken commits.

> +cat> expected2 <<EOF
> +error: Your local changes to the files:
> +	a
> +would be overwritten by merge.
> +EOF

I'd have phrased it like this:

error: Your local changes to these files would be overwritten by merge:
	a

to avoid splitting the message in two parts. It's more consistant with
the rest of Git (git status or git reset for example). Also, your
version would become hard to read if the file list is long.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
