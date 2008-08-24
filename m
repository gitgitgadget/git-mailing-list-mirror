From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 11:11:14 -0700
Message-ID: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXK4e-00077v-Ek
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYHXSLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYHXSLU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:11:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYHXSLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:11:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AD7B6D58F;
	Sun, 24 Aug 2008 14:11:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6456E6D58D; Sun, 24 Aug 2008 14:11:16 -0400 (EDT)
In-Reply-To: <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> (Karl
 Chen's message of "Sun, 24 Aug 2008 01:40:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CCB9264-7208-11DD-BAD3-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93542>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-22 14:10 PDT, Junio C Hamano writes:
>
>     Junio> If we were to support relative paths, I think it would
>     Junio> be useful and consistent if a relative path found in
>     Junio> ".git/config" is relative to the work tree root, in
>     Junio> "config" in a bare repository relative to the bare
>     Junio> repository, and in "$HOME/.gitconfig" relative to
>     Junio> $HOME.
>
> Makes sense to support it everywhere.  For .git/config, isn't it
> more consistent for it to be relative to .git?

Consistency and usefulness are different things.  Suppose you want as the
upstream of your project maintain and distribute a mail-alias list in-tree
(say, the file is at the root level, CONTRIBUTORS), and you suggest
contributors to use it when using "commit --author".

Which one do you want to write in your README:

	[user]
        	nicknamelistfile = ../CONTRIBUTORS

or

	[user]
        	nicknamelistfile = CONTRIBUTORS

You have to say the former if it is relative to .git/config.

> So, being new to git development, am I correctly assessing your
> response as "with refinement this can be included in git"?

I do not have fundamental objection to what you are trying to achieve
(i.e. being able to say "relative to $HOME").  I personally think the
approach you took in your patch (i.e. only support "~/" and use $HOME,
without any other fancy stuff) is a sensible first cut for that issue.

I just pointed out possible design issues about the future direction after
that first cut.  When I make comments on design-level issues, I rarely
read the patch itself very carefully, so it is a different issue if your
particular implementation in the patch is the best implementation of that
first cut approach.
