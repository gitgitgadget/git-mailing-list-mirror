From: George Karpenkov <george@metaworld.ru>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Tue, 15 Jan 2013 09:57:09 +1100
Message-ID: <CAMoGvRKMwP_JBvNNWoN=m9AX3MP9xVgBUwxELHtry_-8Um8WKQ@mail.gmail.com>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
 <50F3F852.8060800@viscovery.net> <7v622zbn3s.fsf@alter.siamese.dyndns.org> <vpqobgrpoh7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 14 23:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TusyV-0004Qu-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 23:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab3ANW5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 17:57:31 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:59049 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab3ANW5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 17:57:30 -0500
Received: by mail-la0-f53.google.com with SMTP id fn20so4498331lab.12
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=hP5TjEiaylmAxwbXAK581biJxsjOd1Wb1acYwUN3mYM=;
        b=HH1MQPJPpcq6fTH7OFTMQFTLpTAdZj9sfj//TJ5xyKu0CTLkBvJjNpVufRdi4Q16hH
         7Crz8EtTQMvJo1iSUY86kfNZqgSgi4lnyExoqx0ymcVCLwVqU1xPcWz/mYYggsHgBuTD
         7kJwKvnlwVlH7l1OrpP3JqnS0T7sH0P6gp4aQMWF7uUoS4LTD0naMIJkGeJZ551jom+i
         PFjZmJUTvvUmt9Kj6X0rz1DZ4mzPuFvpSR0u+XvGEm7wtS7VKjHSZD2uQLpmlJ7fKIhP
         ZWnnvmp2z4eNpFrbBw219UWHWpWe7WbMPP1nr8rQorz5SXchtbPr79CTVe/Uwg5+M93v
         Us6Q==
Received: by 10.112.98.134 with SMTP id ei6mr35408700lbb.62.1358204249354;
 Mon, 14 Jan 2013 14:57:29 -0800 (PST)
Received: by 10.112.59.1 with HTTP; Mon, 14 Jan 2013 14:57:09 -0800 (PST)
In-Reply-To: <vpqobgrpoh7.fsf@grenoble-inp.fr>
X-Google-Sender-Auth: ExBvCJvswAkP7E-0_q_5Jl0-AQM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213541>

Thanks everyone!

Progress so far:

After executing reverse sed command:
find .git -name '*.*' -exec sed -i 's/    /\t/g' {} \;

And trying to switch the branch I get:

> git checkout X

error: failed to read object 51a980792f26875d00acb79a19f043420f542cfa
at offset 41433013 from
.git/objects/pack/pack-8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack
fatal: packed object 51a980792f26875d00acb79a19f043420f542cfa (stored
in .git/objects/pack/pack-
8d629235ee9fec9c6683d42e3edb21a1b0f6e027.pack) is corrupt

So the actual .pack file is corrupt, unfortunately.

On Tue, Jan 15, 2013 at 6:13 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Everybody seems to be getting an impression that .idx is the only
>> thing that got corrupt.  Where does that come from?
>
> It's the only thing that appear in the error message. This does not
> imply that it is the only corrupt thing, but gives a little hope that it
> may still be the case.
>
> Actually, I thought the "read-only" protection should have protected
> files in object/ directory, but a little testing shows that "sed -i"
> gladly accepts to modify read-only files (technically, it does not
> modify it, but creates a temporary file with the new content, and then
> renames it to the new location). So, the hope that pack files are
> uncorrupted is rather thin unfortunately.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
