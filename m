From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Sun, 30 Jul 2006 23:41:50 -0700
Message-ID: <7vslki9sy9.fsf@assigned-by-dhcp.cox.net>
References: <20060730223754.GA16364@admingilde.org>
	<20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jul 31 08:41:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7RTQ-00036X-Lr
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 08:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGaGlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWGaGlw
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 02:41:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57840 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932152AbWGaGlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 02:41:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731064151.ZUDK1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 02:41:51 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Sun, 30 Jul 2006 20:57:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24493>

-
Luben Tuikov <ltuikov@yahoo.com> writes:

> -- Martin Waitz <tali@admingilde.org> wrote:
>> Generate gitweb/gitweb.cgi to reduce the need to patch gitweb.cgi by
>> the end user.
>> The GIT installation directory and version are already known by the
>> Makefile, they can be inserted directly into gitweb.
>> All other gitweb configuration parameters can now be specified
>> by providing GITWEB_* variables while building GIT.
>> These are described in gitweb/README.
>
> NACK.
>
> I don't like it.  While this method works, it is too much effort
> to have to run make to do this, plus it pollutes your tree.

I do not quite agree with this reasoning.  With that definition
of "polluting your tree", all build of git-*.{sh,perl,py} are
polluting your tree.  If compile/install time customization is
handier I do not have problem doing it that way.

> Instead, what you can do is make gitweb.cgi read a text file
> from . which has those variables defined.

I think there was a discussion on having a configuration file
for gitweb (not per-repository .git/config but installation wide
configuration file).  If I recall correctly, the killer argument
against it was that you would need to bootstrap the process by
somehow telling gitweb.cgi where to read from that configuration
file, and if you are going to customize gitweb.cgi before
installation for the site that way, then giving a bit more
configuration in gitweb.cgi (like Martin did in the patch we are
discussion) is simpler.

>   - no need to run make to build "gitweb.cgi" or "gitweb.pl" whatever
>     you call it,
>   - no need to pollute your tree with site defined variables,
>   - simple copy (cp) would install a working version, instead of
>     the current cp + patch with local settings method.

While I agree all of these "no need to" makes things slightly
simpler, I do not think it is such a big deal -- we are building
git-*.{sh,perl,py,c} anyway.
