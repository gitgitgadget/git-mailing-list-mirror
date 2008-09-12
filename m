From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit question
Date: Fri, 12 Sep 2008 09:51:16 +0200
Message-ID: <20080912075116.GA26685@diana.vm.bytemark.co.uk>
References: <48C94F86.6080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 09:32:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke36q-00058K-92
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 09:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYILH3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 03:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYILH3V
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 03:29:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1850 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYILH3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 03:29:21 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ke3Qy-00076U-00; Fri, 12 Sep 2008 08:51:16 +0100
Content-Disposition: inline
In-Reply-To: <48C94F86.6080707@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95690>

On 2008-09-11 12:04:06 -0500, Clark Williams wrote:

> Are there any guidelines or best-practices for sharing StGit trees?

See below. ;-)

> I'm working with the Linux -rt patchset and I need to be able to
> share my tree with other people. What I'd *like* to do is push git
> tree's up to a git server, let other people fetch them and have them
> be able to 'stg uncommit' to get back to my stack state. The problem
> is that when someone uncommits, you lose the patch names. If you're
> trying to create an RPM out of a stack, this causes problems :).
>
> Is there something I can do or something that we can do to StGit to
> make it possible for an 'uncommit' to restore the original patch
> name? It looks like I could modify the commit message, so that the
> first line is the patch name, but that's not very nice for people
> scanning commits.
>
> Or am I missing something completely trivial that will make my life
> easier?

You've probably already found this and dismissed it, but

  $ stg uncommit foo bar baz woo wee aaahh

will uncommit six patches and give them those names. So if you just
share the output of

  $ stg series --applied --noprefix

along with your branch, the other end will be able to recreate a
series with the same names. (In not-quite-bleeding-edge stg's, "series
--applied" is spelled "applied".)

As for merging your work once both of you have made changes to the
series, the current solution is "stg sync", which you'll have to ask
Catalin about. The patch stack log in my experimental branch is
designed to allow for true 3-way merging of patch series, so that
you'd be able to get your colleague's latest modifications with a
simple "stg merge" command, but that merge currently exists only in a
couple of mails to this list -- there isn't even a prototype
implementation -- so I expect you'll have more luck with "stg sync"
right now ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
