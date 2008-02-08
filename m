From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Minor annoyance with git push
Date: Fri, 8 Feb 2008 17:44:12 +1300
Message-ID: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNL6W-0005br-Fa
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758822AbYBHEoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759771AbYBHEoP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:44:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:16625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268AbYBHEoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:44:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so824335ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 20:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dWtginrZrJgtcbPSF3ai4b0NqAdjKgsYILb8FgF7AQA=;
        b=t9uXeOpOoHJH1huxVSAT12EcmIDuhCR7MbGm/T2Oga5y3/Z8Zbp2KU81dBWW45tJckTyZPYwjpk/GSxHTLbhTV4H38m2CTFUJL2Y7rEmdbl9iP0fFjL43+tg3hobEGXBERNbzlufu9SKmIJzpkciX4DHx+axvrlGWXJvzNEe6Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uhLSS5tzcJtpPdIgmBSdAoBVBldt6JhYVbSNeIuYdR8F15h36YIG3XUiCMzDxIJJCeRUukdM8Kw3n7GH87KqDqief1A5W8q/IGtGvDK81WzMlhx8MRL0y+UySZJooAbJmNLJj4f8pmaI8k1+KjaoOtQnlhiSZGI7yiGE5dIPfsI=
Received: by 10.67.27.3 with SMTP id e3mr4941591ugj.22.1202445852576;
        Thu, 07 Feb 2008 20:44:12 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 20:44:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73038>

I have a minor UI issue with git pull. First, a bit of background: we
run a "central team repo" development model -- and we track on one
repo the "main" branches, and the client branches, where we do minor
customisations and sometimes client-funded feature work that is later
cherry-picked for the "main" branches. This is with a team of ~10
people, and lots of clients.

(To clarify: some clients are in specialised private repositories.
Most are happy and actually request that our work should be public.)

As we run a central repo, we all get *all* the branches when we do
fetch. A bit noisy, but no major issue. It is also a great thing as we
get asked to help in various branches, so I'll often hop on a client
branch that is mainly maintained by someone else, just to fix or
enhance something on the authentication (which I specialise in). After
that, I don't have much to do with that client branch.

This means that beyond the branches I actively work on, I also have
local tracking branches for remote heads that I am not updating. When
I say git push, these stale local tracking branches are making a lot
of noise in the output:

To git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git
 ! [rejected]        mdl17-ceo -> mdl17-ceo (non-fast forward)
 ! [rejected]        mdl18-local -> mdl18-local (non-fast forward)
 ! [rejected]        mdl18-masseyedu-wimbatest ->
mdl18-masseyedu-wimbatest (non-fast forward)
 ! [rejected]        mdl18-nmit -> mdl18-nmit (non-fast forward)
 ! [rejected]        mdl18-proxy -> mdl18-proxy (non-fast forward)
 ! [rejected]        mdl18-shared -> mdl18-shared (non-fast forward)
 ! [rejected]        mdl18-sqm -> mdl18-sqm (non-fast forward)
 ! [rejected]        mdl18-stcuthberts -> mdl18-stcuthberts (non-fast forward)
 ! [rejected]        mdl18-topnz -> mdl18-topnz (non-fast forward)
 ! [rejected]        mdl19-dbperf -> mdl19-dbperf (non-fast forward)
 ! [rejected]        mdl19-ucol -> mdl19-ucol (non-fast forward)
 ! [rejected]        mdl19-uow -> mdl19-uow (non-fast forward)
error: failed to push to 'git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git'

The error messages ("! rejected", "error: failed to push") appear even
if one or two branches did get pushed... I think they are a bit over
the top. None of these "rejected" branches have anything _new_, they
are just stale. Nothing new to say. Can we just ignore them, and only
say "ZOMG Failure! Rejected!!1!!" if we fail to push *new* local
commits that aren't in the repo (leading to an assumption that if the
user said "push" he'd expect those new local commits to be pushed to
the server)?

[ Personally, it doesn't bother me too much. But I can see some
newcomers to my team, and their eyes twitch when they see all the
exclamation marks. I've learned to look for the branch I care about
being pushed in the output, but it's particularly not user friendly as
it stands. ]

cheers,



m
