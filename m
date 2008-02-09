From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] http.c: guard config parser from value=NULL
Date: Sat, 9 Feb 2008 18:46:26 +0100
Message-ID: <200802091846.26708.chriscool@tuxfamily.org>
References: <5d46db230802081639n78aab3b2s1e83ab9c4afc6a38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNthP-00065s-R3
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbYBIRkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 12:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbYBIRka
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:40:30 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35516 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347AbYBIRk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 12:40:29 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 526F51AB334;
	Sat,  9 Feb 2008 18:40:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 17F7A1AB2B9;
	Sat,  9 Feb 2008 18:40:27 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <5d46db230802081639n78aab3b2s1e83ab9c4afc6a38@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73248>

Le samedi 9 f=E9vrier 2008, Govind Salinas a =E9crit :
> Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
> ---
>  http.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index d2c11ae..0a2c1c8 100644
> --- a/http.c
> +++ b/http.c
> @@ -92,6 +92,9 @@ static void process_curl_messages(void)
>
>  static int http_options(const char *var, const char *value)
>  {
> +	if (!value)
> +		return git_default_config(var, value);
> +
>  	if (!strcmp("http.sslverify", var)) {
>  		if (curl_ssl_verify =3D=3D -1) {
>  			curl_ssl_verify =3D git_config_bool(var, value);

After a very quick look at this, it seems that no change is needed here=
=20
because 'git_config_bool' handles a NULL value correctly. Some changes =
may=20
be needed below though.

Thanks,
Christian.
