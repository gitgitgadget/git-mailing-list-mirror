Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A242B74B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749326; cv=none; b=CjP+UhN2G0amzXpkBLWgqY32UYQLYt5R/3a9AXSQbZwyxCG7FKAj6OHNATCH1Cl599hBn4O4t4uFrSLS18lThJ8pFu4Mtj24UlVzSSUK4qUYGFK5GQfqsOmgD9mDn2ZUXOJOI4wp/VmgcUtV+7TAx3XkFkCUrXPmSC1PzWBEoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749326; c=relaxed/simple;
	bh=AE3Nfuc0pMPG9t7yTjh2BOV9pMJwkKlAC1LFGpzj3qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVDje+yYeTts9J3BGxZumhnXNwyt0Su1jDHW3miqMaBZE+6G5nRJDJlyd+Qu4h/dtEyD4dpSzXeFnvyrITOnJaaDLHQAQQ+XZIdWbsb3jBgfBo5SZ7uIDdu/25ZjgZt+5kBmy3/zVHPCmpLsR0O95FZFqryN4IsFWkoDgOi58Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h998XVei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOz8XIz4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h998XVei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOz8XIz4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F22997A0112;
	Mon, 29 Jun 2026 12:08:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782749323; x=1782835723; bh=48N4GBZ3Wh
	SXlDYhVtt1YMCU4m6yJi3wFOP5Rsg5l8o=; b=h998XVeitMrXn1HS6LonnYgz9m
	Cblh2hrNV99bdbeSu9+QaQnqU2EsmaPoPik3ypV4D/ylHZNyJYf1t3rknVCnzgvl
	wd9M82RypXXG5GEErAUGGBfBbAfCJA10WbcU+0tZYJPJEGnXPLkJ3dfM64aHJIIH
	G3On+91GS+cLrg9mr6ktSAMzGHRGVgQ/Q4n0paOdVl+y7qs+hzIcn9vwTkassZ9b
	gRD/FD1vHsvMrM3dhSftmxocYEt8FK9fPXYjrIRP7ImrdE+r/ry8qu2Zu/XDS1zX
	D1AU1fQeCX7VC3TnT1J23+uvHhvjec1KIt69VBB54J9M9EpBAmaz1QlJFz3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782749323; x=1782835723; bh=48N4GBZ3WhSXlDYhVtt1YMCU4m6yJi3wFOP
	5Rsg5l8o=; b=VOz8XIz4WaMFzDRzbtyutalDpZWt7N1xwg+boGsaBZpXZqVMKRu
	mF0ik6E+dCxGr09IgziYbI5rDsHGZ6jZ2j1rmTZzQVqD5DlKcMITv3wsYLeoH5qo
	aPpMuUfdlJnlOD8U3dl45k27yQv+xNm/NhvYjksSTWabOU5Tozdn6Qr2WwEexbhy
	H3wsa8x6mp6DCEiZ0nIVIrFlhzsIQ44c+qWthM11sEgUfhDz6wOu8tLJIoOq29Rv
	A8n/LKK/xBo1/GNcEPfIJ4sGMxCX3JdS8+wmzoqQ4gtL5V2rApxd0dW9Iz6iTJbd
	kZO8bOQBNACzxY8BNAceHBXzLh83IJMN/jg==
X-ME-Sender: <xms:i5hCavZNeJTi3vXB-oh8b07bbC9aIGGTaRM8tpwGO4QTicnEIuVOnw>
    <xme:i5hCalb2OuMtYbU3ERwTSp0j6N4uBwMDo9eeLMFnUO1YIuuZSUPu6UAq2FMegAZPo
    e_5GWRccrmc-GJs5-PS1F6gqWdSnckR4Xm039NvAKpIKmRiiQTTVg>
X-ME-Received: <xmr:i5hCam80ntISXpCaODv9AiHKkmiwMM_nMUOIM3TkIvSgNW7AoToLUYrRDNrby5P9-Xwbk9FAVcaXyu9au826wSajdGgn6zVH6Ix5Wy4>
X-ME-Proxy-Cause: dmFkZTGHNXQHj4QF9DVGTw5UQpKResr2Dek1bmNHstnAOqnBcJOHW2fOdostulsRkMiA6q
    xReooCkKHZew+xrFX6spjVC8W1QqaBPLSwy3zhNLj1q29BAjNRZ+Vz48HX8yaHEojx2gm7
    1dQCTBXQnHpUci1Ecx5jhIilRq+s+OcANAVQ4Ls1kDG18WAnW3ln1Eo8qcMHSWLHNWKx9K
    dmNjNzE/7jj9r9vb/eLik45vjSN3EnkjgwmfP2L1Js93+HSACaPtSGb9a0qABqnk5/iFkL
    pIHtFdZHJoCXCvwyCW5PkxLBd71bhslf0WoB6AtD80Oi4Z1NsvrKE2ZGPYUY84QVfg0RLd
    mvbKXtDlT34TZ6Fg5Xz73h8Y1V66vGzIA0ejFuf0COdzIo5RZb3UhkZ9qUTwIkFEIztXdt
    GV2XhPhmWgXKfiv7c3LdtB8qdLeUkrEYjLq7zPwsJOjpyXoyUkps/xNZYdRD0A78ahmD6R
    1YS1SJh9cWoDOBh3zUFXN71AZd6ZQM/5F1xRYLy8m7/4kygyyAA9QUAWPUoNBklg21mDBL
    Ta6DyxjyrCAy1qxJWPB4mCxRudh/3UCsAbif1C9Kv6jXyezgbCOxIcd1mTMnldzyM1OCpp
    DkB1NWgeFT2LE/ElIUfgPpcpjufQHH7VifkKoiYphH56bWIyYInXA5K6GJqQ
