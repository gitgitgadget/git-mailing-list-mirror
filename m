Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDD18787F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669567; cv=none; b=rC9tYNnfkUJ7gqedE2CLX6fvKaT9Us6LGMUPth62KM4Om/ZLw3RqMtPt2/fOjCWIMzONhN6GzM3UAoQ+NgoX5JKWFQvYOZn4anCp79Nex4Q2Ne0pGwEbQiDzHEUeCJ5aNaMzN1ZL9zi2RXdp0izHO5JH8FSYwEbLohrKLZEnks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669567; c=relaxed/simple;
	bh=HbYaKzZq1TlHXKU1b0AtaX9TFnpEEzhix+CwfkQ0IFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bK65PPSwy/l2BpTWn4UsjzV4hWf4esMkpDC9VaAd7tW3py0AB6EcW0HX2x8SbJ5pJ00KGsl8zpQo/BqIJMeSLDgHXfNYCM/q+7kn1qzcLF5wN+H0shSf9onGXCi75X06x2sXKqfuYBs9URyLMs0zfqJS9+kA+Oolw8FINAy66TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZK54RxMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oqH0Oi2O; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZK54RxMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqH0Oi2O"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C6421140239;
	Fri, 11 Oct 2024 13:59:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728669564; x=1728755964; bh=bxq4ucSzG+
	/X5jS7C77Awh1nc8d+e5AER1RyVibVYwc=; b=ZK54RxMhMIiR6GJs7xvPVGPxA4
	XPizVCD/Lm+kM+NMfquRExsDxlhA+fRcjepRzeifW3fns6iZ0UhqfAIxLAanTaFl
	oaiYHErvulFL+fKw+yozabYmgDOmz4JjAC9DTTcJyX7s3kzd4t5rAlf6nb3R7Js3
	JrMRMdjqMo7TSC0NGOMl4CkUiFtKi+E9R7tQraXgS8gUjEcdkmqKgxMmcJ/e/ybw
	EXaK4x7trQE4iFeSLG2J4/EOVyXh6ZBzonkaCHZpD2auqaLzt5XfTk/uMxoAQjva
	O4vT7L6x5Hd1S6wACaUDk2T8nXSzMHAH4kbuocYmgyWckV4a6qB46yYDSG4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728669564; x=1728755964; bh=bxq4ucSzG+/X5jS7C77Awh1nc8d+
	e5AER1RyVibVYwc=; b=oqH0Oi2OW1Mo6zv70To0a6txnhe6wl3lFRAQFDc2zRsw
	odr7/mKWuzneWpXzhciFZwR/d9JQpWkkMsBrc//Djv8YeUtHmkCYqAyeSTMx3CS6
	d6mf8JvaS/+Q0c1q/ZH8vq6gSbaYqmwvemoya7lT5uw4Z5aKPgIc3mRXA/rboHo7
	F8m/GDprs0ZJqGNV1M3Tm/iq0BXOaBUAdxwe0pGdZObWWVVkjuw8SO/xs5/NIL6X
	gQJBD15VdgkIWGpjyNIHupg+SQ2YrN2ObM0MlpIXHSWGScoBQwsbkfRxcgsWZbQk
	1E05zFCkWGLU9tr4mSHvHZ5CTzt4SETDw+mzCheVKw==
X-ME-Sender: <xms:fGcJZ6eYQeQmB_Qwwdvl4xTFpQAnK4m3RDKqWU5iekRgViF46ITBDg>
    <xme:fGcJZ0Ml_vL0-sUVJiqvrpwjmTlHi024WAARKd_MqxYQGuo8H5zQJlb13b8J0O0h7
    9R1aJOeo6By72IxyQ>
X-ME-Received: <xmr:fGcJZ7hn1DboWLN2eusU57lSud0_et1FmA3ayVjnCd-FqM8Z7J1kMy6OfYM2VzRnTR5zAVUQ-9CYscvJvA9QPP01q0kglDaY30x7ryA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhffgveegteejvdejhfekgffgjedvhefh
    vdffuddtjefgudeludelvdefffetieenucffohhmrghinhepfihtqdhsthgrthhushdrtg
    ifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepshhpvghntggvrhdrfhhrvghtfigvlhhlsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fGcJZ3_lIqDuKGPO5PEPHP3BSDM_xW-piXkagHr_8J99PXvpJrz8WA>
    <xmx:fGcJZ2uVY3htMjEa7prnRVc7LqQrMUusZfHiC7BmcuAxHUNkR7A7RQ>
    <xmx:fGcJZ-FcL8Q3zcj_F6GFzjByy5c_EsWRRzQY_ZUzNvXjrWbr34bweA>
    <xmx:fGcJZ1NDpkVlv0GKskkfIq-qRDhfBQAAE3h6_LBWcE_mu1KO96gKwg>
    <xmx:fGcJZ4LJL9vVv9KMkkjSGc-fz8ehJJjUcDECcS7GD6oh3xlhiNPBz9SA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 13:59:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Spencer Fretwell <spencer.fretwell@gmail.com>,  git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
