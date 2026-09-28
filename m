Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23D3B813D
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578867; cv=none; b=qGdbWHz02OtgrYUeUQF73W+etWc6asROltG0CfPOaqzmUMotVpvU4VbNTv9oRJRg8jspdr6qOhVAB7U/gOTBSS6+tU2ehlVn6lqyzOPYOOChrrHFryCktVtVEHeYdtALxPjQ8ZJY6hcvf2fklcDUMdlarJsHxmnzZ8Gfc/VCd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578867; c=relaxed/simple;
	bh=pZoqa2qAg2+3gP0DyTBEeLqjLQJeq0LtOUJejKKE0gQ=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=GAxxLsO8nVUXHiWVKLXR5xzaFr8dGSLmECDtBY3+2ESGu0tPckMAcwG6s8mPyR4ENsFg9QbBttnrZTXkuaNIgvSoD9qZiOknVZF+YYiQzeGpcgHONXIxolMTBmN1bDAyNBZHrR6dOrzGYiSlKSyhaBZAyiRn4CX1ZRYgGYBmEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.joshka.net; spf=none smtp.mailfrom=lists.joshka.net; dkim=pass (2048-bit key) header.d=joshka.net header.i=@joshka.net header.b=O9l+uKrK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/TmODrC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.joshka.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.joshka.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshka.net header.i=@joshka.net header.b="O9l+uKrK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/TmODrC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B0D11D0008A
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 03:01:04 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 03:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joshka.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1790578864; x=1790665264; bh=5ULasp7VVy
	ZNQoJKDteoxPJKil3uYf68TKTI4ckHM4o=; b=O9l+uKrKIEKBergDDbNe4hSEjo
	d85dZW7w9rJntio/2nkS3TI8ZIqHq8y3iOE+GaIoOLEkCZUsvgSC0x6oLp+X9BO7
	50QSY/22sSPazHuBDB5yF5J8aRFX6bU1uAcqB7PlG0cOKaIy8Sy0aUdx+MONVUa8
	dUN3kz1tcOGi6bIGpcm/KWtqwoxMBiZQYFCBHaEcIy7EEk+bRrbd7BG6ZtghWKCq
	vmzxXVR4+Hs0/AbI9qvyumD7MFe5lBat5aocsTtKK7X/aio7IG7Xt+3dOZuxY608
	WNdnZV9NuvMjf49X6e4hGiHlRuwksA4K88dbevsSIYjKOjGbDXXlTii4nIgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790578864; x=1790665264; bh=5ULasp7VVyZNQoJKDteoxPJKil3uYf68TKT
	I4ckHM4o=; b=H/TmODrC6d20upeK50WDW4urhVSAKSAklxnVpjLyJBW2ZxexraR
	nWMi671V7bHMAM9F0Ka3cJssbuqZ56mmka+iM1RHHa88jL7T/bMIPTnNXMBU5J9C
	girP5Nj4eaZfnzA2DTeKpstQkLOyFE80pyxdoMJymtEF++Cszbzje5k4M9sOHwfC
	hhnrxHrFdoEJtNji+zUfwrqvR0F4U/tjSocsg8h7bZ66TNZofxdOnvugL1twoC4n
	CMZPw7iAVY2MfqkdRIGoFjOv79wJI6k7xwCOgvV2GDeeGlYRKh3HIExNMqlvjCH2
	Zmx+305ZbuWyxHLYkhWiD7tej3RuFj6774Q==
X-ME-Sender: <xms:sBC6aq2cETHBxf6KXBZ_gzRmiw5k7-rxCCSsCR1_cqAfUb5DUcXY7g>
    <xme:sBC6an73TQgx6TY9QVKgFSJ5600M03byQnJm8lMXjz_66_TOgbQhhM9GpLWbQJ8G2
    oleArs4-ebf2O-yCRaw0kLBcod-_vKwXrN3HMP7g_-nUcHMZYX8lac>
X-ME-Proxy-Cause: dmFkZTGtw41yVXP3k7xhToLHerpBjS/xsbGQ7umA+FuSmq3/ZkrsdgXAHNDggE9zYTqdRX
    A9vnKERlB9D3yt0NHtkjCBX3QXQVidYQ/8CgU5uVNQsle3bbRpD2+NncuBDfIUkCHLSPhI
    WxH1lf9dsHzabNkDhYdvzosBtu+DTFzHz7nNVYZ+RJABHG2IBtJlf3e/QYD15NVmsFclWE
    y6t87FauKBAEjJT+ZJDnGAO0BuwTtxEgtAxy7tqcykB6k2cDbVBPW2d3LHePAOYz3xP4rF
    rAXunP+iFI44Ppbg4DaZGVGE4uT79gp5LGBAJTawsJsgCKpDAE13Ee5JWzoo8VwvRBQzEP
    ICbBJwzm8eOvyy4QuqAyRDlKBZ0J9/fY64lTvS6VDcxUrYzjvBPw5qS7PWOhIpOI8IE/gK
    jSFvEixZUFrMqYbGjxlVFCM6sW+zHOS5Oqi3/52lqjDXzcFeLFfO/yCMi1ISjuf1r9cpLe
    bVBMSsMPMKkdyXukZL0ixLdTKnv8CgvzfJo2xSIkGayos1LqUPNT2Q6SpO2jCsOLRYE2sm
    qUHAmnZUBa6qwPV2j7dUi8tuf5LVrF4vLqiI4n2OiotRgCfM0s1+7w8ubzMmsRPaa3oC3b
    adpu7NgLiEWY9XawMAq1HaGi92ymX9XXQgzpmDKm9V0fXAaVC//2vazf7zFg
