Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CA4A0C
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075729; cv=none; b=u0Y3nL8SJu80bwlqkWk3oHDmeBc0cyrMasuQ2bBPBwXHMYbsDZPjYydGTLtXERZmnGGRP2Ma3VdLXQHNw6haeQV3N42OFDkvBFYBLTvDhRMqek3+1wHkpMe2aJpQOmswYg5bzS3afTT/aq+4aVEzDKe3rTto0Is5OxocNqHRdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075729; c=relaxed/simple;
	bh=r1YNEZJmYZTXMSkQ4Dww/7s3FUNvKyv+TsvK71qTD2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTV+y91YH+XoihHVstK8qgYvR7jDam1Ip2Y0fgoOQGE//yVBTpruiU1d505gVRbOWPJrduFKnBq69gqPcKi7Q13edO6moFV+srpMlEWUz9dMIEESAAtLQHbONbns+X79Jx9xptpyVh1WITon1MDddQCE+MsKzHXKlEAVHz+aXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gwNf6nqp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nRWTw6wu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gwNf6nqp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nRWTw6wu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 45D46EC03F7;
	Mon, 13 Apr 2026 06:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075727;
	 x=1776162127; bh=bRmjhgNS9Be1KICWfEtd6/XEvgJ1JTJEEGG+8PfOs4I=; b=
	gwNf6nqpYYg+cqDPupdksASBHL/5rjlQadk74DRhfOy7qaX8TdJimFBmudOuowkT
	EpcLovAvBb4xZq/KwXKnP8HsgfHPMsJNz6UVEd5wNpxZUsz9OawDYuP4BPq2136v
	3gC7Scfvjwk+e5cOoNygs5GPxfojjkDWsAoYnMbjl9hjrpfJSXkaySZ2v7BUb+yl
	p/qapVAsa8gSFUk03bNufJfnb5F3cJPov0uJ533sKQ4mkE9tGAEIykSJF9qBm8Ph
	uPJrcPTHiF7IlDxQxopr/OXxuMZWAVEfe6R1Z7pdOb3hHjC/Adok8DeklfcmRs9K
	TFOmbHyglBM6M4Wg5sAtww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075727; x=
	1776162127; bh=bRmjhgNS9Be1KICWfEtd6/XEvgJ1JTJEEGG+8PfOs4I=; b=n
	RWTw6wuUhU8l/CDQRibLYQuuLeKspeAMYGu4PSmJk3hK81I1uh4mE39Wd9osudxS
	vN7GEFUIwspEmOzq/F2ojAUf1ibb9xLUmewEgJwZH8Dw5oJjJke1tMZI08SpAgp+
	P9ecbLGRIGtqx2kvRyc7dK9mPNq2TpGuHf/kytP9Kq/Jfl5gMbBZpQySei0kiQI9
	4mX+ycig3ZgdXGw42k5R7DOvMT7lALPvbNMTlG5Bxw3o8kWYmUOwh5Qjd/Vb01xm
	fY1i+RpPo8oTGJUNsLgFa02MJ1pmkUfpLxkL/bCFibm7f/wcPVHPnUE2hbo3IuDE
	uO+ZvOfvkX+WJYQJIMLQA==
X-ME-Sender: <xms:z8PcacbadqrJOXT4_bsWBI1a7JnafYTyyZy0wiN2VuDcbdQ1ql9TRPE>
    <xme:z8PcaeTw3dp7it8CzQTej1xA-_IzTdGGfixb7g06XxHhc-ib27YU762sPvuLx2Kob
    2YLA6rtwH-pLSjzm_uEbQQ1PzKc5vsnZNC7m5cmEQhvWH3G5l4AWA>
X-ME-Received: <xmr:z8PcafT7LgRxDD0MM7xDeE-MXrvuY9oje1jMg1dTWMRtHeCHuxxez5SZGNWp69wP-hpFsUAZmL1ACiWra6AtA4HXtQUC0S3VTTkf49b1YN3rI3oKsUEUF2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:z8PcaSSp72D3JljDlNhVXaDoiP6L0Ysq2aitMceRDW1k6MvyL8TW0w>
    <xmx:z8PcaU4ZR_IBh_Sbsj-qUl3etGIXy8Xsa6nyxEA8J10Yjo9NEYfUnA>
    <xmx:z8Pcae0z5gStVXBhzS2-eoXLW2xN-2q7Q6S1bqDQCBAbvrlvzVybbw>
    <xmx:z8PcafBRYKNYApre8G3v6SuuI-8qndlhDCH7cpQAeW9KVfBvWEmY-w>
    <xmx:z8PcaZhUHzK0GxgifAZ0AV2nTS0O_6gUqISwJpde598CVlhlVgdbR8g7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:22:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 2/9] =?UTF-8?q?doc:=20interpret-trailers:=20replace=20?= =?UTF-8?q?=E2=80=9Clines=E2=80=9D=20with=20=E2=80=9Cmetadata=E2=80=9D?=
Date: Mon, 13 Apr 2026 12:21:01 +0200
Message-ID: <V2_metadata_not_lines.615@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We removed the initial comparison to email headers in the previous
commit. Now the introduction paragraph just says “trailer lines”, and
the only hint that this is metadata/structured information is the
“otherwise free-form” phrase.

Let’s replace “lines” with “metadata” since that is their purpose.
This also makes the introduction more consistent with how I chose
to define trailers in the glossary:[1] “Key-value metadata”. (We will
introduce “key–value” in the upcoming commit “explain the format after
the intro”.)

† 1: 68e3c69e (Documentation/glossary: describe "trailer", 2024-11-17)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 1878848ad2a..3f60fd9b720 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,7 +14,7 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines at the end of the otherwise
+Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message. For example, in the following commit
 message
 
-- 
2.53.0.32.gf6228eaf9cc

