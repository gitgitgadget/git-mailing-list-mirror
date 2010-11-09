From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 14:02:29 +0100
Message-ID: <AANLkTi=s+UQ3isK9eEKLM7k=BvxV7cTKdD6Bi=ipG0yS@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
	<4CD918AB.6060206@viscovery.net>
	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
	<4CD9241F.6070807@viscovery.net>
	<AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
	<4CD933BF.6070105@viscovery.net>
	<AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>
	<4CD93CF2.2060800@viscovery.net>
	<AANLkTiny+NmXew6UxjNMO+o75=CxxWm9iVRMRxs0LyTJ@mail.gmail.com>
	<4CD94449.1040201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 14:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnqQ-00024h-5m
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 14:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab0KINCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 08:02:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33451 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0KINCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 08:02:30 -0500
Received: by fxm16 with SMTP id 16so4892075fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vR3t0kpTKPZOE+gf9J85I6kfBh2fYaZfqR4oaCoVsYw=;
        b=ev+JR4UQEIGg1IbCZ3eaKaU7dEhSbf3nqi9/4KeYwcarkrU6sfHgBf3Zy+QWwSfSHu
         YNN0gMGgVp6t+EbfgtfJ6QBYbfPYb6s2UIg8CKh1UFVfb8pfRAARfNxJ0CU5OV14TfIn
         MGdFEGXWeq8ZTHneKjUc1q64nKQ0lWl9lRLws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FbhfH75O9Wxr9Npw30zu7JV7I62tXpO3MrL01VxK0Pz7HD4uYjLbo6bb744m2hqf//
         sc5L5CrlfVO8Kh0DeFI4qAfVoKx2Nz9jwtQauc0yfXdiwpOFOx5buAgPUe68O+sSCpy+
         Ytg3C6Y6Xj+ASQGtYcCIpOCVsvO/D1RBnHe8c=
Received: by 10.223.71.199 with SMTP id i7mr5174782faj.57.1289307749189; Tue,
 09 Nov 2010 05:02:29 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 05:02:29 -0800 (PST)
In-Reply-To: <4CD94449.1040201@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161045>

On Tue, Nov 9, 2010 at 13:53, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/9/2010 13:38, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> I understood your previous comments to mean that the invocation time
>> of git-* on one hand and cat(1) on the other hand had to do with how
>> many DLL's the former needed.
>
> I was only guessing; I can't explain the timing difference.
>
>> Since git-sh-i18n--envsubst needs the same DLL's (i.e. the libc) as
>> cat(1) and *nothing else* it should be as fast as cat(1) and not as
>> slow as git-*(1) once I fix that unfortunate Makefile bug, right?
>
> Wrong. Please accept it as a fact (and I'll forgive your ignorance ;)=
 I
> would like to spend the time explaining the reasons only if you want =
to
> compile git on Windows yourself.

I'd usually check out things like these myself in a virtual machine,
but in this case I'd have to fork over a significant amount of cash
just to get a test environment on a system I'm not going to use.

I'd have the same issue if someone pointed out an issue with the
series on e.g. AIX, HP/UX etc.

Anyway, I don't see any sensible reason for why a Unix utility like
cat(1) would be fast but a utility of ours that does similar things /
links to the same libraries (and no more) wouldn't be.
