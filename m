From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v3 13/39] i18n: git-sh-setup.sh: mark strings for
 translation
Date: Thu, 2 Jun 2016 14:14:22 +0000
Message-ID: <57503F3E.1090705@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
 <1464799289-7639-14-git-send-email-vascomalmeida@sapo.pt>
 <xmqqvb1sydmu.fsf@gitster.mtv.corp.google.com>
 <xmqqd1o0y7m0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:40:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Tmn-00081V-5n
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 16:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbcFBOji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 10:39:38 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:49537 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161170AbcFBOjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 10:39:36 -0400
Received: (qmail 31811 invoked from network); 2 Jun 2016 14:39:33 -0000
Received: (qmail 6195 invoked from network); 2 Jun 2016 14:39:33 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 2 Jun 2016 14:39:27 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqd1o0y7m0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296203>

=C0s 20:30 de 01-06-2016, Junio C Hamano escreveu:
> Junio C Hamano <gitster@pobox.com> writes:
> Would it allow you to lose the $(git --exec-path) prefix in the new
> dot-source to have this patch before applying your patch?
>=20
> -- >8 --
> Subject: t2300: run git-sh-setup in an environment that better mimics=
 the real life
>=20
> When we run scripted Porcelains, "git" potty has set up the $PATH by
> prepending $GIT_EXEC_PATH, the path given by "git --exec-path=3D$ther=
e
> $cmd", etc. already.  Because of this, scripted Porcelains can
> dot-source shell script library like git-sh-setup with simple dot
> without specifying any path.
>=20
> t2300 however dot-sources git-sh-setup without adjusting $PATH like
> the real "git" potty does.  This has not been a problem so far, but
> once git-sh-setup wants to rely on the $PATH adjustment, just like
> any scripted Porcelains already do, it would become one.  It cannot
> for example dot-source another shell library without specifying the
> full path to it by prefixing $(git --exec-path).
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t2300-cd-to-toplevel.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
> index 9965bc5..cccd7d9 100755
> --- a/t/t2300-cd-to-toplevel.sh
> +++ b/t/t2300-cd-to-toplevel.sh
> @@ -8,7 +8,8 @@ test_cd_to_toplevel () {
>  	test_expect_success $3 "$2" '
>  		(
>  			cd '"'$1'"' &&
> -			. "$(git --exec-path)"/git-sh-setup &&
> +			PATH=3D"$(git --exec-path):$PATH" &&
> +			. git-sh-setup &&
>  			cd_to_toplevel &&
>  			[ "$(pwd -P)" =3D "$TOPLEVEL" ]
>  		)
>=20
Yes, this patch allows to have . git-sh-i18n instead of
=2E "$(git --exec-path)"/git-sh-i18n in git-sh-setup.sh file.
