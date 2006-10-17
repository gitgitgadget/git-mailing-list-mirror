From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:24:27 +0200
Message-ID: <200610180124.28048.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org> <45355EEE.3060105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 01:24:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyHw-0005jb-Po
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 01:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWJQXX6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 19:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWJQXX6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:23:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:53384 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751096AbWJQXX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 19:23:57 -0400
Received: by ug-out-1314.google.com with SMTP id o38so68823ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 16:23:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YurxN+ClKdamw/+y/0fml7jWxhec/Xq00QNHk2kWjlnmrmzF1O0y7RXVdh1k/oDRWoUYBtwYVK+++aqkELPB973NDb0vSDgnMyoQNmdPcjyzgc3pW+U4L1d6dcKTT8t+9EukekYcgRe3//9uLZXeXfcXiRfcylbhvqEnLNjK9WI=
Received: by 10.67.100.17 with SMTP id c17mr10717121ugm;
        Tue, 17 Oct 2006 16:23:56 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id s1sm246889uge.2006.10.17.16.23.55;
        Tue, 17 Oct 2006 16:23:55 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45355EEE.3060105@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29136>

Aaron Bentley wrote:

[...]

>> So generating an extra "merge" commit would be actively wrong, and a=
dds
>> "history" that is not history at all.
>=20
> It's not a tree change, but it records the fact that one branch merge=
d
> the other.
>=20
>> It also means that if people merge back and forth from each other, y=
ou get
>> into an endless loop of useless merge commits.
>=20
> You can pull if you don't want that. =A0We haven't found that people =
are
> very fussed about it.
>=20
>> There's no reason _ever_ to not just fast-forward if one repository =
is a
>> strict superset of the other.
>=20
> Maybe not in Git.

Think what the existence of merge commit is for. It is a place where
we can record how we resolved conflicts. It means: we _merged_ (joined)
two (or more: does bzr support octopus merge?) lines of development.

Merge commit in fast-forward case is only marking "here we did a pull"
(here we downloaded from other repository). It is just a marker which
place is in reflog, not in history. It is only cluttering history.


Besides one of canonical workflows used and encouraged by git is:

 * repository A stores does it's own work on branch 'master',
   and fetches changes from 'master' branch of repository B
   into branch 'origin'. "git pull origin" when on branch 'master'
   fetches changes from 'master' branch of repository B (requiring
   usually that it fast-forwards) into branch 'origin', then
   merges branch 'origin' into branch 'master', automatically
   creating merge commit message.

 * repository B does it's own work on branch 'master',
   and fetches changes from 'master' branch of repository A
   into [tracking] branch 'origin'. (...)

Instead of pull/fetch, we could use push.
--=20
Jakub Narebski
Poland
