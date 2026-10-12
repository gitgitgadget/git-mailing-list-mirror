Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0449AA43
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830230; cv=none; b=CoiU71hA9Pn4GKDKojkIi4eG5erArRsEuq5GunVL7pQF3YOIhG9BGAiNXEuRcA57N4RTKj0FRoSdV/P147xsrnRkRoOyZfylFhD6SnCbm9yg+3KTsX34/PHksyY0rnzaNZFVvjnYez3r6RC0/huIFJXY1JxLMCsRqGZUIEyU7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830230; c=relaxed/simple;
	bh=mk4HQHQi6LTzjYmv7CVDl66Cvmm8WcCXL3hYwzZXStg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0YMlJtN3lbPOrDX+jLXG48r5g1e59wo/7AEqOBxCX/DpFdM4ItcylzxdiJzBMSKVfSzK6MKxsbgW7Jq4FNTHF6VyAY+41sI3PSS4RFai9DZIVUhrakyMQBVJhhB8i0skqVlnXZNUHTDICpUEV1hh+MQF5ok2GM216UhK1V4sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HDx/v3wx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDpM3ASt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDx/v3wx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDpM3ASt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 614F1EC07C7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:37:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 14:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791830227; x=1791916627; bh=EHp42T+61h
	6Sn8hElboXc7JgT2MMWRi8CT1e4YIg7Hs=; b=HDx/v3wx3L7YEsluOchcr2VWRf
	OHMuZhjcQbFOZ9IYq5yA63BcOTwyDQxFJXENpDfYN25DEVreoLJ0Tky9+/b/A87o
	ZN0llWrDhyjhHdqG8Ul9Ix7lLYO55BhUkq9udubPfhOtUL0K66vKwC9XIoKPSF/C
	9uKSf8w7FbnVTMBWjvfFsbAeNvVb5OxSszT0PW/YRiyTFd4PmF64TYinH9g6snt7
	T96UOJxx30FMV2FK1EQPKc08uFT1Tqu0j+GBx8UVdmVkwr08X6gYg0jfdX+nVMAk
	CGJIYlo/yJ9zlNAMtL10CdvKGx1ltGhnxRnbqqvBNBLJqqBCJC21lROlxzvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791830227; x=1791916627; bh=EHp42T+61h6Sn8hElboXc7JgT2MMWRi8CT1
	e4YIg7Hs=; b=SDpM3AStNWBZZHwWmf8XJP9Q3YeamlANhHnSrzwjTc8ncAYgnIK
	7Ob7WCYKUFXeuA29XtKBbycEVOYOA9Y7jIwO06QROClRwWs9qXwcz8Q7yuw95Kiu
	dnVal1p+edZkUDp4pK5rak+WmwSXRAuE/9GI0vpO971HqYzVvW+SyBqbpzHv0G2I
	m/wvDadfMNYeYQbhfgzyvcQj2yNYsr+BP6p7IrW3EE1gica/85D9SvGk+u5KMg5c
	c27usuCHjrV15aC6uSKY4wn90Fmdh2JfNaWHskFQTUYy33QpLGJ8YJkVFk6w8o7p
	Pofny71WF8BM4JAk51Q+HEDopLEavElA/Pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791830227; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:d8cHpeX+vcy6x0xmPngr2fhkVZgTpSuHlQRmeEizI3MGRSl
	4leLesVNWsoOP2XDgABB+e2EPE1BEFi5zcgwNsVkBJdiHQyz9PpX/9sBTKy3Hj32
	nqNdBOU7boxeKcSktetrEJvi1YyBOWfRnY/6Zv1EmhQZS7bcWBmhXX6tEWzKeh8J
	jHqYvNj1cfZQ/CgkLuZYJFoqOs0X2k9sxjA/3Dhaqt3JEiSpBFGLuHwkhKb0MqFU
	FA1/ow0tlX5aOb1L9jQisbwJQLzdFmlxyv9oLBpPknMwPKbpuBlPGoU7h9/sbzTQ
	3fpxI6eCa1LaHEkneLp392PHw4R+BXRDsdX7vcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WhTEvm4/A+uc+rQAt19PeB6uydwgqz4TaeCp8PVRRek=:mk4HQHQi6LTzjYmv7CVDl66Cvmm8WcCXL3hYwzZXStg=;
X-ME-Sender: <xms:0ijNaj50f2OoQLLL0XvAinqNy5tp3nlfb1nr4hn7vNqKvdy5hkjpiA>
    <xme:0ijNarI2qstxD9HqH1oG99l0qgyWGlM6dvf5cXlWzPo_PbDexAb77QLP1ljTuaTQV
    1c4XQwOadaJc61oo8mMc8wmqjpt3NY06CDGSkBRNNvzM_sCjCnVQ6s>
