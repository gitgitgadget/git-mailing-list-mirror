From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Fri, 27 Jan 2012 11:59:36 +0100
Message-ID: <CANQwDwfsdCGhNLQrJ5Ajz+BNdZmWEu=2b1UHmP=x0RsaZQOPrQ@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 <69c90e626682e60d33bebcc6d3ff3fdb@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri Jan 27 12:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqjXH-000109-4t
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 12:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab2A0K76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 05:59:58 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33666 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab2A0K75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 05:59:57 -0500
Received: by eaal13 with SMTP id l13so188784eaa.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=phYvs8Gxlllv0gw87JpOrzyD7w1itqXm+3qz17stYkk=;
        b=nxgcVfvnkP8WRLUKCOUdaPhElHhFIsb6BgDcGmZWdZGfL1TudSi2wV+fzApgywz8d0
         YP7yxJlujjT1tkcXQKS8M3vU/+BqvK7t7NXNyvnHcWez8EuRcG9u1hn8rggKFoBeP3yh
         MqZzjx2QLeh+JjcGRjT7B+U43LJUozp1Oo9Sc=
Received: by 10.213.28.19 with SMTP id k19mr1085631ebc.24.1327661996250; Fri,
 27 Jan 2012 02:59:56 -0800 (PST)
Received: by 10.213.13.1 with HTTP; Fri, 27 Jan 2012 02:59:36 -0800 (PST)
In-Reply-To: <69c90e626682e60d33bebcc6d3ff3fdb@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189214>

On Fri, Jan 27, 2012 at 11:15 AM, Hallvard B Furuseth
<h.b.furuseth@usit.uio.no> wrote:
> On Mon, 23 Jan 2012 10:42:02 +0100, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth
>> <h.b.furuseth@usit.uio.no> wrote:
>>>
>>> Or pacify the test and expect gitweb@RHEL-users to install the RPM:
>>>
>>> --- git-1.7.9.rc2/t/gitweb-lib.sh~
>>> +++ git-1.7.9.rc2/t/gitweb-lib.sh
>>> @@ -113,4 +113,9 @@
>>> =A0 =A0 =A0 =A0test_done
>>> =A0}
>>>
>>> +perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
>>> + =A0 =A0 =A0 skip_all=3D'skipping gitweb tests, Time::HiRes module=
 not available'
>>> + =A0 =A0 =A0 test_done
>>> +}
>>> +
>>> =A0gitweb_init
>>
>>
>> [Adding Jakub to CC]
>>
>> This doesn't actually fix the issue, it only sweeps it under the rug
>> by making the tests pass, gitweb will still fail to compile on Red
>> Hat once installed.
>
>
> Is that relevant? =A0gitweb-lib.sh already has code to pass the tests=
 if
> Encode, CGI, CGI::Util or CGI::Carp are missing. =A0I just added anot=
her.

The difference is that:
1.) Time::HiRes is a core Perl module, so theoretically it should be al=
ways
    installed.
2.) Time::HiRes is not really required for gitweb to work, only for opt=
ional
    feature (timing information).

--=20
Jakub Narebski