X-ME-Proxy: <xmx:sBC6amnvexErdNBfVvivTsNw3TH0gC5rcgUkUA6fqcMwE6PCbks6zA>
    <xmx:sBC6atzGHvaAT_aeFuyGKrFGwB3DfiKnJnEHBhKQZxEfs2B5Czovlg>
    <xmx:sBC6ahhJuS2HYvzKDsq3Hau3risC0puHePMuaoAqoL_KZLiriVfI-A>
    <xmx:sBC6aiWcWuPL-oFLxQOnKqvVAn_RF3JAjTnXMDCEvI7z7KPWb1Gc6w>
    <xmx:sBC6athIRCNVvEFZ0UFcU4ZxSX7wrpc-4AP7zVs_kXK82G-cczCiY5bA>
Feedback-ID: i504042c9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 33B5F700069; Mon, 28 Sep 2026 03:01:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 00:00:43 -0700
From: "Josh McKinney" <git-bugs@lists.joshka.net>
To: git@vger.kernel.org
Message-Id: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>
Subject: Reftable reflog timezone encoding differs from specification
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Git 2.55.0 appears to store reftable reflog timezone offsets as signed
HHMM integers, whereas the specification requires signed minutes.

https://git-scm.com/docs/reftable#_log_record states:

    "tz_offset is the absolute number of minutes from GMT the
    committer was at the time of the update."

The specification also gives GMT+0230 as an example encoded as 150.

I reproduced the discrepancy on macOS arm64 by creating a SHA-1
reftable repository and committing with this date:

    2026-09-27T12:00:00+05:30

An independent Python/zlib inspection of the resulting reftable found:

    Stored timezone bytes: 02 12 = 530
    Expected signed minutes: 01 4a = 330

Both HEAD and refs/heads/main reflog entries contained 530. Git reads
its own entries back correctly as +05:30, so its writer and reader
appear internally consistent, but disagree with the specification.

Here is a reproducer using only Git and Python's standard library:

(
    set -eu
    proof_dir=$(mktemp -d)
    cd "$proof_dir"
    echo "Repository retained at: $proof_dir"

    export GIT_CONFIG_NOSYSTEM=1
    export GIT_CONFIG_GLOBAL=/dev/null
    export GIT_AUTHOR_DATE='2026-09-27T12:00:00+05:30'
    export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"

    git --version
    git init --initial-branch=main --object-format=sha1 \
        --ref-format=reftable example

    git -C example \
        -c user.name=Example \
        -c user.email=example@example.com \
        -c commit.gpgsign=false \
        -c core.logAllRefUpdates=true \
        commit --allow-empty -m "Timezone example"

    git -C example reflog show --format='%gD' \
        --date=iso-strict refs/heads/main

    python3 - <<'PY'
from pathlib import Path
import zlib

directory = Path("example/.git/reftable")
for name in (directory / "tables.list").read_text().splitlines():
    table = (directory / name).read_bytes()
    assert table[:5] == b"REFT\x01"
    footer = table[-68:]
    log_start = int.from_bytes(footer[48:56], "big")
    if not log_start:
        continue

    assert table[log_start:log_start + 1] == b"g"
    log = zlib.decompress(table[log_start + 4:])

    # Fixture-specific: email, variable-length time, then timezone.
    email = b"example@example.com"
    search_from = 0
    while (position := log.find(email, search_from)) != -1:
        position += len(email)
        while log[position] & 0x80:
            position += 1
        position += 1

        raw = log[position:position + 2]
        offset = int.from_bytes(raw, "big", signed=True)
        print(f"Timezone bytes: {raw.hex(' ')}; integer: {offset}")
        search_from = position + 2
PY
)

The relevant output is:

    refs/heads/main@{2026-09-27T12:00:00+05:30}
    Timezone bytes: 02 12; integer: 530
    Timezone bytes: 02 12; integer: 530

Is this a known discrepancy? Which representation should interoperable
implementations use? If either the implementation or specification
changes, how should existing tables be interpreted, given that values
such as 330 are valid under both interpretations?

Given that Git consistently writes and reads HHMM values, I suspect the practical resolution is to update the specification to match existing behavior. Are there other implementations or compatibility considerations that would prevent that?

Thanks,
Josh

-- 
Josh McKinney
joshka.net
