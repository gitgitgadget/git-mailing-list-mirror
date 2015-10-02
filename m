From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] applypatch-msg hook no-longer thinks stdin is a tty
Date: Fri, 02 Oct 2015 09:03:36 -0700
Message-ID: <xmqqvbap5kbr.fsf@gitster.mtv.corp.google.com>
References: <CAFOYHZArBv=2E_YonCqOSC4mWk9=xkbG9FyB+zNFFAqmUBUKHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 18:04:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi2oc-0006at-0a
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 18:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbbJBQDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 12:03:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33362 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbJBQDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 12:03:39 -0400
Received: by pacex6 with SMTP id ex6so110233623pac.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7TRTR2cSDCf3FWxZC5jmc1J3tkEIaUA2Y/mfVYZIerw=;
        b=wFxjP6Vi8QlOZFJfvLJ9Js3KYGSGvvZklypW9IQPGk/1anLilvzCEv3zk59Xd7nzOh
         1mWg8vN5jG20EVoRxtQPWUh8Vtf5C0zGw28R2Z+tHogXo0WrKwW3jT9fV7DcL2v4K30R
         OkpXbsaEB/Hz7bdtgi6/XG2T+ymcoKZmuWJupvhVcCRXteH5o+adyo9V5tbOqBJuH1mC
         3Tkrcw0Th96dqQWr/7iolgG/OjlStUxsBrQco3Tlk17uA5K5Pk1PD0gGDUuuLF7X3ZY0
         wc5RQoZufRZkV93NnRnBesXmfeDybWmJ5/Pd9/QhbT8R7btW3ejECjAq+LwrqAl+2JXf
         nTPA==
X-Received: by 10.66.120.80 with SMTP id la16mr21095605pab.1.1443801819417;
        Fri, 02 Oct 2015 09:03:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id rp5sm12798188pab.0.2015.10.02.09.03.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 09:03:37 -0700 (PDT)
In-Reply-To: <CAFOYHZArBv=2E_YonCqOSC4mWk9=xkbG9FyB+zNFFAqmUBUKHA@mail.gmail.com>
	(Chris Packham's message of "Thu, 1 Oct 2015 16:42:58 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278924>

Chris Packham <judge.packham@gmail.com> writes:

> As of git 2.6 this has stopped working and stdin always fails the tty
> check.

We now run that hook thru run_hook_ve(), which closes the standard
input (as the hook is not reading anything).  Perhaps you can check
if your output is connected to the tty instead?
