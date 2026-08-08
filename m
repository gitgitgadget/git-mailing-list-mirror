Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4A205E02
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786181604; cv=none; b=XI6GFIOhpj8sOY8SMZO9Gqm9L8IaEQDNNfNC+6mrCKzjxtcDuceMasCtsB++T/BmCzT/udvFcVK7Vx4R8E+ZFU4PRHA1nVEpW2Cm/nYSjp+pFJaR1gpZYRXeE0cl65CDUxSYypOCUL3XIbJ+FUten+O+89n/4tLUob718o7K+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786181604; c=relaxed/simple;
	bh=EJy4ksn+OXN3x+XeTjKNCEA63ngD1l2H9j8fbLdkldM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IPDsNO1TAc0GSR2dhVt0oI+JOfx49bDuTRmuZkrbwWy7lPvPvafHEIYZcUCD6kHt9sE8eOoNvxKjYcZsiCtrE8NLX5Pl7hFmE+DYUeO9LNinl8N0HcIHCa0Cg27UxON+6b/LH7OAg1w8twaE+pyfuZtywbOcfP4px7IBunvYsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hHG602hpszRnlL;
	Sat,  8 Aug 2026 11:33:12 +0200 (CEST)
Message-ID: <39f99016-8ac4-42f4-9a61-7f20b5431c1c@kdbg.org>
Date: Sat, 8 Aug 2026 11:33:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] gitk: show color preferences on the button instead of
 the label
To: mark <mlevedahl@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <0428a92efc4657d2da1e968ebe45038cd186b055.1785998419.git.gitgitgadget@gmail.com>
 <eff19bf1-a8a8-4de0-9fc1-cea4b3d0f1a6@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
In-Reply-To: <eff19bf1-a8a8-4de0-9fc1-cea4b3d0f1a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.08.26 um 16:37 schrieb mark:
> But, the colored buttons do not stand out to my eye as much as in the prior approach.
> Perhaps use -borderwidth 2?

I agree. -borderwith 2 does help emphasize that these are clickable
buttons. I'll also insert a small space between the buttons like this:

@@ -11868,9 +11868,9 @@ proc prefspage_colors {notebook} {
 
     foreach {uielem colorvar idx label title} $coloruielems {
         ttk::label $page.$uielem -text $label
-        button $page.${uielem}btn -padx 40 -pady 0 \
+        button $page.${uielem}btn -padx 40 -pady 0 -borderwidth 2 \
             -command [list choosecolor $colorvar $idx $page $title]
-        grid x $page.$uielem $page.${uielem}btn -sticky w
+        grid x $page.$uielem $page.${uielem}btn -sticky w -pady 1
     }
 
     grid columnconfigure $page 2 -weight 1


-- Hannes

