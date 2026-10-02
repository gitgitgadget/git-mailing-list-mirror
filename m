Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8236B93C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962408; cv=none; b=Xh/tCQjunllb0eQrP+qqWts9EFXS2vr2Rzzguaq2le2ykGI4vD0/ADM+lsAzSgCvis2VXbUX7lA0UplZ0imKjgzBU4N3WE5BuOfxpdadczl914m9V4ssDZVjHf9H3fXW96OE7stq75O7OIKCRNsVFvFzVtJI/SNX7Ts6e6508Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962408; c=relaxed/simple;
	bh=dDV0lLZSa/x9yxxpKk+hu0Z+VA06hJ+P8i0plLEYJkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcB0gLxBKTGkYvXFFwpbGXM19xEmNl2WeW4g5RQEljGqnqQQm3bjUIkYqL89LHA09kF6b4PMQxBh3KrrDvL/shGiaztnGDb5XjzzBcLdw09e7vubrEo2qB3fhl8vW+iP/qPUjJz7VCfqmpyJwz1k9YpxIJQpeo+1QPo0ggERFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Obidhlof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xg8Njwcr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Obidhlof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xg8Njwcr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FF971D000FB
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:33:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 13:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790962406; x=1791048806; bh=aqV2KiReDW
	QZM4iEE+7xeKWaFdYmLQWAC4uskuKvdxQ=; b=ObidhlofPGsdOrZgWlrw08PNik
	fH4QVIOQdIa+mUJpr0matrs4KvjrHQ+aBn13fM4VZpXBiuke9VRZdjQEWcWD4Dvv
	1Uec/IOWh5m/qeazEm+JJ2FKJXyjxrqnINfdLFfynvkSJhJlYMviFGHbOCb0luTg
	VoSi22WPU8Hl846XUJGfkj5kyB1SJRyIhFSKI7T/FRApVjTu384ipJZqb2xLm38w
	g4l6bFIAFfms013nbT4xR7NoxmYiLYqn8Lm76JltwPL6v8+qWA2AEz1L77l8gVbR
	amBt/dKFJnu1z0O9A/6AGWjA+CE6qMfXqSJ2eHwcPU/xCG9pNdVdGKhk9tPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790962406; x=1791048806; bh=aqV2KiReDWQZM4iEE+7xeKWaFdYmLQWAC4u
	skuKvdxQ=; b=xg8NjwcrfqdAKZsaz/DpRU0ieJmys7nHENIcKScuXBTuEjgL++m
	i7h40I1cCq1pa7pMsDx5irkT2A5Jh8Fi8EpqnZ90dogQ15wavqZ6vl0XGsCgG70y
	mboGnxyFgDL6LJrnm55wLsfPf4uDMHZTwTIfc83pyP29DKGQi/0dPd59Pd1P2ccT
	9LdCqs97du2TQFepT/uf6kR09Zm2npG3r36ooMSs60pvJe3xNr0RVaxCALHe5tbb
	efDRjnOJgQghssHoxgsAo3+sJPBqLbNYXVJcOH9jgef780fhEfYKJgxrbAV5X6fL
	PCKStGdsJ9lruHsquhzltcMjcx26Ax5mxcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790962406; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qsLl7KPJ6IpeYDKaX1gKh33He8rv1yhMnA3CCusX/bx4zNF
	nPFKDSoAQh8H6xJb8Y3bvePU+0O8XYPwreVQ+eNp/NSFfdY1Gtf2JJE3wbD3mpVB
	f8r2OFLmLDNVQUk7hdG2A6jDpIWAblPKIzQBkGAA6RbbzZn9H5NX2FellK0wpOF1
	ltErWajR6pVZwutlilpi6uXb7T8dYwQHPt05L/M3IlbosjCxzcagbyse7tD8aDBy
	ijvFcAemrF8/eLyu6QqjtMwKWyaO6T5/d/L/I09wPhLqWGbNxUWU598H4G+I+TDD
	BOELHJSZ/o4N0K64MonedeUhz0gWK+hNtCpy3fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CUZrcsoBvgXWlRO0dpl1DFBqcseIbsg7py+l5Py8BTE=:dDV0lLZSa/x9yxxpKk+hu0Z+VA06hJ+P8i0plLEYJkI=;
X-ME-Sender: <xms:5uq_ajv-OrUiDfTvAOM1UEIQ34Q5Yy8FDujJsqjLWS5_cCQR5vITZw>
    <xme:5uq_arcBGhZK5nUc2qPthwS28SPi0-uiQFliC7fbcdKvX5ac3In3C9bkzRhzRmv1i
    WCwaxmcFx-u9sGr7LpszNg5ZnHu3rC-hzjmcY0-UcyTV2Xl0ggj1A>
