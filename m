Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211C36B93A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896703; cv=none; b=gtJj45UJgATuxO42rclOxcDQMa0nXwopm0wTMo8WHlmYX5ZrUo45SCxmQtn4hKBAQ+/UxMDxBFrGWlXEMLDs9nbPKOCC63qzzFmi414pDrb7vYnyYrqlnNJpSbFEyZXAV1++KKqwUXJoZ6HW/vhIixoJVtFANLKc4WxsSlAUM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896703; c=relaxed/simple;
	bh=ob3lO711FvuEn45yWeybckH753ynETznTETSLtLx1nI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=meBl9T75opfqliC3dPBiKDEq3b1ZfiVvvWUs7VCo/oO6RuXZyVJaEwLDM8z7/vkzs6GWxAUGL5lvTZDlr2L4clcLjUnJecu3n7SCXzJJ6HFO2CbcauXcueIHFpdBpQWvYJmy82m+9OCasA7Kowgt0MbkKpNts4IpE+u/uXZcGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfCAEDPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfCAEDPO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60AF5C2BCB8;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788896702;
	bh=ob3lO711FvuEn45yWeybckH753ynETznTETSLtLx1nI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XfCAEDPOLi0apgeof0+Y0a+k06hIVHD9quCfZ8rbjkRz5QZC3M6oNM7qQJWjNfgFl
	 Kc/gdjg/tJpc86ymFCdhSeYvXTbvzcMWpTHyeR82ryozvrNQpIol0qRghCeCZL2gjH
	 tEAOHdb4A6dk0bslzxOsjw6+tFPqMlnkbbpPv+3iij8GU0KHWKQ8HoHeFwssAGBM2R
	 ehwxR/vmdQR4CUlV5hMnm+avbYNUM0KrMdov5RbWBr+vNmkkVi0Ipw9YqfwleU75HT
	 kdRJiIWE/aPoUD//Ki7RKn4vOQ4TxhhLq5joNKx7IqqYVhV4BrODYEjGVuK2W68I+J
	 ioUSR9CKegbwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E3C79FAA;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Subject: [PATCH 0/3] Update t40* tests to use modern style.
Date: Tue, 08 Sep 2026 15:44:52 -0400
Message-Id: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDUZJYKriEXVlJEoaREh7q5Yv
 sX/F3hyTB6q6AJHO3uebUASR6AHZXsS3AWDRJljiYWY5o6c5ZPEmiEmwrRZmqLUSpkSQrU4Mnx
 8x7r57bd2JL2+G7jvB240ABBzAAAA
X-Change-ID: 20260908-modernize-t4001-fb43302caaf9
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=589;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=ob3lO711FvuEn45yWeybckH753ynETznTETSLtLx1nI=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWpO66OHmLU/+LwwXNpXPmGh89xLp7BV/ix+RzUckGB
 w0cqzcLdZSyMIhxMciKKbL8/yfQ+IrlgYRf0LtPMHNYmUCGMHBxCsBE/hQx/C+csGte6L6s4rUf
 4tw5PIxPat+6//Kc/JGTAme6j+6Ry77AyLA6xfzQHYuPU2vUJu+72zejufiBnKotj67jxWUPPlV
 GljMBAA==
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Mark C. Chu-Carroll (3):
      Update t4001 to use modern syntax.
      Update t4009 to use modern style.
      Update t4010 to use modern style.

 t/t4001-diff-rename.sh   | 31 +++++++++----------
 t/t4009-diff-rename-4.sh | 54 ++++++++++++++++-----------------
 t/t4010-diff-pathspec.sh | 78 ++++++++++++++++++++++++------------------------
 3 files changed, 82 insertions(+), 81 deletions(-)


---
base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
change-id: 20260908-modernize-t4001-fb43302caaf9