X-ME-Proxy: <xmx:i5hCakgb7EGPO1E69yU13MOGJei5Yp2ngW6NRaCi13UIOC7jq-X6HQ>
    <xmx:i5hCameDq3W7veS3RdUQL3wDOjuLWs_CfbloyfYgwvlUZS1rLZg7Bg>
    <xmx:i5hCarrKn_UWanvjKK25NVp-cokMAM40tt-PN3esxZtF9QFJYtySjg>
    <xmx:i5hCarCAj9wmK9ztrneIoYVbvXKm7qy4ZxV0tk6f8Cfyrbdz6zHP3A>
    <xmx:i5hCao7tt2HC-v03YVrZCZfC1AL-tiTnJDPZNvJGG1AC4m_Hk6y3LYzS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:08:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: [PATCH v2] history: streamline message preparation and plug file
 stream leak
In-Reply-To: <xmqqecht8df1.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	26 Jun 2026 09:38:42 -0700")
References: <xmqqecht8df1.fsf@gitster.g>
Date: Mon, 29 Jun 2026 09:08:42 -0700
Message-ID: <xmqqmrwdxrat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

An early part of fill_commit_message() function uses write_file_buf()
to write out what was prepared in a strbuf, which is primarily meant
for use by callers that have their own message prepared fully and
called as the last thing to flush it to the destination file.

However, the function then opens a file stream in append mode to
further write into it.  It may have been understandable if this was
a later addition, but it seems it came from a single commit,
d205234c (builtin/history: implement "reword" subcommand,
2026-01-13), which is somewhat puzzling, but anyway...

Just open the file stream upfront for writing, write the message
the function has in the strbuf, and then keep writing whatever it
wants to write to the same open file stream.

And do not forget to close the stream.  We are about to pass the
resulting file to an external editor, and on some systems, notably
Windows, you are not supposed to keep a file open while expecting
another program to access it.

Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Changes from v1 are two additional error checks to notice failure
   from fwrite() and fclose() to die.  Interdiff appears at the end.

 builtin/history.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..365e81379b 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -41,11 +41,6 @@ static int fill_commit_message(struct repository *repo,
 		  " empty message aborts the commit.\n");
 	struct wt_status s;
 
-	strbuf_addstr(out, default_message);
-	strbuf_addch(out, '\n');
-	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
-	write_file_buf(path, out->buf, out->len);
-
 	wt_status_prepare(repo, &s);
 	FREE_AND_NULL(s.branch);
 	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
@@ -57,14 +52,22 @@ static int fill_commit_message(struct repository *repo,
 	s.whence = FROM_COMMIT;
 	s.committable = 1;
 
-	s.fp = fopen(git_path_commit_editmsg(), "a");
+	s.fp = fopen(path, "w");
 	if (!s.fp)
-		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+		return error_errno(_("could not open '%s'"), path);
+
+	strbuf_addstr(out, default_message);
+	strbuf_addch(out, '\n');
+	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+	if (fwrite(out->buf, 1, out->len, s.fp) != out->len)
+		die_errno(_("could not write to '%s'"), path);
 
 	wt_status_collect_changes_trees(&s, old_tree, new_tree);
 	wt_status_print(&s);
 	wt_status_collect_free_buffers(&s);
 	string_list_clear_func(&s.change, change_data_free);
+	if (fclose(s.fp))
+		die_errno(_("could not write to '%s'"), path);
 
 	strbuf_reset(out);
 	if (launch_editor(path, out, NULL)) {

Interdiff against v1:
  diff --git a/builtin/history.c b/builtin/history.c
  index f17ec049c0..365e81379b 100644
  --- a/builtin/history.c
  +++ b/builtin/history.c
  @@ -59,13 +59,15 @@ static int fill_commit_message(struct repository *repo,
   	strbuf_addstr(out, default_message);
   	strbuf_addch(out, '\n');
   	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
  -	fwrite(out->buf, 1, out->len, s.fp);
  +	if (fwrite(out->buf, 1, out->len, s.fp) != out->len)
  +		die_errno(_("could not write to '%s'"), path);
   
   	wt_status_collect_changes_trees(&s, old_tree, new_tree);
   	wt_status_print(&s);
   	wt_status_collect_free_buffers(&s);
   	string_list_clear_func(&s.change, change_data_free);
  -	fclose(s.fp);
  +	if (fclose(s.fp))
  +		die_errno(_("could not write to '%s'"), path);
   
   	strbuf_reset(out);
   	if (launch_editor(path, out, NULL)) {
-- 
2.55.0-180-gf61bfe2e0b


