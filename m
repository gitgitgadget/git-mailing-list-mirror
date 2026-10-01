Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C335E956
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849634; cv=none; b=dX0l/aIpImSTp9ZcEuLDrSWW84O4Z5fOAi+sAspZpmpDn55n76ezt119x5/UabNJDetfrtOZruDbdxATs30MugkXvxGg5AFHyQUl0HPa7k1zcLY68HvY3/m3KaZ0JOwfusHmcStWYr+DqJi784Jq4VAtIwdKBqsz+U+HmPzVjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849634; c=relaxed/simple;
	bh=/sazE2Ai78ypo9O0diazdNRM/m0jFSqMiIgjrItv15A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MxU7I2Ggig+sqnJcNnx4jveYe9GVVx7JpaMMqAHhVO5PVcIK2ycYW0ERuGvNMqn78vlTiULWAaCK8oWS6IhaYbYATqERR3w6OoED5mcgIWEH7Sy6uJxmwx2F6Nyw1jSQM/nZE9ZxePnEdX48aVBtJGleUYDeZ7AOb4UVcg2lnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vCh9TxDc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvksFHRk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vCh9TxDc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvksFHRk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 751781D000F8
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:13:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790849621; x=1790936021; bh=q4sAkphRiN
	3U35p0vlnBFnw1ijwLJxmyihebs0zM9dQ=; b=vCh9TxDcGOVb4zhBnUn0ACpeM6
	0ugLOSJhV1aFdbmzVkPpzAK1lWLgWF1sjsbv8lX4fSpzfTgpF9MsastntuMnRT5m
	j1X4MW/p8c2czSPY4A35yWWt69/BaDtBATGtxpfiV2x5D8/4k2S2hDj8ts4zH9jm
	aWv8DPd1mrG+xG4fFY3dhyQAwgFYffqFQ/RY6ZRTlYTGhR/FjObdQSzLkvzpFPkV
	vCmmU4TVDhBH1E46NTrELGlnVb4EZaApb+4VUy4jlAtdpl2U7jWc8s+rQrg4wyEe
	zuy8rJoZf7FQPzfFBnH1FTSm3F7JLD6YDuZa1IBZJll6kyznt49yDfmmFzxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790849621; x=1790936021; bh=q4sAkphRiN3U35p0vlnBFnw1ijwL
	Jxmyihebs0zM9dQ=; b=cvksFHRkdVqWNJbTfjEIaG+NKm8euEY/K0+eIJqYGXd7
	qc8kp35hAuq+0nOuBAYgzsWGmJx/zvvGJykcJkXEqqAtKMfET0gZiVL9QNKay3wb
	1rFWFJPv02rSjEn9G93D/0tufV0+BX2sWp7EUEU1ELML4ZDOdDv90JxCK6RgDKgY
	qpNqrRvg7ydqNJmKpDoL9M2WgHf06DTVnCZ7ugJw7JKxkkyp2u69Teo+swnTlc0T
	BECaN5kLLfFUvtjrUc7dwlXZ0qhaTSjO9AZh+4feOXfeYy978eGbe1DkSJgOI2c4
	QXVgT4r3e9MZ4QDnnOc4JyekXjWDsLRoxBCv/bSjuw==
X-ME-Sender: <xms:VDK-audU_tCYkWDnXF03by1FQOZykz4n6R2p9E1GTganpfu6FviwCw>
    <xme:VDK-avLEJbqO6Cfgny-ltlFuHOUEqvIW3sWtfrE6Fz6gumQbj34Vj3WuRxgzv_BsR
    EmkhVSSzswLvs2F1svzy_ebiqW87NZVEUVB7V3eCkDMjn8pRfPm>
X-ME-Received: <xmr:VDK-alKyQBgn_nE1AyWo_rmxQTh0LFq-1xUValFIEAONtoobcv2XAmsVZjL6yYEuorWZ8Q>
X-ME-Proxy-Cause: dmFkZTEBLfzayD/OOeiM5EmJH1eZMGwcwBHFVSYfvnhWVB+I+kH4mFYEXP/ysMkarOTJHj
    3elXfUlxCBfpXwhznJY36cLY34okngMvgMD0O2PxmRoFJjjAWs9l+u9/zNRzCqKzx6w4GT
    SHBI2/uPj9qmqQY0qCEqykIBVNYR2e0chF96VLIgx76MyrPJa9gVHtlmd1MIYoX1peqAB+
    YFapNRqrQJHoSr+eHkdGgYtZtxTVkVezMojqh152Z6q7BznfPjL5wDTSSQb67nwx8U01uJ
    x1jd8+7Uyt681C6DHhGROqX7B8toAIA5+O5mA+zGP8SB90g4xQoEeSBxMaKfwIcTpg0hBT
    rWAKaXuB9Jj+vTb6qUswUw0XhEODyDA/8MEDAr/95SjNcHP0tVTWJLwkonvVXW8P1UuyV3
    yFR/xKzq71Nb7sNsWrpzTNaaT/cllBhjJZT0DsDWoNI4BOG+AB5ZOZ99SNZeRzdnHGFNzO
    EY1e+32lH9bE4CzItp3XW8nwIuxev8NRUG+4aqTIPrItkhfkRgwa6u1kAcMQnKxCfnJPnM
    uVtkDjgQD2XdoDXbHpV59IF0zP9XsWC4OVifG8XL6FmW/c8HwhA7/TVQU3kiUBLlS7S/my
    Ejsa8sxwRLH8XT3jzAwxb6lVL9W9W6UFAWkqYTdG4fZqgaofWjhip7rrZP8w
