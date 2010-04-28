From: David Borowitz <dborowitz@google.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 12:49:55 -0700
Message-ID: <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 21:50:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DHS-0000An-U4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 21:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079Ab0D1TuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 15:50:24 -0400
Received: from smtp-out.google.com ([216.239.44.51]:41745 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0D1TuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 15:50:23 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id o3SJoLHc031544
	for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:50:21 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1272484221; bh=YThiw5Cy3bV2HnxbZKwTsxrTG+E=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=x9zrCrLZefJZl2V15idrb6oGhGo/iBzRaiBiOXK5uOMprknVF7dPFU0LJa2evoQsi
	 9sn5R+n69ct5pHexHF8mg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:from:date:message-id:
	subject:to:cc:content-type:content-transfer-encoding:x-system-of-record;
	b=q7ISCTDvIdtPe9h7Hun10+OiAfrJ3nIfxvZdZIirRHnRLfB+ZbIMaHQAyPF6wCc30
	8pRVnMjfIz4Yk8t3vZBQw==
Received: from ywh29 (ywh29.prod.google.com [10.192.8.29])
	by wpaz37.hot.corp.google.com with ESMTP id o3SJoKnn020827
	for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:50:20 -0700
Received: by ywh29 with SMTP id 29so18494831ywh.14
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:50:20 -0700 (PDT)
Received: by 10.150.56.16 with SMTP id e16mr212177yba.281.1272484215899; Wed, 
	28 Apr 2010 12:50:15 -0700 (PDT)
Received: by 10.151.128.2 with HTTP; Wed, 28 Apr 2010 12:49:55 -0700 (PDT)
In-Reply-To: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146008>

On Wed, Apr 28, 2010 at 12:38, Eugene Sajine <euguess@gmail.com> wrote:
>
> hi,
>
> we have tried to cherry-pick 2 commits from one branch to another
> branch, but unfortunately the incorrect commit was chosen to be
> applied first.
>
> Thus, the automatic cherry-pick failed and caused conflicts, so in
> order to to cancel the whole operation i had to do the following:
>
> 1. mark the conflicting files as resolved (without even resolving
> them) by doing git add.
> 2. unstage all files staged for commit as a result of incomplete cher=
ry picking
> 3. manually checkout touched files to their correct state (git checko=
ut file)
>
> and then i was able to repeat cherry-picking with correct commits.
>
> Is there a better way?

git reset --hard HEAD@{1}?

> Shouldn't there be a "git cherry-pick --abort"
> for such cases as it exists for rebase?

ISTM the --abort flag to rebase is useful because HEAD may have
changed an arbitrary number of times between the start of the rebase
and now, so you wouldn't know which reflog entry to choose. (The same
holds for "git bisect reset".) But with a cherry-pick it's always
@{1}.

> Thanks,
> Eugene
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
