From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Error when cloning with weird local directory
Date: Thu, 6 Aug 2015 07:48:58 +0200
Message-ID: <55C2F54A.7070702@web.de>
References: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:49:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNE3G-0008MP-08
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 07:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbbHFFtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 01:49:08 -0400
Received: from mout.web.de ([212.227.15.3]:63778 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbbHFFtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 01:49:07 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LlFSg-1YoRGQ1a46-00b441; Thu, 06 Aug 2015 07:49:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
X-Provags-ID: V03:K0:lhUnYbfIXV3HZTJ1gnK34UZWhFrxQuD/Q0y+bUzV8uhbfoHtg5G
 iYcOh6nnlO88D1vRElsf35VNjvaZyW5fJLtFLav8mKxYdS5IUG4DqHBLGjvEUJ0nU9mmBvo
 aWujdBqqwTVqPwALa6bZBmGpMAFtGyzxHiObWC+ewKyqbG8/sQk+cOS5qeiowP+fQ5FdYXL
 fc4/jdU4RxB1wakOLwwWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z27FwGOW4tE=:UoGvz+8N9mLckXgfdAjIfG
 Q7ujB2FKkiKdAmL58R5GmNToeEb2od2l1BxKOPY46Uqbf5+OHMw12tf5YKYJRon3DTqZP7gXf
 DOCVRou69/Qu74D6f/5eJeNPloTYt3RKcgX0JqVzF7yb8t78yoicYi0O/Qop9wEFRFlBXFkzh
 gdzpJNDofFAaXRqF5k/J8l4xwtuw4Or2UAsd5g+0PikRYYUMF2JqMQ9WbfVrBSt2dcpc6Vf5r
 4+klOrAc0zBbR9STgtNQwFoJ2zCvURqXNOvJT7oeB97dIH7doPv/LkFlcMi/U8SA+JH+dfswH
 AFUYBXXC+K/0m9V7rJgXCwfgwSTDgwOLSEiwkPqNYAte2QUSEoDRiL5qyKdx9ZqOWc7XVYYqr
 vjrpTQ60H4X/oh5wW1gjvOsqE397Gatijt8lv6hBU/V5VHbdI2+rbi3ldV/1/jezpmcw6kSUE
 lfH0qOFhjn/LVRhrpv5rFl0Kamc2g0X2v2FckRJRuR8q2k1rcowq/GisiJ9J1T3WF0NzQJrvM
 2GEmaEfqyDcEXttmvJoKxcCok/qaoK6Pi90/5mlhRlt03qMv6JtUIV7eYmXzY+Lt+1f2fFNjz
 gI9idlVxAWaFkxJscb1LZJj9BYltebRifbt2dLyMnSjQWQ4PMxxLnXTaR6MMZu02K9B2ofLBM
 uKAKltNkzxyWizgwRsXV9sA3Gsyw0w52Oe2kn8S3mWuKMu/zEW70BQd+uDMyV6Jz3jRc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275415>

On 2015-08-06 06.21, Chris Packham wrote:
> Hi All,
> 
> A developer at $dayjob called me over to have a look at a git error he
> was getting (names changed to protect the innocent).
> 
>   $ git --version
>   git version 2.5.0
>   $ git clone ssh://example.com/repo.git
>   Cloning into 'repo'...
>   fatal: I don't handle protocol '/home/user/src/ssh'
> 
> After a bit of head scratching we found that he had a local directory
> structure called 'ssh://example.com/repo.git' it wasn't a complete
> repo but it had some of the things one expects to find in a .git
> directory (info, objects, refs, etc). It had been there for a while
> and we suspect was created by a scp gone wrong from the last time he
> was dealing with repo.git.
> 
> I'm wondering if it's worth catching this kind of weirdness and
> erroring out with a slightly more useful message. I'm also wondering
> what would have happened if this repo was actually a full and complete
> thing.
> 
> I'm not sure that there is a problem worth solving here. I can provide
> an anonymized tarball of the directory structure in question if anyone
> is interested. But maybe this is useful for future mailing list
> searchers[1].
> 
> Thanks,
> Chris
This is indeed a bug:

It looks as if
static char *get_repo_path(const char *repo, int *is_bundle)
in built/clone.c
checks if there is a local directory structure looking like a
.git directory.
This is wrong.
There should be a check for the scheme first.


It is not the error message that is confusing, we should never get there,
but invoke ssh instead.

The bug is in clone.c
