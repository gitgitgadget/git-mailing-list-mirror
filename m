From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Wed, 29 Feb 2012 08:54:13 +0700
Message-ID: <CACsJy8DJM5hwWnTs2rkhCa7a=vKRRsLMjZGBotmDDpAaGG+Sxw@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com> <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 <7v4nua25cz.fsf@alter.siamese.dyndns.org> <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 02:54:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Ykk-0000oI-8a
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 02:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab2B2Byp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 20:54:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56365 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2B2Byo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 20:54:44 -0500
Received: by wgbdr13 with SMTP id dr13so3256107wgb.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 17:54:43 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr44274591wiv.13.1330480483411 (num_hops = 1);
        Tue, 28 Feb 2012 17:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GnYqa6OouWsrBtaKz20Ba7Y3mV+P+1OKpsr6BtKsCeY=;
        b=UkSMsfKjW/D379oLT3TOpLoh6wRuxQih6TO5NMzNbZ2p+9vKxT3gQ+gFXTvKMQqCx9
         u6F2rNwwY3kAlzeVGGSJfYTpjkvOqzfyQ8kMT0jy6IuhfiDoD6vbg409CYVRVrjHT/Eh
         y6ynBkMLO7U+2iNX++4wFF4iKnnP29F5QE8sI=
Received: by 10.180.74.177 with SMTP id u17mr35146943wiv.13.1330480483320;
 Tue, 28 Feb 2012 17:54:43 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 28 Feb 2012 17:54:13 -0800 (PST)
In-Reply-To: <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191801>

2012/2/29 Junio C Hamano <gitster@pobox.com>:
>> A natural question that may come after reading only the above is if =
"git
>> column" is the only one that has this problem. =C2=A0In other words,=
 is the
>> undesirable behaviour you observed caused by a bug in setup_pager() =
that
>> needs to be fixed, or should it be fixed in "git column"?
>
> Put another way, if there is another git command X that can be used a=
s a
> filter to the output of a git command Y, do you suffer from the same =
issue
> to when you abuse the GIT_PAGER mechanism to pipe the output from Y t=
o X?
> That is a sure sign that the pager mechanism needs improvement (obvio=
usly,
> an alternative answer could be "don't do that then", though).
>
> For example, shortlog is designed to be X for Y=3Dlog, i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git log v1.0.0.. | git shortlog
>
> is a perfectly valid way to use the command. =C2=A0I could imagine th=
at this
> patch may improve the situation if you abuse GIT_PAGER mechanism to
> implement the above pipeline, i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ GIT_PAGER=3D"git -p shortlog" git log v1=
=2E0.0..
>
> Although I never tried it.

It does improve that situation, or at least it stops git from forking
frantically.
--=20
Duy
