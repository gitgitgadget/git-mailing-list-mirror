Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7022070F
	for <e@80x24.org>; Thu,  7 Jul 2016 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbcGGBMk (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 21:12:40 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33415 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbcGGBMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 21:12:38 -0400
Received: by mail-pf0-f179.google.com with SMTP id i123so1158646pfg.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:12:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y3KmPqRMjzHA5g9PZUsuAyPC3w/mMrBzRcCjE/+hCDs=;
        b=Rnd7o4El6sLnGEmXkewuRs4pePMNcybHA4Vs5t4fI/GNUMke0QE53UaztHRc/l6dVR
         4TtaGQlEM+3Htc6Kl7AHn+bqmOVmrEsD0SiB1ToInBLybb/tszxxJnjOOf8jChY3mDoP
         ICommex4k49jY42onpexd6Ys5kkITiiW/YFKErI3jJVnvLqyZs4eN4LhslV2+uxrJoYu
         MvuxS/XOG3Qnpa6Yw80BBz06Qnq6Ld1V4mBIo3fGzWxEdajoQ1Qe/igMhuxCI+xe//PT
         Y+gtpR/RSMcxS3iSuDFJePsJ/XAYJfFz12D13En+QbsfNbFufumrtlIPyYsRt8SP98m2
         CZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y3KmPqRMjzHA5g9PZUsuAyPC3w/mMrBzRcCjE/+hCDs=;
        b=KGSQAgAweF09IC8I08n6yuxSThSmOS+IFUdTCz4HnzYvNEJ8A3cQkQE0edk36enCEC
         7EgJTrLu4sanO53VcwtEWl792L5z2Xj5z78mFVmWFkKK4gPUJDSe4GVT6/tGRW4ZGgXV
         jJRXOw6HzQ7jGSMBRJiTZhlRIsvQ2aszl12aQwMG3uhJfWQLWVXLU+7anGebdFLRAmhy
         RQycPRZ+JqSxGXq6RjTUC8aZE7yyWBtIeKb8KUKHB+Qswxn0h6ILlbJQr2CwxU2B/PyU
         kCWj+W77TeW4HY5v52q+d8Kj4Q0Miv1eFa5wTXAp5GQcAdW5TWWiJAjFuDEgwWKmkeRE
         7wAw==
X-Gm-Message-State: ALyK8tIP3BDS9xlOz1MdXYNBLWu81st62ciT3Q+7/EFm9PXAL2OMsQpN6x9XND7svT8VKeZ9
X-Received: by 10.98.110.195 with SMTP id j186mr548235pfc.49.1467853957655;
        Wed, 06 Jul 2016 18:12:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7518:e836:5c9c:93dd])
        by smtp.gmail.com with ESMTPSA id 78sm6974827pfm.43.2016.07.06.18.12.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 18:12:36 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/4] Push options in C Git
Date:	Wed,  6 Jul 2016 18:12:14 -0700
Message-Id: <20160707011218.3690-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is not marked for RFC any more, as I do not recall any open points
left for discussion. This addresses the only reply from Eric Wong on patch 3:

diff to v2:
diff --git a/send-pack.c b/send-pack.c
index e328276..c943560 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -536,7 +536,8 @@ int send_pack(struct send_pack_args *args,
 
                for_each_string_list_item(item, args->push_options)
                        packet_buf_write(&sb, "%s", item->string);
-                       write_or_die(out, sb.buf, sb.len);
+
+               write_or_die(out, sb.buf, sb.len);
                packet_flush(out);
                strbuf_release(&sb);
        }
diff --git a/transport.c b/transport.c
index 598bd1f..0298be1 100644
--- a/transport.c
+++ b/transport.c
@@ -641,7 +641,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
        struct transport *ret = xcalloc(1, sizeof(*ret));
 
        ret->progress = isatty(2);
-       ret->push_options = NULL;
 
        if (!remote)
                die("No remote provided to transport_get()");

Cover letter v2:
================

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

Jeff writes on v1:
> Whereas in Dennis's patches, it was about specific information directly
> related to the act of pushing.

This allows to transmit arbitrary information as the backends of $VENDOR
may have different options available related to the direct act of pushing.

Thanks,
Stefan

Cover letter v1:
================

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

When using a remote that is more than just a plain Git host (e.g. Gerrit,
Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
push options can instruct the server to:
* open a pull request
* send out emails asking for review
* (un)trigger continuous integration
* set priority for continuous integration (i.e. bots pushing may ask to be
  treated with lower priority compared to humans)
* ... 

Most of these actions can be done on the client side as well,
but in these remote-centric workflows it is easier to do that on the remote,
which is why we need to transport the information there.

More concrete examples:
* When you want a change in Gerrit to be submitted to refs/heads/master, you
  push instead to a magic branch refs/for/master and Gerrit will create a change
  for you (similar to a pull request). Instead we could imagine that you push
  to a magical refs/heads/master with a push option "create-change".
  
* When pushing to Gerrit you can already attach some of this information by
  adding a '%' followed by the parameter to the ref, i.e. when interacting with
  Gerrit it is possible to do things like[1]:
    
    git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
  
  This is not appealing to our users as it looks like hacks upon hacks to make
  it work. It would read better if it was spelled as:
  
  git push origin HEAD:refs/for/master \
      --push-option draft \
      --push-option topic=example \
      --push-option cc=jon.doe@example.org
      
  (with a short form that is even easier to type,
   but this is is more intuitive already)

This is a patch series to Git core, which is developed at the same time
as a change is proposed to JGit by Dan Wang, see [2].

This code is also available at [3].

Thanks,
Stefan

[1] Not all Gerrit '%' options are documented, so here is a link to source code instead :(
https://gerrit.googlesource.com/gerrit/+/refs/heads/master/gerrit-server/src/main/java/com/google/gerrit/server/git/ReceiveCommits.java#1141

[2] https://git.eclipse.org/r/#/c/74570/ 
 
[3] https://github.com/stefanbeller/git/tree/pushoptions

Stefan Beller (4):
  push options: {pre,post}-receive hook learns about push options
  receive-pack: implement advertising and receiving push options
  push: accept push options
  add a test for push options

 Documentation/config.txt                          |  7 +-
 Documentation/git-push.txt                        |  8 ++-
 Documentation/githooks.txt                        |  4 ++
 Documentation/technical/pack-protocol.txt         | 10 +--
 Documentation/technical/protocol-capabilities.txt |  8 +++
 builtin/push.c                                    | 16 ++++-
 builtin/receive-pack.c                            | 85 +++++++++++++++++++----
 send-pack.c                                       | 29 ++++++++
 send-pack.h                                       |  3 +
 t/t5544-push-options.sh                           | 85 +++++++++++++++++++++++
 transport.c                                       |  2 +
 transport.h                                       |  7 ++
 12 files changed, 242 insertions(+), 22 deletions(-)
 create mode 100755 t/t5544-push-options.sh

-- 
2.9.0.141.gdd65b60

