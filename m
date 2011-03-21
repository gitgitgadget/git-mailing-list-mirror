From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Mon, 21 Mar 2011 19:39:10 +0100
Message-ID: <AANLkTi=E7fahZ9rnO2-bq=Jo7eVnimkFkcMR_=FdtBN9@mail.gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
	<201103210120.50337.jnareb@gmail.com>
	<4D86B968.9030304@eaglescrag.net>
	<201103211701.01785.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k6e-0002cn-Ng
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab1CUSp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 14:45:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38838 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1CUSp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 14:45:26 -0400
Received: by vxi39 with SMTP id 39so5237103vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5yqAf3SmpNzuTfO1L//oMfHsjCa2Pn18VhbuF7vrvzE=;
        b=g7Nz+a8esGCUpnsdPuQoaYpcUmEOmUwYuHVPxdqjkDQwLEPQaTkqY9R35EmFGnC0kU
         YyxmG0uTpz2zaH25qxZuYJjgP3ZG8MfRK6L0B01E0pZq9XZnPwaYpFKYCOtb/KR+VOYW
         i1Zzzm51EUNQLrywqFcr/vT2mZNKMkz7SMxHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=svmSUXqynO5Bvf3oDqHs0MN8r/nnHbj8wN2CpGIgqb1tPq7VQULEHBx/WRAcMHK1JL
         vkq+MupDW9G195XGw1g4ndaBu7Fi/FIqXedZiDY14NyHQXSWohj2pqPKXyHv9igLlitQ
         J0OBv/x0tJoeQMeRed7i5hyQeDKI2H53BGcKY=
Received: by 10.220.102.82 with SMTP id f18mr1166420vco.241.1300732750097;
 Mon, 21 Mar 2011 11:39:10 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Mon, 21 Mar 2011 11:39:10 -0700 (PDT)
In-Reply-To: <201103211701.01785.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169640>

On Mon, Mar 21, 2011 at 5:01 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Mon, 21 Mar 2011 at 03:35, J.H. wrote:
>> On 03/20/2011 05:20 PM, Jakub Narebski wrote:
>>> On Sun, 20 Mar 2011, J.H. wrote:
>>>
>>>>> With this feature enabled, all timestamps are shown in the local
>>>>> timezone instead of GMT. =A0The timezone is taken from the approp=
riate
>>>>> timezone string stored in the commit object.
>>>>
>>>> I'd argue there are two types of "local" time that anyone using gi=
tweb
>>>> would be looking for (particularly if this is called local time)
>>>>
>>>> 1) Time Local to the observer: =A0Specifically I don't care where =
every
>>>> other commit has taken place, I want to know what time it was in m=
y
>>>> preferred time zone (local time zone likely)
>>>
>>> This can be done only via JavaScript, otherwise how would you get u=
ser's
>>> timezone? =A0Well, you could specify timezone via a form, save it i=
n
>>> a cookie and do conversion to timezone from cookie on server... but=
 this
>>> means more code, and would screw up with output caching if/where
>>> implemented.
>>
>> I think this would screw up less caching vs. more caching w/ Javascr=
ipt.
>> Without doing this with Javascript having any hard coded timezone li=
ke
>> what's proposed here is bad, particularly if for some reason two peo=
ple
>> can select different time zones for whatever reason (not an unreason=
able
>> extension of what's been proposed)
>
> First, it would complicate caching, as output would depend not only p=
urely
> on URL, but can also depend on cookies. =A0Cache key would have to ta=
ke it
> into account.
>
> Second, it would reduce effectiveness of cache, as single page would =
have
> to have multiple versions (up to 24, one per timezone, I guess).

It would reduce the effectiveness only if it's really needed. If everyo=
ne works
from one timezone, the cache have only one version. Only if there are u=
sers
from multiple timezones, which means the feature is really required, th=
e cache
would have multiple versions.

In my case we have main office in one place, but we get commits from
several other timezones. So although the "one timezone for project" wou=
ld
benefit most people, some might still not be very happy.

--=20
Piotr Krukowiecki