In-Reply-To: <ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 8 Oct 2024 19:52:33 +0000")
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
	<CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
	<ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
	<CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
	<ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net>
Date: Fri, 11 Oct 2024 10:59:22 -0700
Message-ID: <xmqqmsjaed1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Is there any chance for git to support a CRLF magic ignore line,
>> particularly considering the variation in standard line ending across
>> different platforms? I tried autocrlf=input as well and it sadly
>> doesn't normalize the commit message file itself. Either way (magic
>> ignore with CRLF or normalizing line endings in the commit message),
>> would be appreciated for mixed line ending workflows (especially
>> considering WSL)
>
> The answer is essentially that I don't know.  We typically make
> decisions on whether we'll accept features when we see the patch.  My
> guess is that, assuming someone (maybe you) sends a patch, it will
> probably be accepted, since I wouldn't expect it would be very difficult
> to do or have major impacts on the code.  It might, as with any patch,
> take a couple of rounds, though.
>
> I use Linux or rarely other Unix systems and always use LF endings, so I
> don't plan to send a patch since this doesn't affect me, but assuming
> the patch looked reasonable, I don't see myself having an objection to
> it.

I do not offhand see a downside if we loosened the detection of the
cut line a bit.  What is happening on the Git end (I do not care how
Editor screws up and munges what we wrote before "Do not modify or
remove the line above"---to us, it looks like the user did not honor
that instruction) is:

wt-status.c defines cut_line[] to be

        static const char cut_line[] =
        "------------------------ >8 ------------------------\n";

IOW, we insist that after the dashes we have LF.

Then wt-status.c:wt_status_locate_end() does this:

        size_t wt_status_locate_end(const char *s, size_t len)
        {
                const char *p;
                struct strbuf pattern = STRBUF_INIT;

                strbuf_addf(&pattern, "\n%s %s", comment_line_str, cut_line);
                if (starts_with(s, pattern.buf + 1))
                        len = 0;
                else if ((p = strstr(s, pattern.buf))) {
			size_t newlen = p - s + 1;
			...

That is, if the buffer begins with the cut line (including the LF at
the end of the line, without any CR before it), we found it at the
beginning of the buffer at len==0, otherwise if we find a region of
memory that begins with LF, followed by the scissors, followed by LF
(again, without allowing CR before it), we have a match there.

That is reasonable as long as the user does not muck with the line
that we told them not to touch.  In this case, the editor is
corrupting the line without being instructed by the user so the user
cannot do much about it.

We could loosen the rule by doing something along the following line:

 - define the cut_line constant without LF at the end of the line.

 - teach wt_status_append_cut_line() to compensate for the lack of
   LF in cut_line.

 - teach wt_status_locate_end() to notice and ignore CR if it
   appears at the end of the cut_line.

I'll go offline at the end of this week, so I will stop here at
illustrating the above approach in the form of an untested patch
below.  I am sure I'd have many off by one errors in it, but it
should be sufficient to outline the idea.

 wt-status.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git c/wt-status.c w/wt-status.c
index 6a8c05d1cf..b54bc5de81 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -39,7 +39,7 @@
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
 
 static const char cut_line[] =
-"------------------------ >8 ------------------------\n";
+"------------------------ >8 ------------------------";
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -1095,15 +1095,28 @@ static void wt_longstatus_print_other(struct wt_status *s,
 	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 }
 
+static int at_eol(const char *s, size_t len, size_t loc)
+{
+	if (len <= loc)
+		return 0;
+	if (s[loc] == '\r')
+		loc++;
+	if (len <= loc)
+		return 0;
+	return s[loc] == '\n';
+}
+
 size_t wt_status_locate_end(const char *s, size_t len)
 {
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
 
-	strbuf_addf(&pattern, "\n%s %s", comment_line_str, cut_line);
-	if (starts_with(s, pattern.buf + 1))
+	strbuf_addf(&pattern, "%s %s", comment_line_str, cut_line);
+	if (starts_with(s, pattern.buf) && at_eol(s, len, pattern.len))
 		len = 0;
-	else if ((p = strstr(s, pattern.buf))) {
+	else if ((p = strstr(s, pattern.buf)) &&
+		 (s < p && p[-1] == '\n') &&
+		 at_eol(p, p - s, pattern.len)) {
 		size_t newlen = p - s + 1;
 		if (newlen < len)
 			len = newlen;
@@ -1116,7 +1129,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, comment_line_str, "%s", cut_line);
+	strbuf_commented_addf(buf, comment_line_str, "%s\n", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_str);
 }
 

