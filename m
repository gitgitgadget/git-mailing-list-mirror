From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow testing of _relative family of time formatting and 
	parsing functions
Date: Sun, 30 Aug 2009 09:25:11 +0200
Message-ID: <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828190319.GA9233@blimp.localdomain>
	 <20090828191521.GA12292@coredump.intra.peff.net>
	 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
	 <20090828193302.GB9233@blimp.localdomain>
	 <20090828205232.GD9233@blimp.localdomain>
	 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 09:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhemw-0002OD-Ko
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 09:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbZH3HZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 03:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbZH3HZL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 03:25:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51366 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZH3HZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 03:25:10 -0400
Received: by bwz19 with SMTP id 19so2264783bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jhr+ubwDMev00L73JoAiI24CjKCO4kOWWVhfrktQQPQ=;
        b=ORQ/S/Ms2x2PFlmhgN5nIYwEcH7U1IZNiqZpm+nPQw/eTAookMsQo2fYwSEeHiBjyW
         hiO9LKy6szbx8bwUI3BxTLjfOxd11aCDPXLQy0EIgW5qR1FYVSk0X2B2SQayqv2Er9Go
         nP7L0jFEt0Rr497hMaxC98p0f6ZikPYUaLK4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OMB9ziwjqqV5hiHggwHLzZbYrPxVj7/C5DIuuv5fAGMY1qiVFaulv3hsZBey/76XTI
         VWAI6RjTp8VA/WKSDhNKTBT6xWn0ginB3u7spwQA2cyb73c59aBGgH+yw/iHmAeob+tP
         h4z+ZdirJFeaS26gKPQZ9pHQUxYpCow6vh1IM=
Received: by 10.204.154.209 with SMTP id p17mr2908234bkw.104.1251617111629; 
	Sun, 30 Aug 2009 00:25:11 -0700 (PDT)
In-Reply-To: <7vk50mz41e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127395>

On Sat, Aug 29, 2009 at 23:46, Junio C Hamano<gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> To complement the testability of approxidate.
>> ---
>> Alex Riesen, Fri, Aug 28, 2009 21:33:02 +0200:
>>>
>>> It should allow safe testing of this part of the code.
>>
>> And this should really allow testing of it:
>>
>> =C2=A0 =C2=A0 $ ./test-date '10.days.ago'
>> =C2=A0 =C2=A0 10.days.ago -> bad -> Thu Jan =C2=A01 01:00:00 1970
>> =C2=A0 =C2=A0 10.days.ago -> Tue Aug 18 22:50:20 2009
>>
>> =C2=A0 =C2=A0 relative: 10.days.ago -> Fri Dec 22 12:00:00 1989
>>
>> =C2=A0 =C2=A0 relative: 10 days ago, out of Fri Dec 22 12:00:00 1989
>>
>> =C2=A0 =C2=A0 $
>
> What are these blank lines for?

ctime(3) artifact (it adds a \n in the output buffer), which I missed.

>=C2=A0Is this intended as a serious submission for inclusion?

Not yet. AFAICS, test-date is never used in our test suite.

>=C2=A0I am having a hrad time to guess, especially you did not
> sign this off, nor Cc'ed me.

Right, that's because I'm not sure myself. Frankly, I'm not
convinced we have to test every single thing. In my experience,
the bigger a test suite, the less are people inclined to use it
(including setting up automatic test runs).

Jeff, Nicolas? Is this test enough? Are there any other code
paths you want to include in the test?

And sorry for having you missed in Cc:, that wasn't intended.
