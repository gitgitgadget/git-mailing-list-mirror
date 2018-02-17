Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAA11F404
	for <e@80x24.org>; Sat, 17 Feb 2018 03:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeBQDG2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 22:06:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59764 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeBQDG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 22:06:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C13DD14E4;
        Fri, 16 Feb 2018 22:06:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=P3d
        BERuFAFyK7AMF2yUyugKDlnI=; b=ku0DhjPXTx7GasYlezgM+Z/Leuum36Z9Lvl
        engu9M+c0lZC/PRgVqw9OPyfAoEuMz21kKlSFkG1fJs1R9XZqArPVt7xfLtwrr0N
        llTv0/DzWOU8FEUxcSkz1FUp0yCCRN9wqaNIeiz+aojPrwmDz/rvgutkZ8andN96
        E9GK8VLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        bxwipV2D7LByKT39qnP4hj0fqAtvToxubRIrhwxRwg4+Ci5nopB1cCSdb+PgGzld
        sxCu0AUnYeCFf5dHQ2gRZMyM2p+rsTmL7tDsprLzV1UmFeXEhjwAG5lTnW6cIFfL
        Qi95DazVUWF2nqpp9dAiTwC4PKk9SmjN9G0uWxF1n88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54A97D14E3;
        Fri, 16 Feb 2018 22:06:26 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D53D3D14E2;
        Fri, 16 Feb 2018 22:06:25 -0500 (EST)
Date:   Fri, 16 Feb 2018 22:06:24 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] Makefile: remove *.spec from clean target
Message-ID: <20180217030623.GT27038@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 8A76573E-138F-11E8-9550-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for generating an rpm was dropped in ab214331cf ("Makefile: stop
pretending to support rpmbuild", 2016-04-04).  We don't generate any
*.spec files so there is no need to clean them up.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I noticed this minor cruft today.  Since we don't generate a
spec file, this is at best unneeded.  At worst we could
wrongly delete a users spec file if they happened to be
working on it in their git clone and called make clean.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c56fdc14ca..d135f8baa1 100644
--- a/Makefile
+++ b/Makefile
@@ -2734,7 +2734,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
2.16.2

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A thing worth having is a thing worth cheating for.
    -- W. C. Fields

