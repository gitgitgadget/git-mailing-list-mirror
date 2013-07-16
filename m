From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] show-branch: fix description of --date-order
Date: Tue, 16 Jul 2013 22:11:23 +0200
Message-ID: <87ehayqn84.fsf@hexa.v.cablecom.net>
References: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
	<8768923c2d317d02beabbf1bff2f61927e126f81.1373966389.git.trast@inf.ethz.ch>
	<20130716182254.GL14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Ralf Thielow <ralf.thielow@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 22:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzBas-0005o7-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 22:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933532Ab3GPUL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 16:11:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34428 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133Ab3GPULZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 16:11:25 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 22:11:22 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 22:11:23 +0200
In-Reply-To: <20130716182254.GL14690@google.com> (Jonathan Nieder's message of
	"Tue, 16 Jul 2013 11:22:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230581>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> The existing description reads as if it somehow applies a filter.
>> Change it to explain that it is merely about the ordering.
> [...]
>>  		OPT_SET_INT(0, "date-order", &sort_order,
>> -			    N_("show commits where no parent comes before its "
>> +			    N_("sort commits such that no parent comes before its "
>>  			       "children"),
>>  			    REV_SORT_BY_COMMIT_DATE),
>
> I fear this wording tweak doesn't go far enough.  The above
> description seems to describe --topo-order just as well as
> --date-order.
>
> How about something like
>
> 		N_("topologically sort, maintaining date order where possible"),
>
> ?  I haven't checked the code to see if that's accurate, though.

Same laziness here, as I never actually use show-branch.  However,
you're right, I missed that it also has --topo-order (with a much saner
message).  So I think we can safely assume that it's the same meaning as
for git-log:

>  - by default, commits are listed in commit date order (newest first)
>
>  - with --topo-order, they are topologically sorted in such a way as
>    to ensure that in cases like
>
> 	---1---2---4---7
> 	    \           \
> 	     3---5---6---8
>
>    (from git-log(1)), parallel tracks are not interleaved
>
>  - with --date-order, they are topologically sorted but less
>    aggressively, in particular matching commit date order in the
>    usual case that that is already topologically sorted.
> 
> That would make --topo-order stronger than "show commits in
> topological order" --- it should say something like "sort trying to
> avoid breaking up lines of development".

Depending on how you look at it, the lines of development are kept
together purely by coincidence or algorithmic convenience...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
