Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542518A6CF
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760908186; cv=none; b=LPIW3bBry6qBIekNS4QU+NpVQkcws/+h7KfZzjaNvOYx9wnbOfS24RgK8poqHqNKRAyciJHPx7FH/BEMhCOkAq/SBcgH+PsCJffPWIHYA/QHUOa+jk62k6pc/WGIpTr/STAkZNPXxOuT28St/bH75QE8Bp1JXOyXirAPrffOjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760908186; c=relaxed/simple;
	bh=HonbrynOcb6O2xrPtD15kYEkqLLOqU+oPLEnaZ+RTgE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DjcM1EHja6erGr29qLhKbG8QWiHzswgz4ol8R0n/B7YoHPJWo9a6FinnZ0ekvKk5t07/pZZz9xXQuLgp7gb2CtJjMs7tp9c93xuCwI1RTS1NLKnqPY7FbyCIetp41zPgclJhAYWxLo0YcTMZenRHT7cPl392sH7/8wD5XCA91kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=c5Hv9GkI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="c5Hv9GkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760908171; x=1761512971;
	i=johannes.schindelin@gmx.de;
	bh=U0zIvNhVl64pw0p26UNy6UtJ6rHuW+AQUut3LYKzEfU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c5Hv9GkImoKPrQErd9446PTayNqezsn01GzE2BpVtBKRgiWI7pOp4q3fgbtSACDU
	 UW3OVrNtawleyEdau3TwFsjp4fiNIVlGeugZQAzjYiCvWiO4SvuLneyfeauzxmhX6
	 Wk2+X49FUKed3mgrUjv1YgBf/wu0klwyFfXSg3dQdKOAkFRH1oNoahTlsfk515tm5
	 5+WMHcV1PEdA9uaR7OBzU2p4zDx4pi3FKXeSCcFqINm+kbk5nfkbw3aoD5DwTsRCe
	 r6x4XCxd710lgkZ3Oh+M8CzyAD8vneNRsL9Tnk5+Qo4OAzyWDJIgOyD569OoVseqU
	 gT+61t0a9AIkGHXFMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.131]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1u7nEc3b6C-016ehJ; Sun, 19
 Oct 2025 23:09:30 +0200
Date: Sun, 19 Oct 2025 23:09:28 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: restore redirection to /dev/null for
 diff_from_contents
In-Reply-To: <20251017083641.GB4073661@coredump.intra.peff.net>
Message-ID: <d5895f9c-5b3c-7a69-46e0-cf16cda5bf3a@gmx.de>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com> <20251017075153.GA4078773@coredump.intra.peff.net> <20251017083641.GB4073661@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1DFiWJrVUb7631y0ZRcib+jkK6tdb1rPBh7qh8Vks+qxwv4NCgE
 cCUsF+GkYryv9917U2aXnlfvxHrChfAAgf9d+IQFkpsAfzV1ceuNFsHIjFGto1hUVIf6PGj
 0g0lVpCArZvMoCyMZRdbYA0tB/id8tF/d+9RUHuws0D0duDKQIEaYrdJuEWOV2HEnJUHZG1
 FjLo1BT6Xu5F8+7QfLnyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S6CJt3ZaUPw=;EVbIchWIymGZqVCs+5HfQuoL5rL
 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
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Fri, 17 Oct 2025, Jeff King wrote:

