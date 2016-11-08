Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF92720758
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbcKHAxG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:06 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46577 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbcKHAxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:05 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3uet-0003Jx-K9; Tue, 08 Nov 2016 00:53:03 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/6] Provide for config to specify tags not to abbreviate
Date:   Tue,  8 Nov 2016 00:52:36 +0000
Message-Id: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Please find in the following mails patches which provide a way to make
gitk display certain tags in full, even if they would normally be
abbreviated.

There are four patches to gitk, three to prepare the ground, and one
to introduce the new feature.

There is one patch for git, to just document the new config variable.

I hope this is the right way to submit this series.  Thanks for your
attention.


As I say in the patch "gitk: Provide for config to specify tags not to
abbreviate":

The config setting is in git config logs.* rather than gitk's
own configuration, because:

 - Tools which manage git trees may want to set this, depending
   on their knowledge of the nature of the tags likely to be
   present;

 - Whether this property ought to be set is mostly a property of the
   contents of the tag namespaces in the tree, not a user preference.
   (Although of course user preferences are supported.)

 - Other git utilities (or out of tree utilities) may want to
   reference this setting for their own display purposes.

There will be another, separate, patch to the `git' tree to document
this config option.

Background motivation:

Debian's dgit archive gateway tool generates and uses tags called
archive/debian/VERSION.  If such a tag refers to a Debian source tree,
it is probably very interesting because it refers to a version
actually uploaded to Debian by the Debian package maintainer.

We would therefore like a way to specify that such tags should be
displayed in full.  dgit will be able to set an appropriate config
setting in the trees it deals with.



Ian Jackson (4):
  gitk: Internal: drawtags: Abolish "singletag" variable
  gitk: Internal: drawtags: Idempotently reset "ntags"
  gitk: drawtags: Introduce concept of unabbreviated marks
  gitk: Provide for config to specify tags not to abbreviate

 gitk | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)


Ian Jackson (1):
  config docs: Provide for config to specify tags not to abbreviate

 Documentation/config.txt | 8 ++++++++
 1 file changed, 8 insertions(+)


-- 
2.10.1

