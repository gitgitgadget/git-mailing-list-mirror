Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBC3BFE4F
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065355; cv=none; b=H+iA/vojItUeWHd+HzbmoMbTEhKDaPq8Pfh4i30Turw296NPo33RZDPpmNUwNnFVl8KY4jxFbwCW37CJzFOBEsoVZr45drMU1AZxSrkTejlEHMao71slW+l2XZPoFF3dj/IjI/FBoTRRW6xSAzVc0YxWPuOaMg01Nr88YlUJNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065355; c=relaxed/simple;
	bh=CiZDLu0gmTQd/5vBBCiEdDf1hzi2yDdICbSuVRiGieE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTQUH1FHFg+66K52yqe1y0wXOz4Arx5sG9X3bla4V24hqAejvAogTabp2OEtEzYld4gRs7cEyKBqwCzENl1hqNzmkWl9pJf4NWkodbTVTauIPmzdYQjZApMUqj+GlEZSsXpUGiBqEulx0cnXHW8bxCCl3ix2Z+6QuDcg/gqibBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=he+aT87u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABcEtTr9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="he+aT87u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABcEtTr9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AF475EC00DA;
	Thu, 10 Sep 2026 14:35:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 14:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789065352;
	 x=1789151752; bh=m51R//A/u4OzAlplx87dCTKxvysz+qnce+l+uRg8Wew=; b=
	he+aT87uyqhW8dHK7e4wHi6XL4KhK9ZOO5FJgVuX4R3x0fk7rpYA+IBmMQSVMcny
	jS77vm+rOgX2d4bnWL46qquWJNbY8JpECuycWGiNvibfPZSIoSVK8GFfvIayPECH
	YOC6i12EzqABINatxfCzAe2eNL/tAz/P66uTHzah8L9wKpPP4JYhX9UcTvkynU4o
	biOjW3iHfZ0WwaOWjpnIv3rKS1QpzQs8YlQNJ9hOF5/r/ttFWU79WD82Snx0xwGd
	a/48mECzLcAZjYsZsjOoDoCVDBEnHNJTgi8gba84eyFDH1cvhgb45orz8wSi2cH8
	Owgw7gQTbH2P5470msullg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789065352; x=
	1789151752; bh=m51R//A/u4OzAlplx87dCTKxvysz+qnce+l+uRg8Wew=; b=A
	BcEtTr9qC4bLM8PU5iX/EfmQ/qleSDrNKx1cGnO+iAGtlMxO1orn9QEFtBRb/yh5
	rHbqJo8rdSUmM0tejGXKP7saCVvtvjpgOrxq8FhjRufIhuFvuFpEs0CsK18ZCTRA
	2NymYCqoDwgsC7l6THm33n5+D8lQvYJLTTs0KsUy8y4UR0j2OgOW42Qy8uHmcraw
	dm06fZ4/KuxL55zzH2c16FFwPgdLnNx+WFAtF7SP6zhFNooijPGjOQHlaLnn2ZFC
	6L0FB42Pt4XT7D6hg7mTIb+iVp06p0jmW4j/KQa0gmFRKjgD63lyu7GNhM22sl2h
	GuhkrKF+xxLd2T/MQGUlw==
X-ME-Sender: <xms:iPiiagm9lIRxsQSlIxBOS6ZsBK2e3c6qtPpq-4NRma329J6dEuwdoA>
    <xme:iPiiajjU5x5iJacZp5GuD6iFdpK9mySC00bMyvLXWtFlI5NbjsXWmdcA1n6hPaTB-
    jU8hfDe4NeyZBz7xaE7CFgh5Dc42QqDN8chWMXlU0m9aaUCJSvgsYM>
X-ME-Received: <xmr:iPiiaocGw-1ZxmlZS_V8WnlCvNOGRex_qofd-DsyiEy6Ov4Ct8EC32TEf6gf63frc40RB6q4in_afTcnwIwmDY5CqM9CEsDDEJJP>
X-ME-Proxy-Cause: dmFkZTE2jtIcNqsxFd8vZ+wSGdPo7pdZ4Y0mdtn6UtZlIV2Zl9ClxYwXHIk/iztE53PeiH
    m+n1115H8yoB6xDvlHy3Ou36QSLbGxonfLZ/LI8CYKZt/xcJwHaaHKx/TqKIcT7oUI+DT/
    lBZ4kHCaZ6PfjpKNu3nx3yQhl1sGJLDzM6cjHts7B0rwgVFGGBRUgV+XUd3gK7bt7XU/Iw
    +RFX4C2w8CwFVK8X1azAVGI16+4lOdfybRg3+ycy2TFPhWUagG43VVwVsoam5F2LCfyV2a
    LdkYGh4UsUJdcn9o2cglVIacZn2steBPAC7E5oJF8PUeL2NPQtL5lWo39n5UebzHVIVrfQ
    gqSMO5IJHv+NbEDwVYxD9DK0MlvG54MM/EFRW/FzWkGCDsZXuxU7A/k9X4zZOxseCESJ4n
    QzhKuGdscM6v+WRL4PyEMXm5USuIZvndyqLkCgiUmEetLivDAPSwaH3JAxcvIk8suHPIJ5
    hMWHDlSZsWIY/7m5f3bOQkYWfR9xmuVEUqWhwDAgxXZXqZ2dcieC7DdnEsLDa42SIgsIRu
    n3V13tSy7cZFUZUDus+MzLXdz2stiF9khGhgqVn5+1FXNgdP3MY/q9OZ3/4G20xGUp2E+t
    OlhKWIwQRfT/7oHcF8eYJBFiTxCEZK3On9S9H1Rho8YKJc/3h0oQ0TCbj9Yw
