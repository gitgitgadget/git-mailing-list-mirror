From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v3] rev-list: refuse --first-parent combined with --bisect
Date: Mon, 9 Mar 2015 12:57:33 +0100
Message-ID: <20150309115733.GB6273@vps892.directvps.nl>
References: <1425824339-8036-1-git-send-email-me@ikke.info>
 <1425827005-9602-1-git-send-email-me@ikke.info>
 <CAPig+cROEyWvJDW7uf1D7owdL-FwLHMtEBwWSNwS1M=vMcozLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 12:57:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUwJY-0003na-PS
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 12:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbCIL5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 07:57:36 -0400
Received: from ikke.info ([178.21.113.177]:37903 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbbCIL5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 07:57:35 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id B6E701DCF6D; Mon,  9 Mar 2015 12:57:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPig+cROEyWvJDW7uf1D7owdL-FwLHMtEBwWSNwS1M=vMcozLQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265160>

On Sun, Mar 08, 2015 at 05:58:24PM -0400, Eric Sunshine wrote:
> On Sun, Mar 8, 2015 at 11:03 AM, Kevin Daudt <me@ikke.info> wrote:
> > rev-list --bisect is used by git bisect, but never together with
> > --first-parent. Because rev-list --bisect together with --first-parent
> > is not handled currently, and even leads to segfaults, refuse to use
> > both options together.
> >
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > Suggested-by: Junio C. Hamano <gitster@pobox.com>
> 
> It's customary for your sign-off to be last.
> 

Ok, noted

> > ---
> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index 4ed8587..05c3f6d 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -123,7 +123,8 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
> >         because merges into a topic branch tend to be only about
> >         adjusting to updated upstream from time to time, and
> >         this option allows you to ignore the individual commits
> > -       brought in to your history by such a merge.
> > +       brought in to your history by such a merge. Cannot be
> > +       combined with --bisect.
> 
> A couple questions:
> 
> Should the documentation for ---bisect be updated to mention this
> restriction also?

Was doubting whether that was necessary as --bisect can be seen as a
mode, and --first-parent modifying that mode. But it can make sense to
also add it to that section.

> 
> Should this change be protected by a "ifndef::git-rev-list[]" as are
> all other mentions of "bisect" in rev-list-options.txt?

Yes, I see why. git log also uses rev-list-options.txt and it has a
--bisect option that is unrelated to this one, so that comment doesn't
make sense for git log.

Will reroll this later.
