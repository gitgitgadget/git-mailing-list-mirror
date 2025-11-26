Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E63191D8
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171535; cv=none; b=MoN769rlDOiQvqiaRh9gUC/pQOsSAWC7cp+Acs7vkjF4PUMPKlWqXDIcfRqoCJKIfkh90hyWdL7Cy3cdg0Cg3j+mRxjd8eVtNlgoLAvXPuDJvbfZRgRGCxRfHOEUFqpK6K3DBdjvHyZ1//QOmtvUjBDvvGbjGcEiglGp5sG2Qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171535; c=relaxed/simple;
	bh=a6vBLYqVKLCRiNmOro6j5iUalZgwN4AHi6YcsxsOVIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=p/QVSI57EGiebq3h0wcuzeGRSV4LZrlk0Qi2LQAOijeNAXFau8AQJWA+Y4HU2YB7qAu8g63APkdDpKE2SONHRBmAwsYMYarbGN+qxXOKkaMI48q6UXkvLqfVwDGFjREjuu3WqXYgsvz8EIzLSYCQX0onhE3AeaSNF6LUj/K74QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dGkHS57NKz7QZDv
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 16:38:44 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dGkHH3fmkzRpKr;
	Wed, 26 Nov 2025 16:38:35 +0100 (CET)
Message-ID: <a3e24a03-55c8-4c1e-8c19-e800f5a128b4@kdbg.org>
Date: Wed, 26 Nov 2025 16:38:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: restore window position, external diff of renamed
 files
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit c435c515dad872532705d45d9ff81d3f4af22d6d:

  Merge branch 'ml/themes' (2025-10-05 13:09:49 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to 776223c4d8482a29585266e189ea8f1933ac9652:

  Merge branch 'tb/external-diff-renamed' (2025-11-26 16:04:14 +0100)


The commit that reinstates that the main window position is saved across
sessions is controversial and needs testing. In b9bee11526ec (gitk: Only
restore window size from ~/.gitk, not position, 2008-03-10) [1] it was
argued that restoring the main window position is inconvenient. With the
reversal of that patch I have now implemented my preference (to restore
the position) with the purpose to solicit feedback whether it is still
inconvenient. We can revert the patch again or find a better solution if
needed.

[1] https://lore.kernel.org/git/20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org/

----------------------------------------------------------------
Johannes Sixt (6):
      Revert "gitk: Only restore window size from ~/.gitk, not position"
      gitk: persist position and size of the Tags and Heads window
      gitk: fix a 'continue' statement outside a loop to 'return'
      gitk: show unescaped file names on 'rename' and 'copy' lines
      Merge branch 'js/persist-ref-window-geometry'
      Merge branch 'tb/external-diff-renamed'

Tobias Boesch (1):
      gitk: add external diff file rename detection

 gitk | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 18 deletions(-)
