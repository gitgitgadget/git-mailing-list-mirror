From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Wed, 21 Jul 2010 00:09:13 +0000
Message-ID: <AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
	<AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
	<20100721000101.GB4282@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 02:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMsC-000230-Gz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 02:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0GUAJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 20:09:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55642 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0GUAJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 20:09:14 -0400
Received: by fxm14 with SMTP id 14so3206341fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g1BRKiysPzH1Q/0mhyoSOC293zs4Pgm531LMrk2YO30=;
        b=notd9OOgt3ruTKnF7IknRrdg8PDw+q/6ELu2zbIgHoaa5KgAhpJQ1quRxqLmy593W2
         Pc/kak2xAC9WeVRlgO9DVOKyvTcxo7FnTIhey/h5GnKB2HHDwHI9hKJD0Jr/0x06TLoB
         7zntDOCjWH5jEsXGGuEpb/Z+3wH9SMiehE1ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MexeOiLypU3auCO2Eb3SQOEUZI/AjgwK5Z4JMmIF2POAaf6PzpS0yr2WxV7ed6pa1S
         /gFYhVbt/1xygV7zjIugTJh/m6JvBWYmoj5pz7+gO7/hFHe73tTMmpgWUagl6PRd6hJ7
         61yKaw3VMxbM4Vmd3lQhcCWZ6z/cOafOmiu0E=
Received: by 10.223.107.211 with SMTP id c19mr6080318fap.20.1279670953114; 
	Tue, 20 Jul 2010 17:09:13 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Tue, 20 Jul 2010 17:09:13 -0700 (PDT)
In-Reply-To: <20100721000101.GB4282@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151379>

On Wed, Jul 21, 2010 at 00:01, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> You must use "export PAGER;", not "export PAGER &&". export doesn't
>> return zero on all systems when exporting, see previous changes in
>> this regard in t/.
>
> Nope. =C2=A0Sorry I missed this before.
>
> diff --git a/t/README b/t/README
> index b906ceb..f81998b 100644
> --- a/t/README
> +++ b/t/README
> @@ -259,11 +259,11 @@ Do:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test ...
>
> =C2=A0 =C2=A0That way all of the commands in your tests will succeed =
or fail. If
> - =C2=A0 you must ignore the return value of something (e.g. the retu=
rn
> - =C2=A0 value of export is unportable) it's best to indicate so expl=
icitly
> - =C2=A0 with a semicolon:
> + =C2=A0 you must ignore the return value of something (e.g., the ret=
urn
> + =C2=A0 after unsetting a variable that was already unset is unporta=
ble) it's
> + =C2=A0 best to indicate so explicitly with a semicolon:

We should have examples for both export and unset, but the prose
should mention both IMO
