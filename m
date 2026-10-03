Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30246AEF2
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043466; cv=none; b=hJh7UQwWgkSQth8CtxKhKztTRce8IH8EONcDgzERUJJl2pUm9+BxMNa3koD28errqOJZMBt861ZJkBU22/Pa/g+ZoxTzmIJKvJ64oUU9zTOMrcxd5ZAh1HsUPQrgZ5eNYGRDgpDJY+I1retA5koIRdq0MKE7Co6RLKybAs6M+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043466; c=relaxed/simple;
	bh=x/wvMXnoYavKsqIZqZEmLx1Cq8IeNqddAXQZSkAeyZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4MRyQbuW2muYQujgkdz6mbrDHogdHCQEC30dhSdPx0jMonizOkSB6hWhTnDlUbMnXYFtVigl+6+v/9wRTS8vPCix4k7DwS0QdQIJRcqSF4x8RTGlBaVcEsmtThj+7M9CgnqTmSE3aZ2wWKAfk0o6wGNIqq7GY0uhmzymZ4JCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X3/OTLZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZriLdPYt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X3/OTLZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZriLdPYt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 761191400087
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 12:04:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 03 Oct 2026 12:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791043453;
	 x=1791129853; bh=gzDJnISHOfcD0LcEPKyj6fIE55CwacjAglbOk6TJW2g=; b=
	X3/OTLZO1wB5j6Tj8Y9D1/qLkyARAGVNklo8TdGAbGZXWsCu4z7wBV3PvdUDBREP
	Dd1hrM1UVdMpIMeykDN13AQg1SJMzazP7nfW/Cn4o0/j2vhUAnyP53CbsfARK3sM
	E3bvvhM62FmLt+MouhbH4Ju+Q3XTxOeTXw4XnKjCnVuSW04OmqEGeydM13kYL8YN
	6STlbleNoVUsMckbknOaKCDMQdLM5y8ZEbN3Mzeg2fsnAK+5u/Jz1yMfz93UG7VC
	DAQsYfeDkPVb47SHmZimyeRxHNtQR4KpXK2/tZfFhhrp8Gcg6dNGTlxVY7Kr9rDc
	BIl/VSlCfTv7OSG5uZWpWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791043453; x=
	1791129853; bh=gzDJnISHOfcD0LcEPKyj6fIE55CwacjAglbOk6TJW2g=; b=Z
	riLdPYt3Q8silhbI5NMYvutsIKqmPz5cikwA+1EWbaWhpeqvjymhuIR6vVEh3NtS
	34HHANmp3QStu3xYtzZBaOQTIYDAOKrB896J/UpzHT/7HNxeNQJR7Iq0sv7ifrlP
	rXg/YEjHva4FiwZ8LVlppDdk3N7jxKtgBpCapECof7N32MNPu3H+t5EStL7EyXHZ
	fN0rjn7kOlEjV2hvNgnUTVrcZb2xIo5wmg3nx7Wn5hd+isD8kWGuM1S5M8TBOFr7
	4jkwXfcICyLn4yf1n5JKzms6iuTWVHTQfGIcpVHWRBZkd7VwU6WpYzULUweACGMN
	jP+FAZRqNrf3pZU1awdsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791043453; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rX5Fc8CIdKjFFf82SWR1VnNYvef//q6SbVth5z5Ww5T8UFP
	tGRUGQ0/1Z+TebSY7DusyK3Xcrk1lxKU7ohpf7E7uy2EBe47TxLLoPfgHRQUZI/G
	GVmeKM4Dyt3kHBrFxT3UBhul0EbwKtVnLkVmA8SblY39cfDaqds8xApdFKru1XlZ
	NNVBvi9GfIETnJQtM6Ml8Z3Bf/Axroa6r+QlMnauF/Vzg9rvh0c6rJn4ny06Dx47
	8PuYQPcw8L30XBlkuFhro0o2iusyTgF7R4YGUAXQ85WZ2Gooec1rxKCPPp1pSONi
	0l4368ER5n2tVJn7V65f0fyffCKKRj9zkKDEBow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zTecet7o/65hizPSR0Vn3tK+Qq3qzEE9uu6nnT9UGCs=:x/wvMXnoYavKsqIZqZEmLx1Cq8IeNqddAXQZSkAeyZM=;
X-ME-Sender: <xms:fSfBapYDszRVd6qPiKur9VVsgCWC62W4UBtE5iNa-w9PpaFs3Y3KHfI>
    <xme:fSfBambqTID3PcvhQ_dm7DXv9HnowyCQYT0yFDEiWbGakXx7C2Tno_tTgddTl4okK
    gZxk20o5_iDpbWL0wJsM-mfwiuQ1egtmYbFpizc-2bvAnANDreyATM>
