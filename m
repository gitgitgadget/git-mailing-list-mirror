From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 29 Mar 2010 11:48:18 +0530
Message-ID: <f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<4BAFFFAB.4080808@gmail.com> <alpine.LNX.2.00.1003290055000.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 08:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8JB-0008Cc-9z
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab0C2GSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 02:18:40 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:37805 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab0C2GSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:18:39 -0400
Received: by gxk9 with SMTP id 9so1375620gxk.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=jwdvXYKIME18AYOZndYcWfvnH/C0sjOjHf86//AbaiU=;
        b=qUQWej/lBTmiA+PyH0akgxd5V6i1f9KDMXxYeKMwlrBeuST4fO3j0KIs0XqvAZDQlD
         JcTMoAdaRRoXVzaqhdE7yNdttt4IY0laywYJKaLTAw/94h7HWwQtm9CwQTW2cagvL85T
         1fXpkb17kH/0+p7t0pF1dzJkQHZfYOPeoyHYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=w9qaf1TcdDvh4PSnFIxrCj9NjBG9bUx2L4giWD1MHzaDOekmah5zAYq9Q8p11xGrcy
         iuakdZ5kYLjeLE9uOujz7oqQp5BS8qn3TW1YAlOPwGK07NX2k6BZwdW6CaCCTun4SOv0
         z3uDZL9lrW1ByNWeHGVLGMzbOPsibcZpry+98=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 23:18:18 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003290055000.14365@iabervon.org>
Received: by 10.90.59.12 with SMTP id h12mr3210767aga.118.1269843518167; Sun, 
	28 Mar 2010 23:18:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143441>

Hi,

> That information ought to be in the documentation, but possibly not on
> this man page in particular. I think it would be better to document that
> part in the documentation of the code and programs that call the helper,
> not in the helper documentation.

I agree that the callers need to document the subset of the
invocations they make to remote helpers. I think we can defer this
until we have a real remote helper in `git.git` that actually
interfaces with a foreign versioning system.

I've thought about documenting the full set of invocations in the code
for the developer, but there's a problem. Here's an excerpt from
remote-curl.c, showing how it parses its command line arguments:

	remote = remote_get(argv[1]);

	if (argc > 2) {
		url = argv[2];
	} else {
		url = remote->url[0];
	}

Unfortunately, I don't see where else this documentation can fit in:
if it were to go into a specific remote helper's code, then it'll have
to be duplicated for all the remote helpers, since all of them parse
options similarly. It certainly cannot go into remote.c or
transport-helper.c, because they have little/ nothing to do with the
actual argument parsing.

I could try modifying the documentation I've written to serve more to
specify "how remote helpers are invoked" and less about "how callers
invoke remote helpers", and try to fit it in this manpage. It's more
of a developer manpage and less of an end-user manpage as it is. Or we
could create another page about remote helpers intended to be read
exclusively by developers. What are your thoughts on this?

-- Ram
