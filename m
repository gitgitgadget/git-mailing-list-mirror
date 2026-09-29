Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276C3DB320
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719114; cv=none; b=IzgezCd3dzbgQue0+2ate5N9gHQzrfedgeQB+sjNu0U2nLYRUN4tQp2y++jYyUn6Nyj9OClGEI04UucbF9UF6XYImHbPrBqUFUHLsqCql9txjgfBVOm7z7CwDFz9dkQtiDlLoPvPqiQWlSovXUcs9AeScbXSUBXJXTGvF/qFRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719114; c=relaxed/simple;
	bh=3v8YHw8f+6QC2sDEZO8lFEOdD2YMdIU26P7vyF8E/kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XU4EjsXLklUsqRLgzSVOnTbqj1XlNMXshjDCG5kiI+IkR023p9jk2+tacjb6o/4c3RNsAfA0xWLHFfk+JoIsJqiHjloGs1cVs32erz2E/LmkLOL/cd6qKsMKrR6/UVYvaCzjBGOtNoDDpBYoE8YAOkNlJjEsCdoVST1NtBalX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X0XaM76S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DukCJ+hg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X0XaM76S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DukCJ+hg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A5C3A1D0076B;
	Tue, 29 Sep 2026 17:58:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 17:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790719111;
	 x=1790805511; bh=fRhHuKjlRiXDaZsDyV3qj7NR82gKW+THDihNakeYCos=; b=
	X0XaM76SyimPT7WP/xK4XpZBYYXZ65yrxlIKFOwbrgO7b79UQcO+9XwpRjC1bSlO
	lPh3AwMirdjBLmieyseyJPzEW1QzCt+LBdK084sFaj4Ypm0qXVo1MqxRajYJ64at
	vsg2petkUf3YoerDdpmA4gYcMSqtUmHlw1ImrmCknGO4P1VEv05OLAP1Vqmc1sO+
	gPqS/kHnclCJj5RDmZJG5WS2zuBBuK7F8mW2k3oWDdPOAW3ZM0KSR5Xcv1RqZ62W
	ilvp56LL94Y4zD2nHnZDXSPKP8RdCv456L1xTK9QcGUNAWotNjNtpUuIsG9vApfa
	EroHq6uoeDTNnBvuJ9HarQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790719111; x=
	1790805511; bh=fRhHuKjlRiXDaZsDyV3qj7NR82gKW+THDihNakeYCos=; b=D
	ukCJ+hgM07xCzjAV6oOXiY2J1CVyXpeR0cfvUtEOpPSrpy2ODaO3plddVN3m4O4Y
	a0/DXqHBK1GM5cEID/+6tvQc4uQXVV//1StLzouUShmX6ZXxFo8DTR9cdUnZrwlh
	dQjI44aU2u+7G6lu8j6BZuv8uvnbGxMV2fO+uF/OT62GKJgWOl/z6sbWhdvNZkJp
	erbFsmhvCp3mqWWG8gRrShHOhkT7CjmC/z6zgsnFgbfwESnnvGTxIgfafdgEiKfR
	MUkPg+CVeChzZpRhAg69ske0ih4ynmd19vNaTex3V+iMWsrtaQxEClBvYVNEnFNn
	PGrUBAvDBeU0WgESBOYJA==
X-ME-Sender: <xms:hzS8asFiOiyNVHP0rRRMDu60KrM3XRRSQnrqrqCR9tbw0Vlvzjj2dw>
    <xme:hzS8asNYrsxGaRZ7UVY4YpM0PnBS39UZx8FvulDGWefOVhmskkNszwCoGjvLnq0pf
    0dRJlZkNd2EHuPRW5Rt8h2JDIHgRwgQeiaf6LUldyL_vb_TUY-QXlA>
X-ME-Received: <xmr:hzS8aueP0VpPexTdmtP8BOJVScML1InOtkZuDFQjavscRDwerj8HMXMVHKuT08ynm7Nialzi-IDFnq5zij2QzvcdIRAGe66aSn0v>
X-ME-Proxy-Cause: dmFkZTFgzEy5fIqm18BlSNe7obJxV7cTELOlWcwboB0eTvcHwFiGuI4ZJqgFH4qofJsc+H
    oetiw++6I8Ap1ZVtA4TQ5x6+zJYNJzaDJGOJ9FHVXtxZFfDdIzT+Zh2q+nFeaFeKMWriO2
    fIlRd1GWpW4ZG+LjnuuNwLu7gEuj3X2uC4cF5gFT0oHPg+XUMYGCPy1COQ8oroXwvOIL8I
    7jVOdtUYzgHJkMlQ1NeU6XHSL6mIl9vRBma9P53meKIWcnXhiFI1+6DiHFljoHI5ose8T/
    wetmQlvr3SRlR53UbrkHrbhr9OvT7eq0G6XHrIrWLS959GebsIeTUPU8eAcSjxOtHUswBP
    narxqxjB8pK0ryOrA1FUREsKuaVY02WBREZTlg59LH/5Lk/Gy1Na28fuYAZxlynmxcWRHj
    r5ZYvJHy6kDDuoWN/VfcFUzdT2H/E9TKFWuA5rfa8SQ8NIqETsGWArqJl77tEdGyLCHxyA
    EB5pqE/45UV60uKqdcIbwYjtlSQI9j4e+poayVP/I7cgPxTRiupn46CETE6B/D97b/jsmb
    xuxKmegE8GQFWAINQQt1FPp9TngY2Y6CEzRa/g9+SyKDX9/icgFG0O0d2vvvvEz1Qt+od1
    jzvSBBsdKdK0V0056n8empPz/2Fb5VEvKhqlkOoudQ9RZzEH5caUSZKHfZFA