X-ME-Proxy: <xmx:iPiiajiBSG6L025BwNXhcQMhscFdcyoXLBWUQkflEy7oHKDMxGkzOQ>
    <xmx:iPiiagwkDS9jIcfP721h087_wPNKZxh6l7RsRHeKHs7NXSaP03t_9g>
    <xmx:iPiiavM_Owk5O0v4t3qQfc21zUiOW2PIHCggvDP_deAiiACcidiA7g>
    <xmx:iPiiahUDu-VAeojgCI-skJxJF7z5fsCk2nYMTaSORCTviA0-Dp96Sw>
    <xmx:iPiiajvrcwK32RpketHuGICUviFC5USQNrRrQ2dkvJmgiA1H9c5fMlx6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 14:35:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  git@vger.kernel.org,
  ben.knoble@gmail.org,  gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260910155247.GA251185@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 11:52:47 -0400")
References: <20270829004959.90983-1-ub4nal@mail.ru>
	<20260910085353.109373-1-ub4nal@mail.ru>
	<20260910085353.109373-3-ub4nal@mail.ru> <xmqqzexpf78k.fsf@gitster.g>
	<20260910155247.GA251185@coredump.intra.peff.net>
Date: Thu, 10 Sep 2026 11:35:50 -0700
Message-ID: <xmqqpkyldke1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> I'm really not sure why anybody would use those other flags, though (or
> even --system, for that matter). After reading the thread again, I get
> why we want "--global" for advice that only affects new repository
> creation (like defaultBranchName), since otherwise it could never have
> any effect. But why would you ever want --system?

No particular concrete expected use case in mind.  But I figured
that it would not be too much additional effort to allow other
scopes once we need to add support to allow "--global" to be added
to the message.  I didn't think of "--worktree", but now you have
mentioned it, I tend to think it is more plausible to have real use
case than "--system" (which users often do not even have power to
set).

The primary reason why I didn't think of "--worktree" is because
output of "git config --help" has room for improvements.  This is a
tangent, but one of its SYNOPSIS item reads like this:

	git config set [<file-option>] [--type=<type>] [--all] \
		[--value=<pattern>] [--fixed-value] <name> <value>

And nowhere in the body of the documentation there is any
description on what <file-option> is.  There is this sentence

    ... and options --system, --global, --local, --worktree and
    --file <filename> can be used to tell the command to read from
    only that location.

in one paragraph that gives enough hints that these five options are
related to each other and give the closest thing as the definition
of <file-option>, but I wouldn't call it a very good form of
documentation.

There is a section called FILES, at the end of which has

       You can limit which configuration sources are read from or
       written to by specifying the path of a file with the --file
       option, or by specifying a configuration scope with --system,
       --global, --local, or --worktree. For more, see the section
       called “OPTIONS” above.

but it is not explicit that the section is talking about
<file-option>, either.

--- >8 ---
Subject: [PATCH] doc: clarify <file-option> in "git config --help"

The SYNOPSIS section of "git config --help" refers to <file-option>
without explaining what they really mean.

I *think* they meant to refer to the mechanism to limit the file(s)
read from or written to by giving the scope options or the '--file
<filename>' option.  Spell it out early in the description.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The SYNOPSIS section also refers to <display-option> for many
   operations; I have no idea what it means.  I left a needswork
   comment there.  We should either clarify it in a similar way, or
   remove it if it does not refer to anything.

 Documentation/git-config.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 57af010ade..3673226505 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -39,6 +39,12 @@ outgoing values are canonicalize-able under the given <type>.  If no
 `--type=<type>` is given, no canonicalization will be performed. Callers may
 unset an existing `--type` specifier with `--no-type`.
 
+The `<file-option>` in the SYNOPSIS refers to options that limit the
+read/write operations to a specific scope (see <<SCOPES>>) or a single
+file (see <<FILES>>).
+
+// NEEDSWORK: What is the `<display-option>` meant to refer to?
+
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
 `--system`, `--global`, `--local`, `--worktree` and
-- 
2.56.0-rc0-135-g9520983108

