Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D87310652
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491926; cv=none; b=i+VW+/kqL3vvu6Ih5yeqacktDw65hH5bu2iUZdTqbKXpFyDSrb2sWNqMxpg2vuVoc0s++iHOT+p1KG82T2dYXFPTMKZrEIzYk9ixNXxZalPzPEZzM6lR5iGsAnnmWxaMzSVtoKKLBYi/47OCWkR8RadzdBIPX60TPlI06e9hRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491926; c=relaxed/simple;
	bh=9Z557X5p+QK0ZfEn+DyvWgLVHeNjnRr1MMR/Daho6YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFxkZ5eXixIjQsglYKswwLu2XltH6psucqs7v0+wwQc+jMYZziK901xlv/MBX7XIMrzQrOfXpcZuNyJOmITQ/1xeMga8kKZ7X2HXlDcREOpqBCDyj7bbW7z4HWuahSxCT2SaR23e0OZPQ7O8sOEYZQL6wbTco6cyg/ngAAJt1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iDSBG7m4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ty446KQV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iDSBG7m4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ty446KQV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 304647A0140;
	Fri, 26 Jun 2026 12:38:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 12:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1782491924; x=1782578324; bh=LInLG9YD13dlwZWtZkbrF6zMgVURzp5Y
	mdaEg6evHWw=; b=iDSBG7m46NvWK8kP1GJ376e0IrUn1GpxUf1EpLiu7swhMQ28
	R6jWL79ploLtPECs7dFzatl1Sz0pX90xprsR0icjnKaiBCUlVOJ4uyQew0SSxiMF
	wBMoX8LSMN5NibyhHQzqFu+5IvcqLLVcs/YnPGsBvqdSwx/dsJfcIJWRqvKYrllF
	L+Rk9Ya2YPL1boAvbLQoOIy6wj1lHAEzUsrOFxCj58g/zpsOsZR7JoyAvWWsE1kq
	oqbQNnESYp5pdR0amwX/vD6QSY0yrH6F1NlTUsl9SexUB2AGv5DwTqrv6Kww0HYM
	hSj1qS5X46L5yJMMPLKlJcK+61BsMfFUhvbKOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782491924; x=
	1782578324; bh=LInLG9YD13dlwZWtZkbrF6zMgVURzp5YmdaEg6evHWw=; b=T
	y446KQVazejvfdDKDgyPlnyEsAbgz2Hqwrx9m6hoPuNuymKWohHQ2FXxKcRYpY6j
	Lo1ZpAk0kwcdlW9/CuxSL8qpn+oXomULXBiIZVWcmuxsSq3vpa1T4aDzFAMgN8js
	TKvBStK6/UvDAe6aIFuWDgFcXv+sCGxSvEyh1Rlm5rVOph7zS2tX1DZbU0BuZgD6
	TFxCQHE8zuN+d7Kqe6SS44wAfmg5C16navE7YXmgZmqeHowLfZeNGMbggQyy3f1w
	3N+BjjXDsAJirHLDBeLuTQQ1VXLslFGVbkrWkYIWN7xju5bN2u6fgLWSB9wDERYr
	qK6qrwY7Og+qkQSwwEykw==
X-ME-Sender: <xms:E6s-atghiIgkFltCGhYew9jsRNYZNtFjLE9kcXPvQTC3zbWgMzCDqg>
    <xme:E6s-apA5rVYc-N7m4_R3TqpUe3H90lsE5lP7VNhAw-_WD5h_qMIgsRCREzphl5XRD
    uy7EfhiwkYVbK0V6y58UTqpJlKNW5Ql-uNRPDEThJjOUWOZmWDAxqw>
X-ME-Received: <xmr:E6s-aiHwIuiU3fgggZY8_zQlJAHByPnLZWQ9LRIYS-6n85x8Q0kSdjsaL4LOnu9bkCzSvnoWZWj9NjbJVYDK01liaIP2KaWC3fRy1DY>
X-ME-Proxy-Cause: dmFkZTGaCB9894af9utAkDXNVjpy5YunvIcO8f3lzTpsSJPvoPknZxauhWBgW9vgzBF2CX
    VVyzrJ/CEVmY9rOHz6uWHhAn1IGOvCk1PjTZhg0FqPffDNSQ8vHkCruMRIBDXyiUqEtfzP
    zsXUVf1EFa9IstXdQssVzVtjcTmCqJg+L4IYzrLh3l123qxHvaZVYcot7E3zJgvAvte1Sw
    udDcLiTHSoy+Tw4DBcY/QO5yijl+Am1ynS5m93LlU8Tqmt25HiLWCan0zdq7ua4ubWXJSB
    JFXng/20w4L06kkDE1bNBScwACZUBQ4Uh5y2sPPLWNHm9bP6+SIz/w+65w00BUkDkv6sV2
    m37l2Z2vxt1W9H7hz460Yzp/3SLCKU6I5YxYMw28Pcf32PwIYuSTQM1VeZpLzo41dUMej8
    tI2yjUlW3OUDLhcuDwdPEfE/FBeab8W3VkiByy9h1VOlWgUU9KagWnM/Gzv10QeDVpIvBT
    uQKAs6Mg2CX7RSzz2/rG2bpqL6kN4ZZZbAY3mF1+hCd52NDPkhipwjCm45as1yR+2/zcKi
    5OTtn0TsQVMDjUlekABzysrfug2UcIhoz7Z3O0nWZWw6wZvdoekcHP8Q9/GgLGXfAgiCnJ
    aQTK/Vki8eDiYLJ4Iqr3arMOxN5OQPyrO9kiyrlLMIxxaUwNchod9zdc34Ig
X-ME-Proxy: <xmx:E6s-ahLyKRAILTARLmkBrS2JTx6x4LepBIgl3ml-RUQgPGnHJeewTQ>
    <xmx:FKs-amlzMQNkXOW29iZsK4BUX0-6pgFPeqzLoggZbKA0bwJgs6OTuw>
    <xmx:FKs-apTHIIspHuaLI071A_o6lrm4alyc2yJs6PH0Bdbtiftp9x_7ug>
    <xmx:FKs-aoIFn4xcBf1zVBbJGVC_z22lJqlJ03-EIIVyWrwWU0jygmQbUQ>
    <xmx:FKs-asD6TlNAcC_sw4h_c-AMaZaVWBAgyaWfDIkAX99XEr_gg0CpEOB0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 12:38:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Schindelin
  <johannes.schindelin@gmx.de> 
Subject: [PATCH] history: streamline message preparation and plug file
 stream leak
Date: Fri, 26 Jun 2026 09:38:42 -0700
Message-ID: <xmqqecht8df1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

An early part of fill_commit_mmessage() function uses write_file_buf()
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
 * As the initial one was written and sent as "how about doing a bit
   more thorough job while we are at it?" response to a posted patch
   found in <pull.2158.git.1782412427801.gitgitgadget@gmail.com>,
   this is a tested and merge-ready cersion that I consider "v1".

 builtin/history.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..f17ec049c0 100644
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
@@ -57,14 +52,20 @@ static int fill_commit_message(struct repository *repo,
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
+	fwrite(out->buf, 1, out->len, s.fp);
 
 	wt_status_collect_changes_trees(&s, old_tree, new_tree);
 	wt_status_print(&s);
 	wt_status_collect_free_buffers(&s);
 	string_list_clear_func(&s.change, change_data_free);
+	fclose(s.fp);
 
 	strbuf_reset(out);
 	if (launch_editor(path, out, NULL)) {
-- 
2.55.0-rc2-177-gc9430f6415

