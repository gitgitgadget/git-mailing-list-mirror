From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Tue, 16 Nov 2010 07:46:57 +0100
Message-ID: <AANLkTinZVw4aB3VVxrELQgdaLZyCLzpeWgMTkxwVY+Mt@mail.gmail.com>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
	<7vaalajkiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 07:47:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIFJp-0006Uz-UD
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 07:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218Ab0KPGq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Nov 2010 01:46:59 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48720 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278Ab0KPGq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 01:46:59 -0500
Received: by iwn35 with SMTP id 35so430576iwn.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C5DfvSoI2a1pQDrSwJ37HlxRBT8jW7CM73mJzPEOcQU=;
        b=gaT+6oRU8t3ss84s5GO+BLJWl3XpueZRrq/AuZmM1ra+4x5auUG+3PVx8auyAsHnvh
         DQKiE7QecYDensKUQ5F7hUBaShWQHhSJ9AbLP2ndwikRly8wUi6FnioXtaD1SgHzvgiq
         bllGOM9ln3fKWVeks56Igg9Hl3IWp/MHJplvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LYU6kFYadW9BEzBAZ9w/xDeYno2NCeQRN73BFE4qg3N/9QNurWsgJ9m3Rk/scnHcn2
         Y6/mFP3VT4h4DPB4YGpUM4u/7M1wZChOZBJnpyYpl380Vnhr5BZRTfx7a6ABAsT1K9e1
         KoE4A54S3NIwSG/I0Na4c3paqpXlGmi0ObMuQ=
Received: by 10.42.210.71 with SMTP id gj7mr1596158icb.307.1289890017557; Mon,
 15 Nov 2010 22:46:57 -0800 (PST)
Received: by 10.42.165.202 with HTTP; Mon, 15 Nov 2010 22:46:57 -0800 (PST)
In-Reply-To: <7vaalajkiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161544>

On Mon, Nov 15, 2010 at 23:21, Junio C Hamano <gitster@pobox.com> wrote=
:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a417bdf..3088322 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -613,7 +613,10 @@ test_line_count () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test $# !=3D 3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error "bug in =
the test script: not 3 parameters to test_line_count"
> - =C2=A0 =C2=A0 =C2=A0 elif ! test $(wc -l <"$3") "$1" "$2"
> + =C2=A0 =C2=A0 =C2=A0 elif =C2=A0 =C2=A0case "$3" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !*) =C2=A0 =C2=A0 =
! test $( eval "${3#!}" | wc -l ) "$1" "$2" ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 =C2=
=A0! test $( wc -l <"$3" ) "$1" "$2" ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "test_lin=
e_count: line count for $3 !$1 $2"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cat "$3"

This line will fail for the !* case.

Bert
