From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 01:38:02 -0700
Message-ID: <7v64iy505x.fsf@assigned-by-dhcp.cox.net>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz>
	<e72j53$1m1$1@sea.gmane.org>
	<46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:38:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsnI-0000C6-R3
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFRIiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFRIiE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:38:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40604 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751131AbWFRIiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:38:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618083803.EVWQ5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 04:38:03 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 18 Jun 2006 19:42:48 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22062>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 6/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> So GIT_CONFIG would be ~/.gitconfig, and GIT_CONFIG_LOCAL would be
>> $GIT_DIR/config or what?
>
> I don't quite follow why gitweb needs a GIT_CONFIG_LOCAL defined.
> Given that it works in a CGI environment, it should read
> $GIT_DIR/config by default, and $GIT_CONFIG if set (from httpd.conf).

I am not Pasky, but I think the intent of the patch is to run
"git repo-config" with GIT_CONFIG pointing at /etc/gitweb.conf
to obtain server-wide configuration (e.g. finding out where
repositories are) and then when serving individual repository
(i.e. after we set up GIT_DIR to point at it) run "git
repo-config" without GIT_CONFIG to read per-repository
configuration.  That way we can reuse the configuration parser.
