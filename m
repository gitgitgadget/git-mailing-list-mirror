From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 07:33:25 +1200
Message-ID: <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
References: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 21:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fslyd-0003iQ-2L
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 21:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFTTd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFTTd1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 15:33:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54937 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWFTTd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 15:33:27 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2437774ugf
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 12:33:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RRS55EqKvZlSL66+4hLP7KsQd8yl3fgK1fJK9Uaf8fs5p8Ow9ZX2rq7HZtLsylJe1i280SQok9J4jWyEKN8yKpZwtQWIKQn+lgbD0A2NUgh4EYcGruS81ln3DwSj7KYIoH+4JCnapUoOlOeSJ0GJptQtrPJxNYhGA3A6TgGYgfU=
Received: by 10.78.52.17 with SMTP id z17mr2917322huz;
        Tue, 20 Jun 2006 12:33:25 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 20 Jun 2006 12:33:25 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e79921$u0e$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22219>

On 6/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
> I am planning on copying features from xmms2's gitweb version
> to git's gitweb, and introducing new ones.

Cool!

> * Storing site-wide gitweb configuration in separate gitweb.conf file.
>   Needs GIT_CONFIG patch. Not implemented yet.
>
>   Bootstrapping: gitweb would need location of configuration file.
>   Has to be changed in gitweb.cgi itself. Additionally gitexecdir or
>   git in PATH is needed to be able to run git-repo-config to read config;
>   the solution might be home-grown "parser" to find gitexecdir only.
>
>   Both could be set from Makefile at install stage.

There's been some discussion about reading GIT_CONFIG from %ENV (but
defaulting to the repo config). If GIT_CONFIG is set, I think we can
trick git-repo-config to parse it for us.

Now, I suspect we'll want to read _both_ the per-repo config and
GIT_CONFIG, which is likely to be /etc/gitweb.conf or similar.

> * Add git fetch URL to the project page from gitweb-xmms2. Needs site-wide
>   base_url, which need not to be set as there is sane default: use base
>   of gitweb URL.
>
>   Is it useful to allow repository configuration to override it?

I think so, as mentioned above.

> * Add (of course optional, like blame support) snapshot support. There are
>   at least two different implementations. I'd prefer to do without second
>   CGI script, but perhaps this is better from the performance point of view.
>   gitweb-xmms2 has snapshot.cgi in Python: should it be rewritten in Perl?

I intend to post a patch that adds snapshot support in Perl, in the
main code. Just need to make it optional ;-)

> * Code highlighting for plain view for blobs. gitweb-xmms2 did that using
>   GNU highlight program and some embedded configuration (filename regexp to
>   syntax used). More generic: run some post-processing. Configurable
>   globally (perhaps separate "syntax type" filename or file magic mapping),
>   and enabled per repository (default off).

Yep, probably a generic filter facility is better...

> * gitweb-xmms2 has something called committags support: it means that
>   'BUG(n)', 'FEATURE(n)' and 'RELEASE: xx' in commit message are turned into
>   bugtracker (Mantis for xmms2) or wiki links. It is extension of turning
>   sha1-ids into references. Probably needs some extra configuration file,
>   and some per repository configuration. Of course we want to support not
>   only Mantis, but also e.g. Bugzilla (e.g. Linux kernel) and conventions
>   for marking bugs therein.

That would be great.

...

> Which of those should be implemented first?

I like the order the list has... but it's up to you.

> Any further ideas for other useful features?

Now what I think would rock too is something similar to gitk's "nearby
tags" feature. When reading a commit, it lists the heads and tags that
this commit is part of. It's very useful. Now I'll have to read up on
how gitk does it.

And, as you mention in your other post, mod_perl support. And a bit of
speed. Gitweb rght now is really really slow.

cheers,



martin