X-ME-Proxy: <xmx:VDK-ahEaz1uiseDMc3_u8nJYormi6lu75d_quFaC9LBgudQGTg-rfA>
    <xmx:VDK-aqlUao8C4qVgMC6xDI5POBw3ZQvMRN4Rus1VcRC_KWdFh8Lo4g>
    <xmx:VDK-auLOzPMFruzrTUNFpFPjGbWBxf-vrbzvThbfsVanG1epDw3pGA>
    <xmx:VDK-arYrapNA4VAWhEC2IIA-dZshICWc2zQ-l0a5YikDReoBVhaDPw>
    <xmx:VTK-asMPcn-uOAxEXpUjWr_QBltR9A00_zxd3D054CG--kVGATsd6sXY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Oct 2026 06:13:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c7781d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Oct 2026 10:13:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] builtin/refs: introduce subcommand groups
Date: Thu, 01 Oct 2026 12:13:27 +0200
Message-Id: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBBFf6XM2oEkakV/RVzkMa2jNBkyrQil/
 27U5YFzz11BqTIpXLoVKr1YueQGdtdBvPs8EnJqDM643hpjMRxQnoriqxIWmZuvqEuIZZp8Tjj
 Wsoji8Rz2gzslb/oILSaVBn7/jq63P7fRg+L8rcO2fQCafZyWigAAAA==
X-Change-ID: 20261001-b4-pks-parse-options-subcommand-groups-59b3f27da06c
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

the git-refs(1) command has grown quite a bunch of different subcommands
by now. These subcommands can easily be grouped into three categories:

  - Operations that span across the whole reference database (migrate,
    verify, optimize).

  - Operations that read references (list, exists).

  - Operations that write references (create, delete, update, rename).

This patch series thus adapts the parse-options subsystem to support
grouping subcommands and then introduces the grouping for git-refs(1).
This results in the following output:

  usage: git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
     or: git refs verify [--strict] [--verbose]
     or: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
                                  [(--sort=<key>)...] [--format=<format>]
                                  [--include-root-refs] [--points-at=<object>]
                                  [--merged[=<object>]] [--no-merged[=<object>]]
                                  [--contains[=<object>]] [--no-contains[=<object>]]
                                  [(--exclude=<pattern>)...] [--start-after=<marker>]
                                  [ --stdin | (<pattern>...)]
     or: git refs exists <ref>
     or: git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
     or: git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
     or: git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
     or: git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
     or: git refs rename [--message=<reason>] <old-ref> <new-ref>

  Reference database
      migrate               migrate the reference database to a different format
      verify                verify the consistency of the reference database
      optimize              optimize the reference database

  Reading references
      list                  list references
      exists                check whether a reference exists

  Writing references
      create                create a new reference
      delete                delete a reference
      update                update an existing reference
      rename                rename a reference

I expect that going forward, we'll probably have more use cases where we
can use these new capabilities (e.g. an upcoming git-objects(1) command,
which is going to be the equivalent to git-refs(1)).

Thanks!

Patrick

---
Patrick Steinhardt (3):
      parse-options: fix completion format when first option is skipped
      parse-options: allow grouping subcommands
      builtin/refs: introduce subcommand groups

 Documentation/git-refs.adoc                    |  2 +-
 Documentation/technical/api-parse-options.adoc | 10 ++++-
 builtin/refs.c                                 | 32 ++++++++-----
 parse-options.c                                | 62 ++++++++++++++------------
 parse-options.h                                |  7 +++
 t/helper/test-parse-options.c                  |  4 +-
 t/t0040-parse-options.sh                       | 16 +++++++
 7 files changed, 92 insertions(+), 41 deletions(-)


---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20261001-b4-pks-parse-options-subcommand-groups-59b3f27da06c