> diff --git a/diff.c b/diff.c
> index 87fa16b730..687206f353 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
>  	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>  	    options->flags.exit_with_status &&
>  	    options->flags.diff_from_contents) {
> +		/*
> +		 * run diff_flush_patch for the exit status. setting
> +		 * options->file to /dev/null should be safe, because we
> +		 * aren't supposed to produce any output anyway.
> +		 */
> +		diff_free_file(options);
> +		options->file =3D xfopen("/dev/null", "w");
> +		options->close_file =3D 1;
> +		options->color_moved =3D 0;

I do not see any discussion about the `color_moved` line in
https://lore.kernel.org/git/20250808033019.78817-1-yldhome2d2@gmail.com/#r=
,
nor here.

Since you re-add it, I consider at least a little bit of reasonsing in
order, e.g. why this is necessary, and if it is necessary, why isn't
`options->use_color` forced to 0 also?

Taking a step back to see the 100ft view, I can understand why you want
that "extra level of protection" here. An even more important thing, that
is missing, is a plan to avoid the need for this protection.

Given that you're still on GitHub's payroll if the hallway rumors are
correct, I am quite a bit puzzled that you did not immediately reach for
CodeQL (which is a GitHub-sponsored technology, after all) to get clarity
on the code paths that would make this exra "layer of protection" still
necessary, and thereby provide said plan.

I started an AI-assisted brainstorm session and ended up with this query
(which is neither as concise nor as comprehensible as I would have liked,
but at least it does the job of finding the `run_diff_cmd()` code path
that I also find, and no other code path, and in v4 of Lidong Yan's patch,
it finds no remaining code path):

```codeql
/**
 * @name Potential file write during a dry run
 * @description Traces paths where `diff_options->dry_run` is set to non-z=
ero
 * and the corresponding `diff_options->file` is later used.
 * @kind path-problem
 * @problem.severity warning
 * @id cpp/potential-dry-run-file-write
 * @tags correctness
 */

import cpp
import semmle.code.cpp.dataflow.new.DataFlow
import semmle.code.cpp.controlflow.IRGuards as IRGuards
import semmle.code.cpp.exprs.LogicalOperation
import semmle.code.cpp.exprs.ComparisonOperation
import semmle.code.cpp.exprs.Literal

/** Holds when `assign` sets `dry_run` to a non-zero literal. */
predicate setsDryRunNonZero(AssignExpr assign, FieldAccess dryRunField) {
  dryRunField.getTarget().hasName("dry_run") and
  assign.getLValue() =3D dryRunField and
  assign.getOperator() =3D "=3D" and
  isNonZeroLiteralExpr(assign.getRValue())
}

/** True when `expr` is literally zero (allowing common suffixes). */
predicate isZeroLiteralExpr(Expr expr) {
  exists(Literal lit |
    expr =3D lit and
    lit.getValueText().regexpMatch("(?i)\\s*0[uUlL]*\\s*")
  )
}

/** True when `expr` is a literal that is definitely non-zero. */
predicate isNonZeroLiteralExpr(Expr expr) {
  exists(Literal lit |
    expr =3D lit and
    not lit.getValueText().regexpMatch("(?i)\\s*0[uUlL]*\\s*")
  )
}

/** Holds if `access` uses the `file` member of a diff_options instance. *=
/
predicate usesFileField(FieldAccess access) {
  access.getTarget().hasName("file")
}

/** True when an `if (options->dry_run)` immediately returns. */
predicate earlyReturnOnDryRun(FieldAccess fa) {
  fa.getTarget().hasName("dry_run") and
  exists(IfStmt ifStmt, ReturnStmt ret |
    ret =3D ifStmt.getThen() and
    ifStmt.getCondition() =3D fa and
    not exists(Stmt elseStmt | elseStmt =3D ifStmt.getElse())
  )
}

/** Data-flow configuration tracking diff options pointers while dry-run i=
s enabled. */
module DryRunConfig implements DataFlow::ConfigSig {
  /** Sources: the `diff_options *` pointer whose `dry_run` field is set t=
o non-zero. */
  predicate isSource(DataFlow::Node source) {
    exists(AssignExpr assign, FieldAccess dryRunField |
      setsDryRunNonZero(assign, dryRunField) and
      source.asExpr() =3D dryRunField.getQualifier()
    )
  }

  /** Sinks: any dereference of the `file` field through that diff options=
 pointer. */
  predicate isSink(DataFlow::Node sink) {
    exists(FieldAccess access |
      usesFileField(access) and
      sink.asExpr() =3D access.getQualifier()
    )
  }

  /** Barriers: proofs that `dry_run` is zero or explicit resets back to z=
ero. */
  predicate isBarrier(DataFlow::Node barrier) {
    exists(IRGuards::GuardCondition guard, FieldAccess fa |
      fa.getTarget().hasName("dry_run") and
      guard.getAChild*() =3D fa and
      barrier.asExpr() =3D fa.getQualifier() and
      safeDryRunCheck(guard, fa)
    )
    or
    exists(AssignExpr assign, FieldAccess fa |
      fa.getTarget().hasName("dry_run") and
      assign.getLValue() =3D fa and
      assign.getOperator() =3D "=3D" and
      barrier.asExpr() =3D fa.getQualifier() and
      isZeroLiteralExpr(assign.getRValue())
    )
    or
    exists(FieldAccess fa |
      earlyReturnOnDryRun(fa) and
      barrier.asExpr() =3D fa.getQualifier()
    )
  }

  /** Holds if `guard` ensures that `dry_run` evaluates to zero/false. */
  additional predicate safeDryRunCheck(IRGuards::GuardCondition guard, Fie=
ldAccess fa) {
    exists(NotExpr notExpr |
      guard.getAChild*() =3D notExpr and
      notExpr.getOperand() =3D fa
    )
    or
    exists(EQExpr eqExpr |
      guard.getAChild*() =3D eqExpr and
      (
        eqExpr.getLeftOperand() =3D fa and
        isZeroLiteralExpr(eqExpr.getRightOperand())
        or
        eqExpr.getRightOperand() =3D fa and
        isZeroLiteralExpr(eqExpr.getLeftOperand())
      )
    )
  }
}

/** Execute the configured global data-flow analysis. */
module DryRunFlow =3D DataFlow::Global<DryRunConfig>;

from DryRunFlow::PathNode source, DryRunFlow::PathNode sink,
  AssignExpr srcAssign, FieldAccess dryRunAccess, FieldAccess fileAccess
where
  DryRunFlow::flowPath(source, sink) and
  setsDryRunNonZero(srcAssign, dryRunAccess) and
  source.getNode().asExpr() =3D dryRunAccess.getQualifier() and
  usesFileField(fileAccess) and
  sink.getNode().asExpr() =3D fileAccess.getQualifier()
select fileAccess, source, sink,
  "`diff_options->file` used while `dry_run` forced non-zero at $@ and con=
sumed here at $@.",
  srcAssign, "dry_run assignment",
  fileAccess, "file field use"

query predicate edges(DryRunFlow::PathNode edgeSource, DryRunFlow::PathNod=
e edgeSink,
  string edgeKind, string edgeText) {
  DryRunFlow::PathGraph::edges(edgeSource, edgeSink, edgeKind, edgeText)
}
```

>  		for (i =3D 0; i < q->nr; i++) {
>  			struct diff_filepair *p =3D q->queue[i];
>  			if (check_pair_status(p))
> diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
> index 0352bf81a9..35eaf0855f 100755
> --- a/t/t4035-diff-quiet.sh
> +++ b/t/t4035-diff-quiet.sh
> @@ -50,6 +50,10 @@ test_expect_success 'git diff-tree HEAD HEAD' '
>  	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&
>  	test_line_count =3D 0 cnt
>  '
> +test_expect_success 'git diff-tree -w HEAD^ HEAD' '
> +	test_expect_code 1 git diff-tree --quiet -w HEAD^ HEAD >cnt &&
> +	test_line_count =3D 0 cnt

I understand that you imitate the surrounding code, but there is
`test_must_be_empty` now, which has the huge advantage of documenting
intention much better than requiring the line count to be zero (and I wish
that there was a comprehensive roadmap and planning in general to avoid,
or at least clean up, the vast amount of style inconsistencies in Git,
preferably via automation so that no human being is burdened with _that_
cognitive load).

Ciao,
Johannes

> +'
>  test_expect_success 'git diff-files' '
>  	test_expect_code 0 git diff-files --quiet >cnt &&
>  	test_line_count =3D 0 cnt
> --=20
> 2.51.1.685.g6bf3278fbc
>=20
>=20
>=20
