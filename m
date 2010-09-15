From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Thu, 16 Sep 2010 09:29:58 +1000
Message-ID: <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
	<7v62y661pl.fsf@alter.siamese.dyndns.org>
	<AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1QV-0004pz-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab0IOXaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 19:30:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33747 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab0IOX37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:29:59 -0400
Received: by wyf22 with SMTP id 22so790731wyf.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D0sHSgqjr7qwFg4bZIo9iOFvor6UNho1So4tng54xTU=;
        b=j4KrUqxGQTmp5tdsQbammmGv1k1MHZllpz7Q4nOd8p5eby5yNj6TftHmXaxTAAIk4r
         Zt5t9liyUxSMaT4drxAzTSNXvoKkMWDMnuwVLGTEiM7eEewiBXJ1/vRtSH8WG4ed97D4
         SDd04JnViELdIMkt2faPar9Wurw9Gmfufn1ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NbLgnC13Kxj/koK9EfkXPnLKdqL3g3LM22hitt+UogJCkGbSvyfGIvl+WezqnA7uEM
         Hmj4qublo05d8iUs0pqv+BCgcFsNPuXj95w+yro0YVVv/ra8I+vznNWWtIpk3nwjZgI3
         JlY5Nk9dYRzh3DOm3IukHQ5gOPK/NdIUlw60c=
Received: by 10.227.135.15 with SMTP id l15mr1895106wbt.203.1284593398062;
 Wed, 15 Sep 2010 16:29:58 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Wed, 15 Sep 2010 16:29:58 -0700 (PDT)
In-Reply-To: <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156274>

On Thu, Sep 16, 2010 at 9:19 AM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Wed, Sep 15, 2010 at 7:12 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Am I missing something really obvious here?
>>>
>>> kore:~/Repos/git (master)$ git ls-files | wc -l
>>> =C2=A0 =C2=A0 2009
>>
>> You asked it to show the cached paths (default). =C2=A0Your project =
currently
>> tracks 2009 paths in the index.
>
> Correct.
>
>>> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
>>> =C2=A0 =C2=A0 2009
>>
>> You told that '*' is the exclude pattern for carrying out some opera=
tion,
>> but you didn't tell what operation you want. =C2=A0You are shown the=
 cached
>> paths (default).
>
> I want cached paths, minus the exclude pattern. Using -c -x \* gives
> the same result.
>
> There is no indication in the man page that -x doesn't apply to -c.
>
>>> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
>>> =C2=A0 =C2=A0 2009
>>
>> You told that '*' is the exclude pattern, you want only paths that m=
atch
>> the exclude pattern, and chose to show files in the index (which aga=
in is
>> the default) by not saying -o.
>>
>> I've never found -i useful myself (actually I don't find many option=
s the
>> command has very useful anymore), but the above is how I read the ls=
-files
>> manual page.
>
> I don't care about -i myself, and maybe I should have been clearer.
> AFAICT, [-c] -x is broken:
>
> $ git ls-files -c -x \* |wc -l
> =C2=A0 =C2=A02009
>
> =C2=A0 =C2=A0 =C2=A0 -c, --cached
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Show cached files in the output (d=
efault)
>
> =C2=A0 =C2=A0 =C2=A0 -x <pattern>, --exclude=3D<pattern>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Skips files matching pattern. Note=
 that pattern is a shell
> wildcard pattern.
>
> Oh, geez, here it is lower down in the man page:
>
> =C2=A0git ls-files can use a list of "exclude patterns" when traversi=
ng
> the directory tree and finding files to show when the flags --others
> or --ignored are specified. gitignore(5) specifies the format of
> exclude patterns.
>
> Bah, what use is that? Minimally ls-files shouldn't accept -x unless
> given either --ignored or --others if that's all it applies to. I
> guess this is my itch to scratch.

I sense another use of negative pathspecs here..
--=20
Duy
