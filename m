From: Santi Bejar <sbejar@gmail.com>
Subject: Re: finding similar blobs (was: Re: $Revision$ keyword replacement?
Date: Wed, 23 Nov 2005 00:10:27 +0100
Message-ID: <8aa486160511221510v667dbfd5y@mail.gmail.com>
References: <871x18h9ee.fsf@ifae.es> <7vy83gb8zk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 00:12:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehHU-0000mh-9K
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVKVXK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVKVXK3
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:10:29 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:43646 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030239AbVKVXK2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 18:10:28 -0500
Received: by zproxy.gmail.com with SMTP id z6so96555nzd
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 15:10:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTwB1GnL7QS2v8k2W7UkM/aq73gfEFqTxggV+8xNzkKmjalx63cpJNPPYHazCon6LuK0EI+Nac1zGKuZivqTSL0JpTr0vg1CrDv1zddXNDVbrLT95z6XPM3fD6wCrASX2xYf2blXgCCxCjQNekQ39nNKtMUzQC5eehA0Kqsgi2U=
Received: by 10.65.11.20 with SMTP id o20mr5126417qbi;
        Tue, 22 Nov 2005 15:10:27 -0800 (PST)
Received: by 10.64.178.1 with HTTP; Tue, 22 Nov 2005 15:10:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy83gb8zk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12583>

2005/11/22, Junio C Hamano <junkio@cox.net>:
> Santi B=E9jar <sbejar@gmail.com> writes:
>

>
> > tmp=3D`mktemp -t -d git-find-sim.XXXXXXX`
> > ...
> > git update-index --add $file || exit 1
> > tree=3D`git-write-tree`
>
> Are you going through all this trouble just to avoid a blob and
> a tree object left dangling after you are done?  Or is there
> something else going on?

No, there is nothing else. These are "easy" avoided, so why have these
dangling {blob,tree,...}s?

>
> > rev_arg=3D`GIT_DIR=3D$GIT_DIR_ORIG git-rev-parse --default HEAD --r=
evs-only "$@"`
> > revs=3D`GIT_DIR=3D$GIT_DIR_ORIG git-rev-list $rev_arg`
> > for i in $revs; do
> >     git diff-tree --name-status $i -C $tree | grep $file |
> >     sed "s/^/$i:/"
> > done
>
> Perhaps
>
>         GIT_DIR=3D$GIT_DIR_ORIG git-rev-list $rev_arg |
>         while read one
>             git diff-tree --name-status -r $one -C $tree | grep $file=
 |
>             sed "s/^/$one:/"
>         done
>
> just in case the similar file you will discover is hidden in a
> subdirectory?

Oops :)

Santi
