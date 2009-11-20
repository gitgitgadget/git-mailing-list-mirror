From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What
	does that say about git?
Date: Fri, 20 Nov 2009 16:58:47 +0100
Message-ID: <20091120155847.GA1359@localhost>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com> <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian May <adrian.alexander.may@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 16:59:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBVtF-0007Hu-Mg
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 16:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbZKTP7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 10:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZKTP7E
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 10:59:04 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50910 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZKTP7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 10:59:03 -0500
Received: by bwz27 with SMTP id 27so3481756bwz.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5nIVnjW4lv4jWxQmpFEcn3Y9PJ2B049xpUQZsSf5g4E=;
        b=OBg8/Aun5Y6fSe2R3CC2u204fc89Co+dRzQgmt28g50gk60FwznSLiG3sO/DYHNhjX
         clDTNpYJATZ5/OEEYbydovYJD9FLcg8MRoYRdHWNxzSi+aBLdUl5nhRyTtcIytUHNgzH
         zpnpRZ8kMz7tzzaZjZ31LjxxykwY/fFHOpSTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=nkUEPGojOffBQwbCXkt1kAzdX4zC8YmaLDCFO8aKph8yC5anmLo0Rzw9yDuZbfsTzz
         4unE87vbZAisXaZyW+++5v8JzF+PZaT1q+0VMZcWBOJV/N7dyDbwCUUyVAJfOhcRB67r
         BbGHkAsa+C45d/alYjtQFDNYJtB3fPxgjHB3M=
Received: by 10.204.141.3 with SMTP id k3mr1530160bku.177.1258732748476;
        Fri, 20 Nov 2009 07:59:08 -0800 (PST)
Received: from darc.lan (p549A4DE7.dip.t-dialin.net [84.154.77.231])
        by mx.google.com with ESMTPS id 16sm463417bwz.15.2009.11.20.07.59.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 07:59:06 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1NBVsl-0000nt-I6; Fri, 20 Nov 2009 16:58:47 +0100
Content-Disposition: inline
In-Reply-To: <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133353>

On Fri, Nov 20, 2009 at 06:51:32PM +0800, Adrian May wrote:
> Git is just plain wrong, because you can't split or merge repositories
> or pull subtrees of them.

I think you made an unfortunate choice of words here, because as others have
mentioned, splitting and merging subtrees is implemented already. Maybe you
were talking about checking out or cloning subtrees. To date, none of the
distributed version control systems are capable of doing that. And that is
one of the reasons why we have wrapper scripts like repo (although IIRC repo
does a lot more than just that).

AFAICS, there is no fundamental reason why this should be difficult to
support. Clearly, there are some odd situations to deal with. For example,
how to deal with merge conflicts that happen outside of the subtree that's
currently available? How to detect (modified) moves of files into the
available subtree?

But we could simply fail in these cases. The workarounds currently in use
are not able to do this either.

> It doesn't have the kind of triggers you need to assert change control
> either, and these bolt-on scripts are just making life messy.

I don't understand what you mean here.

> Will somebody please finish git itself instead of working around it, or
> use a source control system that's up to the job.

There is a desire to do this in the git community, as documented in [1].
However, it appears to be hard enough to do so that people had rather
implement custom solutions such as git-submodules, which are probably just
good enough for them.

Clemens

[1] http://git.or.cz/gitwiki/SoC2009Ideas#NarrowandSparseclonesupport