X-ME-Received: <xmr:0ijNassR-VfrCtDmEwF7qKiVvclnq0VIOPg78fU90ZrnZLRuFXaClDHVlc-j9nNFs7bZNwM9P_Q_irbxKMNjpK59oHeG28ELSbPa>
X-ME-Proxy-Cause: dmFkZTFqbnxwJc3Ks2JUEKyPqivHuwKgZmEpMyxwylTIYrutofUJZ4L+BD3gan0aiwd6aU
    UBfdFA+Wmm8w4aD7ToMJ1CZ6gwCaglBA9jLJBJwHC04thiruxeO+TUsrn4ZvSIVvxQYkeo
    rsd43Hl6Bjgw1bEpMp4M9x8YYgPbAd+SiFIWszCRwLmiyLFVpJE3B3ctF9tMn/EJ8R6sff
    PqlDWf0YhND4nJ3UyLYUi7he086hIc77lAw0FjYk8xBxfChhlewLcT9B5FY2AQSYTmg7hB
    zhQ/+UbxI/tFuO8F+ywg97kGygegxYUEsZdE0bqF+GPLcujrCTBCMAlHZC/ugU20hP4jFi
    6zmJUFZ0oC1O9IVy/CJUGkVtps2t7NlQJerXkVuB/+2yHAiGyUfanEyeoYda62cQ/NWg7I
    53RMB/6bmW6TeMNeC+vDmcsf77DXid5N4XlnFUQ4QM6wevKO0h8kf7A+3t2L//8iMM3GOk
    yGiKd5vu/gvh8aeehApnwdTro+BNP+yrIdBYzB5MoDmOeT0StxMbsNo/BV1NNJ176lkP7K
    nRBQ98vs6tyIRqlLGlW+c+nHT9uDgEgO8ikTC7nvCCFfORki2WgMMpgVAnow2NknFpQRRT
    6U/IFrZwojYbaITjASAuYursQY8i1/yx74KR4AFpyujQxnvwKHLj3BTNtGSA
X-ME-Proxy: <xmx:0yjNaqJj3Dop6jYyYAnuu0tRLKUw6yTU30E09cz0wLgph_6Yb6ETFA>
    <xmx:0yjNal_MZq7pGuzjUK5wTd7LY5vcLRIz-Fr9rfD4n_R6aEdtsReC1A>
    <xmx:0yjNajy-Q7k5KKiaqFWQcw33r2--4RZiJ_Fdxp6IYlVe1OGZ1ZGwqA>
    <xmx:0yjNai5D7JnR1WN23dB4IcS5eSaEXVnmoeQMpmoA6BeqbF-G6OA2tw>
    <xmx:0yjNajPPLtHsOEw6G-z4FwoL1aCtDgNUb5Qr2cP6jurHvdAELlGft1Sk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 14:37:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <xmqqse2a7pgo.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	12 Oct 2026 11:17:59 -0700")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
	<xmqqse2a7pgo.fsf@gitster.g>
Date: Mon, 12 Oct 2026 11:37:04 -0700
Message-ID: <xmqqbj8y7okv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I had some comments on diff3 in [1/6]; everything else looked good.

Here is a restatement of my [1/6] review in a squashable patch form.

The second hunk arond l.77 replaces "code" with "lines", as not
everybody using Git are writing program code, which is not what I
mentioned earlier.  There are parts that talk about programs and
code, while other parts that talk about lines, so the mixture is
already there, but I think this part does not have to be specific
to code, but just applicable to anything that is line oriented.

The main part of this change is the updated diff3 example.  It
reveals that the situation was different from naive interpretation
of an earlier (ambiguous) example showed.  This should help readers
appreciate the extra information diff3 format supplies.

 Documentation/gitmergeconflicts.adoc | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git c/Documentation/gitmergeconflicts.adoc w/Documentation/gitmergeconflicts.adoc
index 3c6eaaddf8..eeeeac85c0 100644
--- c/Documentation/gitmergeconflicts.adoc
+++ w/Documentation/gitmergeconflicts.adoc
@@ -60,8 +60,9 @@ MERGE CONFLICT MARKERS
 When there's a merge conflict, Git will update the conflicted file
 to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
 For example, here's a merge conflict where both sides edited a list of
-fruits in different ways -- one side added "cherry" and the other side
-added "banana":
+fruits in different ways, and ended up in different states.  One side
+has "banana" but not "cherry", and the other side has "cherry", but
+not "banana".
 
 ----
 FRUITS = [
@@ -76,8 +77,8 @@ FRUITS = [
 ]
 ----
 
-The code from one side of the merge conflict is between `<<<<<<<` and
-`=======`, and the code for the other side is between `=======` and
+The lines from one side of the merge conflict are between `<<<<<<<` and
+`=======`, and the lines from the other side are between `=======` and
 `>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
 of which side is which.
 
@@ -121,8 +122,8 @@ FRUITS = [
 ]
 ----
 
-Then you might edit that part of the code like this,
-which includes the fruits from both sides of the conflict:
+Then you might edit that part of the code like this, to take
+all the fruits from both sides of the conflict:
 
 ----
 FRUITS = [
@@ -208,15 +209,15 @@ DIFF3
 By default, Git doesn't include the original code when formatting
 a merge conflict. To include the original code, you can set the
 configuration option `merge.conflictstyle` to `diff3`.
-This extra context can make it much easier to understand what's
-happening in a merge conflict.
+This extra context can make it easier to understand what's
+happening in a merge conflict and avoid mismerges.
 
 Here's an example of what a merge conflict would look like when using
 `diff3`. There's an extra section (between `|||||||` and `=======`)
 with the original code.
 
 With this view, you can see that both sides fixed a spelling
-mistake in "mango", and each added one fruit to the list.
+mistake in "mango", and each removed one fruit from the list.
 
 ----
 FRUITS = [
@@ -225,15 +226,24 @@ FRUITS = [
     "cherry",
     "mango",
 ||||||| 1c22e48
+    "banana",
+    "cherry",
     "mangoooo",
 =======
-    "banana",
     "mango",
 >>>>>>> add-fruit
     "orange",
 ]
 ----
 
+In the default format, you would see this conflict as shown before,
+i.e., "one side has 'banana', the other side has 'cherry', everything
+else is the same".  But presented this way, we would realize that the
+conflict resolution to keep "banana" and "cherry" we showed earlier
+was incorrect.  Rather, we want to drop "banana", and "cherry" and
+keep the "mango" with corrected spellings.  The `diff3` format is more
+unambiguous by being more verbose.
+
 [NOTE]
 ================================
 `zdiff3` is an alternative to `diff3` that makes the merge conflict
