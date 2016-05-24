From: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 12:12:30 +0200 (CEST)
Message-ID: <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, matthieu moy <matthieu.moy@grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	larsxschneider@gmail.com
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue May 24 12:05:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b59Cu-00038G-P9
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 12:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbcEXKE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 06:04:57 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59189 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbcEXKE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 06:04:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 945B12552;
	Tue, 24 May 2016 12:04:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUaaFGn9bPUN; Tue, 24 May 2016 12:04:51 +0200 (CEST)
Received: from zm-int-mbx7.grenet.fr (zm-int-mbx7.grenet.fr [130.190.242.146])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 81C7D2508;
	Tue, 24 May 2016 12:04:51 +0200 (CEST)
In-Reply-To: <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Win)/8.0.9_GA_6191)
Thread-Topic: Git remote whitelist/blacklist
Thread-Index: AQLJLMcy5aI0sQo5p+pO4Y/K+qYQcZ3S6uzwnGoegUQ2KyjQFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295481>

> > > On May 20, 2016 10:22 AM, Francois Beutin wrote:
> > > We (Ensimag students) plan to implement the "remote whitelist/blacklist"
> > > feature described in the SoC 2016 ideas, but first I would like to be
> > > sure
> > > we
> > > agree on what exactly this feature would be, and that the community sees
> > > an
> > > interest in it.
> > > 
> > > The general idea is to add a way to prevent accidental push to the wrong
> > > repository, we see two ways to do it:
> > > First solution:
> > >  - a whitelist: Git will accept a push to a repository in it
> > >  - a blacklist: Git will refuse a push to a repository in it
> > >  - a default policy
> > > 
> > > Second solution:
> > >  - a default policy
> > >  - a list of repository not following the default policy
> > > 
> > > The new options in config if we implement the first solution:
> > > 
> > > [remote]
> > > 	# List of repository that will be allowed/denied with
> > > 					# a whitelist/blacklist
> > > 	whitelisted = "http://git-hosting.org"
> > > 	blacklisted = "http://git-hosting2.org"
> > > 
> > > 	# What is displayed when the user attempts a push on an
> > > 		# unauthorised repository? (this option overwrites
> > > 		# the default message)
> > > 	denymessage = "message"
> > > 
> > > 	# What git should do if the user attempts a push on an
> > > 		# unauthorised repository (reject or warn and
> > > 		# ask the user)?
> > > 	denypolicy = reject(default)/warning
> > > 
> > > 	# How should unknown repositories be treated?
> > > 	defaultpolicy = allow(default)/deny
> > > 
> > > 
> > > Some concrete usage example:
> > > 
> > >  - A beginner is working on company code, to prevent him from
> > > 	accidentally pushing the code on a public repository, the
> > > 	company (or him) can do:
> > > git config --global remote.defaultpolicy "deny"
> > > git config --global remote.denymessage "Not the company's server!"
> > > git config --global remote.denypolicy "reject"
> > > git config --global remote.whitelisted "http://company-server.com"
> > > 
> > > 
> > >  - A regular git user fears that he might accidentally push sensible
> > > 	code to a public repository he often uses for free-time
> > > 	projects, he can do:
> > > git config remote.defaultpolicy "allow"	#not really needed
> > > git config remote.denymessage "Are you sure it is the good server?"
> > > git config remote.denypolicy "warning"
> > > git config remote.blacklisted "http://github/personnalproject"
> > > 
> > > 
> > > We would like to gather opinions about this before starting to
> > > 	implement it, is there any controversy? Do you prefer the
> > > 	first or second solution (or none)? Do you find the option's
> > > 	names accurate?
> > 
> > How would this feature be secure and made reliably consistent in managing
> > the
> > policies (I do like storing the lists separate from the repository, btw)?
> > My
> > concern is that by using git config, a legitimate clone can be made of a
> > repository with these attributes, then the attributes overridden by local
> > config on the clone turning the policy off, changing the remote, and
> > thereby
> > allowing a push to an unauthorized destination (example: one on the
> > originally intended blacklist). It is unclear to me how a policy manager
> > would keep track of this or even know this happened and prevent policies
> > from being bypassed - could you clarify this for the requirements?
> > 
> > Cheers,
> > Randall
> > 
> > -- Brief whoami: NonStop&UNIX developer since approximately
> > UNIX(421664400)/NonStop(211288444200000000)
> > -- In my real life, I talk too much.
> > 
> 
> I agree that we cannot have a completly secure and reliable
> way to forbid a push to the wrong remote. This is not what
> our feature is trying to do, we assume that if a programmer
> tweaks his config file and changes the rules he knows what
> he is doing and we won't try to prevent it.
> Our goal is to implement a safeguard against accidental push,
> the feature will work only if the programmer wants it to.


In the end we decided to implement the first solution described
above.
We chose this version because we think there could have been
conflicts between the global and local config files. Moreover, we
think using two different lists for denied/allowed remotes is more
intuitive and user-friendly, and it will allow the user to use
"advanced" options such as:
denied = "http://git-hosting.org"
allowed = "http://git-hosting.org/exception-repo"
to deny a push to git-hosting.org EXCEPT to git-hosting.org/
						exception-repo

We are unsure about the behavior to adopt in case of a conflicting
config file (for example a remote is in both the allowed and the
denied lists). The programm would print a warning message and:
		- follow the defaultpolicy
	OR	- ask for confirmation
	OR	- reject the push
As of now we are inclined to implement the "ask for confirmation"
option.
