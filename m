From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] completion: refactor __gitcomp related tests
Date: Wed, 31 Oct 2012 00:02:01 +0100
Message-ID: <CAMP44s0aN_FU+51huzdtEKOMaw2yhVy4d=jV6YHMeoCKDeqU8Q@mail.gmail.com>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
	<1350869941-22485-2-git-send-email-felipe.contreras@gmail.com>
	<20121030224558.GN12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 00:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKp7-0007n3-V0
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 00:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934578Ab2J3XCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 19:02:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39563 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab2J3XCC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2012 19:02:02 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so842232oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ywv2lh6aEZUECO1cjiUL0hAOsI9/Km4PMrCIG6pDPdE=;
        b=KVTU57oCa0rzmwm9xZIGiYNL//RMiHy+UbQ9dnIjBxRic5XBYWQualEESJlkyvzXN1
         nxGlvcWjw7PPsmGNwj4AOQHVFFW/xO2xMFz52QQkqDFIT5rGyXS2Dfr3QYIWAmOBh8/V
         R4GFpORe+U6NC+f+UzwNqJGpkfv2KwQGPSyRm/BR2GbPX3deyYuWvGgQMCmJE76vsMlL
         Fx2Ld+Jv1Itg47hTt9FGgSUDXS4Yq8UoP3Uyc+hZzkKbkpy2z75GJOI9j1jyC7dfnxIJ
         14vnneA0cLvSzLEQg6770kZBXLUvOeoW+wsr3wWKwmAR+psWGP7wTRAXdoGmg9kEyv1U
         9+sA==
Received: by 10.60.22.228 with SMTP id h4mr29691890oef.30.1351638121280; Tue,
 30 Oct 2012 16:02:01 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 16:02:01 -0700 (PDT)
In-Reply-To: <20121030224558.GN12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208767>

On Tue, Oct 30, 2012 at 11:45 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> On Mon, Oct 22, 2012 at 03:39:00AM +0200, Felipe Contreras wrote:
>> Lots of duplicated code!
>>
>> No functional changes.
>
> I'm not sure.
> I'm all for removing duplicated application code, but I'm usually mor=
e
> conservative when it comes to test code.  The more logic, the more
> possibility for bugs in tests.  So tests should be dead simple, even
> if that means some duplicated test code or the lack of convenience
> functions.
> While this might be considered just a matter of personal preference, =
=2E..

=46air enough, but my preference is different: test code should be the
same as normal code; easy to maintain.

>> +test_gitcomp ()
>> +{
>> +     sed -e 's/Z$//' > expected &&
>>       (
>>               local -a COMPREPLY &&
>> -             cur=3D"--re" &&
>> -             __gitcomp "--dry-run --reuse-message=3D --reedit-messa=
ge=3D
>> -                             --reset-author" &&
>> +             cur=3D"$1" &&
>> +             shift &&
>> +             __gitcomp "$@" &&
>
> ... I was really puzzled by how __gitcomp() gets its arguments here,
> and had to think for a while to figure out why it's not broken.

You mean because "$@" is treated in a special way? Without that
behavior I'm not sure many things would be possible :)

Anyway, I don't think we should make our life more difficult while
maintaining test code... that's my opinion.

Cheers.

--=20
=46elipe Contreras
