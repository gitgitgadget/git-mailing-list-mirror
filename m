From: Johan Herland <johan@herland.net>
Subject: Re: git format-patch should honor notes
Date: Wed, 8 Dec 2010 11:50:09 +0100
Message-ID: <201012081150.09424.johan@herland.net>
References: <4CFEACC5.70005@redhat.com> <201012081112.12112.johan@herland.net> <4CFF5CD2.2000009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Blake <eblake@redhat.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 11:50:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQHbZ-0007bz-UH
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab0LHKuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:50:32 -0500
Received: from smtp.opera.com ([213.236.208.81]:41435 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab0LHKub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 05:50:31 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oB8Ao9gF010578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Dec 2010 10:50:09 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4CFF5CD2.2000009@drmicha.warpmail.net>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163186>

On Wednesday 08 December 2010, Michael J Gruber wrote:
> Johan Herland venit, vidit, dixit 08.12.2010 11:12:
> > On Wednesday 08 December 2010, Michael J Gruber wrote:
> >> Also, in order to be really useful, I would need a place to store
> >> the cover letter also. I was experimenting a while back with a
> >> design for annotating branchnames which "basically" worked but
> >> haven't had time to really implement it. If I remember correctly,
> >> I had to set up some "bogus" refs to keep my notes from being
> >> garbage collected and was still figuring out the best place to put
> >> them. I'll dig it up when I have time to.
> >
> > I believe the last time the issue of adding notes to branch names
> > was discussed, the consensus was that rather than using notes, they
> > could be stored using a custom entry in the config file, e.g.
> >
> >   git config branch.mybranch.description "Description of mybranch"
> >
> > I might have misremembered this, though.
>
> They certainly "could". The question whether they "should" depends on
> what they are used for:
>
> - config is neither versioned nor easily shareable; perfect for your
> own scratch notes to go away once work is done
>
> - notes are versioned and can be shared (I don't need to tell
> you...); perfect for longer term annotations you want to keep
>
> Note that "sharing" here includes also pushing to your backup repo
> and cloning around. I'd certainly put patch series cover letters in
> the second category.

True. I was wrong to equate cover letters with local-only branch name 
descriptions.

As has been discussed before, you can use notes to store the cover 
letter, the question is which SHA-1 to attach it to.

Using a SHA-1 that doesn't exist in the repo (e.g. the SHA-1 of the 
branch name) leaves the note vulnerable to 'git notes prune', but maybe 
that is an acceptable restriction ('git notes prune' must be manually 
invoked in any case). For extra safety, we could add a config option 
that refuses 'git notes prune' for a given notes ref, something like:

  git config notes.mynotes.refusePrune true


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
