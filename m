From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Wed, 28 Jun 2006 11:59:21 -0700
Message-ID: <7virml14za.fsf@assigned-by-dhcp.cox.net>
References: <20060628183557.GA5713@fiberbit.xs4all.nl>
	<7vr719159v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 20:59:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvfG3-00023c-Tk
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 20:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWF1S7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 14:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWF1S7X
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 14:59:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16295 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751003AbWF1S7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 14:59:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628185921.MLUT19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 14:59:21 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <7vr719159v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 28 Jun 2006 11:53:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22818>

Junio C Hamano <junkio@cox.net> writes:

> Marco Roeland <marco.roeland@xs4all.nl> writes:
>
>> In commit 6294a10 it was noted that "on x86-64 it seems that Git.xs does
>> not link without compiling the main git objects with -fPIC". Set it
>> therefore automatically on this platform.
>
> I agree with it in principle but was too lazy to do that myself.
> I wonder it should be inside Linux, though.
>
>>  ifeq ($(uname_S),Linux)
>>  	NO_STRLCPY = YesPlease
>> +	ifneq (,$(findstring x86_64,$(uname_M)))
>> +		USE_PIC = YesPlease
>> +	endif
>>  endif

In other words, I am wondering why you did not do this more
obvious one:

        ifeq ($(uname_M),x86_64)
                USE_PIC = YesPlease
        endif

My suspicion is that you protected that in Linux on purpose
because you know that my version would break for somebody else,
or because you are trying to be cautious not to break other
platforms you do not have access to, and I cannot tell which.
