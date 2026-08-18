Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D627FD76
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062784; cv=none; b=qVAZDAJiWqcJeA8ZGlyOyZWoH5QcpyOo6h74qQJt+gHAszvmMEMoctaqziVt658DG81C8432aKBRvITIMrmhW3f7+6wCNhq2C1OCTScUPb5JG5brt08LBaOYlNt7+O5IbbyQNzQLl1R5KYJ4MO8yF6r+S/QFZ5sGt1LVNqs4Auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062784; c=relaxed/simple;
	bh=WMuXIK4VBHXee7Fi7heRJnweo8hd6CvLGuIb0g/gV98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ka9VJoykbBT1IWbYLxX3lKH56q3WIvXunWL0o+FfVmGBBD3iIw3TFqoY2OQQfivve9RXJIUzOgT8C5CPwVm4GOhn0s+TUjIb21E1xdzqOweDSeiGt/JfAzpGIoZL88LT2PGiH0etytkJpVgKPOY3w/a8rkUMUijVqh7BMOSdPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lg63NqnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIzBEgC6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lg63NqnF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIzBEgC6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 355E41D0014A
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 18 Aug 2026 10:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1787062781; x=1787149181; bh=/aGNyb0eyz
	hLnM32zoF0tUVgN6JIcBKs4uZJBgtTsDg=; b=Lg63NqnF3ZT1E6msGhJX0GwwUq
	MorM3nMIydvzPanri3CREYw6gP41OVxKBrXzAglvPghaz/gVzeC3LY8HIjQ2gvz6
	UjeQcFsc1bX+x5baokO0SBLe2S1vsvcla64/rHUjws4y0a1ZigXj8p+vaazQZiN3
	2HEZXxPBA4IFJ18577xMCG/jtGaOjjUSLAOrAPvK6yJHluIRzZnELPLR782VgzNc
	ZRxZreWunmHIITO6XunEaSHx/ooWVEwp5O83FitF7++w6zKlrRhPO0Q2boRwJka0
	S6ygmXhMB+i06ssPBUnxZ8s1NpMRHgUC4PuiC5MpPFgyIg+pLtfZ45HnTYwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787062781; x=1787149181; bh=/aGNyb0eyzhLnM32zoF0tUVgN6JI
	cBKs4uZJBgtTsDg=; b=hIzBEgC6pVSlY7Q+ssVPDvGVJtbZUQpzVI1zxpx1k6P3
	nh3KN4OsX/e4hdj+YzCfNg4x2DxOe2T/QWIgbNG3adNjG4Y0+9HmhH/52mxoCi6p
	H5rUKoUSIPnVrdx3zjUILD/gp6JeM0n7xKJPxW3yXRjAmVqCFc8oLJlxhavoSVkl
	3VE+3oVxlIeZeCc6iS7yC9HCBNroh7OgThboVEucP0kjboSKytSOSC3FLZj4qmvP
	oPnZe7geA3KsTQ+axT5lmaSEGoPIeD+LD8CKuqfVddn8FoJWkMvcS3L90dUIzK9U
	WYDVWLmPXinxhksmWVrsBkXHFxxD6mA2xZMTZbwe9w==
X-ME-Sender: <xms:_GmEavlzh_8igUujx8utetjS37FOYor-HbhH0McCyhEi4UAZMmW3Iw>
    <xme:_GmEapwrCv25Uyxt4h2z-8Ktv7EXaAgwXaPHlxaruK7kJX5ea31JqN-FQHh19RwHi
    4S1p0Y2NEwKpMiiUnKlQCgO7YtH-zfTNFfPA1v8-FUJzuSUOFUD>
X-ME-Received: <xmr:_GmEarQkddi911GwbI2vWomV25SzpA5hfpBEYs3iaIbfbsepmMZdwmR9HqUjSn06jevyg8b50O-G5yDjDPsnhU1dyL5Mnx-VgNKmHXbN>
X-ME-Proxy-Cause: dmFkZTFYnVVCy8h/8MdvQW477NExrC9ZWZd3LwN+5hpnChPN2lMmxtgMt1zuHUDm75tifp
    /mSMQ88Tv+hwBYurFoyqjeyq8cNC8XPHSMskeMSETTRYJ3DyOeIeGHk+9ue6TPZ7V85XXo
    wKgRY6ojP+5gprUkPoigRaYwnQZtszzsemq6S6F0omHvLVEWJU0UDfMErtv5j1L8CLzXZ0
    4xqeIATqWGxycJhgjUQox3eK4jR+40uFdAl94RNCzkt906/FwuZ7cmDgkUUzjYike1Wv9t
    sRmYMCA6ksqMkQoNDCBq4q6wQXX+YV0uRRejD1musAatCjYWdl8VTZbNHqkScMnnAZefFy
    gpi/P9T1uNxKlTVYbCxvwqe51B2n7L3Mgwigb6MNGVC6ui23vKSvLz49N8BHrO8u9ayXXY
    yInXO0+ilYFrXWlrlxMeoKT6SlWlw91yBEpOWYg/cx9m0bRowBKwTT/UlhYoSuXGmodMrL
    u2j6QOslCHNfbEZGwMfC0oxQNNBkorbw3UIcbBdzAYaUxEI6mbmpwODcZapcG81TNbTfce
    /WF8coN6Bivm5fisDtupzT/+KAvfV5pUpKgZDMSHpZ9hJYg+/9sQbk9QYWxULu4gtuVvgU
    JCs11Q0pS7fY0YLsohhH/midG5tj8aNwUsI+4WKG6+XFyvi09f1m6f5A8Wlw
