From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode ==
 true
Date: Sun, 12 Oct 2008 12:35:07 -0700
Message-ID: <7vskr1fvys.fsf@gitster.siamese.dyndns.org>
References: <20081012133934.GB21650@dpotapov.dyndns.org>
 <1223837086-2864-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, spearce@spearce.org, dpotapov@gmail.com,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 21:36:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp6jy-000303-W8
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 21:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYJLTfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYJLTfX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 15:35:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYJLTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 15:35:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AC1B89D66;
	Sun, 12 Oct 2008 15:35:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC8A989D38; Sun, 12 Oct 2008 15:35:09 -0400 (EDT)
In-Reply-To: <1223837086-2864-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Sun, 12 Oct 2008 14:44:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E87FE474-9894-11DD-857F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98049>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Cygwin's POSIX emulation allows use of core.filemode true, unlike native
> Window's implementation of stat / lstat, and Cygwin/git users who have
> configured core.filemode true in various repositories will be very
> unpleasantly surprised to find that git is no longer honoring that option.
> So, this patch forces use of Cygwin's stat functions if core.filemode is
> set true, regardless of any other considerations.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
> Updated to use trust_executable_bit as suggested on the list.

Before you do that, can you explain why git_cygwin_config() should
duplicate the setting of that variable instead of using the existing
parser for that variable by calling git_default_config()?
