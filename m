From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: push not resolving commit-ish?
Date: Fri, 24 May 2013 00:16:47 +0300
Message-ID: <20130523211647.GC31421@redhat.com>
References: <20130523105310.GA17361@redhat.com>
 <CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
 <7v4ndtftyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfcsD-0000fw-43
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944Ab3EWVQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758494Ab3EWVQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:16:28 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NLGOwh019529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 23 May 2013 17:16:25 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4NLGMqN001145;
	Thu, 23 May 2013 17:16:23 -0400
Content-Disposition: inline
In-Reply-To: <7v4ndtftyf.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225296>

On Thu, May 23, 2013 at 11:10:32AM -0700, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Thu, May 23, 2013 at 5:53 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> Looks like push can't resolve tags to commits.
> >> Why is that?
> >>
> >> linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next
> >
> > Perhaps v3.10-rc2^{}. Yeah, totally and completely not-user-friendly,
> 
> More commonly "v3.10-rc2^0:vhost-next", if you are truly pushing it
> out to a remote repository, but then it invites a puzzlement "What
> do you plan to do next after pushing?  The only reason v3.10-rc2 is
> used is because there is not yet a local branch that will host the
> vhost-next changes that is built on top of that tag (otherwise you
> would be pushing that branch to vhost-next)".

This was just a bad example.
The real reason is this:

I have a development branch, vhost-next. I have a tag there
like for_linus for things that are ready to go out.
I don't always point it at the tip of the branch
since I might want to rebase/amend X last commits.

It's a tag and not a branch since I need to sign the tag.
I push to a branch and not just the tag since this way
people can track it and do downstream development on top.
So pushing the tag to branch would save me some churn.


> But in this particular case, you are force-pushing into the current
> repository, and it is spelled much more commonly
> 
>     git branch -f vhost-next v3.10-rc2
> 
> I would think.
