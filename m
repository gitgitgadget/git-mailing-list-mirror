From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Fix git rebase --continue to work with touched files
Date: Tue, 27 Jul 2010 10:20:46 +0000
Message-ID: <AANLkTikEAtttvFY-M39eaoiPM600nvfunxBn7DmxHHQv@mail.gmail.com>
References: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhHI-00057Q-Em
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0G0KUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 06:20:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60675 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0G0KUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 06:20:47 -0400
Received: by iwn7 with SMTP id 7so3653398iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kpBNnexadohubZgf6uXjYzOe0QS6i8tjlWoUi1KK2H4=;
        b=j7FJOhHZWVLIos1hXSKcJVKPLypz0awPf8rzHLXJkMfnkhyactAXei0jLhqoG0cEjI
         h4y0RrKqZjg4b5HH/4aPZdAwD7QXE6SjqGWluIJa7BU3ewp8HPwPDe2TBv1PJc+ewoAp
         Le7jAyEX6Jfh3UsfuvxpnDzFZ0QTPGXvloT4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g+lOoKPJEI/I1pE2t35oLuq5ie6s/blCZ8Jfow3ctGuD+NuGNRRpuUWhZZukcKWr1k
         1WHs3NUcPvrEh1THt8yRyVAkuCmq4GhfJd7pfvvOUugdZX3AG1eye+njqKKsvn2khwyG
         kklaAXucY79mgPQ7DvygaquDoJVvxT3+kp+58=
Received: by 10.231.139.195 with SMTP id f3mr8979997ibu.139.1280226046751; 
	Tue, 27 Jul 2010 03:20:46 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 03:20:46 -0700 (PDT)
In-Reply-To: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151926>

On Tue, Jul 27, 2010 at 10:06, David D. Kilzer <ddkilzer@kilzer.net> wr=
ote:
> +test_expect_success 'setup' '
> + =C2=A0 =C2=A0 =C2=A0 echo 1 >F1 &&
> + =C2=A0 =C2=A0 =C2=A0 git add F1 &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "commit: new file F1" &&
> +
> + =C2=A0 =C2=A0 =C2=A0 echo 2 >F2 &&
> + =C2=A0 =C2=A0 =C2=A0 git add F2 &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "commit: new file F2" &&

Use test_commit for these:

    test_commit "commit: new file F1" F1 1 &&
    test_commit "commit: new file F2" F2 2 &&
    ...
