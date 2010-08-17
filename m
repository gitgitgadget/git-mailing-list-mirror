From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Tue, 17 Aug 2010 18:48:59 +0400
Message-ID: <AANLkTi=wWii8ep78G7OuyFQ+W9xsm6O-WVZBGyPJjg-p@mail.gmail.com>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
	<7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
	<7vpqxmjphl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 16:49:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlNTR-00054M-AL
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 16:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab0HQOtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 10:49:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59117 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528Ab0HQOtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 10:49:00 -0400
Received: by pvg2 with SMTP id 2so2391896pvg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BTyAolOJjR5t4KLiPa0xC9oQfDSYS81C+TSga/KqtHc=;
        b=Y625SONK2/aoBjYJukIArxohhMi8HfqbHAdnjKVqfvRDfpUZTHPMyzcOy5XUURZmd/
         FJAdvhoeuuxbLTme01cBOYmFK/73smyfNgUMEXjA/llN/bo/+olDonf9mkcT6QIj6XM9
         MBSF3RqU5psOmzq6fR5YqIxQOtMOZJ0TjyP3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lBq6PsbzFV7+WCuiyTzBK+YzEqK/MJLlGcZyh/3v3V67kI/CjfElDCilYIX5VTkC9l
         BljeSf39jRYyNDN0Bax7l/49MWXizfEb4ODRRMXCvvcxQfFqGtxDvdaw263AmgUv3ECs
         jATCA3eQYUOXu9IqcGhzwnMVg8M1stbXt7Muk=
Received: by 10.142.86.6 with SMTP id j6mr5928011wfb.55.1282056539883; Tue, 17
 Aug 2010 07:48:59 -0700 (PDT)
Received: by 10.231.192.69 with HTTP; Tue, 17 Aug 2010 07:48:59 -0700 (PDT)
In-Reply-To: <7vpqxmjphl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153751>

On Fri, Aug 13, 2010 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:
>>
>>> Somewhere between the git 1.7.0.2 and the git 1.7.2.0 the rename
>>> detection started to fail with fatal error on some files in our
>>> repository. The bug could be seen on the public IntelliJ IDEA
>>> repository (about 760M in size), but our users have reported it as
>>> well.
>> ...
>> But what 1da6175 (Make diffcore_std only can run once before a diff_=
flush,
>> 2010-05-06) did is clearly wrong. =A0Not wanting to call resolve-ren=
ame-copy
>> does not mean we do not want to run the rest of what diffcore_std() =
does
>> at all! =A0For example, "-S" and "--diff-filter=3D" options are proc=
essed in
>> that function; the exit status of the command based on the presense =
of
>> difference is computed in the function, too.
>
> This reverts 1da6175 (Make diffcore_std only can run once before a
> diff_flush, 2010-05-06) and replaces it with an uglier looking but
> hopefully correct fix.
>
> Constantine, does it fix your issue?
>
Yes. It fixes the issue on the known problematic files. The patch was
tested over 3235b7053 in the git.git master. Please apply it to the
next update.

Thank You,
Constantine
