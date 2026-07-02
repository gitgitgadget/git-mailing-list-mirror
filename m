Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E047DFB4
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993728; cv=none; b=A/2Fna54u5ZLT8x2Ea7S2AmIszYikX2L1vPsJS0G5h8bgarf1i+lb+P7GlCQW8/x9I+qKVJbCUBtNTqKs2RcXA5K6WsOuavVbWd9mQ9JseTLLAgYznoog+gFNAkBXTflI53BFYSu49C33Wr83d9dkZTEouEUmFxCsSRzEZ51m5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993728; c=relaxed/simple;
	bh=iujIou8RIBer7bzLwrkb0VqG+/gon790HkdmkhETuIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rhJqF2JH6buxNKriBKmFfKNF0kb2YKTAfP3t6Kwm+aSp+Mx80MMttM/cGgfEr9ZavnlMLhxt0lraDc1+5XZ1NEtLTz1nA+XwojzYQASxOGmVurIS0qNdB7Jm3qDTnef7zXoDYFGwuqQEeVnizu+I0lkpFtrtMUGnyN4C7JIQkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bWXi722v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYyhBisW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bWXi722v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYyhBisW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D2F71D000AB;
	Thu,  2 Jul 2026 08:02:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 08:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993726;
	 x=1783080126; bh=ood4PwGikFhWmEjBrH57xdkxEt7pDIH036PLgdYhrL4=; b=
	bWXi722vNeXDZ3aN7CRu4rxmGHI85eip3bJmWDWN/m+rQwHsOwWZkeBdOIprGGlZ
	i4GufQtNfgCHfoKlbrRLD5NoU4zhxiFLTWls1yTWM+UE2eAmN1aZg9ayCbSdLupl
	4JxusiuoYJR+26e795FfdFK8oHmXCYw3aQ9I3tPxg98mBEib+rZqwYNYzJo8FuVH
	GIXAK8C+PC3xWfJ6HJUwg/bcDUIGV1tyHuw1moCKZo6cCPq1b9HQp+C9ctSR6v4F
	gdJcF4AhClKP2HMHhin9m80jyzixTuXmlON1VgrYrD1f8VnDkR68/4i/92OZBc2P
	DSS0MJ6Fduyp9FXuUC0K/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993726; x=
	1783080126; bh=ood4PwGikFhWmEjBrH57xdkxEt7pDIH036PLgdYhrL4=; b=i
	YyhBisWj3kO90AWo4JB4Yf7UaL5ugqP09N6a8eCxp9VPMKm2aersoSBxdKK6UZ/x
	RO/27urKVr170tMPyNErEj56ytneg5N8i03PJMV/uLv+2DIy3sdSZ4vGRaCq2j8x
	7on5o0U9tVTpg0kj3tQAYYWEvqeMJ6HgpQRRzzGXcf8EAMnWJDofJYy3DPFqupYJ
	uPRIHch0FPOZmUrmTRuy52R+rOB9qhH8koYUQAicftP1umocsya2hu1AP99rg3rS
	g40L5d8R9GpGxYqtb0gfTtOcYcN9aY0i3Qcxr5vj3wZ1cHZ8eNVUZ4FdApGKlPCe
	Dym01XOfLXmJsER82JRRA==
X-ME-Sender: <xms:PlNGam8OPNXisbWL7tW17f8LOJnykYbVRq_6K4At7gBHZvHDQeqwzg>
    <xme:PlNGauLWrwG54dPmU3x2yvbh_Vp03wIC-WTIQ4mIQeN7ZwrA4qMJ-6YB49fgqMxCh
    9IMo_2d-zVu0sPSNB48xwzBNBX7cWtTQUWqRca-I8MtLG6t60j6BpU>
