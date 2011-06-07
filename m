From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Tue, 7 Jun 2011 21:32:48 +0200
Message-ID: <BANLkTinoGn-t28DFQCxk+dB+tw1oAjiWng@mail.gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com> <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
 <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com> <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=eC37opWnN4nmC5AP66M+m5nZ86Q@mail.gmail.com> <BANLkTik3ywV91UtLSR_Dydjqg=pva+b0qg@mail.gmail.com>
 <7vhb815tvm.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theo Niessink <theo@taletn.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU228-0002ou-An
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276Ab1FGTdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 15:33:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52812 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab1FGTd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 15:33:29 -0400
Received: by pwi15 with SMTP id 15so30838pwi.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NQWlNZKSSfHZdMTHX+1FRwtKwzC9H9sYdhYTJ2nJeJ8=;
        b=kcIRic9DDYJQAwQTvcXmO+wUVXBUoWFXoi0rJOUtAxUbZ5PxzkEcf0SXG03E04J4NX
         wsrEjxJukaMGBdEsZCTXKRby1NhaQ1KL0h/e44jPWjBCgR3BGSu3luMaOm8WIMJ8Wy3d
         p5Gm2wfVFQZQOqeqqc2zgMlNNKUgNLZDXUJDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Ao4i7DW6s5fhwf039hABcZD67Pf4/RmD60Mr9N4dnJSAPsQOYDYQEtW0GDOv6mb6O6
         PmtNglkCNOzA+R4fa6b8TX8LSnPbUUwew+TRm26amBb8eVl4PhV7wChae6e6rXF5YU67
         Kuu3xTAYmNFZppycSRNRjX2Fhpp0AmFF+XMOI=
Received: by 10.68.24.37 with SMTP id r5mr449905pbf.450.1307475208211; Tue, 07
 Jun 2011 12:33:28 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Tue, 7 Jun 2011 12:32:48 -0700 (PDT)
In-Reply-To: <7vhb815tvm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175257>

On Tue, Jun 7, 2011 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I forgot to ask; do you want me to resend? I would imagine the commi=
t
>> message should be updated to reflect this change as well...
>
> Here is what I queued last night. If it looks Ok then I'll merge it d=
own
> to 'next'.
>
> -- >8 --
> Subject: [PATCH] verify_path(): simplify check at the directory bound=
ary
>
> We simply want to say "At a directory boundary, be careful with a nam=
e
> that begins with a dot, forbid a name that ends with the boundary
> character or has duplicated bounadry characters".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0read-cache.c | =A0 13 +++----------
> =A01 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 31cf0b5..3593291 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -784,16 +784,9 @@ int verify_path(const char *path)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_dir_sep(c)) {
> =A0inside:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (c) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '/': case '\0':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '.':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ver=
ify_dotfile(path))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((c =3D=3D '.' && !v=
erify_dotfile(path)) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_dir_sep(c) |=
| c =3D=3D '\0')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
> =A0 =A0 =A0 =A0}

Looks good to me, thanks for following up on it :)
