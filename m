Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2242035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758161AbcJYSRQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:17:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63080 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753142AbcJYSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:17:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C3AB473EA;
        Tue, 25 Oct 2016 14:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=MjkW
        Y4zL4iYkT8GdHFjY6Tcd3xs=; b=ffOSNd0i6OxvoianjxUrUJ/wQMkvw6yy2wgW
        yLGg04f5XkTA5kVTUTp7zMz3woapT9NUysmoBAkxGgHQs0Ju/6ggOUrAZYl6MBrM
        C7H/TtqBqQW1HJR5YtA41U0G08KpqIxF8+XGzhVhMTBAeSnChvOLm2NFdPpQVKSQ
        Gsu8B1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        BkMT8dkSACzBqFoDNnDKq7jMR0Br4tABnxQwxIcn5mkHN7bUbavnuSQ+uYEechrB
        zDCQByxoxtKBFyqskWXup75EwpANxzSOlqa3i2d8EP6udsZHI2vc3G2U+nKWNRTG
        9DtVvpOPO1yWHISXBzkAIYTAgV64jrHvih7dg7gshHE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14B51473E9;
        Tue, 25 Oct 2016 14:16:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CBE6473E6;
        Tue, 25 Oct 2016 14:16:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 0/3] quick reroll of Lars's git_open() w/ O_CLOEXEC
Date:   Tue, 25 Oct 2016 11:16:18 -0700
Message-Id: <20161025181621.4201-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-777-gd068e6bde7
In-Reply-To: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
X-Pobox-Relay-ID: 22EFDBE6-9ADF-11E6-8755-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is to make sure everybody is on the same page regarding the
series.  The patches are adjusted for comments from Eric and Dscho.

Lars Schneider (3):
  sha1_file: rename git_open_noatime() to git_open()
  sha1_file: open window into packfiles with O_CLOEXEC
  read-cache: make sure file handles are not inherited by child
    processes

 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 read-cache.c           |  9 ++++++++-
 sha1_file.c            | 25 +++++++++++++++----------
 5 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.10.1-777-gd068e6bde7

