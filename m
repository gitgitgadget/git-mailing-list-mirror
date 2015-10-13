From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] send-email: allow to compose only prepared cover letter
Date: Tue, 13 Oct 2015 14:11:54 -0700
Message-ID: <xmqqa8rma2xx.fsf@gitster.mtv.corp.google.com>
References: <1444752768-82136-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6rZ-0002b2-4Q
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbbJMVL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:11:56 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35208 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbJMVL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 17:11:56 -0400
Received: by padcn9 with SMTP id cn9so839809pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pCPh/Ou3JFJKO9f1YFXNG3KjQCsCua6zl11ZrAR+UUo=;
        b=pM1QfysepAFAWDAq6lyD39m/093+M6S1wLAfjWXy3PvH4ozDtddw91xU4tKy/vW7XT
         njh2fl24m+Va9azIIqLFNySyXnFXsvjtrIZ9UxyN7mih1VD82iqVS0Nad+Z15DfvN0nr
         Zhef2jOm78Gu+16WWGAoGb/gDyJtcdwxL7oF9uga4LkUnSrTUlFjR9imS1udUouZk1T9
         V+9e8sHrcPUIaLAC0lfjLrhbmHiUypvIbrkFv/q1CR2AK5+W4HCZX+4CGLc8tgnkx/rT
         8xXBynTU94SRc1v1ti3kmqA/KmfE2yBnP1xOa2vW+SQrfyKWD72ezKNcZrT3djDlk5Gb
         gz0Q==
X-Received: by 10.66.121.110 with SMTP id lj14mr42335082pab.61.1444770715444;
        Tue, 13 Oct 2015 14:11:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id w9sm5571590pbt.29.2015.10.13.14.11.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 14:11:54 -0700 (PDT)
In-Reply-To: <1444752768-82136-1-git-send-email-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Tue, 13 Oct 2015 19:12:48 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279521>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> My often use case is to do:
> 	% git format-patch --cover-letter --subject-prefix="PATCH vN" rev1^..revXYZ
> 	% $GIT_EDITOR 0000-*
> 	% git send-email 00* # assumes series less than 100 patches
> 	% rm -f 00*

I guess this patch would not hurt too much, but the above would
vastly be improved if you used "-vN" option, instead of the
hand-rolled subject prefix, and dropped the last "rm -f" (which in
turn would mean you would want to use -o option to specify where to
keep the older iterations of the topic).  Then you can easily refer
to cover letters and patches from previous rounds while preparing
the latest to send out.
