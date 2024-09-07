Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7E1B85DC
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727077; cv=none; b=aYmicXy1LBFwxvuPge3lPxjzFm529R5+c7HB9SeUnKx7AluMIj1YjnjCeFV5myK46GmlKlSIQSU5XY0QQw/8let12SCFUFjSBbtEkuTVU1jjZ7LDGUqqIPCaq5HplOvTS/rFHmwrFXCYrQUvlZlexyUqKUR1h11G39vef2O8wOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727077; c=relaxed/simple;
	bh=R/Z1OHW7j3t8P5UH4d8dq5D+UAhq/tK9n05vb2HIOJ8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=AGpIOum+RKp5RmPgBESbZqwrYo3t4FFP6vQJRGQ73xLD8PA/jJozfxEGhXiGA8LF3DT7gvLFn/lUjXSeJ1g7PyTpEcU/QoStSRStv9Csl+0SEElyS1RcYYtqiaYp8xQvfVmdw9Gu/7nvzmM00WMDRvyFhaHy5IGB+654j1lK0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=RuiHfm00; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="RuiHfm00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202408171023; t=1725726519;
	bh=R/Z1OHW7j3t8P5UH4d8dq5D+UAhq/tK9n05vb2HIOJ8=;
	h=Date:To:From:Subject:From;
	b=RuiHfm004dSbB9wESyh0ZSCsqSlibo93IEmAfvW6IBWS/HArSKDaeIOK6vrcAV7mb
	 csOlrYFlND6Ssbys9VelaC1+0lG/xy1cAof3zsse9DvABu2T3jYqCHTNxjOH7Sw+8s
	 HTil/InoRXx7Iyfm9I49gxjwC7Hczth1TttPtfUL54HEV4CHhgFaMqzn9MtNgmKElK
	 wQXlea1p07rX1cn6RWQh+XCoaZrAzSYv/wp7DfUotNbTOTojLN1xQKpDCphYjF/mUR
	 YHF7XU0B6l76+8AB3ZWi5ssIL9by2YJYYOVnwslb4GKNCk8QeJpGn3MwdjCAygYagU
	 EZPbO5xEwYj2g==
Received: from [192.168.42.22] (236-98-142-46.pool.kielnet.net [46.142.98.236])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 528113C049C
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 18:28:39 +0200 (CEST)
Message-ID: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
Date: Sat, 7 Sep 2024 18:28:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
Subject: Thoughts on the "branch <b> is not fully merged" error of "git-branch
 -d"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

I frequently get this error when trying to delete a branch that was
merged on github, and the remote branch was deleted through github's UI too.

When I then fetch and see that "git branch -v" shows it as "[gone]"), I
will want to delete it, but at that time it is pretty random which
branch I happen to have checked out. If it's some other unrelated branch
that I didn't rebase onto origin/main yet, or if it is main but I didn't
pull yet, then I get the error; but if I'm on main and I have pulled, or
I'm on an unrelated branch and I have rebased onto origin/main, then I
don't.

This feels arbitrary to me. It would seem more useful to me if the error
only appeared if the branch is not contained in any of my local or
remote branches, because only then do I lose commits. Any thoughts on that?

-Stefan
