From: Nico Williams <nico@cryptonector.com>
Subject: Re: Use case (was Re: Should branches be objects?)
Date: Wed, 25 Jun 2014 00:29:50 -0500
Message-ID: <CAK3OfOgb3zt0HKkeQKfMR9u7sKRzjCZAeOQh=qSyt9cVordG4A@mail.gmail.com>
References: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
	<20140624110932.GI14887@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:29:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzfmP-000291-46
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 07:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbaFYF3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 01:29:53 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:36035 "EHLO
	homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752725AbaFYF3w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2014 01:29:52 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 406F12007F008
	for <git@vger.kernel.org>; Tue, 24 Jun 2014 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=f9BKJdTfd0EiQRg71Aci
	vG9sUbQ=; b=q2iedIbyx5Ts1KBlBzUi8MDXKq5LfDEgh9nDULFGDxAMI0+llOQ6
	rUUhQJu5MG6CfPGqigjgMj0M66/GGiDpNf8Yqzm2g632Ng1XL6O1lnDPlYn4UGnm
	vSJs8JaA1XfIx8/CJILW+V0wxUe2013soh2LFDPiMSLTyvIL8kYk4ts=
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id EA1EB2007F006
	for <git@vger.kernel.org>; Tue, 24 Jun 2014 22:29:51 -0700 (PDT)
Received: by mail-wg0-f43.google.com with SMTP id b13so1383868wgh.14
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 22:29:50 -0700 (PDT)
X-Received: by 10.180.37.230 with SMTP id b6mr7482764wik.47.1403674190606;
 Tue, 24 Jun 2014 22:29:50 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Tue, 24 Jun 2014 22:29:50 -0700 (PDT)
In-Reply-To: <20140624110932.GI14887@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252434>

On Tue, Jun 24, 2014 at 6:09 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jun 23, 2014 at 10:20:14PM -0500, Nico Williams wrote:
> >
> > Now, suppose that branches were objects.  Then at push time one might
> > push with a message about the set of commits being pushed, and this
> > message (and time of push, and pusher ID) would get recorded in the
> > branch object.  At fetch time the branch objects's histories would be
> > pulled (but usually never pushed), and would be available for browsing
> > with git log at remotes/<remote>/<branch>.  Each commit of the branch
> > object (as it were) would record each logical set of commits.
>
> This seems pretty close to what we have with signed tags.  When I send
> a pull request to Linus, I create a signed tag which createscontains a
> message about a set of commits, and this message is automatically
> included in the pull request message generated with "git
> request-pull", and when Linus merges my pull request, the
> cryptographically signed tag, along with the message, date of the
> signature, etc., is preserved for all posterity.

Thanks for pointing this out.  Signed tags are objects -- that's a
clear and strong precedent..  That's another thing that branches as
objects could have: signatures of pushed commits (separately from the
commits themselves).

> It seems the major difference is that it's a pull model, where some
> projects seem much happier with a push model.  But that sounds like
> what is needed is that someone replaces Linus Torvalds with a shell
> script --- namely, an e-mail bot that receives pull requests, checks
> the signed tag against an access control list, and if it is an
> authorized committer, accepts the pull request automatically (or
> rejects it if there are merge conflicts).

Shell script, protocol..  The git push protocol is convenient.  The
fact that git supports a patches-via-email, push, and pull models,
that's a great aspect of git.  Why disadvantage the push case, when
it's so popular (e.g., via github and such)?

Nico
--
