From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 02/22] i18n: advice: mark string about detached head
 for translation
Date: Mon, 30 May 2016 11:03:42 +0000
Message-ID: <574C1E0E.6040808@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-3-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 13:03:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KzE-0001hB-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 13:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbcE3LDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 07:03:52 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:55403 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754403AbcE3LDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 07:03:51 -0400
Received: (qmail 1413 invoked from network); 30 May 2016 11:03:48 -0000
Received: (qmail 3400 invoked from network); 30 May 2016 11:03:48 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 30 May 2016 11:03:43 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <1464031661-18988-3-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295886>

=C0s 19:27 de 23-05-2016, Vasco Almeida escreveu:
> Mark string with advice seen by the user when in detached head.
>=20
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  advice.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/advice.c b/advice.c
> index 4dc5cf1..703a847 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -107,13 +107,13 @@ void NORETURN die_conclude_merge(void)
>  void detach_advice(const char *new_name)
>  {
>  	const char fmt[] =3D
> -	"Note: checking out '%s'.\n\n"
> +	N_("Note: checking out '%s'.\n\n"
>  	"You are in 'detached HEAD' state. You can look around, make experi=
mental\n"
>  	"changes and commit them, and you can discard any commits you make =
in this\n"
>  	"state without impacting any branches by performing another checkou=
t.\n\n"
>  	"If you want to create a new branch to retain commits you create, y=
ou may\n"
>  	"do so (now or later) by using -b with the checkout command again. =
Example:\n\n"
> -	"  git checkout -b <new-branch-name>\n\n";
> +	"  git checkout -b <new-branch-name>\n\n");
> =20
>  	fprintf(stderr, fmt, new_name);
>  }
>=20
I just realized this does nothing but letting xgettext extract the
string. Does not allow interpolating the actual translation. Hence, the
translator would translate this text but the translation would never be
used.

There are 2 solutions: 1) use const char *fmt =3D _("...") instead
2) still use N_() like this patch but do fprintf(stderr, _(fmt),
new_name); to trigger retrieving the translation when printing the mess=
age.

Option 1) it most common on git source and 2) is used primarily during
command line option parse (see usage_with_options_internal() in
parse-options.c).

I prefer the solution 1) and I'll choose it if there are no objections.
