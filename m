From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sat, 21 Mar 2009 11:58:18 -0700
Message-ID: <20090321185817.GA22540@gmail.com>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org> <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll6Pm-0003hK-Jj
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 19:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbZCUS5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZCUS5n
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 14:57:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:2191 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZCUS5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 14:57:42 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1029747wah.21
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cmiWxwXXVs/TMnyncs19m6t9cjEhMRDvDZgVhwFi66c=;
        b=AefUpl2yYyy6oAP0XQjpDoqKzBI7/i4q9B7um3cVv4IW7OPQUMq8N7QpESVpSVzCcx
         s6en5LqHlDQG7g7/2qle4oeI2c3T0PFlWuzdx9fJFMVNu21t/GEgEBo691RZi6qoMJ6P
         9iuhV2xigm+9nFZl5qI1oU/sHddS3nUzeEYcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mD/xUYQkqOOehdjAMGl1HG5SeSnAxRbHiUVYrioTEbA6lVfsxrg5B+Iu/Gbr8ks816
         ZONeOKj/VJIDSvlEPgFXOxq12HqEtHhnNYgxG3JWbtkNbSidcS9dNuEspeRKEE3kuntt
         iSTbQpohc3INz9zHxu5eo6f9a/ciEFXnHA0Kw=
Received: by 10.114.184.11 with SMTP id h11mr3446269waf.100.1237661860529;
        Sat, 21 Mar 2009 11:57:40 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m31sm3430540wag.29.2009.03.21.11.57.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 11:57:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114050>

On  0, Wincent Colaiuta <win@wincent.com> wrote:
> El 21/3/2009, a las 8:58, Junio C Hamano escribi=F3:
>
>> * da/difftool (Thu Mar 19 01:25:25 2009 -0700) 1 commit
>> - difftool: move 'git-difftool' out of contrib
>
> Before this one goes any further, I noticed that nobody replied to my=
 =20
> email on this thread a few days ago:
>
> http://article.gmane.org/gmane.comp.version-control.git/113609
>
> My concern was:
>
>> Given that git-difftool shares basically all the same options as "gi=
t=20
>> diff", I think a good long-term plan would be looking at adding the=20
>> "--tool" option to "git diff" itself so that users wouldn't have to=20
>> learn a new subcommand, just a new option.
>
>
> What do people think?
>
> Cheers,
> Wincent

That could be interesting.  git-difftool is just a
frontend to git-diff so there isn't really any maintenance
worries about keeping the options in sync.  I do agree that
keeping things easy for users is a noble goal and that that
was your only concern.

git-difftool is pure porcelain, so I'm interested in how we
could implement this.  Right now the call stack is:

$ git difftool
=2E.. GIT_EXT_DIFF=3Dgit-difftool-helper
=2E.. git diff
=2E.. ... git-difftool-helper
=2E.. ... ... xxdiff


What should it look like instead?

Are you envisioning this (1):

$ git diff --tool
=2E.. --tool was passed, so set GIT_EXT_DIFF?
=2E.. git-difftool-helper
=2E.. ... xxdiff ...


Or do you mean this? (2):

$ git diff --tool=3Dxxdiff
=2E.. --tool was passed, so set GIT_EXT_DIFF?
=2E.. git-difftool-helper
=2E.. ... xxdiff


Or even... (3):

$ git diff --tool
=2E.. --tool was passed, delegate to git-diff--tool,
=2E..        remove --tool from *argv
=2E.. git-diff--tool
=2E.. GIT_EXT_DIFF=3Dgit-diff--tool-helper
=2E.. git-diff
=2E.. ... git-diff--tool-helper
=2E.. ... ... xxdiff ...

(git-diff calls itself in this scenario...)


Right now users only specify --tool=3D<tool> as an override.

The default behavior without --tool is:
- difftool looks up diff.tool and uses that value, or
- difftool makes a best guess based on the environ

Hmm.. if --tool supported both '--tool' and '--tool=3D<tool>'
then that could work.  That would make '--tool' both a switch
and an option-with-argument.  Is there anything in git that
does that?  I can imaging that being a little surprising from
a ui point of view, but it's not horrible.

What about the --no-prompt option?
Would we need that in git-diff too, or would we be able to
blindly pass it along to git-diff--tool without worrying that
git-diff would try to interpret it?

I personally like the separation of concerns --
git-diff is plumbing and git-difftool is porcelain.
But, I also agree with making it easier for users.


That said...  (off-topic)

I have a patch for difftool that lets you do stuff like this:

	$ git difftool Makefile~3
	$ git difftool Makefile~~~ Makefile~

That is *completely* the antithesis of git because git is not
file-centric.  Nonetheless, this is something people ask me
all the time and users really hate the "right" way to do it:

	$ git difftool \
		$(git log --pretty=3Dformat:%H -3 Makefile |
			tail -1) \
		-- Makefile


The point here is that since git-difftool is a frontend to
git-diff I was actually able to implement it without changing
any of the core git commands (or extend its revision syntax).
This is both good and bad.  It's good because users are much
happier using the extended file-rev syntax, and it's bad
because git-diff doesn't know about it.

What it illustrates, though, is that the separation of
concerns between the porcelain git-difftool and plumbing
git-diff is helpful specifically because it makes such things
possible.

The really cute thing, though, is that
	$ git difftool --no-ext-diff Makefile~3

=2E..actually makes it so that git-diff understands the new
syntax.  It's quite a clever hack.  It's user-friendly
and extremely helpful, which is why I entertained the
notion of implementing it.  It basically transforms user intent
"give me Makefile from 3 changes ago back" into something that
git-diff understands, which is in my opinion the whole point of
porcelains.

That said.. it would be really user-friendly if diff and
friends understood the extended file-rev syntax directly, but
being that it overloads the '~' character and "looks" just
like a rev-parse revision specifier, I don't even know if its:

	a. possible, or
	b. something we'd want given that git is
	   commit-centric, not file-centric.

I should really start a second thread about the file-rev
syntax because I made it out of thin air and it's exactly the
kind of thing that the wisdom of the list can help vet.


An interesting thing is that users have been mailing me
directly with questions about difftool and I really want to
use the full potential of the community, which I think will
come naturally with the move out of contrib.

So.. I agree in principle but also think it wouldn't hurt to
go forward with moving git-difftool out of contrib so that we
can get more user feedback.  I also think that a scheme most
similar to (3) above seems like an interesting way to go and
would be interested to hear if it's what you envisioned.


I hope I didn't just muddy the waters further =3D)

Have fun,

--=20

	David
