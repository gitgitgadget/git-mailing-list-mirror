From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.4-rc4
Date: Mon, 19 Aug 2013 13:41:49 -0700
Message-ID: <8970708B-BCAC-4BF6-8440-EBA6660D7948@gmail.com>
References: <7vr4dplaep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWH0-0000oI-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab3HSUlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:41:55 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48382 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3HSUly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:41:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2133013pab.34
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=omWKxEPJPVXrqPP9bofWF0NbdTMeWP59GC+NUxz9owg=;
        b=IjUVroi/v8T6egc+t2eGg5qpcRMkXjkpZji5XcNy3Kdg9HY+D+63TDZkw+qN8yq/bN
         +0AXk2rCUsoW/LcInKj5kqgmiZG8dEAFuUyu/jahfYujmDIwe9g4SEHdFxB6RTvSZtnJ
         KxQglTsqBCSBkhsicRv4UgMyxlH/kq9Sy48ZHfFzsctmrtW7UOGa9ssqsXZZ5RN9NtMu
         1mpDOrnw2Me9ahHGV9VL464TOgBY8n40VlZxMVrTcL+cgAJlGjJGiEB3Wi2f9DSFL0Xi
         xjiAuSGlqLpOv5NUs0jiV3TqoaUD6Ky1vFimtO0K1YQEjglzzEN66baAHUYapq67jWhY
         TtBA==
X-Received: by 10.68.226.7 with SMTP id ro7mr15264484pbc.72.1376944913836;
        Mon, 19 Aug 2013 13:41:53 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id zq10sm12769806pab.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 13:41:52 -0700 (PDT)
In-Reply-To: <7vr4dplaep.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232562>

On Aug 19, 2013, at 12:59, Junio C Hamano wrote:

> Performance, Internal Implementation, etc.
>
> * On Cygwin, we used to use our own lstat(2) emulation that is
>   allegedly faster than the platform one in codepaths where some of
>   the information it returns did not matter, but it started to bite
>   us in a few codepaths where the trick it uses to cheat does show
>   breakages. This emulation has been removed and we use the native
>   lstat(2) emulation supplied by Cygwin now.
>
> * The function attributes extensions are used to catch mistakes in
>   use of our own variadic functions that use NULL sentinel at the end
>   (i.e. like execl(3)) and format strings (i.e. like printf(3)).
>
> * The code to allow configuration data to be read from in-tree blob
>   objects is in.  This may help working in a bare repository and
>   submodule updates.
>
> * Fetching between repositories with many refs employed O(n^2)
>   algorithm to match up the common objects, which has been corrected.
>
> * The original way to specify remote repository using .git/branches/
>   used to have a nifty feature.  The code to support the feature was
>   still in a function but the caller was changed not to call it 5
>   years ago, breaking that feature and leaving the supporting code
>   unreachable.  The dead code has been removed.
>
> * "git pack-refs" that races with new ref creation or deletion have
>   been susceptible to lossage of refs under right conditions, which
>   has been tightened up.
>
> * We read loose and packed rerferences in two steps, but after
                             ^^^^^^^^^^
>   deciding to read a loose ref but before actually opening it to read

s/rerferences/references/
