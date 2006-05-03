From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Tue, 02 May 2006 17:36:24 -0700
Message-ID: <7vmze0hrlj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3bfsol9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605021422520.7051@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 02:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb5M5-0005Ep-F9
	for gcvg-git@gmane.org; Wed, 03 May 2006 02:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWECAg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 20:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWECAg1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 20:36:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8642 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965054AbWECAg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 20:36:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503003625.WLGF27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 20:36:25 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605021422520.7051@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 2 May 2006 14:42:14 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Well, I took the liberty of adjusting the first one in the
>> series and tonight's "pu" has that one and the second one.
>> I haven't touched the third one yet, though.
>
> I don't think it is worth introducing yet another way to specify 
> short-cuts for remote information, if there is not at least one problem 
> which can get solved easier with it than with the other two ways.

I think the biggest contribution this series might bring in is
to send a message that we would want to have things in config,
not outside -- otherwise people might be tempted to do "while on
this branch use this remote to fetch/pull from by default"
outside config (perhaps abusing .git/branches, which _is_ per
branch configuration).

>> I do not like that hidden environment variable that sits in the
>> command I use everyday, waiting to be triggered to update my
>> .config file, possibly by my PEBCAK mistake when I did not want
>> it to do so.
>
> I will refactor it.

Thanks.

> I fixed this error (see separate patch). This was reintroduced by 
> carelessly checking argv[1] for "--list" and "-l", even if argc < 2.

Thanks.

> As for the trust in repo-config writing the config: it is all done by 
> calling git_config_set() or git_config_set_multivar(), which you use 
> yourself to set core.repositoryformatversion, among other values.

Since that happens in a freshly created empty config, I do not
have to have a high confidence for that case, compared to the
case it has to muck with random configuration files people
already have populated with arbitrary gunk.  In any case, I
haven't seen breakage myself recently so hopefully it is safe
enough now ;-).
