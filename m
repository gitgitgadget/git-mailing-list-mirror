Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7118AEA
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015149; cv=none; b=PgIwenb/0H9uNgXB4VQntXUcbp7dXmj4NCgl8bSGrLpRKYsMVqocWzT0VxCp5dEWZ68eeutlt2jf6xWpcRJGgHJTpn/y6tLDXirAXbPOPDF5Vc5K6CD8fLEpERGNrnDF8ZhhRWXagZX253d0LHC4m8NvJ/rCovXZ74hID45w8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015149; c=relaxed/simple;
	bh=TvhmMTu5ndwm616VEZcEVNWg7uv3ODtT3MDG7fAh71s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZ1b4SKBEcn4JHmskf8y3WcsP+9+yjWRk5t55yZQ7498T0Bw/rZxOcpTdDR2JFefAKnAqJXQ8pl9UzAu/oUZh02rA5J3SoxP1xlWaDdt0H3bsZ5MYXj2L2mGJUaeNjbD8PoeJqs9D8Vx7fWXZCDufyXgg0bu1xuIETKcpSRMAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YpixvCpT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YpixvCpT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5721D30F94;
	Fri, 26 Jul 2024 13:32:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TvhmMTu5ndwm616VEZcEVNWg7uv3ODtT3MDG7f
	Ah71s=; b=YpixvCpTaKKRH6cqzrDaQSA39DDXpPfwxbTojnXHEHmYTGJftPVfeS
	i7Ajz2msEclD8LiParricexL7J3wHH3PltgdYixrpeQOJZLuhd44o+PRzXdEj5lU
	WOKGGrwUnAP/WnMdNsCA76FBHXbLZEkgfCnLB1GDZCOq2zzkZiQEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F27B30F93;
	Fri, 26 Jul 2024 13:32:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFAF530F92;
	Fri, 26 Jul 2024 13:32:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jayson Rhynas <jayrhynas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix hex code escapes in git-ls-files
In-Reply-To: <CACStHN-Gs2Sxej+md6zWr3V1dFo+pp=B4yEPm9=uPambDR2NaQ@mail.gmail.com>
	(Jayson Rhynas's message of "Fri, 26 Jul 2024 11:41:40 -0400")
References: <CACStHN-Gs2Sxej+md6zWr3V1dFo+pp=B4yEPm9=uPambDR2NaQ@mail.gmail.com>
Date: Fri, 26 Jul 2024 10:32:24 -0700
Message-ID: <xmqqh6ccvz2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 061A3076-4B75-11EF-A4FF-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Jayson Rhynas <jayrhynas@gmail.com> writes:

> The --format option on the git-ls-files man page states that `%xx`
> interpolates to the character with hex code `xx`. This mirrors the
> documentation and behavior of `git for-each-ref --format=...`. However,
> in reality it requires the character with code `XX` to be specified as
> `%xXX`, mirroring the behaviour of  `git log --format`.

Given that no placeholder strings ls-files uses begin with two
characters that are valid hexadecimal, it is tempting to say that we
probably can teach strbuf_expand_literal() to grok %XX the same way
as %xXX for 256 cases where XX is hexadecimal, and do away with this
documentation update, and it would make things consistent.

Doing such a change is also almost trivial (see below).

But "git log --format" shares the code, and over there, %cd is a
placeholder that is committer datestamp, not a byte with value 205,
so that would not quite work.

> Signed-off-by: Jayson Rhynas <jayrhynas@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index d08c7da8f4..58c529afbe 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -219,9 +219,9 @@ followed by the  ("attr/<eolattr>").
>
>  --format=<format>::
>   A string that interpolates `%(fieldname)` from the result being shown.
> - It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
> - interpolates to character with hex code `xx`; for example `%00`
> - interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
> + It also interpolates `%%` to `%`, and `%xXX` where `XX` are hex digits
> + interpolates to character with hex code `XX`; for example `%x00`
> + interpolates to `\0` (NUL), `%x09` to `\t` (TAB) and %x0a to `\n` (LF).
>   --format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
>   and `--eol`.

The change looks good.

Thanks.



[DONOTUSE-BROKEN] Allow %XX as a synonym for %xXX

 strbuf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git i/strbuf.c w/strbuf.c
index 3d2189a7f6..3594e10d09 100644
--- i/strbuf.c
+++ w/strbuf.c
@@ -443,13 +443,13 @@ size_t strbuf_expand_literal(struct strbuf *sb, const char *placeholder)
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
-	case 'x':
-		/* %x00 == NUL, %x0a == LF, etc. */
-		ch = hex2chr(placeholder + 1);
+	default:
+		/* %x00 == NUL, %x0a == LF, etc., with 'x' being optional */
+		ch = hex2chr(placeholder + (placeholder[0] == 'x'));
 		if (ch < 0)
 			return 0;
 		strbuf_addch(sb, ch);
-		return 3;
+		return 2 + (placeholder[0] == 'x');
 	}
 	return 0;
 }
