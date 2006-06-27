From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on diffcore API
Date: Tue, 27 Jun 2006 16:33:22 -0700
Message-ID: <7vbqse6unx.fsf@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
	<7v4py7h2b9.fsf@assigned-by-dhcp.cox.net>
	<7virmn9hx8.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0606270141x7e38af5i8a97b27e37da17bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Timo Hirvonen" <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 01:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvN3g-0003nM-A0
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 01:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWF0XdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 19:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWF0XdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 19:33:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63415 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932587AbWF0XdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 19:33:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627233323.EJSH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 19:33:23 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22763>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 6/27/06, Junio C Hamano <junkio@cox.net> wrote:
>> -- >8 --
>> Notes on diffcore API
>> =====================
>
> Thanks!
>
>> Diffcore Transformation
>> -----------------------
>>
>> The input file pairs recorded in the previous phase are
>> collected in diff_queued_diff (a global variable -- which means
>> that you cannot have two diffs running in parallel with the
>> current setup).  This is an expandable array of pointers to
>> `struct diff_filepair` structure.
>>
>
> merge-recursive shouldn't have any problems with that, as the
> renames are just read in the current implementation.
> Still, it is somehow uncomfortable to see the amount of APIs
> with the above restriction. Never know when it'll bite.

I think it is simply the matter of moving diff_queued_diff a
field in diff_optionss structure and adding an extra parameter
to point at the current diff_options to handful functions if we
ever need to support it.  I haven't bothered doing that because
we haven't had the need to run more than one diff at once.
