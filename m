From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in
 http-fetch.c and remote-curl.c
Date: Thu, 1 May 2014 00:17:28 +0200
Organization: <)><
Message-ID: <20140430221728.GA27914@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-9-git-send-email-marat@slonopotamus.org> <5360B5EC.1070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>,
        GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j.sixt@viscovery.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRB7HMQWNQKGQEU23ZLTI@googlegroups.com Thu May 01 00:17:37 2014
Return-path: <msysgit+bncBCU63DXMWULRB7HMQWNQKGQEU23ZLTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7HMQWNQKGQEU23ZLTI@googlegroups.com>)
	id 1Wfcon-0005M2-Sf
	for gcvm-msysgit@m.gmane.org; Thu, 01 May 2014 00:17:33 +0200
Received: by mail-we0-f191.google.com with SMTP id u57sf211832wes.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=lDo13SsCZewfeYn7LgH8K0cByPDDS31KqLC6dzsWCpc=;
        b=SvkQHCxNklRJ+in2swS98Eq0LA/oqEs1DNj7rKGobMNayEV8KpUsngKJCrVbXSjP6I
         934JIGDVB6KIenVNXpCJqw+kQmOiru6Vr2W80dOa3m0RFdkbRQGAjzVSbpqVYzPNrs0D
         sHZWfljSDEWpWScyjuv58mMjjRRsSocrpiz1BSyhmpa/e9yu6RNG8732q/iga/qT8A8J
         pKgMiDAvspuXeE9e/vgti0pVn1pUE4akOHQjcow++cnKDBZJ5of6FRLROnqZZ8iR8+j5
         u3Vznhgt+rH5eKAdBnxLuilaqlNu6LAwUvAjrU4htKX1Gv/9Jy+e5XtidFJzjrC9jejT
         BYNw==
X-Received: by 10.152.198.138 with SMTP id jc10mr41526lac.31.1398896253465;
        Wed, 30 Apr 2014 15:17:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.2 with SMTP id ky2ls137647lab.69.gmail; Wed, 30 Apr
 2014 15:17:32 -0700 (PDT)
X-Received: by 10.112.168.198 with SMTP id zy6mr604503lbb.15.1398896252065;
        Wed, 30 Apr 2014 15:17:32 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si908223eeo.1.2014.04.30.15.17.30
        for <msysgit@googlegroups.com>;
        Wed, 30 Apr 2014 15:17:30 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id A8E551C00EC;
	Thu,  1 May 2014 00:17:29 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UMHTd8028125;
	Thu, 1 May 2014 00:17:29 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UMHSJr028124;
	Thu, 1 May 2014 00:17:28 +0200
In-Reply-To: <5360B5EC.1070907@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247798>

Hello,

On Wed, Apr 30, 2014 at 10:35:56AM +0200, Karsten Blees wrote:
> Would you mind cross checking your changes with the msysgit fork?
> [...]
> See https://github.com/msysgit/git/commit/9206e7fd (squashed from
> https://github.com/msysgit/git/commit/0115ef83 and
> https://github.com/msysgit/git/commit/6949537a).

OK, I _did_ checked these, let's look at the two original commits:

- 0115ef83 is interesting, but not relevant to the warnings,
- 6949537a contains a fix for the const warning, plus it fixed a
  minor nit in the other commit.

> [...] you to come up with an
> alternate solution for something that's long been fixed).

Long been fixed by a quick and dirty hack.
Marat's fix is nicer, can I ask some of the msysGit guys to ack it?
(Appended below for the new cc's here.)

Have a nice day,
	Stepan

PS: I bet Dscho will be able to handle the conflict.

From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and remote-curl.c
Date: Tue, 29 Apr 2014 13:12:02 +0400

On MinGW, compat/mingw.h defines a 'mingw_main' wrapper function.
Fix `warning: passing argument 2 of 'mingw_main' from incompatible
pointer type` in http-fetch.c and remote-curl.c by dropping 'const'.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 http-fetch.c  | 5 +++--
 remote-curl.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index ba3ea10..a6a9a2f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,7 +6,7 @@
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct walker *walker;
 	int commits_on_stdin = 0;
@@ -38,7 +38,8 @@ int main(int argc, const char **argv)
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		} else if (argv[arg][1] == 'w') {
-			write_ref = &argv[arg + 1];
+			const char *ref = argv[arg + 1];
+			write_ref = &ref;
 			arg++;
 		} else if (argv[arg][1] == 'h') {
 			usage(http_fetch_usage);
diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..565b6c9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -938,7 +938,7 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
