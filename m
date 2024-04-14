Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652636121
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113284; cv=none; b=UbzCps39FotUL9LXQzpkbsyp1fO9d/2zzHiiupkjIgy5r7giTxytmO3GRzqUkWArkM4EC8OmONfplWXo6NQepP+VG7lpFuY0ri8wSpRPAHcEpX8JFLydgPpzNg2IOh/s5cbX7nK6IIFEhasl/oh4tUtu/yLqXLSSDP4bzH2D7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113284; c=relaxed/simple;
	bh=r1IV2BkB4ADmssy58b8Loi859z04lKh66CbgdKmkXUI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iNXNZUzFQi1NivlzsamUmY3JYjw4QEiXK/9/KBHZI3MW0GcWuZtzxhwe92ihZHIlLrEjEmglkpWUKAO9uK207KIOI0KV8kmeOp7RWeU2u+RwsInsBFaIkPvuQ6ddVUIbh8iZqcpqsNIRi9gW71M8fn05CYopU1UdQYpfJUyJhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=usCDdJhe; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="usCDdJhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713113273; x=1713718073; i=l.s.r@web.de;
	bh=mcK3u7RlWr/YBcWf1U6+epwqyUoxnqaqar0wG2q7wpU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=usCDdJhe3WuppsDQjssptLq6aGN2ga1E18E5dQ/pAZ+xGhcix/PxTvq2WofLS6hO
	 6kA2yOt62Ecjz/WwulbIHb8+aAkUk9+hP4ITGC35BFN8Z5i4PNWo68r0H2ZhusLPA
	 05ZAGdXE4sE5c7fWF8wx+mSrR+SVOT2DW6YoaBXgvQhoWGjlsaxwimXvosLUA9vHc
	 UUtTRGUd2yr74HKXyTPJIKxbV+ATk5HnbHEjsvqk553T8DS0TEupExg9OyXN7pm+d
	 /8bZEG8DoK5H2tpxJrU3mhbug4hfv6iQ13Q+2/p8Mj7LY5y6wp6Iq2f1YmrZYRZj4
	 iv9AiC6UnsdzNn27fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5bT-1sF8ei1gBp-00YBNo; Sun, 14
 Apr 2024 18:47:53 +0200
Message-ID: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
Date: Sun, 14 Apr 2024 18:47:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] imap-send: increase command size limit
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1keMgAg7visskGi6wDnQj2AnYjTbBSS+HK+KpF02qpwd/jgxMv
 PODBxT0f+liOyUKRd4fOZHX+uo7PqE1q2q4UMBxr3PMG0eX2tBQolftEpDY9nyfl0UXjjxq
 VNtZoXYWqTdV4tDBeT6rwbU5qznKwDTm3hwjR6Y681R29tg26WLxAZ975gYcUfb4cf7awjw
 BQ92OWVRME6BcTojV/VTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lc8x0ptYEgc=;hdx8zeWK+iA+r8W7V2K1UUcE7LL
 qgEOYlVB+kYRLXOXdfyBFzSlE82mcBZGVPLL+wHl9PyBi8JNQvAR3zSd+e0gff24rTF7hk5kK
 +PJcJpgCHiaq95HtuZK2xmiWZIgUqRDGffzN7B49v64X8XOwixVmH4DMfJsd1InVGqGTC8RNP
 Q2D4XH5VFJv/9CloFcVKGOnWQLhktm5ldnCvZh5Bp1OiQOk3vG7ZdaVNdk6+4i8rsgyLinubl
 O0VQWaHrN0G5CdrTawg5EEYdMREZwMgGxLfoaPtydBALfGhuAILljawhutAsZKZcgCI9Q5t2t
 duN9Aj2/Cs/4j9PwRnEfzN1qs10weGVWWMWL6C7zxZr8vgHC1RedSMkqv990hdekEplqaqbiW
 1Wi93UjJgTYMYSY7Mpu0aReGmQHGlW/DiYv4QcBpVD0ZgTHLKSt6QxOf26re+kp96N8tUCcWa
 m635eiF6WRC1ohEejpPrhpmtPNSJZOCeFJ4lo/z2p6+5epqrMi0Dky4KgEUfaTkKCmncMGWLj
 vOLHiukv8G7oD3vtdLICRLNJwWtcwrwmkEw6XXkw0wmfGaCTZzOGwgVGzBLR71BiRwYIIvCi3
 KRWWMQCoAJWHo3ZPK/qzxhcojgSqOBF14r+wNnEoSsvAkSThDsDcij35Y6kWNOiXcC5yPrEkf
 Vs99ZQd+UYLZTrLRueAmn+oCmX6zsv8D2yEL9U58RnWxJp9ZcDX3yd7LrKmYhBSYyRSDiQs9v
 KS+gj+wpjlKSAjgBM5Zv8RLMd0DRHKmoeatTBVb7DprT0fVJAhvLJNJFl5SLp4kZsnpK4iYTr
 hFhqNUNV5AwMwlvzIOkUavzmZhTtJ7H9/n8Zuixuxne+E=

