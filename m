From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Sun, 20 Jan 2008 14:28:40 -0800
Message-ID: <7vd4rw6siv.fsf@gitster.siamese.dyndns.org>
References: <4790BCED.4050207@gnu.org>
	<7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org>
	<alpine.LSU.1.00.0801191119050.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGifP-00077o-EK
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 23:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbYATW26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbYATW26
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 17:28:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbYATW25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 17:28:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA941984;
	Sun, 20 Jan 2008 17:28:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DFA31982;
	Sun, 20 Jan 2008 17:28:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71198>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, there is a fourth of "two other" possibilities:
>
> Make a script calling git-commit with "-F - -e" and pipe your generated 
> template into it.
>
> Use this script whenever you want to create a new commit.

I think that the approach has one huge advantage.  Commands
other than "git commit" itself ("git merge", "git rebase", "git
am", etc.) do call "git commit" to record the changes they made.
I suspect these command would not want this template behaviour,
and not adding this custom commit message "feature" to "git
commit" would avoid the risk of breaking them.

At the same time, this exact issue could be a drawback.  Some of
them _might_ want it.  But in that case, the the custom template
"hook" needs to be told _why_ it is being called, so that it can
adjust its behaviour.
