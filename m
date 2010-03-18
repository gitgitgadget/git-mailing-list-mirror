From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] pull: replace unnecessary sed invocation
Date: Thu, 18 Mar 2010 09:46:39 -0500
Message-ID: <5rEymC6ZWmCbugaX54NzNsnDmRUKU5-au3DQ0l_p5YIjUz7xRlUzXA@cipher.nrlssc.navy.mil>
References: <1268889045-21751-1-git-send-email-bebarino@gmail.com> <4BA22AEE.8000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 15:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsH0e-0002fc-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab0CROrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 10:47:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38226 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab0CROrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 10:47:23 -0400
Received: by mail.nrlssc.navy.mil id o2IEke77003382; Thu, 18 Mar 2010 09:46:40 -0500
In-Reply-To: <4BA22AEE.8000606@gmail.com>
X-OriginalArrivalTime: 18 Mar 2010 14:46:39.0960 (UTC) FILETIME=[D178AD80:01CAC6A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142471>

On 03/18/2010 08:30 AM, Gabriel Filion wrote:
> On 2010-03-18 01:10, Stephen Boyd wrote:
>> Getting the shortened branch name is as easy as using the shell's
>> parameter expansion.
>>
>>  curr_branch=$(git symbolic-ref -q HEAD)
>> -curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
>> +curr_branch_short="${curr_branch#refs/heads/}"
> 
> This modification is a bashism. This syntax is not compatible with other
> shells.

But, there is already precedence for using syntax in scripts, so it
is probably ok.

$ egrep -- '\$\{[^}]+#[^}]+\}' *.sh
git-bisect.sh:                  start_head="${head#refs/heads/}"
git-filter-branch.sh:           ref="${ref#refs/tags/}"
git-parse-remote.sh:        heads/*) remote=${remote#heads/} ;;
git-parse-remote.sh:        refs/heads/*) remote=${remote#refs/heads/} ;;
git-pull.sh:    curr_branch=${curr_branch#refs/heads/}
git-pull.sh:            echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
git-rebase--interactive.sh:             pend="${pend# $p}"
git-rebase--interactive.sh:                     new_parents=${new_parents# $first_parent}
git-rebase--interactive.sh:             if      left=${1%...*} right=${1#*...} &&
git-rebase.sh:  eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
git-rebase.sh:  if      left=${onto_name%...*} right=${onto_name#*...} &&
git-stash.sh:           branch=${branch#refs/heads/}
git-submodule.sh:                       url="${url#../}"
git-submodule.sh:                       url="${url#./}"
