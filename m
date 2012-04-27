From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 20:26:23 -0700
Message-ID: <xmqq62cl7t40.fsf@junio.mtv.corp.google.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
	<xmqqty068ffd.fsf@junio.mtv.corp.google.com>
	<CA+7g9JzpLkNHT_o1QyJ_r=4DrauWOPFr5XR_CPeAHGcLpLoD+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 05:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNbpU-0000kr-NG
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 05:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667Ab2D0D01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 23:26:27 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:41429 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759545Ab2D0D00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 23:26:26 -0400
Received: by eekc41 with SMTP id c41so11153eek.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 20:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=qwYCGK+h21J66UqVh6SLbeevcB4NXn3KkeOzcW1GTr8=;
        b=MoSz1v1gpG0og0RjL/i3HDp87btB/MGKXEq7NlvUc1ZIziX5JkTj561NiIM136fl6T
         yZL8f1ub7wmFhu/BPC75hEo/0aE8UNWqajAo7EOtwSCu2xWVk9GhgTQI+1ym0EjB9Njk
         ESCq7HoJJyFRSBOWsm428Ro9R4S0/g+H3DUvqK87723d8Kev/tw+W1oV08TByYjBHihr
         bUVJb1ebx6jSoyJIY8psEHjOj0FnsrJAvTxuBRj5yjjlg3WHQyM2uZsMBFJdIG/rF82j
         VaUSFIqOA2SjLw2zknLCveo2lQG+41o4hPy7ynUjPBPp7k88xUlja+uPYRSeUHhOEdxi
         dXsg==
Received: by 10.213.2.70 with SMTP id 6mr524659ebi.18.1335497185109;
        Thu, 26 Apr 2012 20:26:25 -0700 (PDT)
Received: by 10.213.2.70 with SMTP id 6mr524650ebi.18.1335497184847;
        Thu, 26 Apr 2012 20:26:24 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si4735759eei.3.2012.04.26.20.26.24
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 20:26:24 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id A453020004E;
	Thu, 26 Apr 2012 20:26:24 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id F2C98E125C; Thu, 26 Apr 2012 20:26:23 -0700 (PDT)
In-Reply-To: <CA+7g9JzpLkNHT_o1QyJ_r=4DrauWOPFr5XR_CPeAHGcLpLoD+w@mail.gmail.com>
	(Nathan Gray's message of "Thu, 26 Apr 2012 16:33:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk0OrrxOwgkn3bItAemkpHybqHEuUCfd1NSTC536jyuRXPauzPF0dB/uyr/TtR1O2nNpbrP+4nQ0EY5QxD6bcnyhRwza65rJm3BXYodZjYqovp5bpVznAwn3e5ERcRtx8DNHG0Cbdoedg0MIba4PYZ0IWluIkq9451odrhDprKCzhS8Eis=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196449>

Nathan Gray <n8gray@n8gray.org> writes:

>> Other workflows that use private tags are possible and they might
>> benefit from having separate namespaces; it is just that they are not
>> the workflow Git was originally designed to support.
>
> That makes sense.

Yeah, as I said, the current behaviour aims to support a particular
workflow, e.g.

 * "git fetch --tags" uses a built-in refspec "refs/tags/*:refs/tags/*"
   and that maps a tag at the remote to the same location in the refs/
   hierarchy in the local repository.

 * "git fetch" that stores the history it fetches to local repository
   (i.e. uses refspec with non-empty RHS), when run without "--no-tags",
   fetches tags that point at commits in the fetched history from the
   remote and stores them at the same location in the refs/ hierarchy.

and does it well.

But there is nothing in Git that fundamentally forces you to follow that
pattern.  It is entirely plausible to enhance the former (i.e. --tags)
to a bool-or-string option to let you specify different refs/ hierarchy
(e.g. "--tags" would use "refs/tags/*:refs/tags/*" to map the names,
while "--tags=refs/remotes/origin/tags" might store fetched tags in
specified place that is different from refs/tags/), and to add a new
option to specify where the auto-followed tags would be stored to
enhance the latter.
