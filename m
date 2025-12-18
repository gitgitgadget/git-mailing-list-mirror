Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68334BA34
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080800; cv=none; b=JVr2gyktY4PFG0ImCJANsbdQIxBaGqdMpglIKlqieCSC4W6P/iahw3VMHrXrwy7wpzg0FtXRYlpcZ12ajM7y2fd9MI/aOcOoIUJTkfjVjkWvhEvt5/TqhwzE8WHPOyREBVX2dhP07Ba1Z6wn9hF7bMWafSZJoo0+bGb7xALXCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080800; c=relaxed/simple;
	bh=ZvDOJQZLr/mwQS1hBprTxGsPouFIxas5liSkv46Rrxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d+ZrzGZ9CTGCKtKLpD8mB8igRhxDrDoHcYEehV61JvwURWsy8/FO516J1tM+AX9pJi2zSY+Orgq0b0I8TIDpZqnRm08JTSZJdmmi9jA9DBnYOvQ5Uzv9VoyMlvVXS7AbRi1UcAjiCBN+lIz9CPSzBRpcav9NG4NBF98vR+TZkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DpQ89Mbj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DpQ89Mbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766080790; x=1766685590;
	i=johannes.schindelin@gmx.de;
	bh=f53OVRDIq00KX2TlHoxgkaoQG3Gmkvsjt7dt06zhNjw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DpQ89MbjxJy4IxK+5RxlAhl2T5z72IefDm3yjKKqWREO8kwAhNW53/PBdJzBZA+T
	 Ae80iK+YiX9uMudkRSBiBQ4/Wu+28dXx1eatJROM2VPB9yQq6rURdxD0CZ22xyjRU
	 e4yYZb3DcUwXLMZ/BODO/rBwH+YDwhFdroPJ064uj+jsvIJ/8Z0mXvkF60ZqVAJ/1
	 daPuyFNGiANOYh9gnKwFvGtfQmtM9RDutHrxb91lLoBnqK/LyFAPKjvpyS2f55XvX
	 4JJPNmyzlu3YMf6W13v7Ta5j8Ux+/j0QkLjtXgC8t7myIcevyBCwFCQzzpyRUTvuR
	 u9ATldijayOcVyjNyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1wGP1O3O5n-00oAgi; Thu, 18
 Dec 2025 18:59:49 +0100
Date: Thu, 18 Dec 2025 18:59:48 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow
 control characters
In-Reply-To: <xmqqy0n0y1ep.fsf@gitster.g>
Message-ID: <9dd1aa88-badd-0cae-a2f7-21972548815c@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com> <xmqqy0n0y1ep.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NcQhoj9RkagG44Eve96/+VPUfRYHWp1CLO/WvnNACHmM2pjmD5u
 l39ueChdbHoFajxArJMaGkyTVGjkUMDyGR+Bc0DMCOMY1fx3+UD94HufAaMkcf2+vuduDvZ
 sVFN4RHE2jSbuEgG0oZdqfQSitSl2sYtQ5iaetoqLrbTfGDKJcKY213BfsvvBtxWRqDqpK9
 r2Fwvs/cIcF9HOX2LptiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HLFl1DhUwX0=;Kw3ekpdMVprtzJlHKOdUVnBmX60
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 18 Dec 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > diff --git a/Documentation/config/sideband.txt b/Documentation/config/=
sideband.txt
> > new file mode 100644
> > index 0000000000..3fb5045cd7
> > --- /dev/null
> > +++ b/Documentation/config/sideband.txt
> > @@ -0,0 +1,5 @@
> > +sideband.allowControlCharacters::
> > +	By default, control characters that are delivered via the sideband
> > +	are masked, to prevent potentially unwanted ANSI escape sequences
> > +	from being sent to the terminal. Use this config setting to override
> > +	this behavior.
>=20
> Two thoughts.
>=20
>  - Users may want to say "I trust this remote host" or "I trust this
>    remote repository".  For that, something similar to what we do to
>    `http.variable` to allow `http.<url>.variable` to take precedence
>    over `http.variable` would be necessary.

Good idea! What do you think about something like this?

=2D- snip --
diff --git a/http.c b/http.c
index d59e59f66b1..14b5a95586c 100644
=2D-- a/http.c
+++ b/http.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "object-file.h"
 #include "object-store-ll.h"
+#include "sideband.h"
=20
 static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
 static int trace_curl_data =3D 1;
@@ -566,6 +567,9 @@ static int http_options(const char *var, const char *v=
alue,
 		return 0;
 	}
=20
+	if (!strcmp("http.sanitizesideband", var))
+		return sideband_allow_control_characters_config(var, value);
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
diff --git a/sideband.c b/sideband.c
index 725e24db0db..178c1320cac 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -26,13 +26,14 @@ static struct keyword_entry keywords[] =3D {
 };
