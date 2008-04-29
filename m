From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 08:34:11 -0700
Message-ID: <7f9d599f0804290834v23da6dfbv47b3ca9058934228@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:35:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqrrK-0001is-Pj
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 17:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYD2PeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYD2PeV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:34:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:25945 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYD2PeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:34:20 -0400
Received: by wr-out-0506.google.com with SMTP id c48so62277wra.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=BMsQs65N+6LkED2er01YjM467G58we3+x4ayxXxgDaM=;
        b=kShNPdJ/E4gf1jQxjC41YDa+w8lpXUGuPUyYia/pVb+jDuqSO1ndS5/OUizQOw1cznpe6CUa4Mg4sTe06PzCNyJO579/epqoTNKp6nZhQgCzJqZGDgzsRWvlHWqtLZARxFn9vF/Huc4STrbIk75u2hX9kdwcFqhlYUZtOs0eO4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=W8Y++eyY0A57CctHW1sOMmH/VLX79dX46z9+CRbsZOejvkqtbLj6yDk3t/eRpOupM3kA9nrfNlsM2anhKNMrqSkjmt/AQh8EiRdfhdJ9olZUlAmQy/LMrRpHPuIa+Kr8yQLKSuvDifyyeuPf44Zf4BkK5PNOB8RFayXvaTg+Vxw=
Received: by 10.141.51.15 with SMTP id d15mr3660006rvk.106.1209483257717;
        Tue, 29 Apr 2008 08:34:17 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 08:34:11 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
Content-Disposition: inline
X-Google-Sender-Auth: d4c46090c5b80fcc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80691>

On Mon, Apr 28, 2008 at 12:34 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Mon, 28 Apr 2008, Henrik Austad wrote:
>
>  > Hi list!
>  >
>  > As far as I have gathered, the SHA-1-sum is used as a identifier for commits,
>  > and that is the primary reason for using sha1.  However, several places
>  > (including the google tech-talk featuring Linus himself) states that the id's
>  > are cryptographically secure.
>  >
>  > As discussed in [1], SHA-1 is not as secure as it once was (and this was in
>  > 2005), and I'm wondering - are there any plans for migrating to another
>  > hash-algorithm? I.e. SHA-2, whirlpool..
>
>  No. The cryptographic security we care about is that it's impractical to
>  come up with another set of content that hashes to the same value as a
>  given set of content. The known attacks on SHA-1 (and more broken earlier
>  hashes in the same general class) only allow the attacker to produce two
>  files that will collide. Now, it's true that this would allow somebody to
>  produce a commit where some people see the "good" blob and some people see
>  the "evil" blob, but (a) the "good" blob contains some large chunk of
>  random data, which is a major red flag by itself, and (b) all of these
>  people have to be taking data from the attacker.
>
>  If somebody gives you some source, and it's got some large random chunk in
>  it, and the behavior of the object depends on the content of this chunk,
>  and it's unspecified where this chunk comes from, you should be aware
>  that they might be able to swap this chunk for a different chunk. But such
>  a file is pretty blatantly malicious anyway.

This argument is invalid, since the use of git is not limited to
source code.  People
can and do store unreadable binary data in git, and unless you are completely
sure that no one would ever care about the security of that data in a
way that can
be attacked with a single collision, git should be secure about those as well.

For example, I just converted a 20 GB repository to git which, among
other things,
contains pdf files of my tax returns.  I have looked them over, but I
have not opened
them in a hex editor and looked them over at the binary level, and I
don't think git
should expect me to.

Incidentally, git was the only version control system I tried except
for subversion that
didn't choke on that repository.  Mercurial looked at my file renames
and expanded
the size past 45 GB before I killed it, I had to fix a several bugs in
the bazaar conversion
scripts before I realized it was just too slow, and svk turns out to
be even more like
the Antichrist than subversion itself is (mirroring N repository
copies requires an N-fold
increase in size).

Geoffrey
