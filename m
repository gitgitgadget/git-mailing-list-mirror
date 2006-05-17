From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 10:41:34 -0700
Message-ID: <7vlkt0ft0x.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	<7vejythvkr.fsf@assigned-by-dhcp.cox.net>
	<7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605170722590.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 19:41:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQ1i-0006Oa-Pu
	for gcvg-git@gmane.org; Wed, 17 May 2006 19:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEQRlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWEQRlf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 13:41:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11708 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750791AbWEQRlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 13:41:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517174134.CNDN15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 13:41:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605170722590.10823@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 17 May 2006 07:24:04 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20214>

Linus Torvalds <torvalds@osdl.org> writes:

>> -	if (!cached) {
>> +	if (!cached &&
>> +	    (!NO_H_OPTION_IN_GREP ||
>> +	     (!opt->count && !opt->unmatch_name_only))) {
>>  		hit = external_grep(opt, paths, cached);
>>  		if (hit >= 0)
>>  			return hit;
>
> That's the ugliest test ever, and at all the wrong levels.
>
> Just make "external_grep()" test for the cases that it cannot handle, and 
> return -1. That's how it's designed to work.

Ah....  *BLUSH*  I was not thinking when I saw that "if (hit >= 0)"
stuff.  Yes, you made it to fall back.