X-ME-Proxy: <xmx:_GmEasvZP7_jedhljtBBvCedeiuFAtlZCtBnNexSHgRBByVAgTG9Hw>
    <xmx:_GmEatsSJT79zbxKd-430bU5RZhfG1VVcAn1o_n0NChiL_FhMx_Hzw>
    <xmx:_GmEaiy2SNIBebnQ-48YcUKd5UOHVobxEW8NjDGdD4RI4omeLZhFhw>
    <xmx:_GmEajgiMATaAwZvBC_yaUepUxRRCI-ITRgl9WmxKfUMD_kjzGS5aA>
    <xmx:_WmEav0x2kDJmLNiEvNjLBJ9uL9qohUIK_iiRhdMQ8LPqqlGUvmGVOpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c4edef3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically
Date: Tue, 18 Aug 2026 16:19:27 +0200
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywqDMBBFf0Vm3QETrK9fKS40meq0kIQZlYL47
 03t8sC55x6gJEwKfXGA0M7KMWQwtwLcMoaZkH1msKWty9a0mN6K0U84U8hLhy6KbGnFOL3IrYp
 3O1aNr62pfAe5koSe/LkeHsOfdbvcXxbO8wu5+cIkgwAAAA==
X-Change-ID: 20260818-pks-odb-generic-corrupt-objects-52a47d6214d9
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

when looking up an object with `OBJECT_INFO_DIE_IF_CORRUPT` fails we
want to die in case the object exists but is corrupted. This flag is
handled in two different spots right now:

  - `do_oid_object_info_extended()` calls `has_packed_and_bad()` to
    check whether the object is known to be corrupt in any packfile.
    This function reaches into the internals of the packed source and
    thus breaks the abstraction provided by our object sources.

  - The loose source handles the flag itself and dies directly in
    `read_object_info_from_path()`, which means that we die even in
    cases where another source may still have a good copy of the
    object.

Besides being inconsistent, it also ties us to the specific backend used
by the database sources because `has_packed_and_bad()` assumes that they
use the "files" backend. Any other backend will instead cause us to die
when calling `odb_source_files_downcast()`, even if the object was
simply nonexistent.

This series fixes these issues and makes the check backend-agnostic by
extending semantics of `odb_source_read_object_info()`: on the one hand
it now distinguishes whether an object is missing or corrput, and on the
other hand it starts to return an error message to the caller.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      odb/source: discern missing and corrupt objects
      odb/source-inmemory: signal missing objects via positive return
      odb/source-packed: flag known-bad objects as corrupt and not missing
      odb/source-loose: distinguish missing and corrupt objects
      odb/source-files: signal mark objects via positive return
      odb/source: allow `read_object_info()` to bubble up error messages
      odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically

 builtin/pack-objects.c        |  8 +++----
 midx.c                        | 10 +++++---
 midx.h                        |  3 ++-
 odb.c                         | 47 ++++++++++++++++++++++++++------------
 odb/source-files.c            | 25 ++++++++++++++++----
 odb/source-inmemory.c         |  5 ++--
 odb/source-loose.c            | 46 +++++++++++++++++++++----------------
 odb/source-packed.c           | 53 +++++++++++++++++++++++++++++++++----------
 odb/source.h                  | 33 ++++++++++++++++++++++-----
 packfile.c                    | 29 +++++++----------------
 packfile.h                    |  4 ++--
 t/helper/test-read-midx.c     |  2 +-
 t/t1060-object-corruption.sh  | 18 +++++++++++++++
 t/unit-tests/u-odb-inmemory.c |  4 ++--
 14 files changed, 196 insertions(+), 91 deletions(-)


---
base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
change-id: 20260818-pks-odb-generic-corrupt-objects-52a47d6214d9

