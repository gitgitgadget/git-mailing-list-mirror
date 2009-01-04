From: demerphq <demerphq@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 14:35:58 +0100
Message-ID: <9b18b3110901040535m1f67cb7er95823d31443ee971@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	 <20090104033839.GD21154@genesis.frugalware.org>
	 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Karl Chen" <quarl@cs.berkeley.edu>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 14:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJTAQ-0006Kp-0y
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 14:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbZADNgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 08:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbZADNgB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 08:36:01 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:21803 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZADNgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 08:36:00 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6026431qwe.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sJblYKWbBe654K+XNRLm8mv2U2uLlTAbBhO1o+lKQDU=;
        b=tQhya/wT4MVYcg0ORBRYmZg03Q5eo/pJChRb1+fgcWhlVI1jNqlVMU2uoak3Bxbbn7
         dIDvYiVlxhOd38VIq2gJBqDCuAiM+SFILhgB6gAy334Mk54FAsYRXBIbip6znYcO1OCd
         yTQN0KSw1y1+OjHDQEYP9w1lkduMGQ5shwJYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WTrlG+0hY2SEz8cuPgLUqCssinuHMP6o2cJEXgptlR0mdgUsu30hX5gWzGUWB9g2zg
         pltlVYiwTEmNCpbCwesmTHVxcJ4hsA4uR/fQKW+kD9OZ5xt8001wDlQPfpO3Ej8IEeVl
         eUycjsi7HfVbN9UpHPDv9afznA8GWR0knFkkc=
Received: by 10.214.184.7 with SMTP id h7mr15810512qaf.178.1231076158052;
        Sun, 04 Jan 2009 05:35:58 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sun, 4 Jan 2009 05:35:57 -0800 (PST)
In-Reply-To: <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104517>

2009/1/4 Junio C Hamano <gitster@pobox.com>:
> Karl Chen <quarl@cs.berkeley.edu> writes:
>
>> For example: Google for how to add the name of the git branch to
>> the bash prompt and you'll find countless examples of people using
>> git-branch.  And they're all different, so people aren't just
>> blindly copying one guy; here is a small sample:
>> ...
>> There were a few using git-symbolic-ref but most used git-branch.
>
> That is a good point about user education, and is a demonstration why a
> new option to cover a very narrow-special case to symbolic-ref will not
> help the situation.  People will add their own embellishments around the
> name of the branch anyway, and the most generic symbolic-ref output is
> just as useful as a special case option to show without refs/heads/.
>
> What you quoted are all inferior implementations of showing the name of
> the current branch in the bash prompt.  The most correct way (in the sense
> that it won't be broken in future git) is always found in the bash
> completion script in contrib/completion/git-completion.bash and it reads:
>
>    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>
> You can of course change this to suit your taste.  For example, here is a
> variant I personally use:
>
>    PS1=': \h \W$(__git_ps1 "/%s"); '
>
> The point is that __git_ps1 shell function is defined to be used for this
> exact purpose and is documented in the completion script.
>
> Besides showing the current branch, it knows how to interpret the various
> state clues git operations leave in the repository and the work tree, and
> reminds them what you are in the middle of (e.g. applying patch series
> using "git am", rebasing interactively, resolving conflicts after a merge
> did not autoresolve, etc.), and also knows how to show the detached HEAD.

The version im using, from git version 1.6.0.4.724.ga0d3a produces the
following error:

cut: ./HEAD: No such file or directory

when in the .git/refs directory.

Cheers,
yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
