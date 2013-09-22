From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 15/17] t5300: avoid testing ofs-delta with --packv4
Date: Sun, 22 Sep 2013 08:48:50 +0700
Message-ID: <CACsJy8DBOgkVz_=JFNx88vi7uypcSSBxpwqRMtmwbsdM7q1L3Q@mail.gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
 <1379771883-10278-16-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309211237530.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 22 03:49:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNYnq-0002TZ-3m
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 03:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3IVBtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 21:49:21 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41407 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3IVBtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 21:49:21 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so2263329obc.8
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PV8YNCAc5q1cnFeg6ZYiNdTcMAfyllGnWfksfL0sajU=;
        b=UNjitA/RX5nYMZzAjYisnaTeXVLMh6uyhgimEpmI1JkoMudkbs2ngEYV+X58C/Vcdh
         P3tAB7TmNP6FROHYZzDvaj40HGShadOsFJ+g+pfiUftJpOT0K357HTDnAWtG2o+bxBqH
         M/MsrZk6kjpV4KlWUwDbrtI2mclsUNXKlR3iYS4anZ7ovZDhUvs8esQoGNlFBEvFuori
         mg/qziofXHN/Ulh9qP+rnAuVplIQqDiuGi7c3R7K8gpXMUZI6CSJF+VJ2UBxKEJgkk0+
         k+JJ0GN0fmuk2qRfkuWNULiuqj6zuLSRlvhc5EK5uxLGxK//7IFgga4JSo9cTsAex6X1
         AXOQ==
X-Received: by 10.60.17.136 with SMTP id o8mr13015081oed.7.1379814560712; Sat,
 21 Sep 2013 18:49:20 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sat, 21 Sep 2013 18:48:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309211237530.312@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235153>

On Sat, Sep 21, 2013 at 11:46 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Sat, 21 Sep 2013, Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy wrote:
>
>>
>> Signed-off-by: Nguy=C2=ADn Th=C3=A1i Ng=C3=B7c Duy <pclouds@gmail.co=
m>
>> ---
>>  t/t5300-pack-object.sh | 39 ++++++++++++++++++++++-----------------
>>  1 file changed, 22 insertions(+), 17 deletions(-)
> [...]
>
> This, in combination with patch 10/17, is making the test suite to te=
st
> either packv4 or non packv4, and never both.  I think this is not a g=
ood
> approach.
>
> Instead we should have packv2 specific tests to enforce --pack-versio=
n=3D2
> when using pack-objects and create a duplicate of those tests for
> --pack-version=3D4 when that makes sense.  For tests that are mostly
> common, the test could be factored out into a function with a pack
> version argument.  Then, most tests could be always run twice: once f=
or
> packv2 and again for packv4.  Not doing so makes it more risky to
> regress packv2 when testing improvements to packv4 support.

I agree. I wanted to split this (and maybe other t53xx) for v4-only
tests and update the existing t53xx to test on v2 only. For now I
think this will do as it will allow us to verify that v4 code works
(just need to run the test suite twice, with and without --packv4).
I'll add more v4 tests that run without --packv4. 10/17 should remain
in the end though to exercise v4 a lot more (some v4 bugs were found
not by t53xx), until we finally switch the default to v4.
--=20
Duy
