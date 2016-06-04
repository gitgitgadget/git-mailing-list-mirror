From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sat, 4 Jun 2016 07:31:26 +0700
Message-ID: <20160604003126.GA10430@ash>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com>
 <575199E7.7000503@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:35:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8zV3-0005Dt-BB
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 02:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbcFDAbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 20:31:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33186 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcFDAbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 20:31:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id b124so12688893pfb.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VqwhO7720Uj0PwMX2QU8o4MKVP/yfnzEEcSgm7PgDOU=;
        b=CseUsvbQ7bx0FGvDNvE7DPfc5FKuwP4zHdP2kvkMdA0slphd8weqzK5ZzFONu3/fO9
         aRdAiOS3cHvz/h94qyatnnzX+5hqjpX3JV9KxvGQYavjFHa/GzjpT54TsRYfXg0aVd1t
         tWNGYrEO7q8NWE+XfeYgEm6SSf1jMSNCKdQDhLyKBmYm9O3LzMwzpW5Xgfup+SXhdBIT
         8kslw30A8ytJnLl3jA81JHCmv4U6lvu8xUkzz4u1Rb9rRtANLDD9aKohvJQI9TYWPY1w
         LarXKepKR2tXvnTB0wMjzizWPHkQC+It0DT5jyqiQftzUjOH/591XFQC2NTG+JYDr80X
         DUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VqwhO7720Uj0PwMX2QU8o4MKVP/yfnzEEcSgm7PgDOU=;
        b=BlcGh/XHTr91KxwNJ06Dr4yqf6wMkSsUMUEw52ucBAUrLJqXpWM/VHfM05HxGzkztc
         Co2pOCEJcCuHUn/1PEUcq17VuimNWsWICrRByAtDgMGCNQ4wDxwnQF6Hv1IViSnmkKER
         8bFcwHWGyyevCAZW5HhR/lmgdcDMT35K5BrVUd0FvbQTIUJRy5qjjCduvSwTJapgMzUU
         9nLCH74s0NnQuNMVRKjKdKlAEc8XYHvu22pg1CwlJnmmrdU4aRaH9t8wWSK8sEYvdIi9
         XorhOMOCBd/xE/AKn/eHa/T0ULKi2L5k4O3szgDJT5osLPQwHssUAez7ltZ8Ih8QeQca
         fiLA==
X-Gm-Message-State: ALyK8tIJypr/Y6znNC6zUMlKGfazFd/2QDUkjur7CdwGt1Z0R3LIT5eXVVRii0H6AxCB7A==
X-Received: by 10.98.44.134 with SMTP id s128mr9141657pfs.153.1465000291532;
        Fri, 03 Jun 2016 17:31:31 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id t65sm10949884pfb.37.2016.06.03.17.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 17:31:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 04 Jun 2016 07:31:26 +0700
Content-Disposition: inline
In-Reply-To: <575199E7.7000503@xiplink.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296436>

On Fri, Jun 03, 2016 at 10:53:27AM -0400, Marc Branchaud wrote:
> On 2016-06-03 07:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wro=
te:
> > When there are lots of ref updates, each has different name length,=
 this
> > will make it easier to look because the variable part is at the end=
=2E
>=20
> s/look/read/
>=20
> For the record, I prefer the earlier stair-step format to this
> 	{xxx -> yyy}/foo
> stuff.
>=20
> Peff suggested that a two-pass approach might not be too bad, but had=
=20
> problems when he tried it with extra-long refs.  Maybe those problems=
=20
> could be dealt with, and we could get a simple, aligned output?

The good thing about 2/3 is we can customize the output easily and
even switch format with config variables. But let's play without
config vars for now. A 3/3 replacement that adds another pass to
calculate column width is at the end.

> What if we detect when the full line exceeds the terminal width, and=20
> insert a newline after the remote ref and indent the ->  to the same=20
> offset as its surrounding lines, like this:
>=20
>   * [new branch]      2nd-index -> pclouds/2nd-index
>   * [new branch]      some-kind-of-long-ref-name
>                                 -> pclouds/some-kind-of-long-ref-name
>   * [new branch]      3nd-index -> pclouds/3nd-index

The patch does not do fancy stuff like this yet, but it can because
lines exceeding terminal width is already excluded from column width
calculation. So far the output looks good on my terminal (192 chars,
can't overflow or refnames are insanely long)

-- 8< --
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a7f152a..5e1e5c9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
+#include "utf8.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -449,14 +450,26 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
=20
-#define REFCOL_WIDTH  10
+static int refcol_width =3D 10;
+
+static void adjust_refcol_width(const char *remote, const char *local)
+{
+	int max =3D term_columns();
+	int rlen =3D utf8_strwidth(remote);
+	int llen =3D utf8_strwidth(local);
+
+	if (21 /* flag summary */ + rlen + 4 /* =3D> */ + llen >=3D max)
+		return;
+	if (refcol_width < rlen)
+		refcol_width =3D rlen;
+}
=20
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
@@ -618,6 +631,20 @@ static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
 		goto abort;
 	}
=20
+	/*
+	 * go through all refs to determine column size for
+	 * "remote -> local" output
+	 */
+	for (rm =3D ref_map; rm; rm =3D rm->next) {
+		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
+		    !rm->peer_ref ||
+		    !strcmp(rm->name, "HEAD"))
+			continue;
+
+		adjust_refcol_width(prettify_refname(rm->name),
+				    prettify_refname(rm->peer_ref->name));
+	}
+
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, =
so
 	 * merged entries are written before not-for-merge. That lets readers
-- 8< --
