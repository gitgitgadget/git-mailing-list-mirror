From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:35:09 +0530
Message-ID: <CALkWK0m5rnQPkJGd6mjmFP4BKCe+Cip2ifh94a9FHzYTiYtm8Q@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr> <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
 <20130415165352.GH2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmqp-0002Gz-Ai
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab3DORFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:05:51 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62751 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab3DORFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:05:50 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so5581369iec.8
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4eBYw3053k8baTUL4VJamlDJEPTg4H4CiOPHpwHqnMw=;
        b=xp5OPVFoFhXZSDimdZoW0E4L9EZcEp1AUIvCqh+qU1w8LvWIqs8K3FgQ7QyoRNgIva
         07mtlAAU5xdC8wftQZXV9ZpQ1GNdb6E2SWZPcTTeYS4qUjXZ9pvVKqtuu4DACxPUf+/T
         Jg5nnyPaH9kYIJixYQwTtDLcx38D+fvxVEulm96R1QV0GrQcYHvkZOXrhB9HsxmkdbNw
         IHPQ1orWUoOCySI1FYJ2Y4AwLNZ5HHAlXsW3e7Y0r7L+PJ3SAlS7m+XZGwF3jorvyR+i
         eicNjiIdFF1HLd4n7D19/tdScIhM53uzArDegxP8RXauKUXcxdxQPfHy8L2C0AtMu410
         HNKQ==
X-Received: by 10.50.17.71 with SMTP id m7mr5900637igd.14.1366045550052; Mon,
 15 Apr 2013 10:05:50 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 10:05:09 -0700 (PDT)
In-Reply-To: <20130415165352.GH2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221256>

John Keeping wrote:
> Why restrict it to non-interactive?  I'd find it useful when doing
> interactive rebases as well - consider the case when you simply want to
> re-order some commits.

Actually, I made a mistake: it should be doable for any specific
rebase (includes rebase--interactive, rebase--am, and rebase--merge)
just as easily, without leaking the autostash detail into them.  The
last statement in git-rebase.sh is run_specific_rebase, which just
needs to be wrapped in a git stash/ git stash pop.
