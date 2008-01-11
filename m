From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 19:00:40 +0000
Message-ID: <C3AD6D58.10E02%jefferis@gmail.com>
References: <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 20:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP8I-0004Tv-Mz
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 20:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761437AbYAKTAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 14:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756422AbYAKTAw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 14:00:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:8386 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760957AbYAKTAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 14:00:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so510359ugc.16
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=9YhmOuwrr7SLGED5T6dP3PvHLQ1YCF/AuUTpLxAPRDg=;
        b=A2bC2Eyr1DTUJ4ijm7GM4azSTQyT4L5abb4rDSVHEXNNf8TT9U+ghkR/UwysoMjPYJaE3Dg/z1WrKewJ4bhwUHKoq1ziPVe/rbeJs/Kr3/klaQcRZspsJuOchTCxM96n42yOW+jHfzf9+TJLo8ZzdYuujOQ/6VUk7D6TgKDJChM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=kChNIR4HaEo/ZCXsQT/XOxyZXxwHtnYfh/BNF5DSa2hxJCkpK5Xq+5HJIboIxXLqZCV3mZtqPqJE/aOyzunvWrMC3WHUczUcxX+GmtIu8AmCsQDtTydmwtTJNtvuTqfLWSxwjn6ISBnH1PIOm7Zg1HP3zp1w4KV7n+EvBZnvWPs=
Received: by 10.66.220.17 with SMTP id s17mr4768854ugg.20.1200078046272;
        Fri, 11 Jan 2008 11:00:46 -0800 (PST)
Received: from ?131.111.101.105? ( [131.111.101.105])
        by mx.google.com with ESMTPS id 32sm12043935ugf.9.2008.01.11.11.00.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 11:00:45 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchUhEIDgJjnrMB3EdyCZgAUURoPUg==
In-Reply-To: <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70191>

Sticking my head above the parapet again ...

On 11/1/08 16:28, "Steffen Prohaska" <prohaska@zib.de> wrote:

> I don't think the CRLF problem is a Windows vs. Unix discussion.
Agreed.
> In my view, the discussion is wether git will have real cross-
> platform support as its default or not.  The current default is
> sane for native Unix or native Windows projects.  For cross-
Absolutely
> platform projects the default needs to be changed in the way
> described above.  Git needs to ensure that CRLF never enters the
> repository for text files.

LF only repositories are model that everyone is tending towards but I feel
that there are (sane) people out there who would sometimes like to have CRLF
files in the repository and do cross-platform development (I would
developing on a Mac for a Windows originated Win/Mac project or if I were
keeping vendor source code in a tree).  In spite of the plethora of autocrlf
variants so far there is still none that on unix would give you LF->CRLF on
check in and CRLF->LF on checkout!  This should be perfectly compatible with
git's internals and I think it should be possible to allow this without
breaking anything for other situations.  One solution, which would have
other uses, would be to allow checkin conversion to a specified line ending
and checkout conversion to platform line ending as separately configurable
options.

If this seems outrageous then it should be made perfectly clear that the git
project strongly discourages CRLF text files in cross-platform repositories,
that to prevent CRLF creep we disallow them by default even in the privacy
of your own OS (if it's Windows) and that if you want to do this you're on
your own mate.  But I think that would be a shame, inflexible and definitely
not PC ;-)

> If you did not set autocrlf=true,
> copying source code from Windows to Unix would not be supported.
> But as you earlier mentioned, this seems to be a common
> operation and I am observing the same.  So I recommend
> autocrlf=input on Unix if you plan to ever go cross-platform.

For me this is kind of the mathematician vs the engineer.  I think Steffen
is logically correct in saying that autocrlf=input on unix is the direct
orthologue of autocrlf=true on windows and I dislike the idea that git
should show logically different behaviour on different platforms.  However I
think Linus's cost/benefit analysis is right: CRLF files appear infrequently
on unix system and often as not it's because someone specifically wants them
to stay that way.

So I think autocrlf=input is a useful option but not a necessary default on
unix. 
