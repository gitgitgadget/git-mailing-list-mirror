From: Mark Plaksin <happy@usg.edu>
Subject: Re: Syntax check via update hook?
Date: Wed, 20 May 2009 11:13:09 -0400
Message-ID: <ws7i0bu7sq.fsf@usg.edu>
References: <wsprejtm71.fsf@usg.edu>
	<20090509144711.GA3926@sigill.intra.peff.net> <wsd4aem8rh.fsf@usg.edu>
	<20090514065544.GC10411@coredump.intra.peff.net>
	<wsd4abfonx.fsf@usg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 17:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6nU0-00056G-Of
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbZETPNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 11:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZETPNT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 11:13:19 -0400
Received: from main.gmane.org ([80.91.229.2]:56853 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbZETPNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 11:13:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M6nTr-0001gG-WD
	for git@vger.kernel.org; Wed, 20 May 2009 15:13:20 +0000
Received: from stone.tss.usg.edu ([168.24.82.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 15:13:19 +0000
Received: from happy by stone.tss.usg.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 15:13:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: stone.tss.usg.edu
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.93 (gnu/linux)
Cancel-Lock: sha1:J1slB4ykzzU9tWx1o2srEi9s58c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119614>

Mark Plaksin <happy@usg.edu> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, May 12, 2009 at 03:16:50PM -0400, Mark Plaksin wrote:
>>
>>> >         $ cat <<EOF >.git/hooks/update
>>> >         #!/bin/sh
>>> >         GIT_INDEX_FILE=/path/to/tempdir/index; export GIT_INDEX_FILE
>>> >         cd /path/to/tempdir/tree &&
>>> >         mkdir -p tree &&
>>> >         git read-tree "$3" &&
>>> >         git checkout-index &&
>>> >         your_syntax_check
>>> >         EOF
>>> >         $ chmod +x .git/hooks/update

...

> It does!  You make it seem so easy!  Thanks very much.  I now have an
> update hook which checks syntax just like we want.  Thanks again!

Well, it's oh so close!  If we make changes that don't pass the syntax
check and try to push them the hook rejects the changes.  If we then
make a change that will pass the syntax check, leave the others broken,
and push, 'git diff-tree' doesn't list the previously rejected files so
the hook accepts the push.  Is there any way to get 'git diff-tree' to
list all of the files?

Here's 'git diff-tree' output from our first push attempt:
139ca369a16151faedf78fd86941769ceff289e4
:100644 100644 bfc70383d8e5ab1adb83ce599eac6f4f9dd47f9c 931c8f3acb640606c950ee14b47c92f2b6ad5f51 M      modules/git/files/update_hook
:100644 100644 34cea12e7c32a61f1ad25955c7ee8434652a354a b27af409ca226f9acbd8e7b89ae7ed21785f1ab1 M      modules/git/manifests/init.pp
:100644 100644 598af464c5220f83a6d2342cecf7beace47dd136 033a8b4c897094db050590501c5accef1feb2abc M      modules/git/manifests/server.pp

And here's the output from the second push attempt:
eacdddf85e5d1180f5917a467edd5e0535a61321
:100644 100644 12418bd45df24a7d8cc8c43691c35a62888343e9 65f8137b0887bd734c6adc951eb45ea76a220775 M      modules/git/files/xinetd

Thanks again!
