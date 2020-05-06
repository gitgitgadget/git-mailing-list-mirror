Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383BC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681932075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgEFJna (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 05:43:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:24710
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgEFJna (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 05:43:30 -0400
X-IronPort-AV: E=Sophos;i="5.73,358,1583190000"; 
   d="scan'208";a="347876648"
Received: from 91-175-65-117.subs.proxad.net (HELO rillettes) ([91.175.65.117])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:43:28 +0200
Date:   Wed, 6 May 2020 11:43:27 +0200
From:   Pierrick Gaudry <pierrick.gaudry@loria.fr>
To:     git@vger.kernel.org
Subject: option -q not passed from "git commit" to "git gc --auto"
Message-ID: <20200506094327.GC31637@rillettes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It seems that when "git commit" is run with the "-q" option, there are
still, from time to time, messages that get printed. With the French
locale the message is:
  Compression automatique du dépôt en tâche de fond pour optimiser les performances.
  Voir "git help gc" pour toute information sur le nettoyage manuel.

From what I could guess, this is due to the fact that "git commit" calls
"git gc --auto", but does not propagate the "-q" option if present.

A similar problem was present some time ago with "git fetch" and was
solved in the 2-line patch 6fceed3b . I guess that the same should be
done for "git commit".

Regards,
Pierrick
