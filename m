From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 0/2] completion: sequencer commands
Date: Sat, 30 May 2015 17:57:32 +0200
Message-ID: <1433001452.5113.4.camel@virtuell-zuhause.de>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 18:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyjC2-000113-86
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 18:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbbE3QAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 12:00:46 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33413 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbbE3QAp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 12:00:45 -0400
Received: from p5ddc33fc.dip0.t-ipconnect.de ([93.220.51.252] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1YyjBi-0004cJ-9s; Sat, 30 May 2015 18:00:42 +0200
In-Reply-To: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1433001645;69ec6251;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270286>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
> >
> > >  contrib/completion/git-completion.bash | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> > > index bfc74e9..3c00acd 100644
> > > --- a/contrib/completion/git-completion.bash
> > > +++ b/contrib/completion/git-completion.bash
> > > @@ -2282,6 +2282,11 @@ _git_reset ()
> > >
> > >  _git_revert ()
> > >  {
> > > +     local dir="$(__gitdir)"
> > > +     if [ -f "$dir"/REVERT_HEAD ]; then
> > > +             __gitcomp "--continue --quit --abort"
> > > +             return
> > > +     fi
> > >       case "$cur" in
> > >       --*)
> > >               __gitcomp "--edit --mainline --no-edit --no-commit
> --signoff"
>
> This corresponds exactly to what we do for git-cherry-pick:
>
> local dir="$(__gitdir)"
> if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
> __gitcomp "--continue --quit --abort"
> return
> fi
>
> Perhaps _git_revert() and _git_cherry_pick() should call into the same
> function with different arguments.

Good idea.
I created a new function __git_complete_sequencer which is now used to complete
all commands with active sequencer.
