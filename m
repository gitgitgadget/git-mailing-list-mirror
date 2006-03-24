From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug encountered while comitting
Date: Fri, 24 Mar 2006 14:55:49 -0800
Message-ID: <7vacbfzc3u.fsf@assigned-by-dhcp.cox.net>
References: <20060324183951.GA23193@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 23:56:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMvCF-0005kB-Hq
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 23:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCXWzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCXWzw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 17:55:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55788 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932194AbWCXWzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 17:55:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324225550.FOBZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 17:55:50 -0500
To: Matthias Kestenholz <lists@irregular.ch>
In-Reply-To: <20060324183951.GA23193@spinlock.ch> (Matthias Kestenholz's
	message of "Fri, 24 Mar 2006 19:39:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17943>

Matthias Kestenholz <lists@irregular.ch> writes:

> The PHP script created directories under .git/objects which were
> only writable by www-data. There were other directories which were
> owned by user mk and group www-data, and they were group writable.
>
> So, I had write access to only a part of the .git directory.

core.sharedrepository perhaps?

While it probably is not a good idea to have you in www-data, it
appears that is essentially you will end up doing, because PHP
scripts that may _create_ new directories better not to have
privilege to give newly created directories away to you (busting
your quota), so they will be owned by www-data.www-data and for
you to be able to write into it you either need to be www-data
user or in www-data group, with core.sharedrepostiory set.
