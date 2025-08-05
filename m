Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB021E25ED
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422553; cv=none; b=qI5UGK7x4MW0BORimb5aYy4uLQBJI5l74DCO0wt8YsvC06le/vEtZViw7F+NdnNmGH5ayd4swMararJ/Wg3BiRsA29hu3gLIt301Sukm+5HjWoan4HBCvhMSlfukQ8vgiBC+aLKJvECui7lXM+uBXRJhk9ZBMFlgVV7J5/n011g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422553; c=relaxed/simple;
	bh=h28Zpuwr2aT+L8LcCx9BgrFwS268exxoyRg3EOF7lUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FQaK5Ho1sbK+2Em5975dQJnx1ymF1PzEJHpum0IS2st3prVDuP9uQbYeAlU5MUH1muiq4ClJpoNYio+o+vlH9P9fk/lsTdA4fzlUFygoGNLgJsXnvDRQVYiXxn5DJUT+knwbD9CmqmB6TUcc7zWqbwVIcygU+KQzglZuzIptnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDxdr/Ev; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDxdr/Ev"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso108493f8f.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422549; x=1755027349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=iDxdr/Ev6yhwPIzJyTEBhuI2x1pcgPtRfF9U08d59yxNxsFJqaCV9W2PwnQx59Yyci
         0IpoeWYSaOyPy9VsTuvdHf1hgfCD89eDmNIUdMXn8MqgLf3rCjd+2XTp2xswC1tmHIfa
         Ux6KukL8xRIusGM2yJ7Ziym1EppX9lr3cZO0HCZ4sGWXBxkdr0OkmaOPAYCv+jDYs2zZ
         Kpvkh2FjZiNU7j2yy4IxAqHHy/OV8+W/cTCl1zk0KR82jnGpGh2bTWGX/4l+nvpiRSFG
         dpcNn4QCYMvmUXY6tKQVx+Oi7x3J6gsGcWsmrdVFNlCkkY0whHhTJqOF3SZeqRzkPAjW
         vySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422549; x=1755027349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=u6aG1B6mNiWGNY7IPOav+IZzmDOUg3H6kB+yWjJiqw42IM5AN7c6PKguZRxNftEfdK
         GBOPDZiJdGTV1hM9hDWLK6GevfBVkogEk0e+fUZ2A+ipwpFoepyY5yuHcva8ozD9THKk
         drS+PD6cDvEZftpcSUF+PEg89KhVibwmgUV98uajMOZNLQE7eb+yLAnf5PlU2lRR/ZqF
         OhJPXln4uUBTYZfNsJ+fwR9BCG9cQi+F8eZVnnT+XXLyRi2XBW5fmYYSsvUdEB39FI8r
         41QEOywhOG0Co1x57l6IdIUHdFmEJxM73e/dkFMNoX9P9yC/yhCQYL4EjcXXu6YCgBSe
         hhUg==
X-Gm-Message-State: AOJu0Yzxbmiq4K/cDB/0Rf9hGG2Q3r4Xh0f1ctI1DA2YD84jUYVselFP
	CT6dGGgsqj/CWErTUV4Aw+DqIe5f+KcL2yfLodD12qBKCgl+teQ9OmCig5bwWA==
X-Gm-Gg: ASbGncslpzWMsBrNjimIVIrRRoTMkwO9pZC4vV4++mHvmQDMZxTdiiVwm9P8C+2p1n4
	K93bwLSlhicPBcwAZ/N4GD55ks9U9LwucHH6lBtl0XSilEpwGFkkjAgmx3IyPoYAalIyOQedKmN
	t2ujPUGFA96CD1WVzUZonbtfR7YG/jEC/PhQ2cQvnhBKGvifAk3TU1p79tmF95qO7kxilFN8Mpa
	xebK0TqZQTHJr40jzUYjCWgSvnlw/BDLUWFiVLKpL+emHl39aGjWqadBD1smUP0LF/J4SuOABZq
	vx7gKaN3bqfDyWOQLSt9lT+t6sMBhJq7gVLHa2yTi0iWVNML7TC5PDM0yEJTrH7VPQNb8SkBOnR
	bzFbvRQRnGyJaGLeGqIn3KNI=
X-Google-Smtp-Source: AGHT+IFLpWLGM7YVE5OoIGDmN/Kg62uk12AuAmE67M9CDux4KuT7FswpjCU1I49m6SZ24elEwSRCmA==
X-Received: by 2002:a05:6000:1445:b0:3b7:6e64:bed8 with SMTP id ffacd0b85a97d-3b8f437eb9bmr91660f8f.28.1754422549418;
        Tue, 05 Aug 2025 12:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm20372983f8f.39.2025.08.05.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:49 -0700 (PDT)
Message-Id: <58df0710efc042b014a0c8282ce1d7fa62fbb760.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:42 +0000
Subject: [PATCH v2 2/6] merge-ort: drop unnecessary temporary in
 check_for_directory_rename()
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

check_for_directory_rename() had a weirdly coded check for whether a
strmap contained a certain key.  Replace the temporary variable and call
to strmap_get_entry() with the more natural strmap_contains() call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d87ba6dd42bf..9b9d82ed10f7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2580,7 +2580,6 @@ static char *check_for_directory_rename(struct merge_options *opt,
 {
 	char *new_path;
 	struct strmap_entry *rename_info;
-	struct strmap_entry *otherinfo;
 	const char *new_dir;
 	int other_side = 3 - side_index;
 
@@ -2615,14 +2614,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * to not let Side1 do the rename to dumbdir, since we know that is
 	 * the source of one of our directory renames.
 	 *
-	 * That's why otherinfo and dir_rename_exclusions is here.
+	 * That's why dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
 	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
-	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-	if (otherinfo) {
+	if (strmap_contains(dir_rename_exclusions, new_dir)) {
 		path_msg(opt, INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME, 1,
 			 rename_info->key, path, new_dir, NULL,
 			 _("WARNING: Avoiding applying %s -> %s rename "
-- 
gitgitgadget

