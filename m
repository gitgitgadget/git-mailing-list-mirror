Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D841487FE
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151406; cv=none; b=gz1kzmZCqg+vjYypG3Wml5uqQTmdPq0+KNdHTpD+TlfWXlKCcEJaUxU/f7M6DabIwwz3e53X84ZTaYUoo6DnEgpk8oVLHP8PbUa8iAgJJQf5HJMalixv+15my/yHZt5hrH6Ih3lUwHaeKCtAlVXZvNf5Kq+DNNjyl+daqfX3hSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151406; c=relaxed/simple;
	bh=RdkxUburhK01AFwQkU65usN+R23nIBtiEGBq0yu5Ixs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oe+f+OwrDeE4U2SQf+vdAKRGrj/x8IbxNbwUKtLRur9zFs1+J88oqrC2GiOqDlKx3+MZChnF8e/cnr0/r44rB/OVTDal5JI/vQ77/hgC5EnegbuEqKmIalC2SbxtcrrJOu8UlOdI8momJLnJLKDJlrsReBrqUk0YKAoXhsnOzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4MTTv9o; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4MTTv9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723151404; x=1754687404;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=RdkxUburhK01AFwQkU65usN+R23nIBtiEGBq0yu5Ixs=;
  b=f4MTTv9omyZOzxAWOKei/VgEIMC9WxqoSfFI/t3y7W+Mk5YtkesQNR02
   tfPWCea9Fyv4DiTNnKurRM5awsYvM1/wenu1iSbMrnzKKKuVvn0dSO7xn
   PlryktmSV22jeJQ2bnavPORROpWL6aFDro4wxN5Zb3rnYDEVlyFfY9HIV
   VzPu+SqUnxm2S9qSQ+MELk3T3jJxF9wZgAVATyWX9uQvTFoi6KdLDwNxf
   Fbuy/RopzvwHGKQSUa4hiXKUkJ0dkWEqVebjcAawAtaIAM1I8156ox8n5
   gYXPWLOZ/3LjRUuGo9r4Zkkfx8yBa3NLtAtY8FSB9FdL+JE1mQ0ZMLoYa
   Q==;
X-CSE-ConnectionGUID: aRFezQdtRNeX1SaKuIniWg==
X-CSE-MsgGUID: PYjkkQvMSu2uRsPnXylYYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46712890"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="46712890"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:03 -0700
X-CSE-ConnectionGUID: BiG+5+BXTWC40nQHV2Yxaw==
X-CSE-MsgGUID: +opQub18RveyQcgqvbubAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61991221"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/3] send-email: teach git send-email mode to translate
 aliases
Date: Thu, 08 Aug 2024 14:09:57 -0700
Message-Id: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACU0tWYC/x3MQQqDMBAF0KvIrDsQbSqhVyldDOaro2laMlIE8
 e4NXb7NO8hQFEb35qCCr5q+c0V7aWiYJU9gjdXUuc674AIvK29FsiXZwJJUjA05Ml6iidsBzof
 eX3GLVI9Pwaj7/388z/MHnuKHXW8AAAA=
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

The b4 program has its own "b4 send" utility for sending a patch series. It
is similar in many respects to git send-email. Currently, it lacks support
for processing aliases, which makes switching between git send-email and b4
send somewhat annoying.

It would be convenient if b4 (or other programs interacting with git) could
make use of git send-email's alias file support.

Teach git send-email a new --translate-aliases option, which enables a new
mode to interpret all remaining arguments as email aliases, translating
them according to the configured alias file. Output the translated email
addresses one per line.

I also considered implementing a new "full" format for --dump-aliases which
would dump the entire alias file along with its configured email addresses.
I ended up dropping that change as I felt that it would be less usable than
the translation feature.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Jacob Keller (3):
      t90001-send-email.sh: fix quoting for mailrc --dump-aliases test
      t9001-send-email.sh: update alias list used for pine test
      send-email: teach git send-email option to translate aliases

 Documentation/git-send-email.txt |   7 +++
 git-send-email.perl              |  17 ++++++-
 t/t9001-send-email.sh            | 103 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 120 insertions(+), 7 deletions(-)
---
base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
change-id: 20240808-jk-translate-alias-send-email-1ce048643e5d

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

