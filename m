From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 15:38:01 +0200
Message-ID: <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
	 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
	 <Pine.LNX.4.64.0709171422340.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGnh-0004qq-MP
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbXIQNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbXIQNiE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:38:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:25357 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbXIQNiC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:38:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1304019rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RBbeAsDbIzS4+rixrze0uXAIFDgqCMkh/14I3GEDiCU=;
        b=oZpbQEz/ntBSNpuvs5b4syvCvh1FYr1tfQY2yYklZsTBH2g7vy6a/OBNfwI1gBHY7Q90+vj/r3fZUMgfPbUWdn6pKJ8fIGyP1Zn1nDq2rAh9HQTPh5U5TWjJkkRRPoa+W8rzUfA7E/JqzqiR6viLB8yOdUJW5Gha0Un6ItX6Wlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hiXtTJLKtBBci9zX+ScT7sTh4dq1/vUlxUKAtkCttuVAtWPbttLls9+h4LJeEByu5SzxqWRs0Oo7m4uZpzVNaoYjXVf7yXfnTwLz/rGsT2DbCmmU/cipb1u3v+p471qxdqZv8FM3UD/b8psMvEAnkUqRn6BB1cHXnFdFGYDYM3c=
Received: by 10.114.157.1 with SMTP id f1mr500231wae.1190036281985;
        Mon, 17 Sep 2007 06:38:01 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 06:38:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709171422340.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58442>

[Cc'd Eric since he's the expert on git-svn]

On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Sep 2007, Lars Hjemli wrote:
>
> > When 'git-svn dcommit' decides which commits it should push back
> > subversion, it scans the output from 'git-log --first-parent HEAD'
> > looking for embedded 'git-svn-id' lines. These lines contain the url
> > of the upstream subversion repository + the subversion revision
> > number.
>
> > So the problem with fast-forward merges of subversion branches is that
> > the output from 'git-log --first-parent HEAD' will show commits from the
> > wrong subversion branch (the fast-forwarded commits).
>
> Ah, I think I know what you're trying to get at.  But "git svn fetch &&
> git rebase git-svn" might be a better approach than "git svn fetch && git
> merge --no-ff git-svn", no?

If I'm understanding you right: no. After  a rebase, the commits would
be ignored by git-svn when looking for the subversion upstream branch
(since the commit SHA1's would no longer match the ones stored in
git-svn's rev_db), but the subversion history would look like
'cherry-picked n commits from merged branch' after dcommit.

-- 
larsh
