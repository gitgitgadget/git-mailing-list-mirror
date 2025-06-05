Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07A2E659
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121065; cv=none; b=lJCCMJb98KpwE7o/D9jjOAV++dPljc4h0TDarM8XpNLd5ScBImg5raL4G0Py03ZMtZ1oM5DAT1oZPZ3Dium65Cyp5RW32Jom0+CSGCbV55J/fC0j8MWNew6lUS/kkNrj5mh+pZFIP8n2EDj94WUPmaMrf7Fy4g7ZU1R9usySdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121065; c=relaxed/simple;
	bh=3+59izGH9EEtEJUi/c3pY0s5EZjG0tf/BH+SFWmqGzg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PKOrZfE+GSEzvl2V5dyovwxY3SeLMJV9ks4Sb9IGsR8cVSONF7uhopsHOvtEOP7ePUZQCAYSFT/ENph0dfzY8GJ9DPdJjuTOtRAOxmE+XHvmT8kKiFCQR4bE9zVl54rUz8L91I7C39A5ZCNwlsFSGEceflU8MDnnqGpfg8rYyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tv01xF+b; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tv01xF+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749121057; x=1749725857;
	i=johannes.schindelin@gmx.de;
	bh=NzrMWdXd0G8TsEn59RP/GHWoM72otB7yYR6YevPqhfk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tv01xF+bDTAlI4J1RVRxB+DwgYEVP9Haoq1x+Y0h8AGxKOw33IBhPOcbnm2NQdJc
	 WFAUhvOVQ4QmCMC7D9JI3ClYrj+lybfUnmDH2cNfwzj7kr8iqLPCJHDNcVJ0kw0v7
	 5rPVVi9QVFE7XGTAot0Fwq+fWqZUQ/1kXz3gQOocbCcMCZwUB4W4VcI/TNdBUslbO
	 j5XF/KVeguKRkCPB4c0dpgYrfWtTABy2REz9ERu+/w3sMTt8BHV7ks36jsR5Bmyh/
	 KTt+JV7mViSE5xLp7NsaIWZy2IxKltu3kumuW9R9xH7c3Kzeoe9wvWtWKkIYRKiyO
	 zjpgBSTm54jTT3LNVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1uzURo0gKD-00b734; Thu, 05
 Jun 2025 12:57:37 +0200
Date: Thu, 5 Jun 2025 12:57:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
In-Reply-To: <20250604205513.GA1510819@coredump.intra.peff.net>
Message-ID: <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
References: <20250604205505.GA1510724@coredump.intra.peff.net> <20250604205513.GA1510819@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9/ia6hRECtHpAEUaYb3fJ9ph7uPPLIknQtTuqFsRyoRtrPdWeOn
 YdbysV5SNpbSUkbjLkvbWYq7cvlaRudyC+vD0GomBauzlfGMxFmIqSFCr4ACne7pdfy9Gx8
 ttDCn/pMvNXobYEowQFzW1rfb2WLhXBrrgxmcSecuEdNWDIsQDW+BEVQ/lyEPruV1NNar8Y
 DLRaTzwMJr3GLktxDw9+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0/70tyH7B+Y=;VtOjcNzJtfZWPxgKszTujLhf2uB
 +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
 snxEbQgk0hf+rDz77XQDRE/xniFBdOOA/ysp1w==
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, 4 Jun 2025, Jeff King wrote:

> The curl documentation specifies that curl_easy_setopt() takes either:
>=20
>   ...a long, a function pointer, an object pointer or a curl_off_t,
>   depending on what the specific option expects.
>=20
> But when we pass an integer constant like "0", it will by default be a
> regular non-long int. This has always been wrong, but seemed to work in
> practice (I didn't dig into curl's implementation to see whether this
> might actually be triggering undefined behavior, but it seems likely and
> regardless we should do what the docs say).

The `curl_easy_setopt()` function takes the parameter as a vararg to allow
for multiple types. That means that 32-bit systems wouldn't see a
difference (where commonly `int` and `long` are both 4 bytes wide).
Windows (and other LLP64 systems, if they exist) would be fine, too. But
on LP64 systems like Linux/macOS, it would make a difference. It might
work "by mistake" on little-endian systems if by happenstance the
remaining 4 bytes are zero.

> This is especially important since curl has a type-checking macro that
> causes building against curl 8.14 to produce many warnings. The specific
> commit is due to their 79b4e56b3 (typecheck-gcc.h: fix the typechecks,
> 2025-04-22). Curiously, it does only seem to trigger when compiled with
> -O2 for me.
>=20
> We can fix it by just marking the constants with a long "L".

