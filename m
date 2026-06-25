Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A31A9F87
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412431; cv=none; b=bDlNqMZeXQ5vcndLKGTWOa5D6MdmwKRGmIz51liwb6u2DB508HiumEm8WLlU1LTWK2OKVzItkXIA9md6qilMVX7PmfzYGXF65r1L8FmgIfb0rzghUWC2/K+QcwIb+s75KfnkwEcUkSBKe5saMaxEe38exS6eQqFx4SH10NCVlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412431; c=relaxed/simple;
	bh=t830Sf8h0552uvaqBGjQcjFln9vJ4ACdRv+n7FeRn/I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NrrXQACm2BJfCWohHh5izsruWi4IR+zdyLcLBUmymKW2viV9hU2wwCI4+ZPHKJ7LnqghazePTebgDtnPvRmietZ0ZRCGHJZA+Nj9ogCL+c4IUMo+T3Iv9SvSLaIkGrO1r3ZVVCWrT7/bjw0pRiZkgBJ5dLu2L2qCkyqlUULN/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gShIkoUo; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gShIkoUo"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bc4a1130adso66432e0c.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412429; x=1783017229; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HK9teGEbAuqrNIy5aqNQSmg0J+9jxTnaW9l3MgprSuU=;
        b=gShIkoUoudwsJDNDVBdsMUk941DHT9AljrQap4PuyRA0PY1IrHsdN7b+TR0awFlfeK
         JdJrWCAMdW64ifYqTgGb7WaDXLqn1xH4/wbC7QYAxh+JNAVi9cA/TPFhBaphK9tD5z6h
         DiR2glH42QPGg0o+KndjxUZ1QtnMBnh26nNsxr0e8bxiUkIPFZGSIQ81Mu/Kh32289wh
         1N9zA1mVdXfmhkM/VXoKfMFeZBcGHdJWIlJUi6hDJep7lnM0aFavxwcu26GBQf3IIkSA
         MC7iBG5b3295dLYJzN3UwivOe/a8eUmseFEGsRsEDJdFLzsOdPgWCVT36073yZ6QybFK
         pT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412429; x=1783017229;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK9teGEbAuqrNIy5aqNQSmg0J+9jxTnaW9l3MgprSuU=;
        b=epWx03MQBRLfBCBCllICwTskxYwRyG77OLhQnDlj+eURoLqfjOqEc2je7QR3F9vV5a
         4wGd/5tvwRH4WPo/gFGd3DjVsaJ4TvzSUpKYV8fPn3eL8uaBkbqj6QDfFIlFOUAuGn2Y
         dZQ//n5Oky9eS3hnMGxpRXlLtCXF31OdIjXv3O7GHLwEQhRZEAD+C5GjvqOm5ZbpDxyd
         IEumr6i/XoeTNKaF5/6UctKTvEiWVtkTABV+cDhi05kS5Gtuwny0wrQ9FVAmMm/GjX92
         0GUBxU0DiL54QN6lsqz0GI9BpnNcXVY1Yk8JRa+tmamKLxtsBQXYWmXt/GakXnOvYTxJ
         FRpQ==
X-Gm-Message-State: AOJu0YyR2C2EsLX7wLChnNUVg1+DcmOG3mgDBr1n8Ppl91s01Z9xJPhz
	CUmcLkglsHF/wHNCL0OYmwXFnZFtgfUuaHcZDm4BSwJ+KH6+x3RDdXeHNLpdng==
X-Gm-Gg: AfdE7cmXT+PiazNOWSxNwBLjgIl4wbvWbZB29QJLDrXBFeSQP9ovGcRwhSqMVhWOOT5
	zBeLEObIRmTcIK91SA+2oub1kbh/6A1oPvBQyg8guC6vbTNHZXImMgiXZ49i+Fs9gUXlqz+mCEu
	uKbprUa6nJ9GU2pzS10qkhq51b1gkf26n8IFouak+bByX38RfBXS/1H5seT5aAgzOGZRLrPRDIR
	llUzrdGKQv2kgv5qTF5Pqu7+MudiiADeWxAH+pK/GD14AOGI29iPY0LdgMxv3Zn/fRko/Aee+/Y
	ebXvM2fYcXNZ3AzlUDh6nvlzH86qUr99xt8T8R7c5KryJ7iC4jZnAHbNv7pYGy9Z5C3d0BNSu5g
	SUfkBQACFCLFi6kPmN58NOWbAevcPNtsVtCz7aR5QItEJXitNjcygBlSQNdWRKv5TDYA2EAaiE/
	OiEnUBH4NAf1bApWc=
X-Received: by 2002:a05:6122:e1ae:b0:5a2:5669:d6d7 with SMTP id 71dfb90a1353d-5bd69d8c58bmr1770083e0c.9.1782412428950;
        Thu, 25 Jun 2026 11:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f6fa32esm187479366d6.14.2026.06.25.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:33:48 -0700 (PDT)
Message-Id: <pull.2158.git.1782412427801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Jun 2026 18:33:46 +0000
Subject: [PATCH] history: close COMMIT_EDITMSG before launching the editor
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git history reword` and `git history fixup` subcommands prepare the
commit message by writing it to COMMIT_EDITMSG and then opening that same
file a second time, in append mode, through `wt_status`'s `fp` field to
append the status information. That second handle is never closed before
`launch_editor()` runs, so the editor is started while git still holds
the file open.

Everywhere this leaks a file descriptor, but on Windows it is outright
broken: a process cannot replace a file that another process keeps open,
so an editor that rewrites COMMIT_EDITMSG by creating a fresh file in its
place fails. This surfaced while running Git for Windows' test suite with
BusyBox' `ash` as the POSIX shell: the fake editor's `cp message "$1"`
aborts with "cp: can't create '.../COMMIT_EDITMSG': File exists" (MSYS2's
coreutils `cp` hides the problem via its POSIX unlink emulation, BusyBox'
native `cp` does not), making t3451-history-reword and t3453-history-fixup
fail wholesale.

Close the handle once the status has been written, before handing the
file off to the editor.

Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    history: close COMMIT_EDITMSG before launching the editor
    
    I noticed this problem while trying to whip MinGit-BusyBox into a better
    shape during the -rc phase. Technically, this is not a fix for a
    regression during the v2.55.0 period, but I figured it'd be better to
    send it now anyway than to forget about sending it after v2.55.0 is
    released.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2158%2Fdscho%2Ffix-fd-leak-in-history-reword-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2158/dscho/fix-fd-leak-in-history-reword-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2158

 builtin/history.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/history.c b/builtin/history.c
index 9526938085..4a5d9192f3 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -74,6 +74,14 @@ static int fill_commit_message(struct repository *repo,
 	wt_status_collect_free_buffers(&s);
 	string_list_clear_func(&s.change, change_data_free);
 
+	/*
+	 * Close the handle before launching the editor: on Windows an open
+	 * handle would prevent the editor from replacing the file (e.g.
+	 * BusyBox' `ash` cannot overwrite a file that another process keeps
+	 * open), and leaving it open leaks the descriptor everywhere else.
+	 */
+	fclose(s.fp);
+
 	strbuf_reset(out);
 	if (launch_editor(path, out, NULL)) {
 		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
