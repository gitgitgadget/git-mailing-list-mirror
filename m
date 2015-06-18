From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Thu, 18 Jun 2015 11:08:16 -0700
Message-ID: <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
	<xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
	<CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 18 20:08:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5eEo-0000xz-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 20:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbbFRSIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 14:08:21 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34219 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490AbbFRSIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 14:08:19 -0400
Received: by igboe5 with SMTP id oe5so25083164igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Uds47gJpGb2wzfB98toQLJGgkWsbKFBi43DbFqq2Pf8=;
        b=QZlC3UPR4PUviA1T0DhcxUhNTMA7rvfuvwP3l2QpaT0bi0VJt9e4uFF6pYzqCg63IL
         9mhlFYJ//s1SRgnRlkYL01Rb5GK9gfa3o6loLtG363k6BzPh0m+5ZHV80TEc931QkGmw
         o5wPKyhZH74xxNHZY2FqZ+7yRYokbVafaUJ087au24HKoFBosX5XAIf23c5z0m7puyQR
         QrzHkWMmXwP/WAnA5Er9Oc0oXv49jBNlJIUvG7+u8H81Sctk8cuhSqkqYUQbsTtyPCWN
         bVfyKAend3YfSoPYUu14kKb1jKT88l2rB7rhN0Zsy7f0k8F/jwx9WjeQ/uGNEE8qKDTq
         PX4g==
X-Received: by 10.107.152.14 with SMTP id a14mr16255525ioe.92.1434650898767;
        Thu, 18 Jun 2015 11:08:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id f15sm5401904iof.36.2015.06.18.11.08.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 11:08:17 -0700 (PDT)
In-Reply-To: <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
	(Patrick Palka's message of "Thu, 18 Jun 2015 12:28:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272032>

Patrick Palka <patrick@parcs.ath.cx> writes:

>> I have this nagging feeling that it is just as likely that two
>> uneven hunks align at the top as they align at the bottom, so while
>> this might not hurt it may not be the right approach for a better
>> solution, in the sense that when somebody really wants to do a
>> better solution, this change and the original code may need to be
>> ripped out and redone from scratch.
>
> Hmm, maybe. I stuck with assuming hunks are top-aligned because it
> required less code to implement :)

Yeah, I understand that.

If we will need to rip out only this change but keep the original in
order to implement a future better solution, then we might be better
off not having this change (if we anticipate such a better solution
to come reasonably soon), because it would make it more work for the
final improved solution.  But if we need to rip out the original as
well as this change while we do so, then having this patch would not
make it more work, either.

So as I said, I do not think it would hurt to have this as an
incremental improvement (albeit going in a possibly wrong
direction).

Of course, it is a separate question if this change makes the output
worse, by comparing unmatched early parts of two hunks and making
nonsense highlight by calling highlight_pair() more often.  As long
as that is not an issue, I am not opposed to this change, which was
what I meant to say by "this might not hurt".