X-ME-Received: <xmr:fSfBaplnqHmYVKRohEjH2TCNmQJCFhLGyQ9vBDGG_bHD8HUQxBM1P05rUphlH4A7D49zf9hdiTtHfz55dlIIjVy_nnUmhH-yvgAku231rCNObUi-gAwLSBs>
X-ME-Proxy-Cause: dmFkZTFjt9dcGMVsvVqyo9lQe+iqnOs79o2CoKdDtjMntjSJU+gOGMZN6THcWmt9wxRRAF
    kDSJM7uwc7qdASV0ULLGkYvlUPXDmrXu03cpJuew1VpeZFAeeo0iEGQWjF4dg59+YVjLKN
    cSBIFWNT5f9KLy8NSW9eNPUsHCZxFNuPDWV7m1C7x5WQcDuH58Cnvzb24j6iOa7jguXpa3
    jljvVstqJ0s+vy4QRXOyBO+s1hp7CbHU1DRh5kjFGsvh26NlWiPsWLRqQWIQ7tfzvRkN+P
    W2qKxVk66J4Uzyf54u6IRh7wGRadQINJ6ErY5UpMb7jT7BksU5a/jMbK9mmbR81brCxurp
    qMpXdDh1CtX9sn9oXulhRxIWjfaNXmyBmPkZRRwgzU6QGVW+w0bPzimt2fWybODKKc9RGN
    1vtm0XwY3YNGjj2l8BTrtMLGmLIQbtTUobwXHX9crCBhmW2QM6L2G96JBLgytln6/oqFFy
    DMzAp5iy+2f3OcuoT0UD5JifTpBwVPDl3Pf2xBbni2GRup4G9ylACDWSkI0opa6gEltgV/
    UqN9mv2vcZSI+70MppPoLPwpDHsbsXAmAlnscRXs3tdlDjuxgGZy+CwMITeRiMH2BSHEaa
    1wCtM1tgtxfyi7pIQsgyhQR3dOFmXpA9awvdvfejcpIhE/+Bhx28Le2INnuw
X-ME-Proxy: <xmx:fSfBaizbrXDfIe7G7cFVrQiCfTmWDzb1iO8KMPyqPhSQcjcgeErjWQ>
    <xmx:fSfBanNXRksW52RfA7FE3uTT1IWiGnu3EXfqYR2U_LijOOXylzVwfg>
    <xmx:fSfBamR5IDU7i1TXRRzPyfLGSM_ihNJrfGn4P43DVb0n7L5L8oU3fg>
    <xmx:fSfBalY6qEdYrN6Bs0VNI38Yi1p8cFoYBQQj3TZcZvVFZ2ygRwFWLA>
    <xmx:fSfBasyUr96Pw92FLQjXVFSi38vG89hvH1f-aPHoMtwbqtlgB2oVe3_0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 12:04:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] doc: interpret-trailers: fix cmd examples
Date: Sat,  3 Oct 2026 18:03:19 +0200
Message-ID: <V2_doc_trailers_cmd_examples.d49@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
References: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix `trailer.<key-alias>.cmd` examples which have remained unchanged
since they were written in c364b7ef (trailer: add new .cmd config
option, 2021-05-03). (Modulo formatting changes.)

Steal how the `see` example is phrased and use that as a template:

    Configure a `see` trailer with a command to show the subject of a
    commit that is related, and show how it works:

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name (applied): kh/doc-trailers-cmd-examples
    
    v2:
    • *Steal* the *existing* example:
       https://lore.kernel.org/git/xmqqh5j9mdpx.fsf@gitster.g/

 Documentation/git-interpret-trailers.adoc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..3e81632b252 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -305,9 +305,8 @@ subject
 Fix #42
 ------------
 
-* Configure a `help` trailer with a cmd use a script `glog-find-author`
-  which search specified author identity from git log in git repository
-  and show how it works:
+* Configure a `help` trailer with a command that searches for an author
+  identity and show how it works:
 +
 ------------
 $ cat ~/bin/glog-find-author
@@ -329,9 +328,8 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
 Helped-by: Christian Couder <christian.couder@gmail.com>
 ------------
 
-* Configure a `ref` trailer with a cmd use a script `glog-grep`
-  to grep last relevant commit from git log in the git repository
-  and show how it works:
+* Configure a `ref` trailer with a command that searches for the last
+  relevant commit and show how it works:
 +
 ------------
 $ cat ~/bin/glog-grep

Interdiff against v1:

Range-diff against v1:
1:  c916709d7a3 ! 1:  a8c56a91163 doc: interpret-trailers: fix cmd examples
    @@ Commit message
         since they were written in c364b7ef (trailer: add new .cmd config
         option, 2021-05-03). (Modulo formatting changes.)
     
    -    Use this example as a guide for how to phrase it:
    +    Steal how the `see` example is phrased and use that as a template:
     
             Configure a `see` trailer with a command to show the subject of a
             commit that is related, and show how it works:

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.793.gc667de3f2c5

