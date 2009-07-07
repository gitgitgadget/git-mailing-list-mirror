From: Eric Raible <raible@gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_Schr=F6dinger=27s_diff?=
Date: Tue, 7 Jul 2009 13:30:47 -0700
Message-ID: <279b37b20907071330y732fad4dxe4e21edeab9ff179@mail.gmail.com>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
	 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
	 <20090707193605.GA30945@coredump.intra.peff.net>
	 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHJY-0006bM-9m
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbZGGUau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 16:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZGGUat
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:30:49 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:62884 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbZGGUat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 16:30:49 -0400
Received: by vwj40 with SMTP id 40so4047504vwj.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g7lLYGaTZhen5M+jfm60PvAPxdu/6g/qNRWXGX5bDzI=;
        b=K7GnNLtJCyb9ymws7Da/+573MKfzZ92BcoAhDkFHM02ajBNhKZAhLZTPI8rD+uodmF
         AxuiJ8w2UUdRvKQ9gp3qnberPjLPFeXo81TAh++atrEN8P9ps66+NKdKeziLINmrQQwM
         MOQlVl6OsLWj+rtIiB3dBntAk99LMmLzBkoHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QtUzy/kw+VHBtpjZl5l6QqAP5x4nuGwf8ebhV6pQpbx8f+hxNhPfpjyTnxfJ0FyBOt
         /z09KPN44/oUTCSnA+Mac/VUF/7/DBAuFlf0HBl3/isf8j89kWgIbKSmxUWnw4TSDAWs
         rhZl8v44T0ymDDopZFBVY7pVOTx9j4iMci7Z8=
Received: by 10.220.100.1 with SMTP id w1mr13089922vcn.10.1246998647715; Tue, 
	07 Jul 2009 13:30:47 -0700 (PDT)
In-Reply-To: <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122874>

On Tue, Jul 7, 2009 at 12:48 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>
>> .... But even that might have holes,
>> I'm afraid -- we don't always look at all of the config in every
>> command, though perhaps we do for such core functionality.
>
> I personally do not think it is worth it. =A0If you change the crlf,
> clean/smudge, or anything of that sort, just doing a "rm .git/index"
> followed by "git reset --hard" would restore sanity to your work tree=
, no?

Is there any technical reason why "git reset --hard" shouldn't repopula=
te
the index by doing a "git read-tree" or equivalent [1]?  After all the
docs claim it
"Matches the working tree and index to that of the tree being switched =
to".

Except in this case it doesn't.  The resulting .index is an invalid
representation
of the tree.  Sanity can be restored with "git read-tree HEAD" (as
Jeff suggested),
but that's hardly intuitive.

- Eric

[1] For instance anything at all (possibly involving time stamps) such =
that
the index will truly match the tree.
