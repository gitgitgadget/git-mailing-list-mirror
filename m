From: George Karpenkov <george@metaworld.ru>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Tue, 15 Jan 2013 11:54:46 +1100
Message-ID: <CAMoGvRJhwqRqdV=-AAqbjrDzcL2_zPUfaEhrQuHS+DjD3X9qTw@mail.gmail.com>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
 <50F3F852.8060800@viscovery.net> <7v622zbn3s.fsf@alter.siamese.dyndns.org>
 <vpqobgrpoh7.fsf@grenoble-inp.fr> <CAMoGvRKMwP_JBvNNWoN=m9AX3MP9xVgBUwxELHtry_-8Um8WKQ@mail.gmail.com>
 <B10A5C9F770D48C9958F240D59B1A400@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:55:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuuoR-0006fO-NT
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab3AOAzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:55:10 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:56974 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab3AOAzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:55:08 -0500
X-Greylist: delayed 47655 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 19:55:08 EST
Received: by mail-lb0-f182.google.com with SMTP id go10so3311572lbb.41
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=lJE7U9xFQoSdwpCiq6sEk3bJ7Yc1MxIkSE/MxScvx4o=;
        b=EcGwsF6T06p/yoB/MqSz0H5w47weNQXwfFw4d0ciiaUtgCSQSgcpFWwbI8nt5TNB6f
         6PYuL8bfUG8yTAGXZnqFd2yPP2IIMXwYCChGaC75RqR6oyRmLKmZyPxjuXiHir02n2ZR
         ADiDmpT8Q1ZI68OB7kYaKwmeciw3WM0rLLiXrJMIMQuLQSBxwwsRSIDtYpqSdWwpzIE8
         2gRdacpDEmH92u6AMRsDglqTkOpYz5n2oZZ8IGKzkDqu9FRtfsySVZbi35bhWkEM4buS
         WKlKcZDe3kUqKDlZYutPvmUF4cLyFxoGvl/Jdw7YqEbBP52eWTZuB1y1c2gh0GGoME4M
         +LDw==
Received: by 10.112.9.104 with SMTP id y8mr35843508lba.89.1358211306679; Mon,
 14 Jan 2013 16:55:06 -0800 (PST)
Received: by 10.112.59.1 with HTTP; Mon, 14 Jan 2013 16:54:46 -0800 (PST)
In-Reply-To: <B10A5C9F770D48C9958F240D59B1A400@PhilipOakley>
X-Google-Sender-Auth: NrsB2Ag3CHraMmq_BarYpce6hAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213566>

Happy ending!

Turns out i have actually made a backup 3 days ago.

My other work was on a branch + in a stash. Commits done on a branch
were already present in a backup.
I was able to get the stash working by copying corrupted .pack files
from the backup, luckily all the new work wasn't packed yet.

So i've just verified the log messages to see that no new commits were
made, created a patch from the corrupted git repo of the stash,
applied it on the backup, and wo-hooo, everything worked.
And then I've pushed to origin to avoid such silliness in the future.

Thanks and Regards,
George

On Tue, Jan 15, 2013 at 10:45 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "George Karpenkov" <george@metaworld.ru>
> Sent: Monday, January 14, 2013 10:57 PM
>
>> Thanks everyone!
>>
>> Progress so far:
>>
>> After executing reverse sed command:
>> find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;
>
>
> Have you counted how many substitutions there are in the pack file(s). It
> may be sufficiently small that you can  simply try all the possible
> combinations of fwd and reverse substitutions. Even if it takes a few days
> the computer won't get bored ;-)
>
>>
>> And trying to switch the branch I get:
>>
>>> git checkout X
>>
>>
>> error: failed to read object 51a980792f26875d00acb79a19f043420f542cfa
>> at offset 41433013 from
>> .git/objects/pack/pack-8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack
>> fatal: packed object 51a980792f26875d00acb79a19f043420f542cfa (stored
>> in .git/objects/pack/pack-
>> 8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack) is corrupt
>>
>> So the actual .pack file is corrupt, unfortunately.
>>
>> On Tue, Jan 15, 2013 at 6:13 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Everybody seems to be getting an impression that .idx is the only
>>>> thing that got corrupt.  Where does that come from?
>>>
>>>
>>> It's the only thing that appear in the error message. This does not
>>> imply that it is the only corrupt thing, but gives a little hope that it
>>> may still be the case.
>>>
>>> Actually, I thought the "read-only" protection should have protected
>>> files in object/ directory, but a little testing shows that "sed -i"
>>> gladly accepts to modify read-only files (technically, it does not
>>> modify it, but creates a temporary file with the new content, and then
>>> renames it to the new location). So, the hope that pack files are
>>> uncorrupted is rather thin unfortunately.
>>>
>>> --
>>> Matthieu Moy
>>> http://www-verimag.imag.fr/~moy/
>>
>> --
>
>
