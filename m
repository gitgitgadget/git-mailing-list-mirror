From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 22:01:39 -0700
Message-ID: <xmqqzj2fa764.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 07:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKJUx-0000t4-Um
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 07:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbbG2FBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 01:01:44 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34092 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbG2FBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 01:01:43 -0400
Received: by pdbbh15 with SMTP id bh15so82649023pdb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aEJRfS1Cklr/5eDurKKp0brXm8iy7hHImECmI9htpCQ=;
        b=kHgRxiSS5PH1zkHaEd3UvsfkvSfsheaG9fT6rVQgY8GyoCIS/gI0kYMdaEOMknLDiW
         llnJ98FyzxzCc0ICqEeLA+zAeN/kfuUAEMIsjU6O7AUfrueHC3djK9JABH6hnqVNIPbz
         YaqfwTG7Xk5brg5naXBHTmMYpHNIAJue0WnBXcjTDyUpTTCnoiq/l6RwYSfc8YLnwbns
         kWhZpUPON/pFTR61RB3Wy8SfsZRiKP3+NfUGZ2oP7dLn71pjh1KlKF4+LsO227NKKL7L
         Ys9UESW7CVCk8wfRewR8EzfZA0ebuxZWTpMrUgDWVjqnklk1HAoQOx8Lf7E1A6WXurI2
         qNWw==
X-Received: by 10.70.41.176 with SMTP id g16mr79307332pdl.25.1438146103035;
        Tue, 28 Jul 2015 22:01:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id cf7sm38344469pac.41.2015.07.28.22.01.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 22:01:41 -0700 (PDT)
In-Reply-To: <CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 04:34:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274882>

Johan Herland <johan@herland.net> writes:

> I believe it is a bad compromise. It complicates the code, and it
> provides a concurrent notes merges that is unnecessarily tied to (and
> dependent on) worktrees. For example, if I wanted to perform N
> concurrent notes merges in a project that happens to have a huge
> worktree, I would now have to create N copies of the huge worktree...

Who said worktree has to be populated?  You should be able to have
an absolutely empty checkout just like "clone --no-checkout".
