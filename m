From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Index format v5
Date: Tue, 15 May 2012 00:10:49 +0200
Message-ID: <87bolqtnva.fsf@thomas.inf.ethz.ch>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	<4FA7E703.7040408@alum.mit.edu>
	<20120508141137.GA3937@tgummerer.surfnet.iacbox>
	<4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer>
	<4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer>
	<4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer>
	<4FB1746A.6090408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <gitster@pobox.com>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 15 00:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU3Tn-0002rY-VG
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 00:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443Ab2ENWKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 18:10:55 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:9811 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757855Ab2ENWKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 18:10:54 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 15 May
 2012 00:10:50 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 15 May
 2012 00:10:50 +0200
In-Reply-To: <4FB1746A.6090408@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 14 May 2012 23:08:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197813>

Michael Haggerty <mhagger@alum.mit.edu> writes:

First of all, many thanks for taking up this time-consuming job while I
was away!  There's not much I can add at this point, just a few minor
points:

> 9. read_files() doesn't need to return "entries".  Since entries is an
> array that is only mutated in place, the return value will always be
> the same as the "entries" argument (albeit fuller).

(Ab)using an array in this fashion is somewhat iffy.  It seems
unavoidable in this case (while still retaining the runtime), but try
not to do it too often, and perhaps name the parameter something that
makes this clear (such as 'out').  Usually changing it to use a
generator function (with 'yield') helps.

> 11. It is good form to move the file-level code into a main()
> function, then call that from the bottom of the file, something like
> this:
>
>> def main(args):
>>     ....
>>
>> main(sys.argv[1:])

It's customary to wrap it as

if __name__ == '__main__':
    main(sys.argv[1:])

That way your script becomes 'import'-able, which can be handy (if only
for testing).

Cheers,
Thomas

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
