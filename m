From: Geert Bosch <bosch@adacore.com>
Subject: Re: git branch descriptions
Date: Mon, 10 May 2010 21:16:23 -0400
Message-ID: <F658FEF6-8957-4815-8917-8545E166F6CC@adacore.com>
References: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com> <20100510232612.GA6890@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joel Reed <jreed@lantekcs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 03:16:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBe5H-0004L0-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 03:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab0EKBQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 21:16:26 -0400
Received: from rock.gnat.com ([205.232.38.15]:40361 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938Ab0EKBQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 21:16:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 9519D2BABB9;
	Mon, 10 May 2010 21:16:24 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w25Hfz5F4tra; Mon, 10 May 2010 21:16:24 -0400 (EDT)
Received: from [172.16.1.3] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 3017B2BAB53;
	Mon, 10 May 2010 21:16:24 -0400 (EDT)
In-Reply-To: <20100510232612.GA6890@progeny.tock>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146864>


On May 10, 2010, at 19:26, Jonathan Nieder wrote:
> I think the closest thing we have now is =91git branch -v=92, which t=
ells
> the subject of the commit at the tip of the branch.  =91git notes=92
> annotates commits rather than branches, so it occupies a different
> niche.

Indeed, I've not started to use the -v flag a lot more and wish
it were default. However, when I started to think about attaching
descriptions or any other information to branches, I started
to realize what we'd lose with that.
>=20
> Your request is a reasonable one, and it has come up a few times in
> different forms over the years:
>=20
> . per-branch descriptions in .git/description[1]
> . per-branch descriptions in .git/config[2][3]
> . README branch whose files describe the branches[4]
>=20
> Number [2] is my preferred choice (and comes with code!), for what
> it=92s worth.

The question is what you'd do with these when moving branches around.
You could move the descriptions with the branches, though that would be
a bit ugly implementation-wise: I don't quite like the idea of programs
rewriting configuration files as part of regular operation.

Besides that, I find my self often use a workflow like:

% git checkout -b newtopic
% (hack, commit, hack, commit, ...)
% git log
% (oops, better fix up those revision histories)
% git checkout -b newtopic-fixup newtopic~2
% git cherry-pick newtopic~1 ; git commit --amend ; rinse ; repeat
% (ok, finished, pretend the old stuff never happened)
% git branch -M newtopic

If branches were more than just a way of naming a place to
put commits, it would be getting much more heaving to do this
kind of thing.

The other approach, of leaving them in place wouldn't be much
more appealing either.

It seems if we'd do branch descriptions at all, their main use
would be fore remote repositories. When you publish a branch,
you'd typically not rewrite it on a whim, so attaching a description
makes sense. Similarly, if you're tracking a remote repository,
it would be helpful to get some information for the branch.

=46or local repositories, I have been amazed how useful the git branch =
-v is.
And it comes for free, no need to enter any data!

Regards,
   -Geert