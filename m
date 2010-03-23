From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 12:22:38 +0100
Message-ID: <201003231222.40745.jnareb@gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> <m38w9jjqqd.fsf@localhost.localdomain> <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 12:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu2CI-0005OC-F4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 12:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab0CWLWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 07:22:53 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34733 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0CWLWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 07:22:52 -0400
Received: by fxm5 with SMTP id 5so2749531fxm.29
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3MNgawo/XZ/JUd70dEq1osOlJ+zuRwE28N/NjrLHTlM=;
        b=MUzkWUlSP5xbccaPLMVvjQRR02CcHGZJGPRqIej39TWqklPZ890jeP3UxO8LO+59mb
         RbralRt15PqP7hhP0UIBA4C7v23pTPhYtW3QUXHBYNNqBW1/f1ZgQfpHeJmSB7vgi3tb
         Bs4VSKD9SuXyWitngYXACnZk7Ku2FH8dSqANg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=diIXx4jE0dXXYe2XYdyPt1HOJaBETC7NRtyJ0/QAzsQziWRdamfnCuobz7BWTOflgY
         lJZc+3UejK5kLEhTeHNR6GiJC5u4TvRzuZZ5fI6F8yXOJ89ji/4fwRJs2tOpBFp3Wcug
         wZaMy3Tj/iNY13JG04OVYZBoxsRwn+dpE5s4M=
Received: by 10.223.58.71 with SMTP id f7mr2518019fah.45.1269343369772;
        Tue, 23 Mar 2010 04:22:49 -0700 (PDT)
Received: from [192.168.1.13] (absh220.neoplus.adsl.tpnet.pl [83.8.127.220])
        by mx.google.com with ESMTPS id p17sm3058316fka.46.2010.03.23.04.22.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 04:22:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143007>

On Tue, 23 Mar 2010, Bo Yang wrote:

Please do not forget to include attribution line, like the one I have
added below:
=20
> Jakub Narebski wrote:

> > The problem is when you are asking about tracking a subset of lines
> > that appear in postimage of a patch. =A0For example if we ask for
> > history of
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&buf, extra_hdr.it=
ems[i].string);
> >
> > line, should we track history of
> >
> > =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < extra_hdr.nr; i++) {
> >
> > line which appears in relevant diff chunk? =A0If not, how we should
> > detect which line in preimage (if any) corresponds to given line in
> > postimage?
>=20
> If I understand correctly, that is as following.
>=20
> @@ -1008,29 +1000,29 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>                add_signoff =3D xmemdupz(committer, endpos - committer=
 + 1);
>        }
>=20
> -       for (i =3D 0; i < extra_hdr_nr; i++) {
> -              strbuf_addstr(&buf, extra_hdr[i]);
> +       for (i =3D 0; i < extra_hdr.nr; i++) {
> +              strbuf_addstr(&buf, extra_hdr.items[i].string);
>                strbuf_addch(&buf, '\n');
>        }
>=20
> Here, the user only ask for tracking the strbuf_addstr line. And we
> find the above diff hunk. I think we can then find what the line woul=
d
> be in the preimage using @@ -1008,29 +1000,29 @@.  The strbuf_addstr
> is located at
> 1000(the postimage start line number)
> +3(the context number)
> +1(the number of lines '+' before this line) in the postimage,
> and we can calculate its line number in the preimage by the same way
> 1008
> +3
> +1(the number of lines with '-' before this line).
>=20
> How do you think about this method?

This would work with the simplest case, but not in more complicated
cases, like for example preimage and postimage with different size.

Take for example the following chunk (fragment):

diff --git a/run-command.c b/run-command.c
index 2feb493..3206d61 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,19 +67,21 @@ static int child_notifier =3D -1;
=20
 static void notify_parent(void)
 {
-	write(child_notifier, "", 1);
+	ssize_t unused;
+	unused =3D write(child_notifier, "", 1);
 }
=20
 static NORETURN void die_child(const char *err, va_list params)

If you follow ssize_t line, it is created.  If you follow line with
write, which is 2nd line in postimage, its previous version is 1st
line in preimage.


Another example would be reordering of lines, or reordering with
some change.

--=20
Jakub Narebski
Poland
