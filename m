From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 12:25:21 -0500
Message-ID: <AANLkTikNHJtWpZuZDKHrUDeGTqqEj-tzR2UbNXp98FOd@mail.gmail.com>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com> <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 18:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppl8j-0000Dv-BA
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 18:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1BPR0D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 12:26:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64669 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab1BPR0C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 12:26:02 -0500
Received: by iyj8 with SMTP id 8so1437319iyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=7Naq17PoKg4KqQv+XIKUi++cvhnkFqdpbml/rzpLelg=;
        b=Ws0rOnjIDY+L80JwvHoVXdeCh0rTUH0M/pQ1CyWuzeILEvTcn/opDh5LT43qz+HI2F
         6nSJT5hDlmvYqjQPmYTjqhtgBb1D6RhY+jBm4ebNDAQNv0dMZPhf8JrUpD+dyeRN36hl
         RnFidGxQjQbfOzXSwIeu3gv8wbPsUF/If21YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sPLaVeY1xtTpx0HiU0I2UYzjV+8j1+mzcyaMD5Vow3NXp7XU91yAprp9H4lYrtcaSX
         GSIfifS6gqf0Eth31GOyXUarL6j8r7paig3ANRQdiYoeR/TT397CrnZiEAmqu1UTv7C4
         LAL+ZdtltwlZkls/BHmcukDmzJem78zfsCdjc=
Received: by 10.42.230.74 with SMTP id jl10mr1278858icb.177.1297877161229;
 Wed, 16 Feb 2011 09:26:01 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 09:25:21 -0800 (PST)
In-Reply-To: <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166979>

On Wed, Feb 16, 2011 at 12:20 PM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> @@ -263,6 +279,11 @@ static void print_advice(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msg) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr=
, "%s\n", msg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* rebase int=
eractive takes care of the authorship
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* when the u=
ser invokes rebase --continue
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlink(git_path("C=
HERRY_PICK_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>

Oops, I amended the comment and then fed the wrong commit to
format-patch. That should be:

@@ -263,6 +279,11 @@ static void print_advice(void)

        if (msg) {
                fprintf(stderr, "%s\n", msg);
+               /*
+                * we're in the middle of an interactive rebase, we
+                * don't want it to look like we're cherry-picking.
+                */
+               unlink(git_path("CHERRY_PICK_HEAD"));
                return;
        }

Let me know if you want me to resend. (Sorry.)

j.
