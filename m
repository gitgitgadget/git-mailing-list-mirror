From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [RFC] allow git pull to preserve merges
Date: Thu,  8 Aug 2013 12:38:11 -0500
Message-ID: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
Cc: Johannes.Schindelin@gmx.de, avarab@gmail.com
To: stephen@exigencecorp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 19:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UBI-00076G-HE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966051Ab3HHRjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:39:08 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:58370 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966050Ab3HHRjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:39:05 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so960812pab.38
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4yhJ6PC6XFl+fA541B6qhUvJCCTja/wbJQKqLmgW+jo=;
        b=XGY3RQS+6+2C8uKQJwOvmp5wsFT8HHB55XSU7OTujmAybjEEyQ4M4azipN3Z34toxA
         0cChQEYxyXBQFvWUAWJxX8n9cmq8nIXRK4Nf218YTvxpvOb+emGUqIt+dYlzlsuKy7/u
         RihOSssWcRgLnDOii/L6netTfQlSaXRLwV+6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4yhJ6PC6XFl+fA541B6qhUvJCCTja/wbJQKqLmgW+jo=;
        b=JWkji2nJmBOkuS2+tAFXiQJ/F0Z1ttYsdY4s58h/FNCvYK1B0v3Y6yqv7IRqz9vAly
         KP8UAHam7DrdEcqCq++84bBY0gvR66S3LEMdClwl0/T/vHOQtyuY5yNs35X481GkW5En
         IDrIYjh73qFvfjVYfyUrKX5IB+Niww8H3Jn0YukUkrAIFHrSq7EU0XNnU5VvSYaSc2HI
         twrdZEKwJ6Mlu/zi+n6qDCCod5uGN9yFLIlbDW9MtkF2c/afV2ve2Yf6/lZfoTV6dLhG
         qP7fNKGWB898pf2hvxWD316KiOzyJPpPSkRsYmqZnTtSJtaMbgGncVswQ1t4YYeQXCaX
         TqKw==
X-Gm-Message-State: ALoCoQk6RxWMGzXD2aVGWEqxnxbw0mJmhCXQ0AGFBz5UFjQzZ0YEY+nitsrTMghmQsxMf2KsdFx8
X-Received: by 10.66.252.129 with SMTP id zs1mr7148243pac.113.1375983544640;
        Thu, 08 Aug 2013 10:39:04 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id ts6sm15408024pbc.12.2013.08.08.10.39.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 10:39:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231909>

Hey,

Following up on an old thread (2008):

http://git.661346.n2.nabble.com/pull-preserve-merges-td1471688.html

I'd like to finally add a config parameter/setting to allow git pull to preserve
merges when it's rebasing. This addresses a somewhat common boundary case of a
locally merged feature branch getting flattened into master, as described here:

http://notes.envato.com/developers/rebasing-merge-commits-in-git/

This current patch adds a new `pull.preserve-merges` boolean config setting, but
we could also change the existing `pull.rebase` to be tri-state (so
`pull.rebase` can be true, false, or preserve-merges), or add a more generic
`pull.rebaseoptions` that is just a string of flags to pass to rebase.

Any of these would be fine with me--what would be preferred?

This patch doesn't update the docs, but I wanted to get an initial sanity check
on the preferred config setting before doing that.

Thanks!

- Stephen


Stephen Haberman (1):
  pull: Allow pull to preserve merges when rebasing.

 git-pull.sh     | 11 +++++++++--
 t/t5520-pull.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
1.8.1.2
