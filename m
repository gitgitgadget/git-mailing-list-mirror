From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ACLs for GIT
Date: Tue, 17 May 2011 07:02:29 +0530
Message-ID: <BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
References: <4DD02876.1040404@bbn.com>
	<20110515201608.GX6349@kiwi.flexilis.local>
	<4DD12517.1000308@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "R. Tyler Croy" <tyler@monkeypox.org>, git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Tue May 17 03:32:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM99P-0004W1-NF
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 03:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab1EQBcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 21:32:31 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61166 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1EQBca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 21:32:30 -0400
Received: by vxi39 with SMTP id 39so26304vxi.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 18:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EgbHOjvBiv7wF/s2JW+c/UXJAjiiph6kdc9Pq9WzlOQ=;
        b=i9NUDyYpAV+9kO9uTHv+c5/l7koP99XfiThPRtyVSJJzRTdXazpK0fna3xdbrgiTvq
         iQbXd0vKGxTj9ssuHnVwyzDRowzp1XIgjhaj/mVTEYD35xkcs5k35WlIduWV/vCX/pKD
         uRhMZU300NO0dmZ4sruL6Q/ydw8V/y4ero9nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tZcUIgAY3H2mBmhZ9eZe1KXlqphxtqeMGKlvh8Hrv8OVW0Ofd+1CFh2hlmD6/RqH+Y
         Q6Yat48B3lBAZILRHntnJCDCRu8N0fkMYNif1Y2baxJsymYTCSsbTjwWcQ8fDgq4x3Pc
         2EXIShuMVcyB1BuSw4dHt/4ZYubkqIAOjuDNk=
Received: by 10.52.116.42 with SMTP id jt10mr103449vdb.36.1305595949860; Mon,
 16 May 2011 18:32:29 -0700 (PDT)
Received: by 10.52.183.6 with HTTP; Mon, 16 May 2011 18:32:29 -0700 (PDT)
In-Reply-To: <4DD12517.1000308@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173780>

On Mon, May 16, 2011 at 6:52 PM, Martin L Resnick <mresnick@bbn.com> wrote:
> Thanks for the reply.
>
> But gitolite would only work to deny reads on a repository or ref basis
> not a pathname level.

I notice the original question has been answered, so this email is
just for the record.

Gitolite does not do any access control on *read* access (fetch,
clone).  It can only do that on *write*s (push).

Gerrit does that because they've reimplemented git itself and have
coded that into their git engine somehow.  I believe they had to
implement a callback from jgit to gerrit for the fetch, and deal with
evil clients that might try to read an object by pushing a supposed
change on top of a SHA that they know but don't actually have. (Or
something like that; I'm not real clear on this...).

regards

sitaram

PS: Gitolite does have unreleased code to do this but it's a hack with
several limitations.  Gitolite makes a temp "clone -l", deletes all
refs from it that the user has no access to, then redirects the
git-upload-pack to that repo instead ;-)
