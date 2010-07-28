From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in 
	log options.
Date: Wed, 28 Jul 2010 10:11:20 +0000
Message-ID: <AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 12:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3bj-00049q-5E
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0G1KLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:11:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62909 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0G1KLV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 06:11:21 -0400
Received: by gxk23 with SMTP id 23so1616539gxk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ImzBs7ziRQpu2pP3SO9a76nobp924nJfXGKNd7+Y2/Q=;
        b=v4wLmDij+d079EZ3aLVR/WnmE3BM4TBCFfTehk2AJJiCccbPRBKdxEdvONI1nzXZrV
         QFPCkjYV9QZN/PQ+sd//shzTC7BizyPzjo3lpE0bpfdxLzwIfTo+4k2Zvuhk3JNwLzOd
         aCtfoEDkQ2yTJ9VjO6qHjDSlSb9Z1TmAe822o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w5ifRqBVQTvmmHTkFAC7mQZ5TQn9/G0qCw1jqBk7j3hqls4Eb/YfBVl3FnTUNGurEz
         9tDiB9P5t09QYMW+Tw1UjteTVtA08ClP/diMaJ7Hwt6Ixk3Jd5ywfhD/zyhi/ySGDagk
         dKzIPfjKBdvBzEVwzGAM//0vYLRbezL58tbHs=
Received: by 10.101.171.20 with SMTP id y20mr11306055ano.150.1280311880381; 
	Wed, 28 Jul 2010 03:11:20 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 03:11:20 -0700 (PDT)
In-Reply-To: <1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152069>

On Wed, Jul 28, 2010 at 09:41, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:

Here's a better commit message, the subject was >50 chars> (see
Documentation/SubmittingPatches):

    Subject: git-log: Parse detached options like --grep foo

    Change the option parsing logic in revision.c to accept detached fo=
rms
    like `--grep foo' in addition to `--grep=3Dfoo'. The rest of git al=
ready
    accepted this form, but revision.c still used its own option parsin=
g.

> +test_expect_success 'log --grep option parsing' '
> + =C2=A0 =C2=A0 =C2=A0 echo second >expect &&
> + =C2=A0 =C2=A0 =C2=A0 git log -1 --pretty=3D"tformat:%s" --grep sec =
>actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git log -1 --pretty=3D"tformat:=
%s" --grep
> +'

There's a lot of behavior change in this series, but only two small
tests that I can see. It would be easy to change the parsing code back
without triggering a regression test.
