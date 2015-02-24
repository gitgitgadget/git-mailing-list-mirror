From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/3] protocol v2
Date: Mon, 23 Feb 2015 19:12:39 -0800
Message-ID: <1424747562-5446-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 04:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ5wu-0002Ea-PM
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 04:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbbBXDOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 22:14:07 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35721 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbBXDOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 22:14:06 -0500
Received: by iecrl12 with SMTP id rl12so28892931iec.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bwfw3rZBAM3cSyxFjj0zQZHbN6+s1qy0vvCS2SqX0Jg=;
        b=HjW9fi0AvVvVNxwY2x+FsAnsHNpWxzist7p3Ndn6K4ztI4X5cGv4MunNb4JGa+6NVQ
         ydYKUgu19xmqb357mBPJY0cbsSyz4zlDHBhpVuDjqVDX2ZEucwVy9wM0aHR5NgBIe+Mj
         2wboYorsq7pNouhfNwwMnyZV+1Ny9LcvYp/yE0NI4/rCX8IY6kL2qVvqXmRgfRTaN9vt
         S0Tj8irbt+/oUYoT9KDc+ddmp/oQpklQG1EZ7Ume3dh6VHprF3CGBtoLYQJGzw0MuRl3
         /UFJBw+7HT7KeGl6Ht33UkvfoFJ+q6sO7q54Zf9D9TAne8GqAmqww0eRNHanzzLGdoqt
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bwfw3rZBAM3cSyxFjj0zQZHbN6+s1qy0vvCS2SqX0Jg=;
        b=HYsq9sJ92jIVKCbDpJqtzscI83hVTYN9Ot9ue53iKRu52odoP1tttGJg+k4lFAw/af
         1Zyw+WBfd6R/mVR8N6Rj5tkaMjfzscGhZeHZQ9sAg89yvajcFbAG/HOzW0e3QL/FRbry
         gRKQMC0z/Ekn+bjXSzNZo2juA5e2bcejNBHyFoy1UfDG+qgF5yVyFh1Qa0qyXnMGsuYV
         m90rMAY2U/M7OkVqT3kxVAmU3FLT6Ytp6XWo+REpWFeijiGLFHgHzMWtElK+YNZfnZB5
         yzjIoo8vKEMtY3JOgdCUs6lmHp1sRuVZb704R3P8d7cdS4ie8dfHrzo9XwXAb1ufj22r
         1Aig==
X-Gm-Message-State: ALoCoQnAj1b+cuQ15qA0+0bAUzfl5un2hUkw2pvPBD9OZpmQY6zOZtRlf0iaJ7PsJKuHmJxtIy4K
X-Received: by 10.107.34.210 with SMTP id i201mr18193120ioi.1.1424747644669;
        Mon, 23 Feb 2015 19:14:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:acce:8652:941a:5856])
        by mx.google.com with ESMTPSA id g29sm1923938ioi.35.2015.02.23.19.14.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 19:14:04 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264305>

Inspired by a discusson on the scaling of git in the last days,
I thought about starting the adventure to teach git a new transport
protocol.

One of the biggest problems of a new protocol would be deployment
as the users probably would not care too deeply. It should just 
work in the sense that the user should not even sense that the
protocol changed. To do so we need to make sure the protocol
is backwards compatible and works if and old client talks to 
a new server as well as the other way round.

A later incarnation of the patch series will eventually add the 
possibility to add new versions of the transport protocols easily
without harming the user. For now in the first revision of the 
series it just documents an approach of how I'd start this problem 
of compatibility issues.

I realize this will be a bigger change to git, so I'd rather
just make a small step now. The actual discussion on how to
do the next protocol(s) may be started on the gitmerge
conference? (bloomfilter! client speaks first!, rsyncing
the refs changes!)

Any thoughts on how to make it easy to teach git new protocols
are very welcome.

Thanks,
Stefan

Stefan Beller (3):
  Document protocol capabilities extension
  receive-pack: add advertisement of different protocol options
  receive-pack: enable protocol v2

 Documentation/technical/protocol-capabilities.txt | 11 +++++++++++
 builtin/receive-pack.c                            |  7 +++++++
 2 files changed, 18 insertions(+)

-- 
2.3.0.81.gc37f363
