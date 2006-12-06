X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Wed, 06 Dec 2006 11:11:31 -0800
Message-ID: <7vveko3km4.fsf@assigned-by-dhcp.cox.net>
References: <200612040001.13640.jnareb@gmail.com>
	<200612041133.44816.jnareb@gmail.com>
	<7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
	<200612061351.02712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:11:46 +0000 (UTC)
Cc: git@vger.kernel.org, Pasky Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612061351.02712.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 6 Dec 2006 13:51:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33507>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2B7-0007Cp-1o for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937095AbWLFTLe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937196AbWLFTLe
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:11:34 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48419 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937095AbWLFTLd (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 14:11:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206191132.YMAZ4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 14:11:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vXBi1V00a1kojtg0000000; Wed, 06 Dec 2006
 14:11:42 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> 1. Make it easier to have per repository gitweb configuration, for
>    example by having gitweb configuration file in GIT_DIR for a project,
>    "gitweb_conf.perl" by default:
>
>   our $GITWEB_REPO_CONFIG = $ENV{'GITWEB_REPO_CONFIG'} ||
>   	"++GITWEB_CONFIG++";
>   do "$projectroot/$project/$GITWEB_REPO_CONFIG"
>   	if -e "$projectroot/$project/$GITWEB_CONFIG";

I suspect site administrators would hesitate to have perl
scripts in repositories that could run arbitrary things as their
"side effects".

> 2. Put the configuration in config file, using/like %features support.
>    For example gitweb.committags.<committag name> would hold parameters
>    for <committag>. Committags sequence would be given by sequence of
>    entries in config file. Comittags without options would have sole
>    variable entry (which I think is equivalent to being bool variable
>    and having 1 or 'yes' as value).

I think gitweb.* in $GIT_DIR/config and a config reader in Perl
are very sensible things to do, and you would need the config
reader eventually anyway.  The longer we postpone it, the more
we risk the temptation to pollute $GIT_DIR/ with the likes of
"description", "owner", and "homepage", and I do not think we
want to make this worse.

> What do you think about it? Junio? Pasky?

If you are asking Pasky, you should CC him, I think.  I added
him to the CC list.
