From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Understanding git filter-branch --subdirectory-filter behaviour
Date: Thu, 22 May 2008 19:05:21 +0100
Message-ID: <e1dab3980805221105k15908606s3397ba1a96ecf081@mail.gmail.com>
References: <e1dab3980805201311m3cbde4f2id8c3493a25745238@mail.gmail.com>
	 <4833C07B.3060004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 22 20:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzFBC-0003q4-Eu
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbYEVSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755727AbYEVSF0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 14:05:26 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:33882 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbYEVSFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 14:05:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so191921tic.23
        for <git@vger.kernel.org>; Thu, 22 May 2008 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eG6Pk2fvH4V2KFkz4caosDajnU7a9pAfIFLIwIzVwLg=;
        b=IoUd01E36OFYwR+wSvu4OeshQrqQ7ORg2lVy7JiygHImzWBnkbwenfNYbJBV7s3Tv1U2R5WlaT5unlhOUBfoxdzCcXbpqdiWs/J/S5gghF/O74nDmLqfCzOAyzCNJP3lLH7lEnFkBPX2wjjU5l7oGI0Y5Yp5l67K6DxzO1mmKAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UZANqSC0vpqlPj8nN0L5IqQVy7YsxQdMTU0aE5f2ekAtm9HXVJ4B1rU+fzNcNnEHWfdvZd6AexhpYGtxsfxfZboLZQA5fNAe9FVgkkgygTpegLHdCWmEJvat2zsoYWrNJ6vxdzAS3aQO58KumsTRz7bTVjOPwZ3mcnRbDUt6UaU=
Received: by 10.150.219.3 with SMTP id r3mr649661ybg.65.1211479521651;
        Thu, 22 May 2008 11:05:21 -0700 (PDT)
Received: by 10.150.225.18 with HTTP; Thu, 22 May 2008 11:05:21 -0700 (PDT)
In-Reply-To: <4833C07B.3060004@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82644>

On Wed, May 21, 2008 at 7:26 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> David Tweed schrieb:
> That's difficult to tell without a peek at the repository.
>
> Did you compare 'gitk HEAD' to 'gitk HEAD -- WRITING'? I'd expect the
> latter to be a subset of the former. Note that with a path specified
> "history simplification" happens, which means that you won't see as many
> merges as when no path is specified.

Just did that in the before-filtering repository, and "gitk HEAD --
WRITING" doesn't have any branches after the simplification but it
does go back to the first commit in the repository creating WRITING
(presumably simplifying out several branches that didn't affect
WRITING), whereas the filtered repository starts on the commit
immediately after the first merge you encounter walking backwards in
time. I was prepared for the branch structure to possibly simplify
whilst keeping all the commits that change that directory, but was a
bit surprised it stopped before the first merge.

<in original>
$ git log HEAD -- WRITING | wc -l
   2033

<in filtered repo>
$ git log | wc -l
329

So it's definitely creating a smaller repo than git log filtering. If
you would be interested in looking at the actual repo (about 17M) let
me know and I'll send you tarball details via personal mail.

Anyway, many thanks for the insight and assistance,
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