=20
 static enum {
+	ALLOW_CONTROL_SEQUENCES_UNSET =3D -1,
 	ALLOW_NO_CONTROL_CHARACTERS =3D 0,
 	ALLOW_ANSI_COLOR_SEQUENCES =3D 1<<0,
 	ALLOW_ANSI_CURSOR_MOVEMENTS =3D 1<<1,
 	ALLOW_ANSI_ERASE =3D 1<<2,
 	ALLOW_DEFAULT_ANSI_SEQUENCES =3D ALLOW_ANSI_COLOR_SEQUENCES,
 	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<3,
-} allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
+} allow_control_characters =3D ALLOW_CONTROL_SEQUENCES_UNSET;
=20
 static inline int skip_prefix_in_csv(const char *value, const char *prefi=
x,
 				     const char **out)
@@ -44,8 +45,19 @@ static inline int skip_prefix_in_csv(const char *value,=
 const char *prefix,
 	return 1;
 }
=20
-static void parse_allow_control_characters(const char *value)
+int sideband_allow_control_characters_config(const char *var, const char =
*value)
 {
+	switch (git_parse_maybe_bool(value)) {
+	case 0:
+		allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
+		return 0;
+	case 1:
+		allow_control_characters =3D ALLOW_ALL_CONTROL_CHARACTERS;
+		return 0;
+	default:
+		break;
+	}
+
 	allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
 		if (skip_prefix_in_csv(value, "default", &value))
@@ -61,9 +73,9 @@ static void parse_allow_control_characters(const char *v=
alue)
 		else if (skip_prefix_in_csv(value, "false", &value))
 			allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			warning(_("unrecognized value for '%s': '%s'"), var, value);
 	}
+	return 0;
 }
=20
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
@@ -79,20 +91,12 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >=3D 0)
 		return use_sideband_colors_cached;
=20
-	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)=
) {
-	case 0: /* Boolean value */
-		allow_control_characters =3D i ? ALLOW_ALL_CONTROL_CHARACTERS :
-			ALLOW_NO_CONTROL_CHARACTERS;
-		break;
-	case -1: /* non-Boolean value */
-		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
-					      &value))
-			; /* huh? `get_maybe_bool()` returned -1 */
-		else
-			parse_allow_control_characters(value);
-		break;
-	default:
-		break; /* not configured */
+	if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET) {
+		if (!git_config_get_value("sideband.allowcontrolcharacters", &value))
+			sideband_allow_control_characters_config("sideband.allowcontrolcharact=
ers", value);
+
+		if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET)
+			allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
 	}
=20
 	if (!git_config_get_string_tmp(key, &value))
diff --git a/sideband.h b/sideband.h
index 5a25331be55..e711ad0f4e0 100644
=2D-- a/sideband.h
+++ b/sideband.h
@@ -30,4 +30,11 @@ int demultiplex_sideband(const char *me, int status,
=20
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int pa=
cket_max);
=20
+/*
+ * Parse and set the sideband allow control characters configuration.
+ * The var parameter should be the key name (without section prefix).
+ * Returns 0 if the variable was recognized and handled, non-zero otherwi=
se.
+ */
+int sideband_allow_control_characters_config(const char *var, const char =
*value);
+
 #endif
=2D- snap --

If this is the direction you're thinking, I'll polish it and integrate it
into v3.

>  - It may no longer matter but a remote repository that may send
>    messages as strings encoded in ISO/IEC 2022 would need to set
>    this, merely to make the messages human-readable.  There may be
>    other reasons the trusted repositories want to send "escape
>    sequences".

If the remote side has no way to determine whether the client side is
connected to a terminal or not (which we have already established in this
thread), it has even less chance to determine which character encoding is
in use...

> It might even be a good idea to make the default setting of this
> variable "allow", except for the initial connections to repositories
> (i.e., "git clone $URL", and "git fetch/ls-remote $URL" with an
> explicit $URL without using a nickname recorded in our .git/config),
> as visiting a potentially malicious remote repository you are not
> familiar with may not be uncommon, and users may deserve protection
> over inconvenience.
>=20
> But once the user establishes a working relationship with a remote
> repository, would it be a lot more common to trust the contents
> there than be on the lookout that the repository may spew bad
> strings of bytes at your standard error stream, I have to wonder.

I am not so sure whether that would be desirable, for (at least :-) ) two
reasons:

- `git fetch` with an explicit URL is sometimes used outside clone
  scenarios, and in some clone-type scenarios, `git clone` cannot be used
  (e.g. to establish credentials or to determine the appropriate sparse
  checkout based on information from the tip revision).

  I know that it is a delicate balance to strike between convenience and
  security. Yet I also know that users prefer easy-to-explain mental
  models and this logic would be a bit hard to explain: Why disallow
  something while cloning or fetching with an explicit URL while allowing
  the very same thing in a subsequent fetch?

  tl;dr I expect users to be much more okay with the strategy to disallow
  all but very few ANSI sequences by default, with a message that tells
  them what to do if they want to enable more (or all) control sequences.

- I do not see how the user can inspect what the remote side does, even
  after an initial clone. Therefore users would not have any reasonable
  chance to gain any confidence that the remote side isn't doing anything
  malicious. To the contrary, remote servers could specifically "behave"
  during a clone, and launch the attack only during a fetch (indicated by
  "have" lines in the request).

  tl;dr remote servers don't get more trustworthy just by successfully
  serving clones.

Does that reasoning make sense to you?

Ciao,
Johannes
