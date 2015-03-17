From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Tue, 17 Mar 2015 17:25:33 -0400
Message-ID: <87egons4du.fsf@gmail.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
	<xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
	<xmqq8uewp183.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyzN-0001iv-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 22:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbbCQVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 17:25:21 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33045 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbbCQVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 17:25:20 -0400
Received: by qgfa8 with SMTP id a8so21095266qgf.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y7XNKdAfosCWkLwX3q9Jl/3YopjCPwTHYPlPnfb10z0=;
        b=hFlAnCAciFVZSpUs+DqVIuUxeLxUoMH+rVCpUBr663+VF6REy0RRBrGq2TH22j1LPm
         r+zl44AxGitP2ys1NW0GpSYWXV350nzlMXK9DAbO/NXLGk0lWzVRxl0xLpvi+PVve9e6
         TEdQY9UPJzdEMKm273MnaGbLqbP2Emmk1mMg2supenNJ2DjVUrNh4scJxWhz2rVfCS6N
         Y+090ID12GXE7F0mra6nwamIU+cuKq91u4SeLzhLkoStOx9ukr/VbRXfwfYsMDMdmmhS
         1urpk+YWlij8yw5KlTQI5cpIvaAHvggHaXRwYw+vnyTlVOxITRtoH4huflJP0KbjLfGi
         eYzA==
X-Received: by 10.55.25.194 with SMTP id 63mr97297010qkz.53.1426627519830;
        Tue, 17 Mar 2015 14:25:19 -0700 (PDT)
Received: from fujitsu ([132.205.236.24])
        by mx.google.com with ESMTPSA id w186sm10446788qkw.27.2015.03.17.14.25.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 14:25:19 -0700 (PDT)
In-Reply-To: <xmqq8uewp183.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 16 Mar 2015 23:49:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265670>

On Tue, Mar 17 2015 at 02:49:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> 	if (try to see if it is a revision or regvision range) {
>         	/* if failed ... */
> 		if (starts with '-') {
>                 	do the option thing;
>                         continue;
> 		}
> 		/* args must be pathspecs from here on */
>                 check the  '--' disambiguation;
>                 add pathspec to prune-data;
> 	} else {
> 		got_rev_arg = 1;
> 	}
>
> but I didn't trace the logic myself to see if that would work.

You're right. I was actually going to try and check all possible
suffixes of "-" but your solution saves us from doing that, and it
didn't break any tests.

On a similar note, would it be relevant to add similar changes to
rev-parse? While trying to write some test, I noticed that rev-parse
doesn't support "-". If I'm not mistaking it assumes everything that starts with "-"
must be an option. But since it is a plumbing tool I don't know if it
would be worth it or even an improvement.
