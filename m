From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH User manual-Added advice on proxies and autocrlf]
Date: Wed, 11 Jun 2008 15:58:32 -0400
Message-ID: <20080611195832.GQ15380@fieldses.org>
References: <1033a22d0806111248l5184cf1at3c3130262d8fd0a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Yesberg <john.yesberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6WTg-0001bY-CE
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYFKT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYFKT6e
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:58:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38615 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbYFKT6d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:58:33 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1K6WSm-0006CC-Jq; Wed, 11 Jun 2008 15:58:32 -0400
Content-Disposition: inline
In-Reply-To: <1033a22d0806111248l5184cf1at3c3130262d8fd0a0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84648>

On Wed, Jun 11, 2008 at 08:48:47PM +0100, John Yesberg wrote:
> ---
>  Documentation/user-manual.txt |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

Thanks!

> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index bfde507..02b1be0 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -56,6 +56,16 @@ $ git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  The initial clone may be time-consuming for a large project, but you
>  will only need to clone once.
> 
> +If there is a proxy between you and the repository you want to clone, you
> +may not be able to use the git protocol. But you can use the http protocol, by
> +configuring the proxy. Note that the address to access the repository via http
> +may be different from the git address:
> +
> +------------------------------------------------
> +$ export http_proxy=http://theproxy.example.com:8080
> +$ git clone http://www.kernel.org/pub/scm/git/git.git
> +------------------------------------------------
> +

Especially this early in the manual, I really want to keep the text
short--we need to get to the basics as quickly as possible--even if that
means leaving out some corner cases.

What actually happens when you run across this case as a user?  Are
there any improvements to the error reporting from "clone" that would
lead the user to the right solution without needing to deal with this
case here?

>  The clone command creates a new directory named after the project ("git"
>  or "linux-2.6" in the examples above).  After you cd into this
>  directory, you will see that it contains a copy of the project files,
> @@ -129,6 +139,19 @@ $ git branch
>  * new
>  ------------------------------------------------
> 
> +It is possible, particularly on Windows platforms, that as you checkout
> +the original version, it will in fact be modified, by the autocrlf process.
> +(Windows and Unix store newlines as CRLF and LF respectively, and autocrlf
> +tries to adapt intelligently.) If the checked out version is modified, then
> +trying to switch to a new branch will not work, because then the uncommitted
> +changes would be lost. So you may need to add the +-f+ flag to _force_ these
> +changes to be thrown away. Another option might be to edit +~/.gitconfig+ or
> +use the following command to disable the autocrlf function.
> +
> +------------------------------------------------
> ++git config --global core.autocrlf false
> +------------------------------------------------
> +

Again, I'd rather not deal with this case in the main text; if we
absolutely need to, a quick reference to the appropriate documentation
("note: if you see an error like XXX, see the XXX man page...") might be
the thing to do.

--b.

>  If you decide that you'd rather see version 2.6.17, you can modify
>  the current branch to point at v2.6.17 instead, with
> 
> -- 
> 1.5.5.1015.g9d258
