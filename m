From: Eloy Espinaco <eloyesp@gmail.com>
Subject: Re: Verbose as default for commit (optional)
Date: Fri, 24 Apr 2015 20:51:03 -0300
Message-ID: <20150424235103.GA1798@localhost>
References: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar>
 <vpqbnidmgzh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eloy Espinaco <eloyesp@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlnWH-0003se-EV
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 02:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934231AbbDXXus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2015 19:50:48 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36645 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932766AbbDXXus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 19:50:48 -0400
Received: by qgeb100 with SMTP id b100so29861024qge.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K1jQMAZ4MPMxGcGeQtIBggHYQkekRnmcGVny5aXbmfQ=;
        b=ID3I3I9q/hoQuFLKn2EJy6Appzgf2d6qdtUasgjCB8Lferk56PxAbSU+K/17AH1t9X
         14uavfoYA321wHBcqvEdKwcdvlGDvkB8A/kRyFRfoW76f/ITeSrKS51u0KlVrNrW7lkm
         jZWqa0zDQtdfB/Wu4bTEK+S9fWvPEXqcOnLRxdsV4PUj/xQUr2Kp400wvOmEEpvtl/Zb
         U5s0+5cF9cJXx2XjtLUb5IUltJqdTosEFVb8zFSJqXUj6Sr0OrR3BSJM5iMC6XnyyJOl
         JfY9N4uPg0B0wodTgcaMty912UihVui/vFDhUOmQJwEKsk29xEi6l+6tktvY/2ICNXtI
         0ctQ==
X-Received: by 10.140.237.147 with SMTP id i141mr845790qhc.25.1429919447150;
        Fri, 24 Apr 2015 16:50:47 -0700 (PDT)
Received: from poderosa.eloyesp.com.ar (host7.186-125-111.telecom.net.ar. [186.125.111.7])
        by mx.google.com with ESMTPSA id 197sm9187863qhq.23.2015.04.24.16.50.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 16:50:45 -0700 (PDT)
X-Google-Original-From: Eloy Espinaco <eloyesp@poderosa.nsupdate.info>
Received: from eloyesp by poderosa.eloyesp.com.ar with local (Exim 4.84)
	(envelope-from <eloyesp@localhost>)
	id 1YlnN9-0002W4-Oq; Fri, 24 Apr 2015 20:51:03 -0300
Content-Disposition: inline
In-Reply-To: <vpqbnidmgzh.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267766>

Ok, now I found [this
thread](http://thread.gmane.org/gmane.comp.version-control.git/251376)
that seems abandoned, but implements this config, a --no-verbose that
disable it for one-time and the tests, but was not merged (don't know
why)

This was the patch I've intended to attach:
----------------->8--------------------

Subject: [PATCH] Add commit.verbose config to set default.

---
 builtin/commit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index da79ac4..ad588ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1506,6 +1506,10 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
 		sign_commit =3D git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose =3D git_config_bool(k, v);
+		return 0;
+	}
=20
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
--=20
2.1.4

En Fri, Apr 24, 2015 at 10:03:14PM +0200, Matthieu Moy escribi=F3:
> Eloy Espinaco <eloyesp@gmail.com> writes:
>=20
> > Hi,
> >
> > It is my first mail to the list, so "hello world".
>=20
> Hi, and welcome to the list.
>=20
> > I wanted to make a feature-request about a config setting to make t=
he
> > commit always verbose. I'm not the only one asking for that, there =
is an
> > old question in [Stack Overflow][1].
>=20
> This seems a reasonable addition. In general, we commonly have config
> options for commonly used CLI options.
>=20
> > So I was thinking if it was possible to make a pull request for tha=
t, so
> > I attach the patch. (I'm proud of it :) ).
>=20
> Nice try, but the attached file is empty ;-). Actually, as much as
> possible, avoid sending attachments but prefer inline patches.
>=20
> You'll need a bit of reading to send a proper patch:
>=20
> https://github.com/git/git/blob/master/Documentation/SubmittingPatche=
s
>=20
> --=20
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
--- Eloy Espinaco