I just offered an alternative in
https://lore.kernel.org/git/pull.1931.git.1749112304079.gitgitgadget@gmail=
.com/,
being unaware of your efforts.

Mine was driven by the failing `osx-gcc` job, and curiously after
(changing all the `l`s to `L`s and) rebasing to your series, I still have
this:

=2D- snip --
Subject: [PATCH] curl: pass `long` values where expected

As of Homebrew's update to cURL v8.14.0, there are new compile errors to
be observed in the `osx-gcc` job of Git's CI builds:

  In file included from http.h:8,
                   from imap-send.c:36:
  In function 'setup_curl',
      inlined from 'curl_append_msgs_to_imap' at imap-send.c:1460:9,
      inlined from 'cmd_main' at imap-send.c:1581:9:
  /usr/local/Cellar/curl/8.14.0/include/curl/typecheck-gcc.h:50:15: error:=
 call to '_curl_easy_setopt_err_long' declared with attribute warning: cur=
l_easy_setopt expects a long argument [-Werror=3Dattribute-warning]
     50 |               _curl_easy_setopt_err_long();                     =
        \
        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/local/Cellar/curl/8.14.0/include/curl/curl.h:54:7: note: in definit=
ion of macro 'CURL_IGNORE_DEPRECATION'
     54 |       statements \
        |       ^~~~~~~~~~
  imap-send.c:1423:9: note: in expansion of macro 'curl_easy_setopt'
   1423 |         curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
        |         ^~~~~~~~~~~~~~~~
  [... many more instances of nearly identical warnings...]

See for example this CI workflow run:
https://github.com/git/git/actions/runs/15454602308/job/43504278284#step:4=
:307

The most likely explanation is the entry "typecheck-gcc.h: fix the
typechecks" in cURL's release notes (https://curl.se/ch/8.14.0.html).

Let's explicitly convert all `int` parameters in `curl_easy_setopt()`
calls to `long` parameters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 http-push.c   |  6 +++---
 http.c        | 22 +++++++++++-----------
 remote-curl.c |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 591e46ab260d..f5a92529a840 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -205,7 +205,7 @@ static void curl_setup_http(CURL *curl, const char *ur=
l,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
@@ -213,9 +213,9 @@ static void curl_setup_http(CURL *curl, const char *ur=
l,
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
-	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 }
=20
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock,=
 enum dav_header_flag options)
diff --git a/http.c b/http.c
index ecbc47ea4b3f..d88e79fbde9c 100644
=2D-- a/http.c
+++ b/http.c
@@ -1540,9 +1540,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
=20
 	/*
@@ -1551,9 +1551,9 @@ struct active_request_slot *get_active_slot(void)
 	 * HTTP_FOLLOW_* cases themselves.
 	 */
 	if (http_follow_config =3D=3D HTTP_FOLLOW_ALWAYS)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 	else
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0L);
=20
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
@@ -2120,12 +2120,12 @@ static int http_request(const char *url,
 	int ret;
=20
 	slot =3D get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
=20
 	if (!result) {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1L);
 	} else {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
=20
 		if (target =3D=3D HTTP_REQUEST_FILE) {
@@ -2151,7 +2151,7 @@ static int http_request(const char *url,
 		strbuf_addstr(&buf, " no-cache");
 	if (options && options->initial_request &&
 	    http_follow_config =3D=3D HTTP_FOLLOW_INITIAL)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
=20
 	headers =3D curl_slist_append(headers, buf.buf);
=20
@@ -2170,7 +2170,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
=20
 	ret =3D run_one_slot(slot, &results);
=20
@@ -2750,7 +2750,7 @@ struct http_object_request *new_http_object_request(=
const char *base_url,
 	freq->headers =3D object_request_headers();
=20
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0L);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_fi=
le);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
diff --git a/remote-curl.c b/remote-curl.c
index 6183772191f2..b8bc3a80cf41 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -970,8 +970,8 @@ static int post_rpc(struct rpc_state *rpc, int statele=
ss_connect, int flush_rece
=20
 	slot =3D get_active_slot();
=20
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
=20
@@ -1058,7 +1058,7 @@ static int post_rpc(struct rpc_state *rpc, int state=
less_connect, int flush_rece
 	rpc_in_data.check_pktline =3D stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state))=
;
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
=20
=20
 	rpc->any_written =3D 0;
=2D-=20

I wonder why you did not need those?

In any case, would you kindly adopt these changes into your patch series?

Thanks,
Johannes
