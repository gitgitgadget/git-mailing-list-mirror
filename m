From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/4] i18n: Add shell script translation infrastructure
Date: Sun, 8 May 2011 23:45:24 +0200
Message-ID: <BANLkTinnv=hm80h=9P80t=3QvwS-BQ7D=A@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
 <BANLkTi=nTSf0CQWs-ODxw=P+eX=Dc7Yf-Q@mail.gmail.com> <BANLkTikmj_urw389ad0r86OR+26AvXTVzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Sebastian Schuberth <sschuberth
X-From: git-owner@vger.kernel.org Sun May 08 23:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBnn-0001Eb-LW
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab1EHVqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 17:46:07 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61844 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab1EHVqF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 17:46:05 -0400
Received: by qyg14 with SMTP id 14so3589760qyg.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=q7MTAANs00KQij5UEwsDgcJzg+gY8W4UirB9PRGF3LM=;
        b=blDuYvTGI86/A1dsjS8l77FVl92pyUe9+YwMp/vdnXaMKykweLDej5EpyH3ucqLWNX
         35SX3sP0JhybJlz8/WCzHW3+5QFuup4zaeiT1py0WjWbYcrN5jCASN5uAjfws2NYwtVd
         ALUXw/hqzQs1i7y/sKThqcycXHsPXo1uPG6xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hu9XHQo/8WT4+AMFtYqWueSb2Q3WCIcQmUXEw3X6EWEznZwXbtWJpiLMHnatxgyLwG
         w8+zxXWnrY4xCWr8Ed/zvmdK8Y5AZcMzXvQ5GRnniogJVkxMW3pH48KLkG8mWIXI90W4
         ay1lQRVrW/QAI1fs6O9eHUdOMQzSJ4zxF6VQg=
Received: by 10.229.67.13 with SMTP id p13mr3305912qci.98.1304891164124; Sun,
 08 May 2011 14:46:04 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Sun, 8 May 2011 14:45:24 -0700 (PDT)
In-Reply-To: <BANLkTikmj_urw389ad0r86OR+26AvXTVzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173187>

Heya,

[+msysgit people]

On Sun, May 8, 2011 at 23:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Sun, May 8, 2011 at 19:03, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
>> On Sun, May 8, 2011 at 14:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>> This adds skeleton no-op functions to git-sh-i18n.sh analogous to t=
he
>>> gettext.c skeleton functions for C, adds *.sh scripts to the "pot"
>>> target for message extraction, and updates the git-sh-i18n--envsubs=
t
>>> tests to use the new test_i18ncmp function.
>>
>> I seem to remember there were some concerns about performance with a
>> previous version of this series. Have you done any before/after
>> timings on, say, the git test suite? Or am I remembering incorrectly=
?
>
> When I benchmark this on my (Linux) system it runs at 0% difference
> between the current test suite and the one with this series.
>
> The concern was about Windows, where forks are more expensive, so
> e.g. every time we shell out to sed/awk/perl/grep or
> git-sh-i18n--envsubst we incur a larger speed hit than on Unix
> systems.

Perhaps one of the windows devs can benchmark this then? =C3=86var, whe=
re
do you have a pullable version of this series? Your github fork has
quite a few branches.

--=20
Cheers,

Sverre Rabbelier
