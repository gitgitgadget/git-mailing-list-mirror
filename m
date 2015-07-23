From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 09:38:01 -0700
Message-ID: <xmqqegjyrfrq.fsf@gitster.dls.corp.google.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:38:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIJVb-0000uE-AD
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 18:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbbGWQiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 12:38:07 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33195 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbbGWQiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 12:38:05 -0400
Received: by padck2 with SMTP id ck2so159743138pad.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r34arJ0zlZqbGCEF5VqW5Jx3jttvYCIE4pIK+E4p7Q4=;
        b=EjEIqrZnh2ckUqpRHWqcmoyeNFmFL8RinzfpV63zKo4wf2w2+souQPRECayrAcCchM
         f4KQ1g+ISa4aduTbOXWjtZ/PsUbLPIRa2WI7QiECdsY5ncaH+156fGR7BahWV0jwKxpk
         5BKB5UHtAB0rBOXE4syaR+5QmV1o7d6h5hoHo1m8pmQFmXs5iBAWhOfai/+gHyo6Mxu1
         TQVGwG8zeJ/Pt8zbuN8hPltDNGVgqUqow6Y4+xp0+j+QGQ+oxkOJMKlfsgRqpjAqQuML
         NyhNoUD+atAvwn+iqd/9F5XTDOTV68lC+fV8kpgUA4kJGu7M/FEGBXxQZwnyMKaceCLp
         PACg==
X-Received: by 10.66.117.135 with SMTP id ke7mr20509235pab.31.1437669483785;
        Thu, 23 Jul 2015 09:38:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id y1sm9901429pdy.2.2015.07.23.09.38.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 09:38:02 -0700 (PDT)
In-Reply-To: <CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 23 Jul 2015 09:06:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274504>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Well, from a user's perspective it does not matter which part of the
> internal implementation of diff-tree is responsible for printing that
> single line,...

That is not "internal implementation", but "logically separate
parts".  View it more like "'git show -s' does squelch the diff part
but does not squelch the log output".  After all, a single commit form
of 'diff-tree' is a degenerate use case of feeding a single commit
to 'diff-tree --stdin' from its standard input, which is a rough
plumbing-level equivalent of 'show'.

Documenting the behaviour correctly is the best thing you could do
at this point, as this is one of the oldest part of the system that
existing scripts would rely on.
