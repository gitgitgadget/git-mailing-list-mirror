From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 19:16:27 +0700
Message-ID: <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com> <20101111103742.GA16422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 13:16:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGW5H-0003yp-Nj
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab0KKMQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 07:16:50 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40591 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab0KKMQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 07:16:49 -0500
Received: by wwb29 with SMTP id 29so54356wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZDYs9B2OU2uD9ojDfO/eX9Vw0jlLljiF6g9IiC8SUl0=;
        b=TltZbDrdBqTJemJkeKpNhnDgdQpAwm+beEJYxv/neq3lo/mRr/l8ilaOPVP4V88wHy
         Mv9Y/gZKU29vneizh8IEabFz5iE/dpk65xHFBSPmjLwj8/l5Ohg9tnhsJMKbEQG+pwk/
         I640sclAaFYdH1GA/vAXCverRF0E4n9vGlbKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mhakcdZ6wi2+Z67Ho5lfKzWna1FGamwngXJHO/b940gVm4Ud6eXHh0++w/xLiPiYxw
         fCcBCqDk0q9XqYIvEuHFXrxsIMrfXBiZS4VyXUXM7Rq5cYwqQLejWkv1CPkHA5U98KwZ
         B0A+jlie5KMvnFFkQp6Uv2QjdOPau1NhZKNTE=
Received: by 10.216.47.19 with SMTP id s19mr2291965web.56.1289477807661; Thu,
 11 Nov 2010 04:16:47 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 04:16:27 -0800 (PST)
In-Reply-To: <20101111103742.GA16422@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161230>

On Thu, Nov 11, 2010 at 5:37 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Dun Peal wrote:
>
>> =C2=A0 $ python -c "import os; os.popen('git clone git@git.domain.co=
m:repos/repo.git')"
>> =C2=A0 [...]
>> =C2=A0 $ cat repo/.git/config
>> =C2=A0 [branch "master"]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote =3D origin
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge =3D refs/heads/master
>
> It looks like you've probably figured it out already, but for
> completeness:
>
> Most likely the clone is terminating when Python exits, perhaps due t=
o
> SIGPIPE. =C2=A0It doesn't look like a bug to me; I suspect you meant =
to use
> os.system(), which is synchronous, instead. =C2=A0You might be able t=
o get
> a better sense of what happened with GIT_TRACE=3D1 or strace.

If "git clone" is terminated before it completes, shouldn't it clean
the uncompleted repo?
--=20
Duy
