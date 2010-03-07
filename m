From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCHv2 2/3] grep: Colorize filename, line number, and separator
Date: Sun, 7 Mar 2010 15:47:00 -0500
Message-ID: <ca433831003071247j489177ceke9c3394fdc6d2372@mail.gmail.com>
References: <1267980767-12617-1-git-send-email-lodatom@gmail.com> 
	<1267980767-12617-3-git-send-email-lodatom@gmail.com> <7v1vfwrm51.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 21:52:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoNSv-0003fE-Rm
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 21:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab0CGUwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 15:52:41 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44401 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0CGUwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 15:52:40 -0500
Received: by gyh3 with SMTP id 3so543506gyh.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=azJDyEsQ+gdjRpWVZ+Cpckjp+6mO12JMTOAtKrkA0Vc=;
        b=gs597ZtSduE1p4zHbBdrU15qW5HGonvVtWJvzI6YSeFoD1/2boN2OjXzvlT+DVbKmR
         N40l5xEff2idKEWogOQuCyUDiY+1Z8fXFr7EqjosgeEWjgkCZ00Gxze03ucYj5ZpDMmi
         zCb9ZCit1iBDz1C7TFz3tu6tegPjuYzo6zmKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DmzgknTuBTOTTNvgZCSb8JOpCOA7xhjbAAg7DiPGXko1IC81YdyzlsDjspUVcYUGo9
         BkZNI6vU1bYv0GhuM05mHMnVqjPSvgWArXsxoJallfXC8WSojwnmfIqBegjupMzDdd8l
         KLlvpu4LUA0LU31NfAvG392R1558mnydZH3so=
Received: by 10.91.174.2 with SMTP id b2mr4406170agp.51.1267994840110; Sun, 07 
	Mar 2010 12:47:20 -0800 (PST)
In-Reply-To: <7v1vfwrm51.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141730>

On Sun, Mar 7, 2010 at 2:02 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> + =C2=A0 =C2=A0 if (color) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!value)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return config_error_nonbool(var);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_parse(value, var, =
opt->color_match);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_parse(value, var, =
color);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(color, GIT_C=
OLOR_RESET))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 color[0] =3D '\0';
>
> I don't know this "optimization" is warranted. =C2=A0I can understand=
 that you
> are trying to help the user to save a handful of useless bytes per li=
ne of
> output in the normal case, but doesn't "color.cmd.foo =3D normal" set=
 the
> value to an empty string already if that is what the user wants?

Ah, I didn't know about the "normal" color.  I tried using a blank
value, which defaulted to "reset", so I thought there was no way to
say "no ANSI sequence".  The above was my workaround to get no
sequence.  Since the "normal" color exists, this workaround should be
removed.

The squash-able patch below removes the workaround, and also fixes
another bug: color was not reset at the end of the line for hunk
separators ("--").

As an aside, perhaps a blank color value should default to no ANSI
sequence, rather than the reset sequence?


diff --git i/builtin-grep.c w/builtin-grep.c
index e423eac..c519fcf 100644
--- i/builtin-grep.c
+++ w/builtin-grep.c
@@ -318,8 +318,6 @@
 		if (!value)
 			return config_error_nonbool(var);
 		color_parse(value, var, color);
-		if (!strcmp(color, GIT_COLOR_RESET))
-			color[0] =3D '\0';
 	}
 	return 0;
 }
diff --git i/grep.c w/grep.c
index 1e0b1e6..b641305 100644
--- i/grep.c
+++ w/grep.c
@@ -533,12 +533,15 @@

 	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown =3D=3D 0) {
-			if (opt->show_hunk_mark)
-				output_color(opt, "--\n", 3, opt->color_sep);
-			else
+			if (opt->show_hunk_mark) {
+				output_color(opt, "--", 2, opt->color_sep);
+				opt->output(opt, "\n", 1);
+			} else
 				opt->show_hunk_mark =3D 1;
-		} else if (lno > opt->last_shown + 1)
-			output_color(opt, "--\n", 3, opt->color_sep);
+		} else if (lno > opt->last_shown + 1) {
+			output_color(opt, "--", 2, opt->color_sep);
+			opt->output(opt, "\n", 1);
+		}
 	}
 	opt->last_shown =3D lno;
