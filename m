From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Which file is older in history?
Date: Thu, 21 Mar 2013 18:02:32 +0530
Message-ID: <CALkWK0nOzUXk0cFh8GCHc=YqLkRJ2XNFgU_tOsua81ROK99mXw@mail.gmail.com>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 <7vobeddcjq.fsf@alter.siamese.dyndns.org> <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
 <20130321122130.GA22607@sigill.intra.peff.net> <20130321122428.GB22607@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIegM-0008Sa-EF
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab3CUMcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 08:32:55 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:62498 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727Ab3CUMcy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Mar 2013 08:32:54 -0400
Received: by mail-ia0-f175.google.com with SMTP id y26so2388147iab.34
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ib33dnsdFCNe/aK7J5JKhqMvSQlhKcCP18x9kltJXK8=;
        b=PE1q7FmpCKcdMrxMKcaK6g4dQCLrRf65bYe1C1COZ46LFbUYCFo4w7ErvFt19y6QGw
         Xh2vwXDEnnp+6ns3k9NOG8hOCRX5xspxk0CqK9jBc+p2zHgMjDI42cr0BfLgx4w9D8Yn
         MyjF77mysma3sX4J/bRaC/WTz9tnniOtfmy0Kcp2dgpYQsce5jEFxN/h5vFpfiLdz8TP
         DREiszbaWYTxW0A7OwEEggUOAEFWRfpCobMQap9ln9t8E28TJpS5+NBvsgKRmFE7vlpy
         ZJI9MnIWbTltkm4mBFrfJlsk1+X/b7nAX8Dfxgqk9ylEdNDqP0+ILONZOSw5wzZ1igkL
         iIgA==
X-Received: by 10.43.9.68 with SMTP id ov4mr16112280icb.22.1363869173851; Thu,
 21 Mar 2013 05:32:53 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 21 Mar 2013 05:32:32 -0700 (PDT)
In-Reply-To: <20130321122428.GB22607@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218718>

Jeff King wrote:
> On Thu, Mar 21, 2013 at 08:21:30AM -0400, Jeff King wrote:
>
>> On Thu, Mar 21, 2013 at 05:29:39PM +0530, Ramkumar Ramachandra wrote=
:
>>
>> > > This must be a trick question but the na=C3=AFve way I think of =
is
>> > >
>> > >         git log --diff-filter=3DA -- path1 path2
>> >
>> > Thanks, I didn't know about --diff-filter.  I'll need one extra st=
ep
>> > to figure out which commit corresponds to the introduction of whic=
h
>> > file, no?
>>
>> Maybe
>>
>>   git log --format=3D%H --name-status --diff-filter=3DA -- path1 pat=
h2 |
>>   perl -lne '
>>     if (/[0-9a-f]{40}/) { $commit =3D $& }
>>     elsif (/^A\t(.*)/) { $h{$1} =3D $commit }
>>     END { print "$h{$_} $_" for keys(%h) }
>>   '
>
> Actually, I only looked at your question, not the original point, whi=
ch
> was not which commit was which, but which one was older. If you just
> want to know which is older, then just:
>
>   git log --format=3D%H --name-status --diff-filter=3DA -- path1 path=
2 |
>   grep ^A |
>   tail -1

Great!  I just learnt about --name-status now.
Nit: tail -<n> is deprecated in favor of tail -n <n>, I think.  It's
nicer to have definite fixed command line options, as opposed to
parsing an arbitrary -(*) and deciding if \1 is a \d+.
