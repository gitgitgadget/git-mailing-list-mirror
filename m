From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Projects within projects
Date: Thu, 29 Oct 2009 14:56:36 -0400
Message-ID: <32541b130910291156w693a188dv6dfd0d39a506d145@mail.gmail.com>
References: <ab1d51700910291140ncd80027j4ee9a30637d7bc40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nick Colgan <nick.colgan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3aBD-0004ru-Ct
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbZJ2S4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbZJ2S4w
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:56:52 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57260 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZJ2S4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:56:51 -0400
Received: by ywh40 with SMTP id 40so1969159ywh.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ald98MUWVcoHNL5QoyKCIftYrj74IoZzoxANO3Kohc0=;
        b=Kc++w3Cc2lZZslIWH+e9wD3/eVfB7LyrTt505y+JyrXIIGwwP+pwtVQv2gHh3uFz60
         0ZzHAMVJNJggQQBonjnqBQvGH0p9ehItH5hae3tjwbhiHEKlSsEnOx9pTCE1eNAV2pTv
         /oQZGQawodFc/rOfNgB0S+1nL8Q1nNR1w4lZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qyTWFHY1MT6hE2ECltm9reTPFFPiySrL+6cgY3dEC88AodzkBdp6FOJtwtTemdS7KS
         1KFlK2csYnVIUlrGVrjNVxcAXqRx5KNJwe2LLadAPDSwaQtqY2hVFU00aYdjzJAOjTe4
         lG9XwvVErL89TdZhthE0A2VxYUJQ5ypGVb158=
Received: by 10.150.129.40 with SMTP id b40mr951368ybd.311.1256842616306; Thu, 
	29 Oct 2009 11:56:56 -0700 (PDT)
In-Reply-To: <ab1d51700910291140ncd80027j4ee9a30637d7bc40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131646>

On Thu, Oct 29, 2009 at 2:40 PM, Nick Colgan <nick.colgan@gmail.com> wrote:
> These are the current options I have in mind:
>
> 1. Create a separate repository for each sub-project and manage each
> separately in redmine (separate bug tracker, wiki, etc.)
>
> 2. Create a single repository with a subdirectory for each sub-project.
>
> 3. Use git submodules or subversion externals to combine options 1 and 2
> by creating a separate repo for each sub-project, then creating a master
> repo with subdirectory for each sub-project that imports from their
> respective repositories.
>
> What's the best way to handle this situation? Are git submodules and/or
> svn externals sufficiently capable of dealing with this?

Every way has tradeoffs.  I'd suggest first thinking about whether
these supposedly independent projects are *really* going to be
independent or not.  If they're unlikely to ever be reused - or they
won't be for a long time - #2 is by far the easiest choice.

If you choose #2 and then choose to split the repo later, you can use
git-subtree (http://github.com/apenwarr/git-subtree) to split it
easily, so there's little sacrifice in using #2 at first and changing
your mind later.

If you choose #3, that's exactly that git-submodule and svn:externals
are for, and it seems to work okay for a lot of people.  It's more
work though, since you have to be careful to isolate commits between
one project and another, etc. Personally I prefer to use git-subtree
for this too, but it's a matter of preference.

Have fun,

Avery
