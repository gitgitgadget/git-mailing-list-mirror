From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 18:42:28 +0200
Message-ID: <871wui5a4r.fsf@rho.meyering.net>
References: <87hd3e5ixw.fsf@rho.meyering.net>
	<7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 18:42:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjIuy-0004hb-TH
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWEYQma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWEYQma
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:42:30 -0400
Received: from mx.meyering.net ([82.230.74.64]:41957 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1030265AbWEYQm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 12:42:28 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 167A16A54; Thu, 25 May 2006 18:42:28 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejyixe5g.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 25 May 2006 09:28:11 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20746>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Otherwise, if make is suspended, or killed with prejudice, or if the
>> system crashes, you could be left with an up-to-date, yet corrupt,
>> generated file.
>
> Thanks.  Maybe you would want a "make clean" target for them too
> if you do this.  I often use $@+ instead of t$@ so that I can
> say "rm -f *+" there.

I chose a prefix rather than a suffix, so that if git is built on a file
system with unreasonable file name length limitations, the prefix will
distinguish the temporary from the target; in that situation, a suffixed
temporary name could map to the target name.

However, assuming reasonable file name length limits, using a suffix is
generally better, since it works even when the target is an absolute
name.  Adding a prefix obviously won't work with an absolute name.

I'm happy to ignore 14-byte(and 8.3)-limited file systems and
go with a suffix, if you still prefer that.  New patch coming up.
