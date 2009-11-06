From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Thu, 5 Nov 2009 23:03:53 -0600
Message-ID: <20091106050353.GA8824@progeny.tock>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
 <20091106010947.GB4425@progeny.tock>
 <20091106021038.GA27206@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Lee <richard@webdezign.co.uk>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 06 05:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6GqJ-0002Lm-9b
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 05:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbZKFEyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 23:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756712AbZKFEyY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 23:54:24 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:39003 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbZKFEyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 23:54:23 -0500
Received: by ywh40 with SMTP id 40so641188ywh.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SWoXYxd5YpZIVIKtX+YAi+0dbrw7RYitcUKIsm9QCiA=;
        b=tpcBozxrdT9NIRqIbVCFy0k00wu/S9noeWP01mIt9tq1sv2kNA3qC27799Wmyt/XPT
         jZ82SnquIhySR+/jnEj3YexFQ7+7veTMYMWJ6mVlVpwDDosrrwfm9GCb+p2nEJ7WI4MI
         sJwmw1gKjZDqILhn6mExMgapFgnBA+BFbPv2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BiXRSaDukR5BdinL8ing7qPoRsgqHlx3+9eqJdm1rHg5W8lS2haHMj30fQfo80aVBc
         mmoBUG/vdS1rEXrGpVR8LMIrSCnhceIDjc9lYoDSHmbayR+Lsa6zkmDy5HBOBM05OwAp
         uyWAfLxK8hCy1rXB1jKrAycpBuiY7fs6ALAgE=
Received: by 10.90.180.16 with SMTP id c16mr7278226agf.15.1257483269141;
        Thu, 05 Nov 2009 20:54:29 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1269492yxe.56.2009.11.05.20.54.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 20:54:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091106021038.GA27206@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132270>

Bj=C3=B6rn Steinbrink wrote:

> For example in git.git, I can do "git log --first-parent
> ..origin/master" to get a high-level log of what happened. And then I
> might see commit b7eb912b0, which is "Merge branch ja/fetch-doc". So =
I
> know "OK, there were some doc updates", without having to crawl throu=
gh
> the individual commits.

Yep, fast-forward merges do ruin the --first-parent log.  Thanks for
the reminder.

>> Of course, these things are a matter of taste.  I just wanted to
>> explain why a fast-forward could at least sometimes be the right
>> result from merging a topic branch (and why, in practice, some peopl=
e
>> never end up needing to use --no-ff).
>=20
> Sure, fast-forwards can be the right thing, e.g. when you have a
> (possibly useless) branch head "master" that you update by pulling. I=
n
> such a case merge commits would only lead to useless clutter.

I hope this use case becomes less important as git=E2=80=99s UI improve=
s.  To
track unmodified upstream sources, a simple 'git checkout' to get
up-to-date is much simpler, except that "git branch" does not display
the current branch any more.  Using 'git pull' for the daily update
makes for a distractingly merge-heavy history once one has commits of
one=E2=80=99s own.

A similar use case won=E2=80=99t disappear: asking someone else to reso=
lve a
merge for you and pulling the result.

=46or both these tasks, --ff-only might give better behavior.

In other cases, I would guess some people would always want --no-ff
and others never.  Apparently, there is a configuration option to
support this: add a line "mergeoptions =3D --no-ff" (or "mergeoptions =3D
--ff") to a [branch "master"] section in .git/config or ~/.gitconfig.

> But
> Richard wants to see where topic branches got merged (to be still abl=
e
> to see what got merged in the future), and yeah, that's a matter of
> taste. But you argued that using --no-ff would "[miss] some of the ma=
in
> benefits of feature branches", which is simply not true.

I spoke imprecisely; I should have said that if most merges are
candidates for fast-forwarding, this suggests feature branches are not
being used in the best way, and --no-ff just makes that situation more
tolerable.

Then your response pushed me towards the question of whether --no-ff
is a good idea in general, and I got distracted. :)  Sorry for the
confusion, and thanks for the insights.

Regards,
Jonathan
