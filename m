From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Tue, 22 Sep 2015 20:58:45 +0000
Message-ID: <1442955525.29498.94.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	 <1442508864.21964.26.camel@transmode.se>
	 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	 <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
	 <1442855328.29498.30.camel@transmode.se>
	 <37ca95b3fef79e348fb5ba68cd21c590@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"pclouds@gmail.com" <pclouds@gmail.com>
To: "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUeK-0001Vx-T3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758263AbbIVU6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:58:48 -0400
Received: from smtp.transmode.se ([31.15.61.139]:62121 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbbIVU6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 16:58:47 -0400
Received: from exch2.transmode.se (exch2.transmode.se [192.168.203.24])
	by smtp.transmode.se (Postfix) with ESMTP id AB12B11870A9;
	Tue, 22 Sep 2015 22:58:45 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch2.transmode.se
 (192.168.203.24) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Tue, 22 Sep
 2015 22:58:45 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Tue, 22 Sep 2015 22:58:45 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ9I1i4MUVkjVcJE+EJNOGRY0lNp5HFboAgAHCMwCAABBhgA==
In-Reply-To: <37ca95b3fef79e348fb5ba68cd21c590@dscho.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <47968A4F07578344B883BA74245DF7B9@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278435>

On Tue, 2015-09-22 at 22:00 +0200, Johannes Schindelin wrote:
> Hi Joakim,
> 
> On 2015-09-21 19:08, Joakim Tjernlund wrote:
> > On Mon, 2015-09-21 at 09:48 -0700, Junio C Hamano wrote:
> > > Duy Nguyen <pclouds@gmail.com> writes:
> > > 
> > > > Is it really necessary to remove write access in $GIT_DIR? Do we (git
> > > > devs) have some guidelines about things in $GIT_DIR?
> > > 
> > > Those who are allowed to "git push" into it should be able to write
> > > there.  It is a different matter that "git" program itself may make
> > > a policy decision to disallow some operations that the filesystem
> > > bits alone would have allowed (e.g. you can arrange the "pusher" to
> > > only come over the wire via "receive-pack" and "receive-pack" may
> > > deliberately lack support for writing into $GIT_DIR/config).
> > > 
> > 
> > I view $GIT_DIR similar to "/" and "/tmp". Normally one does not let
> > normal users write to "/"
> > as you want to keep this level clean. It is not obvious to everybody
> > what files are important
> > under $GIT_DIR when mixed with tmp files etc.
> > $GIT_DIR/tmp would solve this nicely.
> 
> By now it is pretty clear that you won't find many people here you share your opinion about locking down the
> Git directory.

So I note.

> 
> The reason should be easy to understand: Git's concept is based on the idea that you have full control over
> your repository. Other repositories you might only have read access.

Yes and some repos I only have partial write access to(config, hooks etc. might be readonly) 

> 
> But this idea you have, to somehow introduce fine-grained levels of control, this idea would imply that all
> of a sudden Git is no longer free to write to its files as it likes. And as far as Git is concerned,
> everything inside .git/ *are* its files.

This does not compute for me, files inside git are git's files, I only think that not all users
to a repo should have the same (write) access. In this case it mostly to protect the repo from "creative"
users and accidents.

> 
> So in essence, the core concept of Git -- you clone a repository you cannot write to so that you have a
> local repository you can do *anything you like* to -- is pretty much incompatible with this idea of a
> selective lock down of files in .git/ that not only would require you to know very exactly what files Git
> might want to write, but also to keep yourself up-to-date with Git's development as to which files it might


Don't see how I can avoid some of that if you want to protect areas of the repo from accidents etc.

> want to write for *every* new version. Making only .git/tmp/ a writable location further fails to
> acknowledge the fact that the hierarchy of to-be-written files follows the function of those files, not any


Curious, how would you set up some level of protection on a repo?

A .git/tmp/ would make housekeeping easier, you would know that every file under .git
should be there and if you find something you don't recognize you would react.

> write permission hierarchy. Since the idea seems so alien to Git's core concept, I called it "overzealous".
> If that hurt your feelings, I am sorry and would like to apologize.

No feelings hurt, I too regret my choise of words.

> Having said all that, I believe that reiterating this idea without pointing to any benefit will continue to
> fail to convince people that the idea is sound and that Git's core concept should change. If you need to
> exert more control in a specific repository, you simply make it accessible only as a non-file-system remote
> (where only `git`, `git-receive-pack` and `git-upload-pack` are allowed to be executed) and define hooks
> that can accept or deny on a *much* finer level than file system permissions ever could, after all.

Even if I did go through this hassle, I would prefer if temporary data were put somewhere else
than .git/ as I think mixing config/persistent data with temporary data in the same directory is something
that should be avoided.

Anyhow, I see that this idea is not something upstream agrees on so I will back off now.

  Jocke