From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Sun, 12 Oct 2008 18:19:52 +0400
Message-ID: <20081012141952.GD21650@dpotapov.dyndns.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net> <20081007001652.GR21650@dpotapov.dyndns.org> <20081008152443.GA4795@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 16:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1on-0005bl-3J
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 16:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbYJLOUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbYJLOUB
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 10:20:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:33043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbYJLOT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 10:19:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so918545fgg.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BhAa/1Vd/Vy9NKEJLDo786Y7NbZlSeyMG8B7hoGPskg=;
        b=CEwWBqict/jd5XLU7eZH6RNFQVclQTOWKWjHlc46IdnYPooz8gJ1f1B8mQguhvwec+
         pLSPAQLZBPsnysYaUFzlrVFp9p47x2fy12kdar45/LdPvJJ6RUTs2jnCWK/34Bzowin6
         bmFPPRwuBscsrmSeI5xbribrONh9nHLgmpmk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SdevMFIh/J1i8eYAdc5KrTBO4q3L+eB4l6cGdlxdSj7ZzoyDbPbbQucLs72yCvZbTL
         FNTrJGG2BdRRL+gBdlDk+bXfQ+7T7p6U47hGcHaLoV4kIvP6lG70VC8YC5h/NIHMwFTO
         JnJwe4dPPU7Z89BSQ7RzKpIWUHoJimxAJIars=
Received: by 10.86.80.17 with SMTP id d17mr3978145fgb.24.1223821198009;
        Sun, 12 Oct 2008 07:19:58 -0700 (PDT)
Received: from localhost (ppp91-77-162-44.pppoe.mtu-net.ru [91.77.162.44])
        by mx.google.com with ESMTPS id l12sm6387444fgb.6.2008.10.12.07.19.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 07:19:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081008152443.GA4795@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98024>

On Wed, Oct 08, 2008 at 08:24:43AM -0700, Shawn O. Pearce wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
> > This allows multiple paths to be specified on stdin.
> 
> > diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> > index 2b821f2..0839a57 100644
> > --- a/Documentation/git-check-attr.txt
> > +++ b/Documentation/git-check-attr.txt
> > @@ -9,6 +9,7 @@ git-check-attr - Display gitattributes information.
> >  SYNOPSIS
> >  --------
> >  'git check-attr' attr... [--] pathname...
> > +'git check-attr' --stdin-paths attr... < <list-of-paths
> 
> I wonder if the option should just be "--stdin".

I used "--stdin-paths" because git hash-object uses it, while "--stdin"
means to read the object from standard input. OTOH, we are never going
to read the object from standard input in check-attr and some other git
commands use "--stdin" to mean: read the list of paths from the standard
input. So, I fully agree here.

> And since its being
> used mostly by automated tools (gitk/git-gui) I wonder if a -z should
> also be supported for input termination with NUL instead of LF.

I have added it, but after I did, I start to wonder whether it is the
right thing to do to unquote NUL terminated input line?

NUL terminated makes sense when you feed raw-bytes, and if the first
byte happen to be a quote character, I suppose it should be treated
just as any other byte, not as a sign that the string is quited. But
then I looked at git checkout-index, and it unquotes string even if it
is NUL terminated. I don't think it is the right thing to do, but just
to be consistent, I have decided to leave as-is, i.e. to unquote a NUL
terminated string.

> > +test_expect_success 'attribute test: read paths from stdin' '
> 
> A test case for the quoting might also be good.

As far as I can tell, there is no test case for special characters in
filenames when these filenames are given as arguments. And there are a
few problems with them. First, it is using colon as a separator in
output, which breaks parsing of a filename containing colons.  Second,
I still have not figured out how to specify filenames with special
characters in gitattributes. The documentation does not say anything
and was lazy to study the code. Does gitattributes understand quote
strings in filenames?


Anyway, here is interdiff to my previous patch, which addresses two
first points as I described above. (I can resend the full patch if
necessary).

-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sun, 12 Oct 2008 18:08:43 +0400
Subject: [PATCH] check-attr: Add --stdin option

---
 Documentation/git-check-attr.txt |    8 ++++++--
 builtin-check-attr.c             |   13 +++++++++----
 t/t0003-attributes.sh            |    2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 0839a57..14e4374 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,7 +9,7 @@ git-check-attr - Display gitattributes information.
 SYNOPSIS
 --------
 'git check-attr' attr... [--] pathname...
-'git check-attr' --stdin-paths attr... < <list-of-paths
+'git check-attr' --stdin [-z] attr... < <list-of-paths
 
 DESCRIPTION
 -----------
@@ -18,9 +18,13 @@ For every pathname, this command will list if each attr is 'unspecified',
 
 OPTIONS
 -------
---stdin-paths::
+--stdin::
 	Read file names from stdin instead of from the command-line.
 
+-z::
+	Only meaningful with `--stdin`; paths are separated with
+	NUL character instead of LF.
+
 \--::
 	Interpret all preceding arguments as attributes, and all following
 	arguments as path names. If not supplied, only the first argument will
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index fa1e4d5..02a8292 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -7,12 +7,16 @@
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
 "git check-attr attr... [--] pathname...",
-"git check-attr --stdin-paths attr... < <list-of-paths>",
+"git check-attr --stdin attr... < <list-of-paths>",
 NULL
 };
 
+static int null_term_line;
+
 static const struct option check_attr_options[] = {
-	OPT_BOOLEAN(0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		"input paths are terminated by a null character"),
 	OPT_END()
 };
 
@@ -41,10 +45,11 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
 	const char** name)
 {
 	struct strbuf buf, nbuf;
+	int line_termination = null_term_line ? 0 : '\n';
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -90,7 +95,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (cnt <= 0)
 		errstr = "No attribute specified";
 	else if (stdin_paths && doubledash < argc)
-		errstr = "Can't specify files with --stdin-paths";
+		errstr = "Can't specify files with --stdin";
 	if (errstr) {
 		error (errstr);
 		usage_with_options(check_attr_usage, check_attr_options);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f6901b4..1c77192 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -60,7 +60,7 @@ a/b/h: test: a/b/h
 a/b/d/g: test: a/b/d/*
 EOF
 
-	sed -e "s/:.*//" < expect | git check-attr --stdin-paths test > actual &&
+	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
 	test_cmp expect actual
 '
 
-- 
1.6.0.2.521.g49aa8.dirty

-- >8 --