nfvasprintf() has a 8KB limit, but it's not relevant, as its result is
combined with other strings and added to a 1KB buffer by its caller.
That 1KB limit is not mentioned in RFC 9051, which specifies IMAP.

While 1KB is plenty for user names, passwords and mailbox names,
there's no point in limiting our commands like that.  Call xstrvfmt()
instead of open-coding it and use strbuf to format the command to
send, as we need its length.  Fail hard if it exceeds INT_MAX, because
socket_write() can't take more than that.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This time I compiled with NO_CURL=3D1 and NO_APPLE_COMMON_CRYPTO=3D1 and
verified with a silly printf that the changed code was actually used
and wrote the present message to an IMAP folder whose name is 1006
characters log, which required a 1026 bytes long APPEND command.  Yay,
freedom!

Ran into a build issue, will send a separate patch for that.

 imap-send.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4caa8668e6..0afd088d8a 100644
=2D-- a/imap-send.c
+++ b/imap-send.c
@@ -68,20 +68,6 @@ static void imap_warn(const char *, ...);

 static char *next_arg(char **);

-static int nfvasprintf(char **strp, const char *fmt, va_list ap)
-{
-	int len;
-	char tmp[8192];
-
-	len =3D vsnprintf(tmp, sizeof(tmp), fmt, ap);
-	if (len < 0)
-		die("Fatal: Out of memory");
-	if (len >=3D sizeof(tmp))
-		die("imap command overflow!");
-	*strp =3D xmemdupz(tmp, len);
-	return len;
-}
-
 struct imap_server_conf {
 	const char *name;
 	const char *tunnel;
@@ -503,11 +489,11 @@ static struct imap_cmd *issue_imap_cmd(struct imap_s=
tore *ctx,
 {
 	struct imap *imap =3D ctx->imap;
 	struct imap_cmd *cmd;
-	int n, bufl;
-	char buf[1024];
+	int n;
+	struct strbuf buf =3D STRBUF_INIT;

 	cmd =3D xmalloc(sizeof(struct imap_cmd));
-	nfvasprintf(&cmd->cmd, fmt, ap);
+	cmd->cmd =3D xstrvfmt(fmt, ap);
 	cmd->tag =3D ++imap->nexttag;

 	if (cb)
@@ -519,27 +505,30 @@ static struct imap_cmd *issue_imap_cmd(struct imap_s=
tore *ctx,
 		get_cmd_result(ctx, NULL);

 	if (!cmd->cb.data)
-		bufl =3D xsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd);
+		strbuf_addf(&buf, "%d %s\r\n", cmd->tag, cmd->cmd);
 	else
-		bufl =3D xsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
-				 cmd->tag, cmd->cmd, cmd->cb.dlen,
-				 CAP(LITERALPLUS) ? "+" : "");
+		strbuf_addf(&buf, "%d %s{%d%s}\r\n", cmd->tag, cmd->cmd,
+			    cmd->cb.dlen, CAP(LITERALPLUS) ? "+" : "");
+	if (buf.len > INT_MAX)
+		die("imap command overflow!");

 	if (0 < verbosity) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
 		if (!starts_with(cmd->cmd, "LOGIN"))
-			printf(">>> %s", buf);
+			printf(">>> %s", buf.buf);
 		else
 			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
 	}
-	if (socket_write(&imap->buf.sock, buf, bufl) !=3D bufl) {
+	if (socket_write(&imap->buf.sock, buf.buf, buf.len) !=3D buf.len) {
 		free(cmd->cmd);
 		free(cmd);
 		if (cb)
 			free(cb->data);
+		strbuf_release(&buf);
 		return NULL;
 	}
+	strbuf_release(&buf);
 	if (cmd->cb.data) {
 		if (CAP(LITERALPLUS)) {
 			n =3D socket_write(&imap->buf.sock, cmd->cb.data, cmd->cb.dlen);
=2D-
2.44.0

