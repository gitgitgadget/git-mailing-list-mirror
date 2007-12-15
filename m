From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/4] Add diff-diff, which compares the diffs of two commits
Date: Sat, 15 Dec 2007 11:34:49 -0800
Message-ID: <7vzlwblpk6.fsf@gitster.siamese.dyndns.org>
References: <1197737505128-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3cnS-0000pz-Gd
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 20:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbXLOTfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 14:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbXLOTfE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 14:35:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbXLOTfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 14:35:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E5613D25;
	Sat, 15 Dec 2007 14:34:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C05633D24;
	Sat, 15 Dec 2007 14:34:52 -0500 (EST)
In-Reply-To: <1197737505128-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sat, 15 Dec 2007 17:51:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68409>

Steffen Prohaska <prohaska@zib.de> writes:

> At this point, I'm only seeking comments about the general direction.
> The patches should not be applied to git.git.
>
>  - Do you think something like this would be helpful?
>  - Are similar approaches already available?
>  - How do you use git to support code review; besides discussing
>    patches on mailing lists?

I think there are other good building blocks you can use outside git to
help reviewing evolution of patches (interdiff comes to mind).

When I receive a replacement series to a topic, I use RP script
(available in my 'todo' branch and checked out in Meta/ directory in my
work area, together with other scripts from 'todo'), which:

 * finds where the older series were applied;
 * detaches HEAD at that commit, and apply the new series;
 * runs diff between the old and new;
 * updates the tip of that topic with the new series.

After it finishes, "diff topic@{1} topic" becomes the incremental diff
between the old and the new series, and if I do not like the end result,
I can reset --hard back to topic@{1}.
