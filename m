From: Alexander Rinass <alex@fournova.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Wed, 6 Apr 2016 08:51:28 +0200
Message-ID: <C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com> <1459802325-22056-2-git-send-email-alex@fournova.com> <xmqqzit80yov.fsf@gitster.mtv.corp.google.com> <57040EE0.40503@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:51:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhJO-0000FN-CD
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbcDFGvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 02:51:24 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37077 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbcDFGvX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2016 02:51:23 -0400
Received: by mail-wm0-f50.google.com with SMTP id n3so49167965wmn.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uamenltZt5Lwzy3U8XhD1ULAY/yEzQZ55kXSwljx5RY=;
        b=CQ878Kw3jIakRdbZMW+O7EHrjmLMYxVDe1N8cuOgCy7oYbROeJn/l3aAzhkajsClpG
         QEDL7yva4GI/3Hl0diGqDexqelH/IRPX2O7s9MCCXJqFdw5TvcffAa1igMXRR2/cBd4+
         2oQUeT2PatPy5ySgnu3fh/ANhX+paDMMtoXYVW2tfLgIStgON6M6o6i9ekD8FP4pssop
         aKb9rTDg14uH8+QkZTmRy5xry7jPjNSu4vOPnZxgXzY6cNl8xcw11l++6d30eS+QNt4C
         JITJe0EltBOirr+PuTYZmL/s10fw/8KixXWectbgVGt2boEvDC6AWU2OC0prV4M62fEe
         hhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uamenltZt5Lwzy3U8XhD1ULAY/yEzQZ55kXSwljx5RY=;
        b=HCrq5CsxZbqnANfWMUpJ1aKn9jcaeOXXtSYQEPJD7o+gmZBnFIg5mOQWlokdghl5/9
         FezPJuhfbiVpMNV1+U5dU2YeK/R3DeEO6xcuZxUI8+XxTdcr83dSmYcSy+VZZyajVyoq
         V3kWH5u5YIavgTqvRiD4sVpiy1vIw0rD/QUIKtDJebsEWHqppVeY/3snQkhourjhSVhw
         LUI+sSJm5ZJafVPd0Y1IdM1a+O1E5/r0z7jkiOkv614MWnjDiONys+3f8ZqWG0erGIAr
         xtUczh9svhYd7HAXch8BrUkQR3Gi4UIlYJbK+MwQ0pgI1vdfAvwPzkUN1UyVYADgL4Lk
         Ap3A==
X-Gm-Message-State: AD7BkJKt5L8rgNtOy9otMQhjIqsTBG6fzVsGn0m1bmH2Z3A3tBGcMUkuiBZFwBCf44gxog==
X-Received: by 10.194.133.161 with SMTP id pd1mr11606355wjb.66.1459925482203;
        Tue, 05 Apr 2016 23:51:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:df42:8b00:595b:e4d9:364e:188f? ([2a02:908:df42:8b00:595b:e4d9:364e:188f])
        by smtp.gmail.com with ESMTPSA id w202sm1971316wmw.18.2016.04.05.23.51.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 23:51:21 -0700 (PDT)
In-Reply-To: <57040EE0.40503@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290828>


> On 05 Apr 2016, at 21:15, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
>=20
> I sense NFD disease: The combining diaresis should combine with the o=
, not the g. Here is a correct line to copy-and-paste if you like:
>=20
> Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> -- Hannes

Thanks for reviewing and catching the NFD encoding error.

I will send in a patch v2 with the correct NFC encoding.

Would you also like me to alter the commit message as mentioned by Juni=
o?

I could rewrite the sentence:

=E2=80=9CAs a result, no diff is displayed when feeding such a file pat=
h to the
diff command.=E2=80=9D

into simply saying:

=E2=80=9CAs a result, no diff is displayed.=E2=80=9D

However, I don't read the original message as it would imply that only
file paths are affected by the precompose_argv call.=20

Are there other suggestions on improving the commit message?
