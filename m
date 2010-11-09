From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 10:49:31 +0100
Message-ID: <AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
	<4CD918AB.6060206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 10:49:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFkpq-0004eX-8B
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 10:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab0KIJtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 04:49:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60280 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab0KIJtd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 04:49:33 -0500
Received: by fxm16 with SMTP id 16so4780222fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 01:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UxU1QDX1uRHS8g3XFEd9f4Dqea8cxOvSRsws1L4CQ5k=;
        b=o3FasluZpHL+/FXuEmGNZIkmrxP5gHprKn1Rp++R74JlA+WxQXALFABa6xG/RxL9Id
         gyepE+4YHUuaof2gKvhSTyTwxtzbdfSTiXvwgPZJMVtKPIw6gxBTUxgFL5iir5mJM666
         PrO3sVYzwIrEN/Xqo8gRrihUz7frycaOUFcKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yEnI7enwFX072Ztn0+VhbDekiEllDOLbQNP27PZUm799/min9SM/x2wgeOVdYDRllB
         ZM10bBgYc2+KWTl7gfV2TtrYqwLzXr4rsvPyvKjFAm4zpKSLlD7f8iZiCYB1GQAZnk7k
         mnCuMQFrDXG9j4zxvvIISuxcJOxUy8mFHn3gI=
Received: by 10.223.83.138 with SMTP id f10mr4954612fal.114.1289296171430;
 Tue, 09 Nov 2010 01:49:31 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 01:49:31 -0800 (PST)
In-Reply-To: <4CD918AB.6060206@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161028>

On Tue, Nov 9, 2010 at 10:47, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/9/2010 10:35, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Why is that a "*must*"?
> ...
>> But maybe you have reason to think otherwise? I haven't noticed any
>> noticable slowdowns from doing it this way, but maybe I've been
>> looking at the wrong thing.
>
> You didn't do your timings in Windows, did you? Every fork() that you=
 can
> avoid is a win.

What's the result of timing it on Windows?
