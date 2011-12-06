From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Tue, 6 Dec 2011 08:34:59 +0100
Message-ID: <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com> <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 08:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXpZ0-0001dY-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 08:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab1LFHfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 02:35:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45740 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab1LFHfa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 02:35:30 -0500
Received: by iakc1 with SMTP id c1so3305780iak.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QQmvgnqed1czT+ak8NZXF1VOqNMQ25F+5X4Y8husFEM=;
        b=hu8sXSBbhSE3Ff2rF41CWaJM5e5tt23oRtyIj7mOOKcNkPN6PkJtZlZuo09ELSfAcN
         H9FAWKf4MDHW2orO/Zca+X/gU9IGRG/joe50jc3+N7QkELDXPIVLtTN5T6QEx2m8KCY1
         R+tQkTEf/ktR+R+Xl7eq4xa0kvVGpVAg25t/Y=
Received: by 10.42.154.7 with SMTP id o7mr13734137icw.48.1323156930179; Mon,
 05 Dec 2011 23:35:30 -0800 (PST)
Received: by 10.50.189.166 with HTTP; Mon, 5 Dec 2011 23:34:59 -0800 (PST)
In-Reply-To: <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186335>

> Think about why you need to use git-reset. =A0Why do new users need t=
o
> use git-reset? =A0What is it they are after?

Ok, so let's forget about git reset and let's focus on the features
instead. If I got it right you suggested the features that people
wants most often are uncommit, unadd/undelete and undo. Here's a new
proposal (based on your input):

uncommit: git jump <commit> (currently "git reset --soft <commit>")
unadd/undelete: git unstage file (currently "git reset --mixed file"
(with "git checkout file" for deleted files)
undo: git checkout --force --clean <commit> (currently "git reset
--hard <commit> && git clean -fd")

So, let's try out some scenarios:

1) Newbie user clones/pulls a repository from somewhere. He hacks
around and then things go bad, and he decides to scratch away
everything he did to make sure things are like they're supposed to be.
He'd then type "git checkout --force --clean master". If he didn't
introduce new files, he would simply type "git checkout --force
master"

2) Newbie adds some file to the index, then realise he added one too
many. He wants to remove it from being added. He'd then type "git
unstage file".

3) Average user creates a commit and suddenly realise he actually
wanted to split that commit in two (he cannot use --amend, and he's
not a rebase -i guru yet). Or he did a "temp" commit because he don't
know about "git stash" yet and wants to discard it. He wants to simply
go back to the previous state while keeping his changes in the index
and the worktree. He'd then type "git jump HEAD^1".

=46eel free to add more scenarios!

Philippe
