From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Thu, 24 Sep 2015 17:41:06 -0700
Message-ID: <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 25 02:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfH54-000243-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 02:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbIYAlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 20:41:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33298 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbIYAlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 20:41:18 -0400
Received: by pacex6 with SMTP id ex6so87853786pac.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 17:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Xtpea2bLrac5jCkCwvchxwS+GS74jVtZco3V+5B54+0=;
        b=SuNB4zuihcMR0pR4ut0cLMjmmaf2NBdm54+Qdak6JmPCSAMUJucMujYWeeVpHnwkxB
         QcoMVUwkS4JofxwzYzucX0+7FSpOdVGbCbOiCe7DdR+GSAuitn8PXd8jOsvtKrUh3eJ6
         R2UXG8M8HdTqp9leigjEBCVCjV5tabTcGQjGLkj5tfX6PGZvII1L4xWwjnl4eGm7OIAD
         g3an/y8VGiHuAxIvGP/gTFPi6o22U9lrJjnBxHDYJI1/ZRR2FlSC1gwKEahS35lRxWo8
         lpYLbFyT0Rn4mpMB2RtwT4DXGZ/6uWFSBKe91G7/kVUTK09QAYKVjdDAPLG/gWSPAoiL
         1oKg==
X-Received: by 10.68.227.227 with SMTP id sd3mr3326152pbc.116.1443141667687;
        Thu, 24 Sep 2015 17:41:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id bk8sm634266pad.18.2015.09.24.17.41.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 17:41:06 -0700 (PDT)
In-Reply-To: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Thu, 24 Sep 2015 23:43:23
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278641>

larsxschneider@gmail.com writes:

> In order to avoid that in the future I configured Travis CI for Git. With this
> patch Travis can run all Git tests including the "git-p4" and "Git-LFS" tests.

Interesting.  I was wondering about the "p4" part myself.

> My idea is that the owner of "https://github.com/git/git" enables this account
> for Travis (it's free!). Then we would automatically get the test state for all
> official branches.

The last time I heard about this "it's free" thing, I thought I
heard that it wants write access to the repository.  If that is
still the case, the history stored in the GitHub repository the
"it's free" thing has access to can become even less trustworthy
than it currently is.  Those who clone/fetch from it cannot be sure
if the tips of branches are what I pushed there, or they were
changed to a malicious replacement from sideways by the "it's free"
thing, taking advantage of that write access.

Granted, those who clone/fetch cannot be sure unless they trust
GitHub.  The only assurance they have is GitHub's word: "gitster has
account with us, gitster pushes into this repository, and we have
ACL to ensure that gitster is the only person that can update this
repository".  Allowing write-access to a third-party will break that
assurance, even if you trust GitHub.

Of course, this can be improved if we start using signed push into
GitHub.  It is a separate issue in the sense that it would help
GitHub to make that assurance stronger---those who fetch/clone can
be assured that the tips of branches are what I pushed, without even
trusting GitHub.
