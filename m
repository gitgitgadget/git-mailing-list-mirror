From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/PATCH 3/4] textconv: support for blame
Date: Fri, 4 Jun 2010 12:34:25 +0200
Message-ID: <AANLkTinfYAFAX4Hcl9lZMspju_Yk5eGll2S-z9HPdkjh@mail.gmail.com>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr> 
	<7veign5oc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 12:34:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKUEr-0005Dv-Hy
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 12:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab0FDKeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 06:34:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52096 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0FDKes convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 06:34:48 -0400
Received: by fxm8 with SMTP id 8so679078fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=5gEnFOKRWvP8N05HjzAEZyl0TUuIDdfJO0YFOlzNbdE=;
        b=fAG1xxvgos8dDwFWC1qFqCb1esDXXAbYIpS9HdMMo5cUMqOP59668f+hbYM0HqNEIY
         NXJxbuG8ucWjI8p/equKN/mZsB2ZsS7okHS1Y5i/d6Z6JUCebqsYu30nxN3o/aJZEkFb
         yy94bM1iyLGr+I+s+YMBxRkGNhCkib7iYqqZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=eNYjMv+pZkBWb03+5ZdZtX9qWaF3axgc2Pm271a4wkA3mK8tEUZwMRrf5qZJibm8sV
         66TVgF2jZM/4X/OysseDwmpXtQkMRUqHdj+fZxCo02kdN+hJpp9BDyOpL5mDHlKcSy6o
         fbYA00E/hiPFJCyEZiDuYnP//FUSB6+vtMrsU=
Received: by 10.239.183.146 with SMTP id u18mr769810hbg.163.1275647686782; 
	Fri, 04 Jun 2010 03:34:46 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Fri, 4 Jun 2010 03:34:25 -0700 (PDT)
In-Reply-To: <7veign5oc9.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: pO_j6i9z7wGC2JO1M8ObeDHMxd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148397>

Le 4 juin 2010 08:00, Junio C Hamano <gitster@pobox.com> a =E9crit :
> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>
>> @@ -2033,10 +2072,13 @@ static struct commit *fake_working_tree_comm=
it(struct diff_options opt,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_from =3D path;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D canon_mode(st.st_mode);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (st.st_mode & S_IFMT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case S_IFREG:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strbuf_read_file(&buf,=
 read_from, st.st_size) !=3D st.st_size)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno(=
"cannot open or read '%s'", read_from);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!DIFF_OPT_TST(&opt, AL=
LOW_TEXTCONV) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !textconv_object(r=
ead_from, null_sha1, mode, &buf))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strbuf=
_read_file(&buf, read_from, st.st_size) !=3D st.st_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 die_errno("cannot open or read '%s'", read_from);
>
> This is just a style thing but it would probably be easier to read if=
 you
> structured it like:
>
> =A0 =A0 =A0 =A0if (! we are allowed to use textconv ||
> =A0 =A0 =A0 =A0 =A0 =A0do textconv and we did get the converted data =
in the buffer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0; /* happy */
> =A0 =A0 =A0 =A0else if (! successfully read the blob into buffer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die;
>

We changed the structure, we now have something like:

case S_IFREG:
	if (DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) &&
	    textconv_object(read_from, null_sha1, mode, &buf))
		;
	else if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_size=
)
		die_errno("cannot open or read '%s'", read_from);
break;

> By the way, can't textconv_object() ever fail? =A0I see the function =
has its
> own die()

I don't really see which die you are talking about, there is no direct
die in textconv_object().

> but it looks a bit funny to see one branch of an "if" statement
> calls a function that lets the caller decide to die while the functio=
n
> called by the other branch unconditionally dies on failure at the API
> design level.
>

The function fill_textconv() called by textconv_object() can fail if
there is a problem during the textconv conversion. But
textconv_object() tests before if we have to and if we can peform a
conversion.
We did not add some die but only let the existing die.

> An alternative would be to encapsulate the whole of the above logic i=
n one
> helper function perhaps.
>
>> @@ -2249,8 +2291,10 @@ int cmd_blame(int argc, const char **argv, co=
nst char *prefix)
>> =A0 =A0 =A0 int cmd_is_annotate =3D !strcmp(argv[0], "annotate");
>>
>> =A0 =A0 =A0 git_config(git_blame_config, NULL);
>> + =A0 =A0 git_config(git_diff_ui_config, NULL);
>
> What configuration are we pulling into the system with this call? =A0=
Would
> they ever affect the internal diff machinery in a negative way? =A0I =
am
> especially wondering about "diff.renames" here.
>

Actually, we call git_diff_ui_config in order to get the drivers. But
we could call a more specific configuration.
Here are others solutions:
1) We could add:

switch (userdiff_config(var, value)) {
	case 0: break;
	case -1: return -1;
	default: return 0;
}
to git_blame_config

2) We could call
git_config(git_diff_basic_config, NULL);
or git_config((config_fn_t)userdiff_config, NULL);
instead of git_config(git_diff_ui_config, NULL);

>> =A0 =A0 =A0 init_revisions(&revs, NULL);
>> =A0 =A0 =A0 revs.date_mode =3D blame_date_mode;
>> + =A0 =A0 DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
>
> As an RFC patch, I would have preferred if we didn't have this line t=
o
> force --textconv on by default, but instead you merely allowed the
> mechanism to be used by giving the option explicitly from the command
> line.
>
> Other than these points, the series looked quite sane to me.
>

Thanks a lot for your time and comments.
