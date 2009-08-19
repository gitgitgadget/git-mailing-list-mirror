From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 16:18:10 +0700
Message-ID: <fcaeb9bf0908190218x487dd7f4y355e411a8cb1f254@mail.gmail.com>
References: <20090819082423.GA18860@atjola.homenet> <vpqljlguqtn.fsf@bauges.imag.fr> 
	<fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com> 
	<20090819091445.GB18860@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdhJY-0004x3-3n
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbZHSJSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 05:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbZHSJSc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:18:32 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:61842 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbZHSJSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 05:18:31 -0400
Received: by yxe5 with SMTP id 5so5256482yxe.33
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WVwcsG+Yx5pqb75Gas5qBUHxOQ2fNTICpo/bfzQWQOc=;
        b=LdCeQ0lBnBkkhtjwtYokLLKeONQTzAYcF59MO5Zj/pchI5uvztDulrGTQROg9fXh1H
         n/bgmQMeV6XB4wuCE7YdjAHC56lzHbPNxcjwwq3bfT/4pAgab5u2YElVbcKNBt6o5uv6
         Y4SHOIYMIyp8VhryHjOlqcomxPAvVtcwj3RQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ohHhB3TlNRRwZoeb30J+RbnBiavKKrL9fgjNZdCuqGRo5yuS9w279H6YG3bgX1Cb2H
         Ybvhdw8Df+ZREaVmEWWWxbFsLLxVAD4T2hBslPmI30lbY6PmXvv9XB999zvgMvCJJ0ZO
         XYRgSn5/fPlMWxqrfCZVYF/b2IC/Z3UWrc+H8=
Received: by 10.101.88.14 with SMTP id q14mr6716983anl.38.1250673511629; Wed, 
	19 Aug 2009 02:18:31 -0700 (PDT)
In-Reply-To: <20090819091445.GB18860@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126524>

2009/8/19 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.08.19 16:04:20 +0700, Nguyen Thai Ngoc Duy wrote:
>> On Wed, Aug 19, 2009 at 3:54 PM, Matthieu Moy<Matthieu.Moy@imag.fr> =
wrote:
>> > Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>> >
>> >> Hi,
>> >>
>> >> ls-files -t seems to always show status H, even if the file was m=
odified
>> >> or deleted, and thus gets shown by -m and -d respectively.
>> >
>> > That's not exactly "always", but I don't know whether it's the des=
ired
>> > behavior:
>> >
>> > /tmp/git$ git st
>> > # On branch master
>> > # Changed but not updated:
>> > # =C2=A0 (use "git add/rm <file>..." to update what will be commit=
ted)
>> > # =C2=A0 (use "git checkout -- <file>..." to discard changes in wo=
rking directory)
>> > #
>> > # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 modified
>> > # =C2=A0 =C2=A0 =C2=A0 deleted: =C2=A0 =C2=A0removed
>> > #
>> > no changes added to commit (use "git add" and/or "git commit -a")
>> > /tmp/git$ git ls-files -t
>> > H modified
>> > H removed
>> > H unmodified
>> > /tmp/git$ git ls-files -t -m
>> > C modified
>> > C removed
>> > /tmp/git$ git ls-files -t -d
>> > R removed
>> > $ git ls-files -t -d -m
>> > C modified
>> > R removed
>> > C removed
>> >
>> > So, you get the C and R flags only when you request explicitely -m=
 and
>> > -d.
>>
>> Let's see how it goes without "-t":
>>
>> pclouds@dektop /tmp/i $ git ls-files
>> modified
>> removed
>> unmodified
>> pclouds@dektop /tmp/i $ git ls-files -m
>> modified
>> removed
>> pclouds@dektop /tmp/i $ git ls-files -d
>> removed
>> pclouds@dektop /tmp/i $ git ls-files -d -m
>> modified
>> removed
>> removed
>>
>> I'd say it's expected behavior.
>
> OK, so -t without _more_ than one of -c, -d, -m, -o, -u, -k simply
> doesn't make much sense, right?

It shows you whether it's a normal entry (marked as "H") or unmerged
entry ("M") as far as I can tell. Junio may give more detail
explanation about this command.
--=20
Duy
