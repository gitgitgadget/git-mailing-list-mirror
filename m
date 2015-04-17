From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Fri, 17 Apr 2015 16:31:35 -0700
Message-ID: <CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 01:31:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjFja-0001wN-8H
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 01:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbbDQXbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 19:31:37 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38298 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbDQXbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 19:31:36 -0400
Received: by igbhj9 with SMTP id hj9so24675346igb.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ii9SQ3+/DQw0YLbdVdR1AuQdysdSA2v9jBfMc5ws2Ww=;
        b=a5GzkVzKvFEEFIGrFsLvu+ZuhUeItz5EoLsEqos7bzlDgJsP8oUGA7Vj1lp4uqWx2s
         b8TTW5fEAXa/wAhMcs8T3ypxKRorsTIjZEw7YTGhH+aLPRv/A0TSfp0DBJ955gCX6n8U
         yH64kjQrfdd9mjRXlyuy9x47Jar/8GQHy5uU1/0bLvAfiUwyHrewmsIbI0bZPWkHVukj
         gYUc/EZgNZ73oUN3a9VNiumYcJ5IMkDjyyC/V1jtsjCTZPL/evhoaNOPzZABF+k6iQAu
         44p59mR6tePfyiPjttOWkasolAg4FjpwFCd7xWnUcJ+HNSlYTl/gfADhDlrI2vlLqGT7
         bJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ii9SQ3+/DQw0YLbdVdR1AuQdysdSA2v9jBfMc5ws2Ww=;
        b=Zwdt/tDy3XeRqqut35GNFBvJCV+j/UFYasNzDFbTYNDCVxgl4dRWirUzp63EKbB4f0
         v4v2lcxuxlATClRZkNquey93ua0gar+cJzj0kxVxY6nOF/bVorTvBeH5f7GTXlo2NovY
         g15NsnQ5lVNAcYazFnnOEpsL4Qnc5p7BXfcfZNxt445Vgo8Oam++bPZ4SiLcBHtcXGZE
         6qszpygeYZvxVEWCFa6f2psq1ATvkU+FS5oyKSiIMkF/4RLkcCN4ey/YuW/kXiuvFcke
         UCNHm8KwwBMps8sGIJBllfrPkT5EokinXMKnzI2zMdyV/gVxJJXU/h6lVa0ZwPRL4RXi
         aaSg==
X-Gm-Message-State: ALoCoQkjbOLPo3DJRL4H1olVWHAwsUaqvN89OB/vzKkJv6B2mWb94p2TvBwlrdHA2CMQaLiOIthm
X-Received: by 10.107.132.223 with SMTP id o92mr7137235ioi.49.1429313496063;
 Fri, 17 Apr 2015 16:31:36 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 17 Apr 2015 16:31:35 -0700 (PDT)
In-Reply-To: <CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267402>

On Fri, Apr 17, 2015 at 3:17 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 17, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This is now pushed out and sitting at the tip of 'pu'.  It seems to
>> break one of the tests in 1400 when merged to 'next', but I didn't
>> look it closely.
>>
>> Thanks.
>
> ok, I'll look more closely.

Apparently I screwed up even before sending the patches over the wire.

  not ok 144 - large transaction deleting branches does not burst open
file limit

fails in my local branch as well as origin/pu as well on
origin/sb/remove-fd-from-ref-lock

So there is a pretty strong argument, the code is only improving
large transaction creating branches and not deleting branches.
