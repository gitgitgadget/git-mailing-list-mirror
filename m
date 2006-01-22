From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Sun, 22 Jan 2006 00:05:09 -0500
Message-ID: <20060122000509.btnr4s4g0wgg0kwo@webmail.spamcop.net>
References: <1137144291.20073.104.camel@dv>
	<b0943d9e0601160018x206faf9ck@mail.gmail.com>
	<1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	<1137539762.12454.11.camel@dv>
	<b0943d9e0601211024s76528ce8m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>,
	Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Sun Jan 22 06:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0XPx-0006rF-3Y
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 06:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAVFFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 00:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWAVFFN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 00:05:13 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:31150 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1750760AbWAVFFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 00:05:11 -0500
Received: (qmail 19974 invoked from network); 22 Jan 2006 05:05:09 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 22 Jan 2006 05:05:09 -0000
Received: (qmail 21616 invoked by uid 99); 22 Jan 2006 05:05:09 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sun, 22 Jan 2006 00:05:09 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0601211024s76528ce8m@mail.gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15045>

Hello, Catalin!

Quoting Catalin Marinas <catalin.marinas@gmail.com>:

> On 17/01/06, Pavel Roskin <proski@gnu.org> wrote:
> > I think if would be better to improve "stg fold" to work on arbitrary
> > patches.  This way, you prepare the patch in the editor (which would not
> > be harder than finding hunk numbers) and fold it into the patch of your
> > choice.  stg should check that the stack remains valid, possibly doing
> > trivial adjustments to the higher patches.  The current tree should not
> > be impacted.
>
> Note that 'stg fold' uses git-apply-patch which doesn't take fuzzy
> patches (a feature I began to like actually). Modifying the patch in
> an editor might create some problems with applying.

Actually, the safest way would be to keep the original patch as presented to the
user.  Then the new patch would be "subtracted" from the original patch (using
e.g. interdiff from diff-utils).  The the difference would be "added" to the
current version of the patch.  Changes to "binary files differ" and similar
line should be ignored.  This way, changes to binary files are preserved.

For additional safety (and at expense or concurrency), it could be required that
 the patch is unchanged since the editor was launched.  Editors tend to run for
a long time compared to non-interactive utilities.

Fuzziness should be tolerated to a point.  Removing hunks could mean that the
line numbers would be slightly off.  If needed, the patch should be applied to
a temporary copy and regenerated from it.

--
Regards,
Pavel Roskin
