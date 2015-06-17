From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v2 2/2] pull: allow dirty tree when rebase.autostash
 enabled
Date: Wed, 17 Jun 2015 12:40:03 +0200
Message-ID: <20150617104003.GA7345@vps892.directvps.nl>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
 <1433625145-29668-1-git-send-email-me@ikke.info>
 <1433625145-29668-2-git-send-email-me@ikke.info>
 <CACRoPnQ0+h2g2cUJk+8zSkcHjoHjezAGC=5pTjn8aFsgB0GrQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Kevin Daudt <compufreak@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5AlO-0000pe-N3
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 12:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbbFQKkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 06:40:07 -0400
Received: from ikke.info ([178.21.113.177]:57787 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907AbbFQKkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 06:40:05 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id B7FD14400AA; Wed, 17 Jun 2015 12:40:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACRoPnQ0+h2g2cUJk+8zSkcHjoHjezAGC=5pTjn8aFsgB0GrQA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271828>

On Thu, Jun 11, 2015 at 09:34:08PM +0800, Paul Tan wrote:
> On Sun, Jun 7, 2015 at 5:12 AM, Kevin Daudt <me@ikke.info> wrote:
> > From: Kevin Daudt <compufreak@gmail.com>
> >
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> 
> Ehh? The sign-off does not match the author of the patch.

I changed it, but aparently forgot to reset the author for that commit

> 
> >  '
> >
> > +test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> > +       test_config branch.to-rebase.rebase true &&
> 
> Ok, though I wonder why not just a git pull --rebase...

Copied that from another test, but was doubting whether to use it or
not.

> 
> > +       test_config rebase.autostash true &&
> > +       git checkout HEAD -- file &&
> 
> Why not git reset --hard before-rebase? If we don't reset HEAD, then
> how would we know if we actually did a rebase?
> 

Good tip, thanks.

> > +       echo dirty > new_file &&
> 
> style: echo dirty >new_file &&
> 

Fixed

> > +       git add new_file &&
> > +       git pull . copy &&
> > +       test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
> 
> Okay, although it would be better to use "test_cmp_rev HEAD^ copy"
> because it prints out the hashes if they are different.
> 

Didn't know about that, and aparently, also not documented. Thanks.

> > +       test $(cat new_file) = dirty &&
> 
> "$(cat new_file)" should be quoted to prevent field splitting.
> 

Fixed

New patch is coming.
