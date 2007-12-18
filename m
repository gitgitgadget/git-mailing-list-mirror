From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Tue, 18 Dec 2007 16:09:24 +0000
Message-ID: <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:09:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4f0w-0003RV-Bt
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbXLRQJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756841AbXLRQJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:09:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:63960 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbXLRQJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 11:09:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2318843rvb.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Is5pJbjbDaed6Rv7wQD/YK+YBBtWp48yB9p/4NNj/+A=;
        b=ROYSJ7MujOYuo7PSSg8rP+NXNhnRq9vCTXKJjJNKqUUOi4kZP3o0PhKpf1Rrl6AC7xA2kOlZwSM0pb+U884WusJJw76ukq3y7Kk4sPKQJ3tiiEY2iLJcSBoVj9rmAMY0/WfGzzXzFgQPKIXXnT8lKlZJ7UWIqR75SMafiW3lDNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KF7T57wuCPOMh+gIBH+s9jIt8eNLBaH45PIB+GGkC2pLCkWsMyTpoPJKpqT++Xz7KeRw5WY4RQoPG/vt8awi2znZn7gJv3PjcH4GDkBd9FdIZUZtZVJdyMcHEromowkn/1oiGJWCOw7NRcpYnDVxEFBesdn4teaYOu6sAlubFh4=
Received: by 10.140.158.4 with SMTP id g4mr2805500rve.64.1197994164966;
        Tue, 18 Dec 2007 08:09:24 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 18 Dec 2007 08:09:24 -0800 (PST)
In-Reply-To: <20071218052115.GA13422@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68770>

Thanks again for maintaining these branches.

On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>   git://repo.or.cz/stgit/kha.git safe
>
> David K=E5gedal (17):
[...]
>       Simplify merge_recursive
>       Use the output from merge-recursive to list conflicts

I'll drop git.merge() entirely since it is only used by the 'sync'
command due to the performance issues I had in the past with rename
detection in git-merge-recursive. Hopefully, these are gone now.

I'll try to fix the automatic invocation of the interactive merger in
case of conflicts (it is only present in git.merge()).

> Karl Hasselstr=F6m (24):
>       Fix "stg resolved" to work with new conflict representation

=46or some reason, the interactive resolving keeps invoking the merger.
I'll have a look.

>       "stg status --reset" is not needed anymore

I would keep this as an alias for 'git reset --hard' (see below as well=
).

>       Remove "stg add"
>       Remove "stg rm"
>       Remove "stg cp"

I plan to add a generic command for these kind of aliases. The reason
is that I don't really like mixing GIT and StGIT commands (I think at
some point I'll get confused and try to run stg commands with git).

>       Remove "stg resolved"

I'd like to keep this command. git-mergetool doesn't support the tool
I use (emacs + ediff and more stgit-specific file extensions like
current, patch etc.). I also don't find 'git add' to be meaningful for
marking a conflict as solved.

--=20
Catalin
