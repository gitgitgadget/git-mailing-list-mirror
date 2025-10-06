Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480E21576E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749964; cv=pass; b=fBxhf+L9r3d+IFn4Wb+2K69DrdjnymDngHq6lZGtk7oK357E06kMc188vow85MeG98ObOmb/kPTj7I0yaiXPqrukVDrVZ5pdax3NeoZV7i7EBGVqmKW5yShTf7r1v8Y9GeUtUwUxiD183YYoyOxP/+EojsPMfT6EtL0abI5CcrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749964; c=relaxed/simple;
	bh=qpsxrOriRWG62LU7GyeWpjGYMvkHS/6joyUt3nwY+c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixO0V/p7ilc6VJRbZCHnKkDXglx1BmRWWRtbXEhUvYILw9utCRz8ON/60qKp8TwGEjI2nBCxS5EuXU/J3+k8JDbFVQBiEmWmp7uitYUFjRoNPIR8NIOK7ZF/q3FDPcD7+vJrbvK2YG/bqL0VjOt/Jkc+Iom++cp3UWBXEm3cBBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=QvWBsFE9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="QvWBsFE9"
ARC-Seal: i=1; a=rsa-sha256; t=1759749944; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gObTrRnq9PrXG0LQSjKf1EegcTlkZx+kdO2wqUl5qfF0MqPzQy7IFTjCa7F1DRLhEnZqYkeB5VAtz21zRiKwvC94qZ3N5S+kGv81IvoffZexjivyMjx78fQ6EVtRChYC5WUZW+9P+nuK2EUM+TiGig8iJbSgEnb1vAiMVdFF8I0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749944; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ryjnfdWy4+wL5oakM1ZPixaJNQgteOt7FN3oxxLwe34=; 
	b=MdEfHJLXwq7fyhT5ADFbXpp6YIKR9fcFvIeWuAP/CyLU9XNXcKbu5y0FlM/frRJkmlT8baoXENG75x2Mtrm5rAb/48s3Nu5x9/Pc1QoSfasNgDdJFleHMsVmiQTJX7hdmNHvAVlQF/5CKK88YwxthxGR1cQcnYNbjNO2ZxdH2GI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749944;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ryjnfdWy4+wL5oakM1ZPixaJNQgteOt7FN3oxxLwe34=;
	b=QvWBsFE9C8EgUAgRDBEn3L6piryPA4iRRPdK+dPOA+tRqjhkawr6YUXNKyikh1it
	i4TkQImu7awB31THd0sdvgZPuGJ84IcIuWvxfrS4NfZhQmEhGVsMByn5ALejnWS1q63
	AxMWZVMJJ6Dp5VX2ondhLa9x+q3gQNbm4IExdE8E=
Received: by mx.zohomail.com with SMTPS id 1759749941478627.0703226998246;
	Mon, 6 Oct 2025 04:25:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
Date: Mon,  6 Oct 2025 14:25:13 +0300
Message-ID: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

v3 is much simplified from v2, starting from the design idea that submodule gitdir
name encoding is to be put behind an extensions.submoduleEncoding.

This allowed removal of the modules vs submodules directories split and simplified
our logic quite a lot. Tests have been been squashed in the smaller commits as well.

Many thanks to all who provided feedback, especially Patrick and Phillip who
suggested the extension idea.

This is based on the latest master branch and I've also merged and tested against next.

I pushed the patches to github [1] and also did a CI run [2] which passed (the lone
Win+Meson CI failure seems to be unrelated because it reproduces without the patches).

[1] https://github.com/10ne1/git/tree/dev/aratiu/encoding-v3
[2] https://github.com/10ne1/git/actions/runs/18276914867

Changes between v2 -> v3:
* Put submodule encoding behind an extension (Phillip & Patrick).
* Removed the submodules vs modules directory split (Patrick).
* Undeleted validate_submodule_git_dir() because it still needs to check the default.
* Undeleted tests from t7450-bad-git-dotfiles.sh because they are still required.
* Moved new tests to a new file which enables the extension.
* Moved unused variables to commit which uses them (Szeder Gabor).
* Squashed commits to reduce their number (e.g. tests are together with new logic).
* Fixed a small bug passing the module repo instead of the_repo to the gitdir helper.
* Small commit msg rewording improvements, typos (Kristoffer & Phillip).

Adrian Ratiu (5):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: add gitdir path config override
  strbuf: bring back is_rfc3986_unreserved
  submodule: encode gitdir paths to avoid conflicts
  submodule: error out if gitdir name is too long

 Documentation/config/extensions.adoc  |   9 ++
 Documentation/config/submodule.adoc   |   7 ++
 Makefile                              |   5 +
 builtin/credential-store.c            |   6 -
 builtin/submodule--helper.c           |  30 ++++-
 compat/pathconf.c                     |  10 ++
 compat/posix.h                        |   8 ++
 config.mak.uname                      |   2 +
 meson.build                           |   1 +
 repository.h                          |   1 +
 setup.c                               |   7 ++
 setup.h                               |   1 +
 strbuf.c                              |   6 +
 strbuf.h                              |   2 +
 submodule.c                           |  84 +++++++++----
 t/lib-verify-submodule-gitdir-path.sh |  20 ++++
 t/meson.build                         |   1 +
 t/t7400-submodule-basic.sh            |   9 ++
 t/t7425-submodule-encoding.sh         | 162 ++++++++++++++++++++++++++
 t/t9902-completion.sh                 |   1 +
 20 files changed, 340 insertions(+), 32 deletions(-)
 create mode 100644 compat/pathconf.c
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-encoding.sh

-- 
2.49.1

