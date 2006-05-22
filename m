From: Junio C Hamano <junkio@cox.net>
Subject: Re: don't accept bogus N in `HEAD~N'
Date: Mon, 22 May 2006 01:16:11 -0700
Message-ID: <7vr72meapg.fsf@assigned-by-dhcp.cox.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	<87d5e7hxhl.fsf_-_@rho.meyering.net> <e4qmsn$3mv$1@sea.gmane.org>
	<87psi6h5kv.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 10:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi5aS-0002gl-8k
	for gcvg-git@gmane.org; Mon, 22 May 2006 10:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEVIQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 04:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEVIQO
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 04:16:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29110 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750707AbWEVIQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 04:16:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522081612.CKMO15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 04:16:12 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87psi6h5kv.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 22 May 2006 09:38:40 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20487>

Jim Meyering <jim@meyering.net> writes:

> Jakub Narebski <jnareb@gmail.com> wrote:
>
>> Jim Meyering wrote:
>>
>>> It'd be better to produce a diagnostic and fail:

I agree with you that we are loose in integer overlaps.  Some of
them do matter, some don't.  The xrealloc one is, as you said,
borderline, I think, but more serious than this one.  This one
is worth fixing only if/because the fix is obvious and does not
hurt the code otherwise (e.g. does not decrease portability,
does not hurt usability, etc.).

>>>
>>>   $ ./git-rev-parse --no-flags --sq -- HEAD~18446744073709551616 /dev/null
>>>   fatal: ambiguous argument 'HEAD~18446744073709551616': unknown revision or filename
>>
>> Wouldn't it remove ability to say "to the root commit"?
>> One can do it now I guess exactly by specyfying overly large N.
>> Although there should probably be some limit... or not.
>
> Do people really use HEAD~<VERY_LARGE_INTEGER> to refer to the root?

You shouldn't have to care about nor refer to the root commit
that often (if ever) in a real project.  It is handy to be able
to refer to it when your repository is very young and you are
toying with git more than you are working on your own project
that is managed by git.  But in such a case, finding it once and
tagging it is so easy and efficient that you would not want to
traverse the whole history every time you would want to refer to
it.

In other words, I think Jakub was just joking, and this
particular objection does not qualify as "hurt usability"
criteria I said in the above.
