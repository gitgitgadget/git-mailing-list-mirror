From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Tue, 02 Dec 2014 00:04:59 -0500
Message-ID: <547D487B.4040502@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>	<1417335899-27307-25-git-send-email-pclouds@gmail.com>	<547B5170.6050206@gmail.com> <20141201103818.GA20429@lanh> <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:05:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvfeB-0004iB-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaLBFFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:05:04 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:57065 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbaLBFFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:05:02 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so8951846qcq.11
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UlDNlyHMTzoAGH1ykn/UdW2QyAr/MOimv7aPlYz0Dls=;
        b=ypD4D+ju43RURbPt/abJA8+VAF5wp1P3uv/otx7oG8aqfwQ96fUcULbGoh86JpTMG3
         Ql5I2Mg3bdt5U0EOgsLsZQQwBmMSbi5sp+Y5Ri5ahBPyudMJEtJqh3br5ou48e4MA5/U
         gsGXQ5IF/PHy/u70AB6Db5vzhoJAIHkcOIQycK+KpuFxXP9RcDxNKC7Uez0jEA2l1e2i
         0CpS1439pPOg9FO8kDdxNua01xwCDTYQuWNl92bDf9WmMbDtpdiVf9o3ww1U0G+5r79i
         Ed3qw0kKbmDR6XQy8+/516wuJOgLAi9l71ExKfdY2GvJpWYN9SHagD0s6B8I+IFLE9gA
         0YVg==
X-Received: by 10.224.37.67 with SMTP id w3mr93826078qad.88.1417496701404;
        Mon, 01 Dec 2014 21:05:01 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-126-100.washdc.fios.verizon.net. [173.79.126.100])
        by mx.google.com with ESMTPSA id f65sm19422431qga.9.2014.12.01.21.04.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2014 21:05:00 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260533>

On 12/01/2014 12:39 PM, Junio C Hamano wrote:
> Sorry, what is a hic? If this were an existing feature like 
> git-new-workdir, even though it is from contrib, making it impossible 
> to do something that used to be possible, even if that something is 
> what mere mortals would never want to to to avoid risking confusion, 
> would be a regression that needs an escape hatch. But this is a new 
> feature. I am not sure why you need to make this overridable in the 
> first place. Those who want to have multiple checkouts of the same 
> commit can just detach HEAD at the same commit in multiple working 
> trees, as the first thing they need to do would be to run "git reset 
> --hard $branch" to synchronize the HEAD and the working tree state to 
> work in the other out-of-sync repositories either case anyway. 

Yes, detached HEADS allow multiple checkouts, but now the user needs 
another system to record what $branch was for each checked out tree or 
needs to resort to forensics using various git-branch / git-log 
invocations to find the most-likely value. So, I do not find detached 
HEADS useful in general, and specifically not for this case. Duy's 
latest addition ('--ignore-other-worktrees') would, so far as I see, 
allow this feature to replace git-new-workdir in my uses, but without 
the addition it cannot.

Mark
