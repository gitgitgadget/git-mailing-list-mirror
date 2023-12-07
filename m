Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69203D53
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:23:39 -0800 (PST)
Received: (qmail 9993 invoked by uid 109); 7 Dec 2023 07:23:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1028 invoked by uid 111); 7 Dec 2023 07:23:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:23:42 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:23:38 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/9] bonus config cleanups
Message-ID: <20231207072338.GA1277727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While looking carefully at various config callbacks for the series at:

  https://lore.kernel.org/git/20231207071030.GA1275835@coredump.intra.peff.net/

I noticed a bunch of other small bugs/cleanups. I split these into their
own series here, which should be applied on top (it could go straight to
"master", but there is a small conflict in patch 6, as the option it
touches was fixed in the other series). I'm happy to prepare it as an
independent series if we prefer.

  [1/9]: config: reject bogus values for core.checkstat
  [2/9]: git_xmerge_config(): prefer error() to die()
  [3/9]: imap-send: don't use git_die_config() inside callback
  [4/9]: config: use config_error_nonbool() instead of custom messages
  [5/9]: diff: give more detailed messages for bogus diff.* config
  [6/9]: config: use git_config_string() for core.checkRoundTripEncoding
  [7/9]: push: drop confusing configset/callback redundancy
  [8/9]: gpg-interface: drop pointless config_error_nonbool() checks
  [9/9]: sequencer: simplify away extra git_config_string() call

 builtin/push.c      | 31 +++++++++++++------------------
 builtin/send-pack.c | 27 ++++++++++++---------------
 config.c            | 11 +++++------
 convert.h           |  2 +-
 diff.c              |  8 ++++++--
 environment.c       |  2 +-
 gpg-interface.c     | 15 +++------------
 imap-send.c         |  2 +-
 merge-ll.c          |  2 +-
 sequencer.c         | 21 ++++++++-------------
 xdiff-interface.c   |  7 ++++---
 11 files changed, 55 insertions(+), 73 deletions(-)

-Peff
