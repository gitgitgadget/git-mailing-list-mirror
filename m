From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [PATCH 2/5 v2] unpack_trees: group errors by type
Date: Tue, 15 Jun 2010 15:40:16 +0200
Message-ID: <AANLkTilPJRAqT4LUF4ps9YtK3bFwZiVTVXa6_xigdkTg@mail.gmail.com>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<vpqljagzc39.fsf@bauges.imag.fr> <AANLkTin381eyaDabz3-z_8jB05N4CVKGmLOqVOprJMW2@mail.gmail.com> 
	<vpq7hm0whkk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:40:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOWNa-0003bF-LA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab0FONkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 09:40:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64305 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0FONkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 09:40:33 -0400
Received: by fxm10 with SMTP id 10so147549fxm.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=PfuV+dNegd5zzO8rv9XDqheIDD9c32bncne0PalQ9uo=;
        b=P+IatBErh4qlMMMO+ekui8VZiLUMl25F1k677Rk/9TCOWi6rHQa6qTPK8KJnUl6GFs
         2MGf9fJ4us5XdvfHz+NbyURFNGStBKLkqyQZtOBe2FY9V+kAKEx+HhOBuFoAwlY69V6Y
         OIM7BJDIJlLGm+5I0SarEl9xdc4a4uVmHNuTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=pQGCwRKyGTGPCDgcILglooYL/7+5xIhaDDEn9Be3cuSTW0LtJlJlJ4wez15zX4Rl93
         ZODMRsnpKyCRfl+P7KBEoDQyDXPht3z6hIdgJ7poso+FEUjVucrVxPXoOrO1D2bn/sx1
         6RQRFwXgbXd5GqnY6zdpo5DANYUCWxZRWQx0w=
Received: by 10.239.183.84 with SMTP id t20mr508548hbg.54.1276609231470; Tue, 
	15 Jun 2010 06:40:31 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Tue, 15 Jun 2010 06:40:16 -0700 (PDT)
In-Reply-To: <vpq7hm0whkk.fsf@bauges.imag.fr>
X-Google-Sender-Auth: 83xNoRlC5kpztzR_ZRyAsKYP-ew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149186>

Le 15 juin 2010 15:28, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =E9=
crit :
> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>
>> In display_error_msgs(), I cannot access o->msg because I would not
>> know which error I am treating.
>
> You do:
>
> static void display_error_msgs(struct unpack_trees_options *o)
> {
> ...
> =A0 =A0 =A0 =A0for (i =3D 0; i < NB_UNPACK_TREES_ERROR; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0}
>
> You know "i", so you know which error it is. The difficulty is that
> the rejected paths are in an array, while the error messages are in a
> struct, but you can either:
>
> * Turn the struct into an array, and say msgs[would_overwrite] instea=
d
> =A0of msgs.would_overwrite (which would also simplify the code
> =A0elsewhere since you would be able to write "ERRORMSG(o, error)" an=
d
> =A0such things).
>
> * Do
>
> switch (i) {
> case would_overwrite:
> =A0 =A0 =A0 =A0msg =3D o->msg.would_overwrite;
> =A0 =A0 =A0 =A0break;
> case not_uptodate_file:
> =A0 =A0 =A0 =A0msg =3D o->msg.not_uptodate_file;
> =A0 =A0 =A0 =A0break;
> case not_uptodate_dir:
> =A0 =A0 =A0 =A0msg =3D o->msg.not_uptodate_dir;
> =A0 =A0 =A0 =A0break;
> case would_lose_untracked_overwritten:
> =A0 =A0 =A0 =A0msg =3D o->msg.would_lose_untracked_overwritten;
> =A0 =A0 =A0 =A0break;
> case would_lose_untracked_removed:
> =A0 =A0 =A0 =A0msg =3D o->msg.would_lose_untracked_removed;
> =A0 =A0 =A0 =A0break;
> case sparse_not_uptodate_file:
> =A0 =A0 =A0 =A0msg =3D o->msg.sparse_not_uptodate_file;
> =A0 =A0 =A0 =A0break;
> }
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
Thanks for your answers.
I did the switch case at first but thought it was maybe a bit
repetitive. That is why, I opted for giving directly the message in
add_rejected_path().

Otherwise, I do agree an array would make things easier, especially
for my patch. Does anyone has an objection into changing the struct
unpack_trees_error_msgs into an array?
