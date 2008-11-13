From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Thu, 13 Nov 2008 08:58:50 -0500
Message-ID: <f73f7ab80811130558h34cb1220q76ef5536e853151c@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
	 <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
	 <20081109014926.GA31276@coredump.intra.peff.net>
	 <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
	 <20081112084412.GA3860@coredump.intra.peff.net>
	 <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com>
	 <20081113053735.GA5343@coredump.intra.peff.net>
	 <7vhc6ci24o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 15:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ckH-00031t-IO
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 15:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbYKMN6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 08:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYKMN6x
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 08:58:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:39285 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbYKMN6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 08:58:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so399175ywe.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 05:58:50 -0800 (PST)
Received: by 10.100.196.17 with SMTP id t17mr4681985anf.84.1226584730807;
        Thu, 13 Nov 2008 05:58:50 -0800 (PST)
Received: by 10.100.241.4 with HTTP; Thu, 13 Nov 2008 05:58:50 -0800 (PST)
In-Reply-To: <7vhc6ci24o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100874>

On Thu, Nov 13, 2008 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> And then the "push to current branch" problem is neatly solved: you have
>> no current branch.
>>
>> So:
>>
>>   $ git checkout new/branch/to/test^0
>>   $ make, configure, etc
>
> Exactly.
>
> I keep a handful pseudo worktrees around (created with git-new-workdir on
> top of a single repository) for quick patch test and build purposes.  I do
> not push into them but pushing into a non-bare repository and checking out
> the same branch twice in such a setup share exactly the same issue, and I
> keep their HEADs all detached for exactly the same reason.

I guess the issue comes down to a UI complication.  It would very easy
for me to tell somebody how to check out and test their branch in my
testbed if I'm not around, except for that little bit of arcane
syntax.  Moreover, the consequences if they forget are really
frustrating and hard to figure out.  It's also very easy with a GUI to
do the simple *rightclick branch, click "Checkout"*, but would be much
harder to do the detached HEAD checkout correctly.

If it didn't involve reconfiguring a lot of other people's
repositories, I might consider having them push to "refs/remotes/*".
In theory that's actually much closer to what I'm doing anyways.  That
would force any checkouts to be bare, but it would require lots of
git-foo on the pushing side.  Perhaps some way to "git push" which
asks the remote repository where it wants the stuff?

Alternatively, it might be possible to add ref attributes or a config
option to force detached HEAD checkouts.

Cheers,
Kyle Moffett
