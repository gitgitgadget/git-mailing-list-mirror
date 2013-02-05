From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: importing two different trees into a fresh git repo
Date: Tue, 5 Feb 2013 13:46:09 -0800
Message-ID: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 22:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qLb-0008Rm-7I
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 22:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab3BEVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 16:46:12 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:39750 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab3BEVqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 16:46:11 -0500
Received: by mail-lb0-f173.google.com with SMTP id gf7so628241lbb.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 13:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=AYSphruvL2yY92yfmqXoP15/kEFoYA5/5kgVS+uAUXM=;
        b=u3f+yDLIVp/1o1tu3+N2aH5OIBDRiyyGJrjJMp1Xga0jukmTFpBhfkRmqi59V6/g3S
         qCyHuPJUc7HrYXAh9vIPQb8AYHNbf1krQkze4VKgmYc9SCtpbMozZ36gxNlKsZedGFmI
         pvlqFQbjJQvd7yukIRVfW4yH3hDndDfyxLSfQdzFUAItKsAOwJ4s6u8VgWyhxo6ETQJ1
         9y1lUZ0aZlbfwxon1TetKEQWMW0febwGDRFhz9KrifYgrizBrHPME9GuV76/4AHeaUky
         yXXfzRpyQc4+oMGW35rS3hs6VQfiGYNeyK3L9lEJZgxjFQeS6cuf+XJqp/FbJYc07gZy
         WEHg==
X-Received: by 10.112.17.166 with SMTP id p6mr4920623lbd.41.1360100769707;
 Tue, 05 Feb 2013 13:46:09 -0800 (PST)
Received: by 10.114.98.168 with HTTP; Tue, 5 Feb 2013 13:46:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215543>

Hi,

I have two distinct trees that were not managed by any RCS, and I'd
like to import them into a single repository into two separate orphan
branches, then make sense of what's in there, merge, and unify into
'master'.

(To give some context, it's /etc/nginx config files from nginx/1.0.12
on Debian 6 and nginx/1.2.2 on OpenBSD 5.2.)

I've encountered two problems so far:

0. After initialising the repository, I was unable to `git checkout
--orphan Debian-6.0.4-nginx-1.0.12` -- presumably it doesn't work when
the repo is empty?  This sounds like a bug or an artefact of
implementation.  I presume this can be worked around by committing
into master instead, and then doing `git checkout -b
Debian-6.0.4-nginx-1.0.12`, and then force-fixing the master somehow
later on.

1. After making a mistake on my first commit (my first commit into
OpenBSD-5.2-nginx-1.2.2 orphan branch ended up including a directory
from master by mistake), I am now unable to rebase and "fixup" the
changes -- `git rebase --interactive HEAD~2` doesn't work, which, from
one perspective, makes perfect sense (indeed there's no prior
revision), but, from another, it's not immediately obvious how to
quickly work around it.

Any suggestions?

It would seem like making some kind of a dummy first commit into
master would be the best workaround for both of these problems.  Is
that basically the suggested approach?

Best regards,
Constantine.
