Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770C21FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbcHWQHq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:57971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751640AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MWT8s-1berwZ1iFm-00XfON; Tue, 23 Aug 2016 18:06:33
 +0200
Date:   Tue, 23 Aug 2016 18:06:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/15] Lib'ify quite a few functions in sequencer.c
Message-ID: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:olWA/oyilW6IXpNfAt6DTsa32e63RZiI6HxQ98OsFUG0Tqnb5wz
 rZkavKsXfAO0pLtoj0AadNuoDYIuPN5YDWwVYWvZYv/DGj07iHo2eSFvesVAo/XogGo0WK9
 N5gLpDHJ8U/VUnJgzSKtV+d1KIlWo4jxaN1GEwZYg6QsAh9ANTMICS4oxzLgP2fcCTbUniA
 Tj+5X+jbQXC7+iBYban9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DaO1B0RmMRk=:IkT1CHzho/JYDnPbJLKYHk
 zn3FFWcMhcEWqcYJdG32gCKHWx2ZtOy2s1yFRDP9jqMPImEvSsOdvtVIEkgEDZrMp2VkKtOMm
 tX6TjEGJjADR/WC/YJ+em/t2JrdEb89ojh7bOmAzKMyM1SNl7n0sOgQoDI7V9q5kzbu3jlE34
 /Em4/7s6NsXCVY03keBR7oULU0aB+52q9ohzUFNByLMTRM3T0TpSzZEE854NIskEoGnm/G9Wd
 pCjdkkkLhD9pEMrvRlK70T1LH9yuflJ9FgtRuaDV7wCZzU7hZF3tHHCOr+l/Xtv7erlOeUWK9
 gIYtO5yhbtsuHt8BSF0l6Wr5Q0fGRK1+iQ9PA2ed3O0cxmXsEz1QtRah/pzLAyxCjKXEK/s/6
 FKXGUFbbpjLF+NT6cMrvOKY71eRlURZLwpwKCs1M1Kqa8u5qamv+/uSg8y/tYsG0pMvXcbgwS
 gAvchSF4mqOge4f0Mgm7STnAB7BFLvx4TUQDJJfrh1Kd94Ndpmo6CJAlGkNFrmQaMWnVXxMdu
 Q+dxZ4UbKaZnxRnOm8DIAcxlREpl38ARnA0K4GL4bT4fPsk0OuB6bFIlayKXL8YhIfi7s2rue
 2dbTGP3EE9RxcR8/+MBq7IyoP3efpaFMRANXz0Yc1NIAFZeb4llEQZ5+FbZNYd2sylrcBnpsF
 u5fsHsFGxFw2s45jrgAUYCPlTtMgw0E3GVGaHPSUJQJm6jFmJgtOLvwdAN3VtAucJhuB+FTFc
 ZhHU5aC/z/IioRukOS3dXOazy7m07O5GPFjJNg13vy822fXo19JYbi2RwgWjZpvRsM+1nNLjX
 3FADHGn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is one of the half dozen patch series left to move the
bulk of rebase -i into a builtin.

The purpose of this patch series is to switch the functions in
sequencer.c from die()ing to returning errors instead, as proper library
functions should do, to give callers a chance to clean up after an
error.


Johannes Schindelin (15):
  sequencer: lib'ify write_message()
  sequencer: lib'ify do_recursive_merge()
  sequencer: lib'ify do_pick_commit()
  sequencer: lib'ify prepare_revs()
  sequencer: lib'ify read_and_refresh_cache()
  sequencer: lib'ify read_populate_todo()
  sequencer: lib'ify read_populate_opts()
  sequencer: lib'ify walk_revs_populate_todo()
  sequencer: lib'ify create_seq_dir()
  sequencer: lib'ify save_head()
  sequencer: lib'ify save_todo()
  sequencer: lib'ify save_opts()
  sequencer: lib'ify sequencer_pick_revisions()
  sequencer: do not die() in do_pick_commit()
  sequencer: do not die() in fast_forward_to()

 sequencer.c | 168 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 101 insertions(+), 67 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/libify-sequencer-v1
Fetch-It-Via: git fetch https://github.com/dscho/git libify-sequencer-v1

-- 
2.10.0.rc1.99.gcd66998

base-commit: 2632c897f74b1cc9b5533f467da459b9ec725538
