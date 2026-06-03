Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728B374E57
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465207; cv=none; b=A303exAG8ZbSoLh/h7w+SHG3gCnfuvRt/7UenF6/eTaAfWlHQjM8e7Y8NFOLXWsstWIV3QI7CBBoGsisOJMTirZfi4Mz6G0Yc0mfBk2Tn57lc3JNQpo8S3s2ymwblBKapDKDzf/OyYQJuzO5SZWG5rLAg116bc4qtdBpNdg1AIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465207; c=relaxed/simple;
	bh=WF3dz+iauiP5tk13RvG+ekwY2IsrPvTK7NsnVugdb3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrwzf3Dc0rWeBKiDqc5qtMPyDCJHIUqt0jpe13MKUbsW2a30I7+hXk2lD59HPAETQGHDZ+BAWfX2wxzOkf1sOSTPXAQ3f/Oe1k3a95/bBLEob5b965GS0YWOoT3iL3R8xzQlubupeyAAlW3RKtJCuhAf0FghqGShsNVb7se/Z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=puqIx62M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZfT3t6G; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="puqIx62M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZfT3t6G"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 564711D0010D;
	Wed,  3 Jun 2026 01:40:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 01:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780465205;
	 x=1780551605; bh=ar0DSp9nUAoLCWG+Y4b0YWGyqcsMnxlWvpYqcVM4ZRc=; b=
	puqIx62MDkIHB/n68W+vlOKI1U56nbXy5y70BI7V8qHOB8cX1xU/qZofjFsFTFc8
	4o1gVWldjR+E6Q16qaZH1RisJVj4ALviO6U+UhKnMEhDDCC4Q/0jZS2mhuTmKjt3
	ldmskEwWAY9K6qbRJNzLesk5bS1GESdRH3hNWr7HYRIxKBvThrxfsXzZYdCbD4r4
	LLha+Fkl4M4eEG6kvxZmnOg4CV23sHVBJvlFyH3F8s5RZPezmF7i1Ao+N1lE7MUH
	AZdEO+/s+NQR3BbeQzLOTUPV85af0cvXbmuSbEaKZZ7LQuCS8WCAi49MSH2O+A/f
	i12mvI6XS+sEOVxsG8j7wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780465205; x=
	1780551605; bh=ar0DSp9nUAoLCWG+Y4b0YWGyqcsMnxlWvpYqcVM4ZRc=; b=A
	ZfT3t6GusEmiENtQFSB1bMnu7xZ6OR9IYbD1aLRwnIwsnOOEhFgaCHTmWB7xEo+x
	lwsSg09WyAO1uypheFEOmY0Q4eWPaYQhBRuoUxzgL0ZKbedLD9UsmJA19GTZ7IAu
	AEiR+UPLuM80JEQAn1nD3qvl8qJxbtuLR8rslvXfJ03hCGWs5CfcJ9DZy+TbcpQk
	DvbNfbhWGHpVTs22+Q+ThgtzG7iquZDXGvq577FQpiCBNlxbd+mqO/ouaJC7vC3A
	A7xANxZnkscNPgKzeS+6j8REetffIUMqpxH45ppk2KyXMglrnyYQUljrY+7LlN1c
	MxsYoTC69XzNRw8vIVBHg==
X-ME-Sender: <xms:Nb4fao1meblCJL4PbKNkLHKzzQv_FCF4pDTXF1prZcd8FiAFtxpR-Q>
    <xme:Nb4fapH3YrPbwBQnmN88q1UUWNoJq6qQsw9iScniqyMDAVigd5z9tTtEluP28d91N
    bSI2oxLguxyqDRSSQkKjLb9VUc6etE78u8dusJDuubqjrrEiQ3dTA>
