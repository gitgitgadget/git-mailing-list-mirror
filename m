From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull --rebase` fails
Date: Thu, 08 Oct 2015 17:52:56 -0700
Message-ID: <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 02:53:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkLvm-0003U3-SP
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 02:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbbJIAxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 20:53:02 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33098 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508AbbJIAw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 20:52:58 -0400
Received: by pacex6 with SMTP id ex6so69645282pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=im69NMkKy4SvSRLT29s0cT4VrW2uu5mcgCGfFzwbN6s=;
        b=rFg6ADSwceyPhHedTs+cLO0vAT3SNJPQG4iak4TXVK5ntcwXJa2Bzs5H/xO4Dzk6Vp
         Q0bNrw5J78fynF6QESvtOnS5624BwEb6tSuGgsWFiWpptDv8gVqLUI6w+h0QkcjSmGqO
         7Vd0+eunIKhG+PBVJbFY6PtGWgfpV0aYTKV3X1Aq+bTbkZ3hDM6vnAJZgiYTld2Z7fj+
         wAT2iSy7rD95f9LIPB/m1WMq6IlsjSyf2u8iUO/8yx9pgheCJOYeZEqFcQKobcEa+lfT
         w7l/GZdmx2MecUg7806j0a2ZJYQp0y39w4mU7NUQhywUDF1F/JfzApe4Q6qop065PNud
         mHJA==
X-Received: by 10.66.55.66 with SMTP id q2mr11719941pap.89.1444351978441;
        Thu, 08 Oct 2015 17:52:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id ih4sm31592410pbc.28.2015.10.08.17.52.57
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 17:52:57 -0700 (PDT)
In-Reply-To: <cover.1444336120.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 08 Oct 2015 22:35:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279281>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Brendan Forster noticed that we no longer see the helpful message after
> a failed `git pull --rebase`. It turns out that the builtin `am` calls
> the recursive merge function directly, not via a separate process.
>
> But that function was not really safe to be called that way, as it
> die()s pretty liberally.

If that is the case, I'd thinkg that we'd prefer, as a regression
fix to correct "that", i.e., let recursive-merge die and let the
caller catch its exit status.

Paul, what do you think?
