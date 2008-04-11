From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible regression (or me abusing git) in v1.5.5
Date: Fri, 11 Apr 2008 14:06:28 -0700
Message-ID: <7vbq4grtij.fsf@gitster.siamese.dyndns.org>
References: <905315640804111221k53dd7063sae5710ed690114f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tarmigan+git@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 11 23:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkQSv-00015H-K1
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 23:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760407AbYDKVGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 17:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760110AbYDKVGh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 17:06:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbYDKVGg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 17:06:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 484E22D47;
	Fri, 11 Apr 2008 17:06:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A24502D46; Fri, 11 Apr 2008 17:06:30 -0400 (EDT)
In-Reply-To: <905315640804111221k53dd7063sae5710ed690114f0@mail.gmail.com>
 (tarmigan+git@gmail.com's message of "Fri, 11 Apr 2008 12:21:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79298>

tarmigan+git@gmail.com writes:

> After upgrading to v1.5.5, I noticed a change in the way that git
> treats symbolic links.
>
> Git will follow symbolic links to directories when they were added as follows
>
> $ git init
> $ mkdir foo
> $ touch foo/bar
> $ ln -s foo foo1
> $ git add foo1/

In this step "git add" adds "foo1/bar", which is a bug that is shared
between 1.5.5 and previous versions.

Recent "git add -u" after that was taught to notice this bogosity (it
actually is git-diff-* family that was fixed), and fixes it.
