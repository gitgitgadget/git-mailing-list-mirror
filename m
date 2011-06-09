From: Marc Pegon <pegon.marc@gmail.com>
Subject: Re: Sha1 lookup and GIT_USE_LOOKUP
Date: Thu, 9 Jun 2011 11:24:15 +0200
Message-ID: <BANLkTi=b+WKy2_9VeEw5B0QqodHfVJs2XQ@mail.gmail.com>
References: <BANLkTintTECbO5X3VMvzHdGgyKmLKe65YE=0mX6Ahj5wutCJ0Q@mail.gmail.com>
	<7v62og2lw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUbTR-0000xm-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 11:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab1FIJYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 05:24:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59645 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab1FIJYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 05:24:16 -0400
Received: by iyb14 with SMTP id 14so1146024iyb.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=reakUu51fFS8T29zdCz4z/SbbbGgh7TnbSoHJaHC+Sc=;
        b=W2vqF/5GOshXTUSi5FKELI2RsVyz5uHCxsQVe8fXpDViWdAWQMl+/lf7PySlfwKiv4
         X+H9bj2NtW4TDa7VULgDi/AvjTJTphsPeXRs8sFd/g4LYJe4SU9OU55bXCd1EApmPwAw
         Z87P9iKRpsILUOlsjuxUZJCu+FzSaDSo8nCXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qcz1W4aQlojAzjpF9pNMYQUbwBU3tAf0HZKw1hD4bO964KWW+lisOJYxlq7y3HS0y9
         WDyletIEqremW45OosUUM4uFHk6gE1VySUlPdH03S+o6O8PrZaUqvXsg+Fg5jEf6DHwn
         zeP0lEVjTAj4alHxnieSMesaOz/fyZLCa5CMo=
Received: by 10.42.229.3 with SMTP id jg3mr685449icb.425.1307611455782; Thu,
 09 Jun 2011 02:24:15 -0700 (PDT)
Received: by 10.42.165.6 with HTTP; Thu, 9 Jun 2011 02:24:15 -0700 (PDT)
In-Reply-To: <7v62og2lw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175511>

On Wed, Jun 8, 2011 at 8:55 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Marc Pegon <pegon.marc@gmail.com> writes:
>
>> Since this environment variable is not set by default, git will alwa=
ys
>> use a simple binary search, won't it ?
>
> Yes.
>
>> Also, when searching for a sha1 given a sha1 prefix, among packed
>> objects, find_short_packed_object also does a simple binary search.
>> Wouldn't it be simpler to just use the sha1_entry_pos method ?
>
> Unknown ;-).
>
> The environment variable is there exactly for people like you who are
> interested in finding out which one yields better performance by
> benchmarking. =A0Once we can get a convincing result, we can either
> deprecate the more involved sha1_entry_pos() if it turns out to be no=
t
> worth it, or we can always use it if it turns out to be significantly
> better.

Perhaps we could compare the two methods by counting for each one the
average number of iterations it takes to find an object in a pack.
But anyways, I guess GIT_USE_LOOKUP should also have an influence on
the method used to find an object given a sha1 prefix, and the code
that does a simple binary search should not be duplicated as it is
now, right ?

> Thanks.
>
