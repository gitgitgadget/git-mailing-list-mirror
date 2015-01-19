From: Josh Triplett <josh@joshtriplett.org>
Subject: Pretty format specifier for commit count?
Date: Sun, 18 Jan 2015 17:29:27 -0800
Message-ID: <20150119012926.GA24004@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 02:29:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YD19v-0001hr-ST
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 02:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbASB3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 20:29:35 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40092 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbASB3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 20:29:35 -0500
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 8836917207C
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 02:29:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter16-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter16-d.gandi.net (mfilter16-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hlnjYT5VUDfs for <git@vger.kernel.org>;
	Mon, 19 Jan 2015 02:29:31 +0100 (CET)
X-Originating-IP: 50.43.58.154
Received: from thin (static-50-43-58-154.bvtn.or.frontiernet.net [50.43.58.154])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9A1F3172077
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 02:29:30 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262607>

I'd like to use git-log to generate a Debian changelog file (with one
entry per commit), which has entries like this:

package-name (version-number) unstable; urgency=low

 * ...

 -- Example Person <person@example.org>  RFC822-date

Since I'm intentionally generating one entry per commit, I can generate
*almost* all of this with git log:

git log --pretty='format:packagename (FIXME) unstable; urgency=low%n%n  * %s%n%w(0,4,4)%+b%w(0,0,0)%n -- %an <%ae>  %aD%n'

This produces entries like this:

packagename (FIXME) unstable; urgency=low

  * Example change

    Long description of example change.

 -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:52 -0800

packagename (FIXME) unstable; urgency=low

  * Initial version

 -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:51 -0800

Would it be possible to add a format specifier producing a commit count,
similar to that provided by git-describe?  Such a specifier would allow
filling in the version number in the format above (replacing the FIXME).
(Note that the version numbers need to monotonically increase; otherwise
I would just use the commit hash as the version numer.)

- Josh Triplett
