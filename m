From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 20:26:53 -0700
Message-ID: <xmqq7fqz5abm.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 20 05:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z69Qs-00013R-32
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 05:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbbFTD04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 23:26:56 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33149 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbFTD0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 23:26:55 -0400
Received: by igbqq3 with SMTP id qq3so29296443igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BEekTomJVjBbMTh35KsH9jj4/kPfJI6T7T4JXgE7fSg=;
        b=lKWvmgqLd3ixoMa/mMuHt7Pp9Cbho/scPzvIANjQm7N3RFsrvlOKbQDBVOpNNnXNdM
         FYUIJkynOPLGoEu88YKawO/eHvi1yY4ADL7dLI3aT8WkTNU5WrUX3+l75r/0N8z2c3bf
         CAbeR7FEiULc7lXyBLiEXVq3kpItraOSYX19wG/jEOXpWuZWHkAWReynj4VsrlRkPcDc
         in0dqYgq4/sHXgmEellbh34a+YYu26T68DrSC4UacqZ3+HTn4E0nY7eoBYAPEfAH3wus
         LXHjJCZGZYUFEnz03WEELvXRUOrKLmioIzPnut9AdNMwA9/2N8L07nsgbt21NYQQM16F
         UU8Q==
X-Received: by 10.43.168.6 with SMTP id ng6mr15505140icc.66.1434770814489;
        Fri, 19 Jun 2015 20:26:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id t7sm3042998ign.8.2015.06.19.20.26.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 20:26:53 -0700 (PDT)
In-Reply-To: <95e42f21de69ab5299c03ce6ad107037@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 19 Jun 2015 22:42:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272222>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> Jokes aside, given that you should regularly repack your repository
>> anyway, I do not think it is such a big downside that this mode
>> misses a corrupt objects, and the 1 out of 4 kinds of objects,
>> i.e. blobs, occupy major part of the repository storage, so this new
>> mode probably makes sense.
>
> It actually makes a ton of sense as a kind of light-weight check ;-)

Yes, didn't I agree that it makes sense already?

> The meaning of "quick" that I was thinking of was not the same as
> "fast", but more like "just a quick check". As in "quick & dirty" ;-)

Sure.

> The point is not to ignore corrupt blobs, by the way, it is to check
> the connectivity only, and save substantial amounts of time doing so.

Yeah, I understand that; after all, that is exactly why I said "make
sure it does not notice corrupt blobs" is not a good test.

On the other hand, you are also checking that it notices a broken
tree (which makes it impossible to complete connectivity check),
which is a good test.
