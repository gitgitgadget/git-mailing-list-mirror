From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce remote.pushdefault
Date: Sun, 17 Mar 2013 06:00:08 +0530
Message-ID: <CALkWK0m2N=D47WJLk1F4j1GsGGWHyfxVF_WGXBbG3vyrfQ-oLA@mail.gmail.com>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org> <1360314123-1259-1-git-send-email-artagnon@gmail.com>
 <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 01:31:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH1VC-0006z2-7e
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 01:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab3CQAa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 20:30:29 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51195 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab3CQAa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 20:30:29 -0400
Received: by mail-ie0-f182.google.com with SMTP id k14so5781688iea.27
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=k89/8AkgLlu97ZeliRnrpIholaPQmkGyPV3jopvwToI=;
        b=iPTQeIJO7Eyz5Sq/P5SxdDFliRLXNm8D/N+JLONJHYcUuI993ON+jpYOh/cmfiUNhW
         4pVd1wk8l+YxCYPgztUek95BD9wFnygz8rEoZpmZI3RXgVTCs0/lvXPGh+xBTFakPTi3
         YKWPYOqrYq+574nc3HBgHDSJtTvNfpC4ScamP56lrvggjXQR2+9YfU+j98/RQtOWrGkq
         ko5trkB4lQmojDTbiRlMAsLe45BNF9QfQJ0AAWP4c+BUVcPDUyDU8nsSbtOqDLs/5up5
         DMisUZo5kCZ6gWaPdT2GVoUlbcDKGu3gjBcgsuW9Nr5rtMNCIBK8iSQT9Toa4P/6pxtX
         iRlA==
X-Received: by 10.50.41.200 with SMTP id h8mr3884074igl.14.1363480228537; Sat,
 16 Mar 2013 17:30:28 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 16 Mar 2013 17:30:08 -0700 (PDT)
In-Reply-To: <7v4nhm1s85.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218320>

Sorry about the horribly late response- I just got around to
re-rolling this, and had a doubt.

Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9b11597..82a4a78 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1884,6 +1884,10 @@ receive.updateserverinfo::
>>       If set to true, git-receive-pack will run git-update-server-info
>>       after receiving data from git-push and updating refs.
>>
>> +remote.pushdefault::
>> +     The remote to push to by default.  Overrides the
>> +     branch-specific configuration `branch.<name>.remote`.
>
> It feels unexpected to see "I may have said while on this branch I
> push there and on that branch I push somewhere else, but no, with
> this single configuration I'm invalidating all these previous
> statements, and all pushes go to this new place".
>
> Shouldn't the default be the default that is to be overridden by
> other configuration that is more specific?  That is, "I would
> normally push to this remote and unless I say otherwise that is all
> I have to say, but for this particular branch, I push to somehwere
> else".

I'm a little confused as to where this configuration variable will be
useful.  On a fresh clone from Github, I get branch.master.remote
configured to "origin".  How will adding remote.pushdefault have any
impact, unless I explicitly remove this branch-specific remote
configuration?  Besides, without branch.<name>.remote configured, I
can't even pull and expect changes to be merged.  So, really: what is
the use of remote.pushdefault?

I'm dropping this patch, and just going with branch.<name>.pushremote,
unless you convince me otherwise.
