From: Stephen Connolly <stephen.alan.connolly@gmail.com>
Subject: Feature Request: Branch Description updating support for git fetch/pull/push
Date: Mon, 19 Oct 2015 10:15:52 +0100
Message-ID: <CA+nPnMzQEgMZQGHjWbWXs2_QcZGV9PVn4+RTTmZO8QD5g18sfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 11:16:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo6Y3-0000pm-BX
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 11:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbbJSJPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 05:15:55 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34943 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJSJPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 05:15:53 -0400
Received: by qkbl190 with SMTP id l190so18605139qkb.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VoWQOiR8XuvMLO2e6HUu9DlCbXodwcYsxCtjAsPvnGw=;
        b=EkGoanu45tTGw/+nJrCgJc2wyEH7dArxeOrsyZG19wJxyx3bqYNREoVlNoEEhI9RA6
         Kpu+AtESKCDW2ZlliAlliiZmoTM1HWNdBx74BQC8lMpHRsZ6HowHfNJkIVWoRUpsBzNJ
         2cYp8N++gaCOGmGh91r2S2eKdY744tMuZ2LayPWQSxCsdr3ZuL09W5gO8bPRTBketTPj
         L+tRjbc9NpbdEkty1GMe4bGfrJI5dMGYC/komEVvjmvT30OF79jYNgwha4i1VCecQxS7
         spVCqqHdf0sH+QeL30eSCx3lwpgRoib742/zUulEw/GL0itP6b+IjiWCVGkKPZ/3eDfM
         LfOg==
X-Received: by 10.194.63.81 with SMTP id e17mr35352911wjs.147.1445246152399;
 Mon, 19 Oct 2015 02:15:52 -0700 (PDT)
Received: by 10.27.3.66 with HTTP; Mon, 19 Oct 2015 02:15:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279869>

Branch descriptions are great. Even more so if you set
merge.branchdesc=true (while we are at it could there be a CLI option
to git merge that allowed overriding merge.branchdesc for that merge)

But the bit that pains me is that my description is local only.

Could we add support for syncing the branch description with the remote?

When I think about how such sync could work:

* I would see the sync as an option that needs to be enabled rather
than on by default (at least as long as `merge.branchdesc` is an
option). Overriding by the CLI would be great, e.g.
`--description-sync / --no-description-sync`
* When that sync is enabled, if the destination side is missing a
description then the description is sync'd. Otherwise if the
destination description differs from the source description the user
must explicitly specify one of `--description-sync /
--no-description-sync` or else the operation will stop before updating
references (I think that `git fetch` could be an exception to this
rule as updating the remote branch descriptions by overwriting is
exactly what you want, but for `git pull` / `git push` I think they
need the CLI confirmation if the user has opted into synchronizing
branch descriptions)

WDYT?