X-ME-Received: <xmr:PlNGapaSw_v-19XEGnj-W8JppnikpyAzojoorwYI2Q5FI1Kfg9YJlioJc8G3ip5HPzkOU_pDqlpp98qGwMXBZcZpcyQq4MVIp-6nkL13A7BYUA>
X-ME-Proxy-Cause: dmFkZTG0RVisYzD4p4v0fdFZeL5c7yhPULM2A7ojBgdU0syoRTGEePApPIMlf0MS++/iPN
    RJzpp2//bosPvSjFVePER9TOkDJHzlfUPdkhOGDStG1mmi+U3U4KmDbRv1nclNfxNqmnVp
    NMxjuCd/dfcSH3KPj8ENnZ9XKPoDGgQiFLYAqU3oY63sPWTwfQ7ZRCApjAlJN8BmTblnJx
    Yoatgg+9HFqr+w8cQCs4iTp0Dd/I8DDC4D2fO0g/cdWKFhQi65shfcSaZknUvVr2YvczsC
    UAr8J/vLc8sIry6iPTBfACGtvbVzQ7GHnYRs1icWDOcuqwF3MZwdGWGdsPIELxQQlgGXSm
    7A1y38txfUHiTKSG5QIdJm46s7MLJECJNf94AtLBz4yJZvAfq5nVmRqiWlly1ekkUpqqwb
    Cfc1ckF0kwAmTP00hv3bvMWhlSLUv8se342DDFPlVcuVF0CIp5Q52+uLtyZtzy9sNxr+hg
    n9cTysJC9XXY86tVkiWNtlm6Yv3h3F1hlR9TB2VyP2Q8aTE/gPl8xaymdH2VPMZZ3q2qIi
    9reePVyT6Za7ottXCgK74JlL71Nbv5KX91pEoSIDIYzP09ZqZ23W37v7EUZr8YeHhaRfLd
    mui8ElNSj6NvoftcBLwAD515c3mZjNomWlo2zxtHi3NYQabfjMAB2bsijnGg
X-ME-Proxy: <xmx:PlNGaoKxCge_TjWASJPD-JHnnXmONViAA6evB4jreN60jCPSz1DA3Q>
    <xmx:PlNGavDbQWUgzXT7vSYkhFhVDDR3rQi2q2hX4nYTsms1OWxFLNEVdw>
    <xmx:PlNGalrGdTQdpfAA4fBERzV6sqAM0hxAaE89wMj1OpmQySGRSrjI-w>
    <xmx:PlNGaihaJXstaG-rYaD90zhMb-IciKdvkz7DuFsTYb-OD6oJPLnUiA>
    <xmx:PlNGaqIvWDWzXMdEyHmLLve6LN0_F6OKNva1POCoeap-WfccQ44ktVTq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 986ff608 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] odb: refactor source-specific information in object
 info
Date: Thu, 02 Jul 2026 14:01:58 +0200
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZTRmoC/3WNyw6CMBBFf4XM2jFtQ3i48j8Iiz4GGY2UtIgaw
 r9b0K3Lk5x7zwKRAlOEU7ZAoJkj+yGBOmRgez1cCNklBiVUIQqp0OQ43iJ6Z9AFP+Kzp8ESSiN
 0V2sjiy6HNB4Ddfzaj5v2y/FhrmSn7W0zeo6TD++9PMvN+0VU/i8ySxRYOVmVpSlroe05WUe+Q
 7uu6wcB1/yvywAAAA==
X-Change-ID: 20260612-b4-pks-odb-drop-whence-1b0af9ab16f4
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series refactors `struct object_info` to not contain the
`whence` field anymore.

This field only gave the caller information about the type of source
this was read from, but it didn't allow them to figure out which source
specifically yielded the object. So instead, we replace this information
with a new `struct odb_source_info` field that both contains info about
the source, and any backend-specific data.

With this in place we can re-query the same backend for any given
object. More importantly though, we can eventually also use the backend-
specific data to also uniquely identify any given object, e.g. by
recording the packfile and offset, so that we can even yield the same
object in case one source contains the object multiple times.

Furthermore, with this change all information in `struct object_info` is
now following the same request-response-field style.

The series is built on top of 26d8d94e94 (A few more topics before -rc2,
2026-06-21) with ps/odb-source-packed at 1bba3c035d (odb/source-packed:
drop pointer to "files" parent source, 2026-06-17) merged into it.

