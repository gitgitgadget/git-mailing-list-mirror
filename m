From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/ PATCH 2/5] unpack_trees: group errors by type
Date: Thu, 10 Jun 2010 11:21:06 +0200
Message-ID: <AANLkTilDYYsbd548oZjz1dOBP7bqPjnAbGdf3rrHIMCO@mail.gmail.com>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<7v39wwp2ur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:21:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMdx3-00012q-37
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab0FJJVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 05:21:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35355 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758640Ab0FJJVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 05:21:23 -0400
Received: by fxm8 with SMTP id 8so4110920fxm.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KPyaTBMG5h/ZAUZoFv6wlBpTBcVNN4fK3IDNKIzKSvg=;
        b=KRTdf8QHzgEEYTm81//DpNkfn4OAS0AOdulJugYa0dtWaI4ZH1pdx0riCBZQmlOjbF
         psDkAJzkTDaqT6QJ6D+2pIVJhTbxXFg6sLTtMSupmP1g2w4y/j08ysm6EUhqpADONhiP
         pmYMDm6bo3RaQx8H0xLrYKPBKQrXk8u0wEU+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=D5xioH86fkZYlc+PEV3Gc3zELWwOtp7NqiF0nsvdswNw3skMeZxye0U5Qloff376Vh
         lKR0iKorF28sivxBRNADkK6fbUCEQTRzWnF5rAb0tj9axoa1PlspF5UcQdmqn/tZqL+H
         TuQPwvoLNrbt58FR8Uq8VzRM8McQVKcxZc7F0=
Received: by 10.239.170.73 with SMTP id r9mr1363164hbe.101.1276161681148; Thu, 
	10 Jun 2010 02:21:21 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Thu, 10 Jun 2010 02:21:06 -0700 (PDT)
In-Reply-To: <7v39wwp2ur.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KUdRRwssG9rVJP1UvZ911h9Bv84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148846>

Thanks for your comments.

Le 9 juin 2010 18:50, Junio C Hamano <gitster@pobox.com> a =E9crit :
> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>
>> +/*
>> + * Store error messages in an array, each case
>> + * corresponding to a error message type
>> + */
>> +typedef enum {
>> + =A0 =A0 would_overwrite,
>> + =A0 =A0 not_uptodate_file,
>> + =A0 =A0 not_uptodate_dir,
>> + =A0 =A0 would_lose_untracked,
>> + =A0 =A0 would_lose_untracked_removed,
>> + =A0 =A0 sparse_not_uptodate_file
>> +} unpack_trees_error;
>> +#define NB_UNPACK_TREES_ERROR 6
>> +struct rejected_files *unpack_rejects[NB_UNPACK_TREES_ERROR];
>
> You folks seem to like global variables a lot... =A0Isn't there a str=
uct
> passed throughout the callchain in unpack_trees that you can attach t=
his
> information to?
>
At first, I wanted to avoid of having a global variable but I was not
sure if I could add my error structure to an existing structure and I
did not want to overload the callchain with a new parameter.
So now, I attached my structure to struct unpack_trees_options.

I also corrected all the style errors and the following remarks.
Thanks.

> Also "rejected_files" is not as technically correct (there are symlin=
ks)
> as "rejected_paths".
>
> Style: we don't encourage "typedef enum { ... } unpack_trees_error";
> instead we tend to just say "enum unpack_trees_error" both in the
> definition and in the use.
>
>> + =A0 =A0 if (!porcelain) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error(msg,file,action);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>
> Style:
> =A0 =A0 =A0 =A0if (!porcelain)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error(msg, file, action);
>
>> +static void free_rejected_files(unpack_trees_error e)
>> +{
>> + =A0 =A0 while(unpack_rejects[e]->list) {
>
> Style:
> =A0 =A0 =A0 =A0while (unpack_rejects[e]->list) {
>
>> +static void display_error_msgs()
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 int hasPorcelain =3D 0;
>
> Style: we don't encourage camelCase.
>
> Whichever way spelled, "has porcelain?" is puzzling.
>
> Is this about "are we issuing error messages as a Porcelain program, =
or
> are we a plumbing without noisy error messages?" =A0Or is this about =
"have
> we said anything in the loop, and if so finish the message with
> 'Aborting'"? =A0If the former, I would name it after "we are Porcelai=
n";
> if the latter, I would name it after "we said something".
>
>> + =A0 =A0 for (i=3D0; i<NB_UNPACK_TREES_ERROR; i++) {
>
> Style:
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < NB_UNPACK_TREES_ERROR; i++) {
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unpack_rejects[i] && unpack_rejects[i]=
->list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hasPorcelain =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rejected_files_list=
 *f =3D unpack_rejects[i]->list;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *action =3D unpack_re=
jects[i]->action;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *file =3D malloc(unpa=
ck_rejects[i]->size+1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *file =3D '\0';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (f) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(fil=
e,"\t");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(fil=
e,f->file);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(fil=
e,"\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f =3D f->n=
ext;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(unpack_rejects[i]->m=
sg,file,action);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_rejected_files(i);
>
> It feels wrong to malloc() inside the loop (and without freeing, whic=
h is
> worse). =A0At least the code should use strbuf to do something like:
>
> =A0 =A0 =A0 =A0struct strbuf indented =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0for (f =3D unpack_rejects[i]->list; f; f =3D f->next)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addf(&indented, "\t%s\n", f->fi=
le);
> =A0 =A0 =A0 =A0error(..., indented.buf, action);
> =A0 =A0 =A0 =A0strbuf_release(&indented);
>
