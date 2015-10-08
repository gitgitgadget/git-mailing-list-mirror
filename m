From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] pretty: add format specifiers for short and raw date
 formats
Date: Thu, 08 Oct 2015 13:04:26 +0200
Message-ID: <20151008130426.Horde.ovF3CHaJ-fo48aLDf23t-Q1@webmail.informatik.kit.edu>
References: <1444235305-8718-1-git-send-email-szeder@ira.uka.de>
 <xmqqmvvutone.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 13:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk908-0002mJ-6a
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 13:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbJHLEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 07:04:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56575 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932163AbbJHLEa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 07:04:30 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Zk8zs-0008GY-4f; Thu, 08 Oct 2015 13:04:28 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Zk8zq-00006U-8t; Thu, 08 Oct 2015 13:04:26 +0200
Received: from x590c1c00.dyn.telefonica.de (x590c1c00.dyn.telefonica.de
 [89.12.28.0]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 08 Oct 2015 13:04:26 +0200
In-Reply-To: <xmqqmvvutone.fsf@gitster.mtv.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1444302268.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279236>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> @@ -120,6 +120,8 @@ The placeholders are:
>>  - '%at': author date, UNIX timestamp
>>  - '%ai': author date, ISO 8601-like format
>>  - '%aI': author date, strict ISO 8601 format
>> +- '%as': author date, short format
>> +- '%aR': author date, raw format
>
> Hmmm, are these two a good things the only ones that are missing?

Sort of.  There is 'local', but after add00ba2de (date: make "local"
orthogonal to date format, 2015-09-03) hit master that's not a
format anymore.

> It makes me wonder if it's time for us to move to a more extensible
> format, e.g. "%aT(...)", in which 'T' stands for 'timestamp' and the
> part in the parentheses can be any format string that is understood
> by "log --date=3D<format>" [*1*].  Once we have something like that,
> we can keep the existing ones for historical convenience, stop
> adding new ones [*2*] and do not have to worry about these two
> mechanisms going out of sync.

> *1* Yes, and in longer term, we should really aim to unify the
>     for-each-ref format and "--pretty=3Dformat:" format.  "%aT(...)"
>     is probably a step in a wrong direction, and it should probably
>     be more like "%(authordate:...)".

That would be great, especially that in [*1*].  Real words are so
much better than one or two letter codes.
Of course that would also be a lot more invasive change.

> *2* Because we have "%ad", we _can_ stop adding new ones already.

With this patch in my tree I have this pretty alias

   pretty.commitref=3Dtformat:%h (%s, %as)

in my config, and a simple '--pretty=3Dcommitref' option works on its
own to produce the format that I used above.  With '%ad' that
wouldn't work, because I would need the additional '--date=3Dshort'
option, too, which means I have to remember it and have to type more
every time.

G=C3=A1bor