Changes in v2:
  - Rename `struct object_info_source` to `odb_source_info` and the
    `sourcep` pointer to `source_infop`. This follows a suggestion made
    by Justin, as the current naming is too easy to confuse with the
    actual source.
  - Link to v1: https://patch.msgid.link/20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      packfile: thread odb_source_packed through packed_object_info()
      odb: make backend-specific fields optional
      odb: add `source` field to struct object_info_source
      treewide: convert users of `whence` to the new source field
      odb: drop `whence` field from object info
      odb: document object info fields

 builtin/cat-file.c     | 12 +++++---
 builtin/index-pack.c   |  9 ++++--
 builtin/pack-objects.c | 19 ++++++++----
 commit-graph.c         |  2 +-
 odb.c                  |  4 +--
 odb.h                  | 80 +++++++++++++++++++++++++++++++++++---------------
 odb/source-inmemory.c  |  3 +-
 odb/source-loose.c     |  4 +--
 odb/source-packed.c    |  4 +--
 pack-bitmap.c          |  2 +-
 packfile.c             | 45 ++++++++++++++++------------
 packfile.h             |  6 ++--
 reachable.c            |  7 +++--
 t/helper/test-bitmap.c |  2 +-
 14 files changed, 130 insertions(+), 69 deletions(-)

Range-diff versus v1:

1:  52cf49cd37 = 1:  19c247567e packfile: thread odb_source_packed through packed_object_info()
2:  325878ed04 = 2:  084c3592b4 odb: make backend-specific fields optional
3:  cb7f9154b6 < -:  ---------- odb: add `source` field to struct object_info_source
4:  63d2eb7b7c < -:  ---------- treewide: convert users of `whence` to the new source field
-:  ---------- > 3:  dc878542bf odb: add `source` field to struct object_info_source
-:  ---------- > 4:  d2e2b90842 treewide: convert users of `whence` to the new source field
5:  332899f012 ! 5:  7e09bc6aa9 odb: drop `whence` field from object info
    @@ odb.c: static int oid_object_info_convert(struct repository *r,
      		}
      	}
     -	input_oi->whence = new_oi.whence;
    - 	if (input_oi->sourcep)
    - 		*input_oi->sourcep = *new_oi.sourcep;
    + 	if (input_oi->source_infop)
    + 		*input_oi->source_infop = *new_oi.source_infop;
      	return ret;
     
      ## odb.h ##
     @@ odb.h: struct object_info {
      	 * or multiple times in the same source.
      	 */
    - 	struct object_info_source *sourcep;
    + 	struct odb_source_info *source_infop;
     -
     -	/* Response */
     -	enum {
    @@ odb.h: struct object_info {
      ## odb/source-inmemory.c ##
     @@ odb/source-inmemory.c: static void populate_object_info(struct odb_source_inmemory *source,
      		*oi->mtimep = 0;
    - 	if (oi->sourcep)
    - 		oi->sourcep->source = &source->base;
    + 	if (oi->source_infop)
    + 		oi->source_infop->source = &source->base;
     -
     -	oi->whence = OI_CACHED;
      }
    @@ odb/source-inmemory.c: static void populate_object_info(struct odb_source_inmemo
      ## odb/source-loose.c ##
     @@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loose *loose,
      			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
    - 		if (oi->sourcep && !ret)
    - 			oi->sourcep->source = &loose->base;
    + 		if (oi->source_infop && !ret)
    + 			oi->source_infop->source = &loose->base;
     -		if (!ret)
     -			oi->whence = OI_LOOSE;
      	}
    @@ packfile.c: int packed_object_info_with_index_pos(struct odb_source_packed *sour
      
     -	oi->whence = OI_PACKED;
     -
    - 	if (oi->sourcep) {
    + 	if (oi->source_infop) {
      		if (!source)
      			BUG("cannot request source without an owning source");
6:  1e79d64921 ! 6:  1c25e56d0b odb: document object info fields
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb.h ##
    -@@ odb.h: struct object_info_source {
    +@@ odb.h: struct odb_source_info {
      	} u;
      };
      

---
base-commit: 969dbd51a70f9105ee9965adec5c5a02e75ab5b3
change-id: 20260612-b4-pks-odb-drop-whence-1b0af9ab16f4

