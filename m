From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite
 description
Date: Mon, 29 Mar 2010 11:39:42 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003291124211.14365@iabervon.org>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>  <4BAFFFAB.4080808@gmail.com> <alpine.LNX.2.00.1003290055000.14365@iabervon.org> <f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:39:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwH4A-0002r5-SE
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab0C2Pjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:39:45 -0400
Received: from iabervon.org ([66.92.72.58]:48550 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab0C2Pjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:39:44 -0400
Received: (qmail 31993 invoked by uid 1000); 29 Mar 2010 15:39:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2010 15:39:42 -0000
In-Reply-To: <f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143483>

On Mon, 29 Mar 2010, Ramkumar Ramachandra wrote:

> Hi,
> 
> > That information ought to be in the documentation, but possibly not on
> > this man page in particular. I think it would be better to document that
> > part in the documentation of the code and programs that call the helper,
> > not in the helper documentation.
> 
> I agree that the callers need to document the subset of the
> invocations they make to remote helpers. I think we can defer this
> until we have a real remote helper in `git.git` that actually
> interfaces with a foreign versioning system.
> 
> I've thought about documenting the full set of invocations in the code
> for the developer, but there's a problem. Here's an excerpt from
> remote-curl.c, showing how it parses its command line arguments:
> 
> 	remote = remote_get(argv[1]);
> 
> 	if (argc > 2) {
> 		url = argv[2];
> 	} else {
> 		url = remote->url[0];
> 	}
> 
> Unfortunately, I don't see where else this documentation can fit in:
> if it were to go into a specific remote helper's code, then it'll have
> to be duplicated for all the remote helpers, since all of them parse
> options similarly. It certainly cannot go into remote.c or
> transport-helper.c, because they have little/ nothing to do with the
> actual argument parsing.
> 
> I could try modifying the documentation I've written to serve more to
> specify "how remote helpers are invoked" and less about "how callers
> invoke remote helpers", and try to fit it in this manpage. It's more
> of a developer manpage and less of an end-user manpage as it is. Or we
> could create another page about remote helpers intended to be read
> exclusively by developers. What are your thoughts on this?

I think getting information on what the helper is supposed to do with its 
command-line arguments into this man page would be good, and the 
appropriate focus for the man page.

The current answer is this:
 argv[1] is the name of a remote, which may be a nickname or some more 
  direct name; in any case, remote_get() will produce the available data 
  for it.
 argv[2] is the URL, if there is one. Since a remote could have more than 
  one URL, the helper gets the URL it should be handling. Some systems 
  don't use URLs, and these will just look at the remote or something like 
  that.

The rest of what you wrote is true, but it's really more information on 
how the attributes of remotes are determined than what the helper should 
be worrying about.

	-Daniel
*This .sig left intentionally blank*
