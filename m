From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 14:53:16 +0000
Message-ID: <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <20100516160800.GB22447@efreet.light.src>
	 <AANLkTinGSBRMRyaD0w2p9PQELLA6ThvKFdi6hcNWBTxr@mail.gmail.com>
	 <201005171632.48253.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 17 16:53:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE1h6-0006d2-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 16:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab0EQOxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 10:53:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51915 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0EQOxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 10:53:19 -0400
Received: by gwaa20 with SMTP id a20so510883gwa.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nGqjb1SXACl9ses0/oc2PfESHOxeyyic29z4JMsiRkg=;
        b=TDQObFLTEPHEgxiHsSde6K4kB8Zng/t/UiZTMe1h72Q4V8pkXfyBGa8WzPqlBMoI8Q
         SWz5XQnoS4MuOaD66HwzieF9V+c3mbn14mqYTjId42wtymrhe7JSL7e3e+rPoncnK3/9
         x+FFlhzYn1+j8Vp1PWvMAvyt6mv5oW0nAPmwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=loPyQXuv4Z5ALf9Xgco3XNT8xIc/M+N6deOZEP+49IZe196s3P68W1nj+zLyXMVWrl
         a70NNFwfkUds/X2R3yBKw02SDGsB/RjEzrKkyppJE36P8jZ5kPXXrZMUffR/t8rRI3+X
         V9xppybTOD4VqfmY+/qSEUnuKOmDC5EMV4q8Y=
Received: by 10.231.120.100 with SMTP id c36mr255502ibr.77.1274107996312; Mon, 
	17 May 2010 07:53:16 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 17 May 2010 07:53:16 -0700 (PDT)
In-Reply-To: <201005171632.48253.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147242>

On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sun, May 16, 2010 at 16:08, Jan Hudec <bulb@ucw.cz> wrote:
>> > It would definitely not be fine to break *git*. You need to make s=
ure no
>> > part of git itself or anything distributed with it (gitk, git gui,=
 gitweb,
>> > things in contrib) is looking for any string that might be broken =
by
>> > translating.
>>
>> Of course internal breakage, i.e. git-foo parsing the output from
>> git-bar breaking under non-English is unacceptable. I meant that
>> external tools now running under some non-English locale may start
>> breaking if they're parsing the output and assuming English. The
>> remedy for that is easy though, just prefix the calls to git with
>> LC_ALL=3DC.
>
> And how exactly do you expect us to go back in history and prefix all
> invocations of git in all scripts with LC_ALL=3DC?

I don't expect you to. I just don't think it's unreasonable that if
Git were to be internationalized that it behave like every other *nix
program. If you have a Chinese locale and rely on the output of some
program being in English your scripts will break if the OS
subsequently upgrades to a new version of the program that has been
translated to Chinese.

The right way to handle that is to call programs like that with
LC_ALL=3DC.

The alternative would be to do introduce a variable like
GIT_YES_REALLY_FOLLOW_LC_VARIABLES=3D1.

> Porcelain such as git-status could be changed, but then there's not
> that much of it anyway. =C2=A0IMHO a set of standard documentation in=
 each
> language would be more useful.

The output of the utilities is what people see when using Git, having
that in your native language is more valuable than some howto being
translated.