X-ME-Received: <xmr:Nb4fauikhHf_1qDpZ0bm91aNc53mjajhpMOTqKBu0tJsYnvh1WQKDqGIAMg_vh4OZxXSuLzkblJK0IK9TRcVfXr48yOa0Vbqzqi-MtFE8mHy>
X-ME-Proxy-Cause: dmFkZTGrzJjPUIO2NsjW9q+5peeonH880scV9FOwhilzaab+1LfhkAPwBnkrMwRIuUbz5U
    +LFYbPLgv1t9z3xYVoPZqQCANWbAn6dNOhLOqMLvkTYH4NGpC2/4VXq116frN/7U2UiL3X
    FNqwOHtvAyZWy5QK3mB9oFxj9mimN69S68JTbcR+0jmsBSt9VsSYceza+JvrHAfa17hbrJ
    qPeLlkQrbj+kzq0dpWBfv2Zb8+smTByit0nlFJgiKOFfTTd/lgjGLqrmXBIahvqi+x4kES
    OPOiOF30oDhR7cCn51miGT5BBhXmaMVzueivIFWud02qrGXtLDHKJdEpKsJTn7BAeXRepR
    GUqSMom3Vr3OTAmYEX9YtJKT7PwzNYlma+TOvng9hhIpvGFi14ii8MBU33LaLeLORXfbli
    uIRQOHw5iL+keM24kURhVi/IyqZoxoiF7SxTyHCF9p2uNMyuYEHz0O4J78WjQ4EuW2oWAD
    Fb44JyGsQ+vf+/oVvDmHRLqrJ+9tALnP7COkPpWz2AUktd4/OiYSMptsJw2NdJy9TAdhyH
    yv7w13thpsQXvt7l0LOj6dZs4px6Iu1gmNlwVjm9OiL9hm/LHvNXkczJ0INVmTzCwPNEA6
    pmduXEpSWoSyoEd1YWrKHCtm8VUObMW7mHIYWvfINSgnXRaKCP5QaUXhDvdA
X-ME-Proxy: <xmx:Nb4fas_vXG0MYqDpfuWTFcncOADCaeCFWnFf-ReSwb6HfJMhyTNTQg>
    <xmx:Nb4fatqSoI4_RB78jEKM00ywszXiDPOFk-ss9WSbXuasjs_m4wMugg>
    <xmx:Nb4faj9O3giwVj7Fg-AY1nn3nlZtLohx1lKSRC7LAEruSZgRH8Ns0Q>
    <xmx:Nb4fapWdnCDtdX_Cbe_Lwhfe1Mv-h9d9JbPhHGU6HoAzl4n_JrxhNg>
    <xmx:Nb4fakO_Dcvws_xmbe3cYrBsZZviVTJIXqmQSwX0O63kEq1lzKemfrDy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 01:40:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 786933a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 05:40:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 07:39:46 +0200
Subject: [PATCH v2 3/4] t/lib-git-p4: silence output when killing p4d and
 its watchdog
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-t7527-fix-tap-output-v2-3-cf3af5694e20@pks.im>
References: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
In-Reply-To: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When stopping the p4d watchdog process via "kill -9", the shell may
print a job-control notification like:

  ./test-lib.sh: line 1269: 57960 Killed: 9               while true; do
      if test $nr_tries_left -eq 0; then
          kill -9 $p4d_pid; exit 1;
      fi; sleep 1; nr_tries_left=$(($nr_tries_left - 1));
  done 2> /dev/null 4>&2  (wd: ~)

This message is printed asynchronously by the shell when it reaps the
process. While harmless right now, this will cause breakage once we
enable strict parsing of the TAP protocol in a subsequent commit.

Fix this by using `wait` so that we can synchronously reap the watchdog
process and swallow the diagnostic.

While at it, deduplicate the logic we have in `stop_p4d_and_watchdog ()`
and `stop_and_cleanup_p4d ()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-p4.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index d22e9c684a..9108868187 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -65,6 +65,7 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 stop_p4d_and_watchdog () {
 	kill -9 $p4d_pid $watchdog_pid
+	wait $p4d_pid $watchdog_pid 2>/dev/null
 }
 
 # git p4 submit generates a temp file, which will
@@ -174,8 +175,7 @@ retry_until_success () {
 }
 
 stop_and_cleanup_p4d () {
-	kill -9 $p4d_pid $watchdog_pid
-	wait $p4d_pid
+	stop_p4d_and_watchdog
 	rm -rf "$db" "$cli" "$pidfile"
 }
 

-- 
2.54.0.1064.gd145956f57.dirty

