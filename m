From: John Keeping <john@keeping.me.uk>
Subject: Re: "What's cooking" between #05 and #06
Date: Thu, 18 Apr 2013 09:49:23 +0100
Message-ID: <20130418084923.GT2278@serenity.lan>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
 <516F1333.5070804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 18 10:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USkXG-0005uf-6J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 10:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966648Ab3DRItg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 04:49:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36604 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965897Ab3DRIte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 04:49:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6428ACDA5B2;
	Thu, 18 Apr 2013 09:49:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Jvv03v6Qh7p; Thu, 18 Apr 2013 09:49:32 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A3EACCDA599;
	Thu, 18 Apr 2013 09:49:31 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 990CB161E3F7;
	Thu, 18 Apr 2013 09:49:31 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bk96-ne4Udg; Thu, 18 Apr 2013 09:49:31 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A7349161E413;
	Thu, 18 Apr 2013 09:49:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <516F1333.5070804@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221627>

On Wed, Apr 17, 2013 at 11:25:07PM +0200, Jens Lehmann wrote:
> I like it, as it gets rid of the top-level requirement. But from
> my testing it looks like we're not quite there yet.
> 
> 'summary' and 'status' behave as if they were run in the toplevel
> directory, while a "git status" shows all filenames relative to the
> current directory. Me thinks 'summary' and 'status' (and all other
> submodule commands) should behave like status and print relative
> paths too. I'm not really sure yet how $sm_path should behave for
> 'foreach', but I suspect having it relative to the current
> directory would be the way to go (which it currently isn't).
>
> When "submodule add" is run with a relative path it is relative to
> the top-level directory, which I find confusing (and won't play
> well with shell completion).

This confused me for a bit because I was sure I handled this, but I see
I missed relative submodules URLs.  So the path at which to put the
submodule is correct, but the path from which to clone is not.

> 'deinit .' doesn't deinit submodules above the current directory
> (but prints the path relative to top-level) while 'init' will
> initialize all submodules known to the superproject.

I can't see how this happens.  'init' uses module_list which has been
updated to handle relative paths.  So I expect 'git submodule init .' to
work correctly here.  I would expect either of them to act on all
submodules when given no extra arguments.

> So this is a good start, but it looks like there is some work left
> to do before this can hit master.

Thanks for the feedback.
