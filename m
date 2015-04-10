From: John Keeping <john@keeping.me.uk>
Subject: Re: Rebasing with submodule change causes red herring with --continue
Date: Fri, 10 Apr 2015 17:44:13 +0100
Message-ID: <20150410164413.GL21452@serenity.lan>
References: <CAHd499AqCJ5N1GP6mBJZB7-9vWPNjtia1G7PHoSY3d=Zovv7UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 18:44:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ygc2e-000882-DH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 18:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbbDJQoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 12:44:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:33233 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbbDJQoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 12:44:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9610BCDA595;
	Fri, 10 Apr 2015 17:44:21 +0100 (BST)
X-Quarantine-ID: <Gyks2tB6kauR>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Gyks2tB6kauR; Fri, 10 Apr 2015 17:44:20 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 75EBDCDA593;
	Fri, 10 Apr 2015 17:44:14 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAHd499AqCJ5N1GP6mBJZB7-9vWPNjtia1G7PHoSY3d=Zovv7UA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267017>

On Fri, Apr 10, 2015 at 11:30:20AM -0500, Robert Dailey wrote:
> I have a branch that contains a commit with a single change: A
> submodule pointing to a new SHA1.
> 
> When I rebase this branch onto the tip of its parent branch AND that
> parent branch had modified that same submodule, the rebase stops at
> the commit on my branch that modified the submodule and asks me if I
> want to keep REMOTE or LOCAL. I say LOCAL and notice immediately that
> the submodule is not staged (normally it would be).
> 
> I do:
> 
> $ git add my-submodule
> 
> Then I do:
> 
> $ git rebase --continue
> 
> At this point, it fails asking me if I forgot to stage changes and
> recommends doing --skip. This is normally what you would see if the
> staging area was completely empty, however it isn't, since I see the
> submodule is in there.
> 
> Is this a bug or am I missing a fundamental here? I'm using Git 2.1.0
> on Windows through MSYS. I'll provide more concrete examples if my
> summary of the issue doesn't "ring any bells".

I hit something similar in the past, but it was fixed with commit
a6754cd (rebase -i continue: don't skip commits that only change
submodules, 2012-04-07) so I think you must be hitting a slightly
different problem, although the tests added in that commit look like
they do test the scenario you describe (specifically 'rebase -i continue
with only submodule staged').
