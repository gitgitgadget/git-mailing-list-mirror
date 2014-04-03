From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Q: ".git/HEAD" and ".git/refs/heads"
Date: Thu, 03 Apr 2014 10:04:48 +0200
Message-ID: <533D3240020000A1000151F5@gwsmtp1.uni-regensburg.de>
References: <533C404F020000A1000151CE@gwsmtp1.uni-regensburg.de><533C404F020000A1000151CE@gwsmtp1.uni-regensburg.de>
 (Ulrich Windl's message of "Wed, 02 Apr 2014 16:52:31 +0200")
 <vpqob0jwrbb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 03 14:36:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVf2F-00026s-K3
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162496AbaDCIEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 04:04:55 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:46461 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162464AbaDCIEw convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:2:1>);
	Thu, 3 Apr 2014 04:04:52 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id B5D40377C7
	for <git@vger.kernel.org>; Thu,  3 Apr 2014 10:04:50 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gwsmtp.uni-regensburg.de", Issuer "Uni Regensburg CA - G01" (not verified))
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTPS id 85669377C6
	for <git@vger.kernel.org>; Thu,  3 Apr 2014 10:04:50 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Thu, 03 Apr 2014 10:00:08 +0200
X-Mailer: Novell GroupWise Internet Agent 12.0.2 
In-Reply-To: <vpqob0jwrbb.fsf@anie.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245731>

>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> schrieb am 02.04.2014 um 19:54 in
Nachricht <vpqob0jwrbb.fsf@anie.imag.fr>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
> 
>> Hi!
>>
>> I have a small question: After a "git gc" with last commit being "[shared 
> 2679648]" I found this:
>>> cat .git/HEAD
>> ref: refs/heads/shared
>>> cat .git/refs/heads/shared
>> cat: .git/refs/heads/shared: No such file or directory
>>
>> Is this intentional?
> 
> Yes.
> 
>> commit in these files: .git/logs/HEAD .git/logs/refs/heads/shared
>> .git/info/refs .git/packed-refs
> 
> Yes, they are where the refs are stored. If you have many refs in your
> repository, having one file per ref is inefficient. It's more efficient
> for Git to have one big read-only file. When one ref is modified, the
> .git/refs/heads/$branch file is re-created, and the packed entry is
> ignored.
> 
>>             if [ -d .git ]; then
>>                 GIT_HEAD="$(<.git/HEAD)"
>>                 GIT_BRANCH="${GIT_HEAD##*/}"
>>                 GIT_HEAD="Git:$GIT_BRANCH-$(cut -c1-7 .git/${GIT_HEAD##*: })"
>>             fi
> 
> Don't access the filesystem. Ask Git.
> 
> GIT_FULL_BRANCH=$(git rev-parse --symbolic-full-name HEAD)
> GIT_BRANCH="${GIT_FULL_BRANCH##*/}"
> GIT_HEAD="Git:$GIT_BRANCH-$(git rev-parse --short HEAD)"
> 
> (Perhaps there's a simpler way without $GIT_FULL_BRANCH)

Matthieu,

thanks for this (it not so abvious how to use "git --rev-parse")!

Ulrich
