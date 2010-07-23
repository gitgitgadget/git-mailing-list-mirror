From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] worktree setup: return to original cwd if prefix is 
	set NULL
Date: Fri, 23 Jul 2010 14:38:21 +0000
Message-ID: <AANLkTimkwfetLWynKCGVxMT0ZzHOZQp_iknrohoV8A79@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 16:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJOQ-0002to-4p
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 16:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab0GWOiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 10:38:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62778 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab0GWOiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 10:38:23 -0400
Received: by gxk23 with SMTP id 23so109848gxk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JAxtnI4zb//JBxq2dE5AsTl6QxPgBoer9X+OICM311o=;
        b=ocxcpPF/SJs1iYLKM5M/0/AHMwmn3QxtI/FMaH30Ab6cU4gSbKuwBhNWDA8aAbfyC0
         5xf34fE+i3lNuDbk8FEjClY9d0gzAFlqR4BAQh8VwcKDcIY1jEhHspfk2ZI5EpYDFslV
         /xKWf96cwj5giiCuV7GUfLTEBpJOhRXKFMqjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t84ivKpJzf6qzEYfy7hOe+6yKcd+6S6g8Tc+W1Cy0ZWuSw2MyLxhVJLJEUA/fU8XAc
         rZrrZ9MlzEvnL7FVkHs002R2mnYUepvOMQINN7UReBHorn+8ljYOZ1jBFuvSR13L0qAF
         TQZCPCpEOw8yw22D1nh+PhtHiSQnsq5m5bkTE=
Received: by 10.150.63.11 with SMTP id l11mr2863365yba.42.1279895901689; Fri, 
	23 Jul 2010 07:38:21 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 23 Jul 2010 07:38:21 -0700 (PDT)
In-Reply-To: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151535>

2010/7/23 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:

> +test_expect_success 'cwd is unchanged when prefix is NULL (from with=
in a repo)' '
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd repo.git/object=
s &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 1 > one &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp one expected &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 2 >> expected=
 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git apply patch &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp expected =
one &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm one expected pa=
tch
> + =C2=A0 =C2=A0 =C2=A0 )
> +'

Is the rm at the end needed here?

This is a minor nit, but it's generally helpful for debugging tests
that things aren't removed if the --debug option is specified.
