Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6F2010EE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120683; cv=none; b=EYoy5UJR7YzUO1BPJsMFLyZKSb2JJhjpOQzL32PcMBALt6npi3M6zZifO/M+iPlolwsYVBP/h3YZ7MckzGm7K7UJFRts6ztXaHDmMN6EIzKOF8qG7FgcMqLYH5w6OqVpWebwm6fRv5cCKY2f/qzMRMxW2zw972lt9AchezEF8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120683; c=relaxed/simple;
	bh=1vs5oHIehemn2D1RzRfeWfOiKQz0IVQpUNgWNSIpci4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJq+fuz4qIDU95yur+oLRbW6752PsOFjuzC076GkDMpgGx6euxD9aTEowPFX3FLSGZrjJLbOn1thL1c3npUXtSJ6riGnmVQp9vVXzg7nsPErHfl2rXHblpXnrs9Y3XSOi8Aso+61xu52GO52rdyHCtH25L8JDhpMWPnxtoZlvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=mZzSo38n; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gRiXDJ5O; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="mZzSo38n";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gRiXDJ5O"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mZzSo38n8JbQr6R3RKoJkYQEpi/1d5L/vHVR7/u2yCwINQBBQo+B6l+oeEE2LuxTEwvpyAh9Ja+iHxxUPXQw7+y4gLXS8Syk2yaQ3EI+c+5I9be855cj8IIF8RK4VgzvHmYb9SGqw66bvnInOCChTSIVaCQ0of8eC6Bd3PFeNvJSJsYw+SugoyC2oPq4dXOAr+NC1kFR4CEQbzmedryCXDdZ+jQsKXY0ObP1I2v8cQqi79CP/AAF2ankuWgzCypjuMUyTkdPm+KO1XIX1c0mtx7tHlDiX+ciNVp2TQQsMk6gzEdnBUx8kzxCC2nYU+EkRKIQftTIoEsxS/fwagtMlg==; s=purelymail1; d=malon.dev; v=1; bh=1vs5oHIehemn2D1RzRfeWfOiKQz0IVQpUNgWNSIpci4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gRiXDJ5Orlx9hu6lNuIelty/NSy3V26YpgPMkurzpHVF5LMApC7iK0NEItTWbxN4jeEpVIxmOLyQGUlKZATz9bama6p1BreQER/09yhENl9U/Q+v1yexcH+aoxtPlA2kCVP5yQAo0C1DxnNOVKjOr8uGLe5Lo1eAUUA/iSTzVI22mo+OfOGrotsvvgHXy8EEmBJmnJoSnfJ128IGmdfVQgoIb2PO8HoQjJMu2Hl8h/aMZS9XlAl0r5+fI9FGGQGxywQReP1NxBsoKnf4JaQTuh8BcPrqn6qB1hBEhsYV9/t05kNVzBejb28RmysLrDCJgcfr1HKPjrDIm45M75RWTw==; s=purelymail1; d=purelymail.com; v=1; bh=1vs5oHIehemn2D1RzRfeWfOiKQz0IVQpUNgWNSIpci4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 268502914;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Mar 2026 05:31:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2] diff: document -U without <n> as using default context
Date: Tue, 10 Mar 2026 13:30:32 +0800
Message-ID: <20260310053032.129327-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309172719.125419-1-cat@malon.dev>
References: <20260309172719.125419-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The documentation for '-U<n>' implies that the numeric value '<n>' is
mandatory. However, the command line parser has historically accepted
'-U' without a number.

Strictly requiring a number for '-U' would break existing tests
(e.g., in 't4013') and likely disrupt user scripts relying on this
undocumented behavior.

Since we are retaining this fallback behavior for backward compatibility,
update the documentation to explicitly state that '<n>' can be omitted
for the short option '-U'.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 Documentation/diff-context-options.adoc | 6 ++++--
 Documentation/diff-options.adoc         | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-c=
ontext-options.adoc
index e161260358..42d29a0c00 100644
--- a/Documentation/diff-context-options.adoc
+++ b/Documentation/diff-context-options.adoc
@@ -1,7 +1,9 @@
 `-U<n>`::
 `--unified=3D<n>`::
-=09Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
-=09or 3 if the config option is unset.
+=09Generate diffs with _<n>_ lines of context. The number of context
+=09lines defaults to `diff.context` or 3 if the config option is unset.
+=09(`-U` without `<n>` is accepted as a silent synonym for `-p` due
+=09to a historical accident).
=20
 `--inter-hunk-context=3D<n>`::
 =09Show the context between diff hunks, up to the specified _<number>_
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.a=
doc
index 9cdad6f72a..40502639a2 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -127,8 +127,10 @@ endif::git-log[]
=20
 `-U<n>`::
 `--unified=3D<n>`::
-=09Generate diffs with _<n>_ lines of context instead of
-=09the usual three.
+=09Generate diffs with _<n>_ lines of context. The number of context
+=09lines defaults to `diff.context` or 3 if the config option is unset.
+=09(`-U` without `<n>` is accepted as a silent synonym for `-p` due
+=09to a historical accident).=09
 ifndef::git-format-patch[]
 =09Implies `--patch`.
 endif::git-format-patch[]
--=20
2.43.0

