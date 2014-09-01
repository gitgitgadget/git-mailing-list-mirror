From: Bostjan Skufca <bostjan@a2o.si>
Subject: Re: Configurable filename for what is now .gitignore
Date: Mon, 1 Sep 2014 22:30:44 +0200
Message-ID: <CAEp_DRBM6cexcoBrYmEktZXh4WMzE-tYwCi80-THCNwJqthQ=g@mail.gmail.com>
References: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
	<20140830054312.GA28512@google.com>
	<CAEp_DRATLprK9LZg45dn5LY=3C8cLM1BNg4rmi0XxJmdPhDGBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 22:30:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOYFZ-0002X7-17
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 22:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbaIAUat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 16:30:49 -0400
Received: from portkey.s.itsis.si ([78.47.12.76]:42286 "EHLO
	portkey.s.itsis.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbaIAUas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 16:30:48 -0400
Received: from undisclosed (undisclosed [127.0.0.254]) (Authenticated sender: undisclosed) by portkey.s.itsis.si (Postfix) with ESMTPSA id 5FAAB80061
	for <git@vger.kernel.org>; Mon,  1 Sep 2014 20:30:46 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.4 at portkey
Received: by mail-ig0-f169.google.com with SMTP id r2so2677666igi.2
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 13:30:44 -0700 (PDT)
X-Received: by 10.50.25.41 with SMTP id z9mr23779877igf.0.1409603444522; Mon,
 01 Sep 2014 13:30:44 -0700 (PDT)
Received: by 10.50.218.174 with HTTP; Mon, 1 Sep 2014 13:30:44 -0700 (PDT)
In-Reply-To: <CAEp_DRATLprK9LZg45dn5LY=3C8cLM1BNg4rmi0XxJmdPhDGBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256311>

I see another crux of the problem.

There is currently no way to transfer/share repository configuration
between clones.
(Or is there? Could this be done with attributes? Probably not...)

This is a bit awkward.
Are there any plans to provide such functionality? Pros/cons?

(It should be limited in scope of course, to provide adequate security
for all parties involved.)


Thanks for sharing your opinion,
b.


PS: For those that did not follow this small thread, here is an
example use case to illustrate the problem:

1. I patch git to support custom filename for .gitignore
2. I reconfigure it in my repository clone (i.e. change it to look for
.gitexclude files)
2a. This is configured in .git/config, for example as
core.excludesDefaultFilename
3. I can commit changes to repository code, namely a change which
renames .gitignore(s) to .gitexclude(s) (which restores correct
exclusion pattern parsing)
4. When I push, only .gitignore rename to .gitexclude goes upstream.
Info about required usage of .gitexclude instead of .gitignore stays
in my repo clone.
5. When someone pulls, they have messed up "git status" output until
they manually set the same setting in their repo clone (using
.gitexclude instead of .gitignore)


On 31 August 2014 03:55, Bostjan Skufca <bostjan@a2o.si> wrote:
> Hi Jonathan,
>
> nope, haven't seen zit before, it does partly what I would need, but
> just for one file at a time (a "bit" awkward) and not really portable
> (git clone will not clone .FILE.git/exclude, for example).
>
> Anyway, do you think that a patch which makes .gitignore filename
> configurable would be appropriate for inclusion in future git
> releases?
>
> b.
>
>
>
> On 30 August 2014 07:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Bostjan Skufca wrote:
>>
>>> Git is great for tracking code development, but when deploying
>>> mentioned code by using git itself, various configuration files must
>>> be created additionally, which are normally .gitignored, for various
>>> reasons (code portability, sensitive data, etc). There is currently no
>>> simple way of tracking changes to those critical configuration files
>>> (at least none that I am aware of).
>>>
>>> One way to approach this would be tracking those changes in separate
>>> git repository.
>>
>> Have you seen zit
>> <https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Zit>?
>>
>> Curious,
>> Jonathan
