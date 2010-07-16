From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is
 supported
Date: Fri, 16 Jul 2010 16:06:09 -0500
Message-ID: <20100716210609.GA23044@burratino>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
 <7viq4ppxt9.fsf@alter.siamese.dyndns.org>
 <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
 <7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
 <AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
 <AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
 <20100716195007.GC16371@burratino>
 <AANLkTikDwJaBN8Y0814m6JaVab9BAXPx_VKE7Z_Q6hq7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 23:07:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZs7n-0000vL-D0
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 23:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966218Ab0GPVHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 17:07:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52170 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966094Ab0GPVHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 17:07:06 -0400
Received: by yxn35 with SMTP id 35so569922yxn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FTCpoL/phSjybd2HHCGAg6I3DwQt3OTdf4DACwNMthM=;
        b=nCJ/sDTj89cjFhBXQ/rmLyH4o5/N2pHIOnD2SnQ7rl3XFZATlLDAMmFdG7KchBXdQS
         EQeOr18RdfghYbmsy/MNAjmW7/PZfa9x2OYPvn07VZgD8aEDdb83GiDGtZSXaypEtt4R
         Yvvlf0jIfm32VZXnJdOE1bJkevHj30TSfX9IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IeThPYZ/gUuvXaOFd1ON+HK1j/4pjgPMmmpI4u2qsgxlX2AfbEH4LmdlUW929K624/
         mwsAxzIMDE44UdOnH5jXvR82qoY8JNfK62EwjmNYrc5jDmL9Xd4YXBSVyVx8lW5UYvLs
         Pid/FS6WvassAiN+tLcEgj8XlH7gSKDAthHtU=
Received: by 10.224.26.68 with SMTP id d4mr1466417qac.324.1279314424843;
        Fri, 16 Jul 2010 14:07:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h20sm11707579qcm.9.2010.07.16.14.07.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 14:07:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikDwJaBN8Y0814m6JaVab9BAXPx_VKE7Z_Q6hq7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151172>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The failure is totally predicated on whether or not REG_STARTEND is
> available on the system
[...]
> Then you could do:
>=20
>     test_expect_success REG_STARTEND 'git grep ile a' '
>         git grep ile a
>     '

Sorry to harp on this, but no, that would not be right.  When
REG_STARTEND is not available on a system, this is still a bug and
we still want to know when it is fixed.  The test should not be
skipped.

So one could do:

 if have_reg_startend
 then
	expectation=3Dsuccess
 else
	expectation=3Dfailure
 fi
 test_expect_$expectation 'git grep ile a' '
	git grep ile a
 '

> The glibc one is probably pretty good as far as minimal POSIX DFA
> engines go. Hopefully you can patch it up to get it to compile on
> non-GNU systems.

No promises, in particular because I don=E2=80=99t have any non-GNU
installations handy to test on.  Probably gnulib=E2=80=99s copy will do=
,
as Andreas suggested.

> Regarding regular expression implementations. We might want to look
> into bundling one implementation and using it everywhere

Please no. :)

If we can do better than glibc, then glibc should be improved (yes,
I know GNU grep does much better than glibc already).

> Using NFA engines like that also gives you some performance guarantee=
s

Do you mean =E2=80=9Cusing DFA engines=E2=80=9D?  i.e. I thought GNU gr=
ep avoids
backtracking by converting the NFA to a DFA, at least conceptually.

Thanks for the food for thought,
Jonathan
