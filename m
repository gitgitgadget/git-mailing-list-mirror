From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 16:43:53 -0700
Message-ID: <7vabg09rye.fsf@gitster.siamese.dyndns.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
 <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org> <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org> <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:45:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNysb-0006lW-MC
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYG2XoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbYG2XoD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:44:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbYG2XoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:44:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E55924B402;
	Tue, 29 Jul 2008 19:43:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4E9814B401; Tue, 29 Jul 2008 19:43:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3672113C-5DC8-11DD-8D7E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90710>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +cat > git-merge-theirs << EOF
> +#!/bin/sh
> +eval git read-tree --reset -u \\\$\$#
> +EOF

This should be $SHELL_PATH, instead of hardcoded /bin/sh, to be easy on
people on Solaris and other systems.

Other than that, the patch is good and there is no need to resend it.
Thanks.

By the way, this eval shows why "theirs" cannot be a symmetric operation
of "ours".  You are taking the last remote HEAD even when you are merging
more than one remote into the current branch at once.  "ours" can be
sensibly defined for an octopus, but "theirs" has this "which theirs"
problem ;-)
