From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Tue, 2 Dec 2014 19:01:47 +0700
Message-ID: <CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
 <1417335899-27307-25-git-send-email-pclouds@gmail.com> <547B5170.6050206@gmail.com>
 <20141201103818.GA20429@lanh> <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com> <547D487B.4040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:02:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvm9v-0007al-68
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbaLBMCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:02:19 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43970 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbaLBMCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 07:02:18 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so11502474ieb.3
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tai94sZyY4SQ1M7BTuK24iLWu8uTEtdprkYpRVVTBRg=;
        b=LznKBzcP/HOenKlMv+6xsXxDU9Kc4mPpVJd9Sy8McpU/BO5idZPDIWVz4vjSYIMJNY
         j21L2D5rgFtHNUJBPiMnMzb63/+OBU1VAz92FLbBtA1RNAFxeHrs0M8Xij7FfZKA7aAQ
         X1/3pfBs5CKH6BMCOmGIv+IhBCCJ6T60vc57c27YZgFs3MKDjV6OL7UXcMc21e/aW4KZ
         UNmAmtFOSMVmf4K0FLtJpRc68PemrIIh0oX/WkKIZydg6aG+zeIBCpi4QdacUDpSIzC9
         XLJ0rl0+B2tdD2/1MacED+oT9Qtl809mvugMNxRRTT/zdxOQJ7WMkp2ObRNT2yw9JwZS
         pWaw==
X-Received: by 10.43.64.146 with SMTP id xi18mr2135062icb.65.1417521737607;
 Tue, 02 Dec 2014 04:02:17 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 04:01:47 -0800 (PST)
In-Reply-To: <547D487B.4040502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260556>

On Tue, Dec 2, 2014 at 12:04 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:
> On 12/01/2014 12:39 PM, Junio C Hamano wrote:
>>
>> Sorry, what is a hic? If this were an existing feature like
>> git-new-workdir, even though it is from contrib, making it impossible to do
>> something that used to be possible, even if that something is what mere
>> mortals would never want to to to avoid risking confusion, would be a
>> regression that needs an escape hatch. But this is a new feature. I am not
>> sure why you need to make this overridable in the first place. Those who
>> want to have multiple checkouts of the same commit can just detach HEAD at
>> the same commit in multiple working trees, as the first thing they need to
>> do would be to run "git reset --hard $branch" to synchronize the HEAD and
>> the working tree state to work in the other out-of-sync repositories either
>> case anyway.
>
>
> Yes, detached HEADS allow multiple checkouts, but now the user needs another
> system to record what $branch was for each checked out tree or needs to
> resort to forensics using various git-branch / git-log invocations to find
> the most-likely value. So, I do not find detached HEADS useful in general,
> and specifically not for this case. Duy's latest addition
> ('--ignore-other-worktrees') would, so far as I see, allow this feature to
> replace git-new-workdir in my uses, but without the addition it cannot.

I'm ok either way. So I'll let you and Junio (and maybe others) sort
this out. No objection means --ignore-other-worktrees is in.

FWIW git-branch usually can show the original branch of detached head
(must not always). I don't think we have a plumbing equivalent for it
though. People can "tail -1 $GIT_DIR/logs/HEAD| sed .." but that seems
hacky. I do like "read-only" ref concept where we can keep ref name
(especially tags) in HEAD until the next commit. But it didn't go
anywhere
-- 
Duy
