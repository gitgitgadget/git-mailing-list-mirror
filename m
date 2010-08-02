From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Mon, 2 Aug 2010 15:51:29 +0000
Message-ID: <AANLkTik3JQMCoDr==9HV9-sd4Yh7Lta9LmbACByVGpzd@mail.gmail.com>
References: <vpqwrs9nxi5.fsf@bauges.imag.fr>
	<1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Marc Branchaud <marcnarc@xiplink.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 17:51:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfxIg-0000X8-PW
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab0HBPvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 11:51:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44153 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0HBPvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 11:51:31 -0400
Received: by yxg6 with SMTP id 6so1309585yxg.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T7RjKM2pPnDw8bTiNlXArsDSr4Xtw1+i48c8l/TfMaM=;
        b=ITEslGSfdQ0wPmB611h1RAZbz+FXKSAKgMURr3v44I7zr2El3pRQBcxrQei1Zyp8WM
         q8T8BzDAOs54uARYEAIfPHwA87hj1N9FI2X+0IhtnTuAu+MVbKxUHSfR9Pdj5NRgFrWT
         RF6WDxFmYHwnWgoIfe6iC6qjWFgujE35Rl0A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xYtNsHEzLw+go+Qf0ahb4cAMHcqopFN8j1fSqsQFTssYmMaVxnBoHQaRQ5rY4ECvgT
         Tw/DRS2KlYda1BkCIs4g+y6OE+iKXA36anwrNMXvOsqQM2/WFpEE/z1vsJlLwUE3A5Sb
         kHTFD0AwI/H5Iw+2yM5g7EMXBgN8+WcDB9od0=
Received: by 10.101.165.35 with SMTP id s35mr3060706ano.258.1280764290869; 
	Mon, 02 Aug 2010 08:51:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 08:51:29 -0700 (PDT)
In-Reply-To: <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152417>

On Mon, Aug 2, 2010 at 10:03, Matthieu Moy <Matthieu.Moy@imag.fr> wrote=
:

> +use usual shell commands like "cd". The commands are ran from the sa=
me

"are run from the same"

> +directory as "rebase -i" was started (this directory is temporarily
> +re-created if needed).

"was started in"

> +file_must_exist () {
> + =C2=A0 =C2=A0if ! [ -f "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "file $1 not created."
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}
> +
> +file_must_not_exist () {
> + =C2=A0 =C2=A0if [ -f "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "file $1 created while it shouldn't have.=
 $2"
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}
> +
> +dir_must_exist () {
> + =C2=A0 =C2=A0if ! [ -d "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "dir $1 does not exist."
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}
> +
> +dir_must_not_exist () {
> + =C2=A0 =C2=A0if [ -d "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "dir $1 exists while it shouldn't. $2"
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}

Leftover debugging code? Looks useful, but probably something we
should have in test-lib.sh as "git_test" as a wrapper for the "test"
built-in.