X-ME-Proxy: <xmx:hzS8apv5GHPR2NlCP6BPbIBuhgW7XhGWMpedaL7-SSGWh3A2wuYZFQ>
    <xmx:hzS8avlF3Sv6McyV9RR0CihoopPS56v8urrYi3m79cMJh7QGAJz0bg>
    <xmx:hzS8arzanO3YoLz2LHtDcqbCFOxFv8V8adz4_CdK5Z1I6vsS7wRvew>
    <xmx:hzS8ahNS1xuy6O6dhyulX1WWf87s-JD1xUvBerVrYUHCUS-U05hNDg>
    <xmx:hzS8ao9LGlnmYg_Pq5iy5UMP0sZr61uUeeYk6-dG5lj3cn4dhChzlJHo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 17:58:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>,
    Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 28 Sep 2026 20:25:19 +0000")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 14:58:29 -0700
Message-ID: <xmqqcxtven3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Documentation/MyFirstObjectWalk.adoc |   2 +-
>  Documentation/git.adoc               |   2 +-
>  Documentation/gitcore-tutorial.adoc  |   1 -
>  Documentation/gitcvs-migration.adoc  |   2 +-
>  Documentation/gitglossary.adoc       |   1 -
>  Documentation/gittutorial-2.adoc     | 422 +--------------------------
>  Documentation/gittutorial.adoc       |  23 +-
>  command-list.txt                     |   1 -
>  po/bg.po                             |   3 -
>  po/ca.po                             |   4 -
>  po/de.po                             |   3 -
>  po/el.po                             |   4 -
>  po/es.po                             |   3 -
>  po/fr.po                             |   3 -
>  po/ga.po                             |   3 -
>  po/id.po                             |   3 -
>  po/it.po                             |   4 -
>  po/ko.po                             |   3 -
>  po/pl.po                             |   3 -
>  po/pt_PT.po                          |   4 -
>  po/ru.po                             |   3 -
>  po/sv.po                             |   3 -
>  po/tr.po                             |   3 -
>  po/uk.po                             |   3 -
>  po/vi.po                             |   3 -
>  po/zh_CN.po                          |   4 -
>  po/zh_TW.po                          |   4 -
>  27 files changed, 14 insertions(+), 503 deletions(-)

One thing I forgot to mention.

I think we try to stay out of the po/ directory unless the patch is
about updating translated text to catch up with translatable text
that was updated by code or doc changes.  IOW, unless you are
working on the patch set as a member of the l10n team, you do not
touch these files.  This is to avoid unnecessary churn and
burdening the l10n teams with synchronization pain.

The above is my understanding of the workflow agreed on by people
inside and outside the l10n group, but I'd like to double-check
with the i18n coordinator (Cc'ed).  If I understand correctly, the
recent workflow used by the l10n teams gives more autonomy to
individual teams than before, which may have changed the equation.

The removals we see in the diffstat touch lines in the early part
that appears in the manual page, namely ...

    gittutorial-2(7)
    ================

    NAME
    ----
    gittutorial-2 - A tutorial introduction to Git: part two

    SYNOPSIS

the string used for "NAME", and one of them looks like this:

        diff --git c/po/es.po w/po/es.po
        index aa1bb9bf90..dcdcbf5360 100644
        --- c/po/es.po
        +++ w/po/es.po
        @@ -14046,9 +14046,6 @@ msgstr "Montar un repositorio dentro de otro"
         msgid "A tutorial introduction to Git"
         msgstr "Un tutorial de introducción a Git"
        -msgid "A tutorial introduction to Git: part two"
        -msgstr "Un tutorial de introducción a Git: parte dos"
        -
         msgid "Git web interface (web frontend to Git repositories)"
         msgstr "Interfaz web Git (interfaz web para repositorios Git)"

I'd say a patch set like this one, which is not about updating the
localization, should just leave po/ intact, since the removal does
not help without a corresponding addition from the same "NAME" in the
file that replaces this "gittutorial-2", which reads like

    gittutorial-2(7)
    ================

    NAME
    ----
    gittutorial-2 - Obsolete tutorial

    SYNOPSIS

and as the patch set stands, we are leaving it to the l10n teams
anyway to add "Obsolete tutorial" to the set of translatable
strings.

Jiang Xin (i18n/l10n coordinator), what do you and the l10n teams
want to see in a patch like this one?

Thanks.
