From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 19:09:23 -0500
Message-ID: <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	 <7v3at42avd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 01:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTwd-0007Wr-Mh
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762245AbYALAJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760383AbYALAJY
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:09:24 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:35979 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760097AbYALAJX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:09:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1090610rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BIVEXNRilyABh0w/PMAFQFMWDrUXN9SkAqzxnYpRU0E=;
        b=i9IsiJM9qp/8TeyToOKtTSCJ8OY+MEmgJUN3ITkhNrFBJEBXqltE4uAHNhJBfGxDZcZWSvUS1ot8GQuYTOdVxx1yrO88cH5MEs1uMumcZ9mHrXeRruc80bUCBxPqVu6eQChHHij11MHcsPXVubZL6AKHkMnIgkm7YsbUyL7Zvbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=alJaq0DMfrhN5dCfnw0vRyQbRvaxKa2dve5RlSn6R9J+vE+w8h+fAAx6jmHyE17KkLt5kWHxwawaXISJvs6aarKQxZaTtxaFn8AvAnDsDwc1IIn0vZe9pKhxj6xnMNdV/dD2jQ6wgJhk99PvwOZceOUoi5Y7Yg5fnzWqe8MbJgA=
Received: by 10.140.201.1 with SMTP id y1mr2382683rvf.246.1200096563104;
        Fri, 11 Jan 2008 16:09:23 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Fri, 11 Jan 2008 16:09:23 -0800 (PST)
In-Reply-To: <7v3at42avd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70229>

> I'd almost agree with this patch if if added AUTHOR but not
> COMMITTER, and only when AUTHOR is different from me.  That
> would help reassure anybody while amending other's changes.
> COMMITTER is always me and I should not reminded with extra
> lines that waste precious screen real estate.

The purpose of my patch was to remind _myself_ what my name is, in
case I hadn't configured it correctly.
But I can see this use case also being useful.


> And no, I did not check if your change correctly supports the
> use case of amending other's changes.  But if I recall the code
> correctly, I suspect that your change doesn't.  The recorded
> author is determined after the log message is prepared, way
> later.

Sure, that's possible.


> I strongly agree with Dscho that this change needs to be
> defended with a good description on the reason why this is good.

The patch was really to go along with my RFC about the idea.  I guess
it was too early to post a possible implementation.
(I have only just begun to look at the git code after all..)


> If the reason is "newbie protection", I do not think this is a
> good change at all.  Newbie protection is never a good reason to
> make people who graduated that state to pay extra price
> unconditionally.

I agree.  I wouldn't necessarily say it is "newbie protection", so
much as a friendly reminder of what username you are using while doing
a commit, which, as I said, might not be as expected if you have just
sat down at a new machine.  Especially if you have been using git for
a long time on a single machine, it is something you might easily
forget to configure.  (As I have, several times now.)  I agree,
however, that this it is not necessarily worth having this on the
screen every time you do a commit, for the exceptional instance where
it might be wrong.  Perhaps more usefully it could appear only if you
haven't yet created a user.email and user.name config entry.

Actually in my honest opinion, the default of using the computer's
host name and login is pretty much _never_ right, but I thought this
patch might be less intrusive than introducing a new error message.

I do have a slightly better patch now that has a more informative
message and uses git_committer_info() and git_author_info(), however
I'll wait for any more opinions before posting it.

In retrospect, I guess I could just as easily solve my problem by
introducing a post-receive hook for my personal repo that issues a
warning for commits not configured to my email address.


Steve