X-ME-Received: <xmr:5uq_arwyO3u3d-PaYxC7JjNgQAwzGyPtXot1xpCjB40Bq2jv4eK7IsL-TnrIOM1f7K7CwXgpwLGM3Dndktt2P0xKtYFVFNGHzW1x>
X-ME-Proxy-Cause: dmFkZTGPtdLAkYDbq3wP3Jb09NUquatvINz9w8RJY4JJnYcyIcIyO8SpEc3dyNOfARGnhz
    Kvnn1X4Lxk1LfjJ+PqQCLlsmvXBOwxpxp1EZP47NDBbn/8LPY8RxisgyNmJYuW/csEdUb0
    D44m/QKYJbVHnWCOkJrOoQo0u0l5lMkM67TZlpLm9KpfA3TH3lFE8/SW+6eWUt10RBZW5I
    +RssjN3R9DSSUBgDCb5OlMhKUKpS+9LWisjrcjVYxGjdSIV/m8JY85kV47tfAmFO1yjB4y
    pRr4lUC8TH2RWcsk1LZMpzX85crRT4uQWaoMyp4/x3pojXIl4NqINaN6RqEYWTVtvPxDRC
    YeERFyAuhpqTtxJLXzLCRNCOkU4V/yWGJsaXmkc0jdQMjtTX0QWQil/gbdB0ky7mupe9z/
    e3RHQmZKBx6m+sKEBl1DK2m0fGHxwJ2SUDxr9WiZdd4Nk3fLyLGbcM5Mqb1/PbgS912rii
    tZ0sakUjLYCrJy+CU/kbHtQw49a2Yue2rY5l8spNQwSj8YWniOZUeav8y7Zco8naHBX+Vw
    IkgdN3cjoghIuzsq+L88KEuafQZq6s0IL5QL42i6IeDmaQ5wI1+QisKZJmWKJtbD81MLBs
    jvCzB3pdYNx9ZXA+Nsy0VwCYmz7TUm/Vg+s6f52/FLu8w8sjAWPP7ZmWG1Hw
X-ME-Proxy: <xmx:5uq_ahGQOU7GlwyWwQZoD8XV91n6ojG9BcxIOsBVJYgRrt_LsMhBXg>
    <xmx:5uq_avzS3kCMyqcLTNzxRc3qvqIHbG_9E6g9pfo7Jd1EL8gJZ4QrHw>
    <xmx:5uq_aiuLVCeUXmXWUlzB9E3vZu9p2UDj1GO5n4_0N_UxPJKsIainhg>
    <xmx:5uq_as32ltESaezV423AZYMC6V9SIzJCFYHJcN6oL2PQfLl-uBZMxA>
    <xmx:5uq_avSblhxeM5eqUza3Lmp5GJ5sbErB1CPxi9LequBGEajfEYcqnHjz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:33:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <pull.2246.git.1790957227881.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 02 Oct 2026 16:07:07 +0000")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 10:33:24 -0700
Message-ID: <xmqqv77kvwgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Remove the SYNOPSIS section from the section 7 man pages where
> appropriate, to avoid having a section that contains no information.
> It's not the norm in section 7 to always require a SYNOPSIS.

Very true.

> diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
> index 6815d6bfb7..9c4598e29c 100644
> --- a/Documentation/gitcli.adoc
> +++ b/Documentation/gitcli.adoc
> @@ -5,11 +5,6 @@ NAME
>  ----
>  gitcli - Git command-line interface and conventions
>  
> -SYNOPSIS
> ---------
> -gitcli
> -
> -
>  DESCRIPTION
>  -----------
>  

Yup.  Thanks for starting this move.  These "we add meaningless
filler only because we need to" were always eyesore.

> diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
> index 02408a0062..e032f6ae53 100755
> --- a/Documentation/lint-man-section-order.perl
> +++ b/Documentation/lint-man-section-order.perl
> @@ -53,6 +53,11 @@ sub report {
>  	$exit_code = 1;
>  }
>  
> +# assume the first line is formatted like 'gitglossary(7)'
> +my $firstline = <>;
> +$firstline =~ m/\((\d)\)/;
> +my $man_section_number = $1;

This means that the main loop that has already read all the lines of
the file no longer sees the first line.  I do not think it would
immediately break anything (in other words, the current
implementation of the loop only checks the section header and
nothing else), but it may be an unhealthy thing to assume that this
will not change.

It would be very simple to move it inside the loop.

Would it work better to do it this way, I wonder?  The idea is to
notice what manual sections we are in, and tweak the %SECTIONS
contents there, to allow us customize behaviour for other sections
later, and keep such customizations out of the actual code.


 Documentation/lint-man-section-order.perl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/Documentation/lint-man-section-order.perl w/Documentation/lint-man-section-order.perl
index 02408a0062..ce60c34809 100755
--- c/Documentation/lint-man-section-order.perl
+++ w/Documentation/lint-man-section-order.perl
@@ -55,8 +55,23 @@ sub report {
 
 my $last_was_section;
 my @actual_order;
+my $section_tweak_done;
 while (my $line = <>) {
 	chomp $line;
+
+	if (!$section_tweak_done) {
+		# assume the first line is formatted like 'gitglossary(7)'
+		my $firstline = <>;
+		$firstline =~ m/\((\d)\)/;
+		my $man_section_number = $1;
+
+		if ($man_section_number == "7") {
+			# section 7 usually do not have SYNOPSIS
+			$SECTIONS{SYNOPSIS}{required} = 0;
+		}
+		$section_tweak_done = 1;
+	}
+
 	if ($line =~ $SECTION_RX) {
 		push @actual_order => $line;
 		$last_was_section = 1;
