Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFB71F453
	for <e@80x24.org>; Tue, 25 Sep 2018 07:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeIYNfz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 09:35:55 -0400
Received: from forward1j.cmail.yandex.net ([5.255.227.19]:41043 "EHLO
        forward1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbeIYNfy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 09:35:54 -0400
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward1j.cmail.yandex.net (Yandex) with ESMTP id B558A218B2;
        Tue, 25 Sep 2018 10:29:39 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WjHSvRZ2zK-Tcg4vGrl;
        Tue, 25 Sep 2018 10:29:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1537860578;
        bh=sXYnx/93Sxn+YGhTEyn0sS5r6hMYDp9asvfv516Yss0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=n/rkE7C/qKGzE+4QqvT1KKBsOGI2qMSvuNMqb/hI0uiX2s30cVU+/KuqShWQs/B1o
         mowHqk7rrIeyzhOrFExeL1cC6AYQpzVyoXVkG7KJjYqmJQZhmssGXbAmhmu8zt7YXv
         ZLH/Hd4dtcaHVSfCwhuUi5rvjWNf1/Je/KgyanmA=
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva1-5148b5385b62.qloud-c.yandex.net with HTTP;
        Tue, 25 Sep 2018 10:29:38 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <21782811537857740@sas2-857317bd6599.qloud-c.yandex.net>
References: <6160201537441514@iva5-cb9df376e345.qloud-c.yandex.net> <xmqq36u42pzw.fsf@gitster-ct.c.googlers.com> <21782811537857740@sas2-857317bd6599.qloud-c.yandex.net>
Subject: Re: Work is not replayed on top while: git pull -v --rebase
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 25 Sep 2018 10:29:38 +0300
Message-Id: <17711781537860578@iva1-5148b5385b62.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commits are lost always if both users did `git push --force`

How to reproduce:
1. First user: `git push --force`
2. Second user: `git push --force`
3. First user: `git pull -v --rebase`

Here after 3 I expect that git will say that after rebase some commits from current branch will not be exists after rebasing

some logs:

kes@work ~/s $ git tree
* 704f068f (HEAD -> 296_tos, back) Fix message
*   8d9aef32 Merge branch 'fix_login_form' into 296_tos
|\  
| * f1c6616a Copy value over all contact
|/  
*   528b8f0d Merge branch 'fix_profile' into 296_tos

$ git pull -v --rebase
From https://tracker.feel-safe.net/gitdev/main
 = [up to date]        296_tos                    -> origin/296_tos
 = [up to date]        297-unification-of-buttons -> origin/297-unification-of-buttons
 = [up to date]        ToS-component              -> origin/ToS-component
 = [up to date]        authorization_pg           -> origin/authorization_pg
 = [up to date]        buy_dev                    -> origin/buy_dev
 = [up to date]        content_negotiation_fixes  -> origin/content_negotiation_fixes
 = [up to date]        dash_v2                    -> origin/dash_v2
 = [up to date]        design_master              -> origin/design_master
 = [up to date]        design_master_2            -> origin/design_master_2
 = [up to date]        fix_order_pg               -> origin/fix_order_pg
 = [up to date]        master                     -> origin/master
 = [up to date]        new_design_master          -> origin/new_design_master
 = [up to date]        new_error_pg               -> origin/new_error_pg
 = [up to date]        text-page-style            -> origin/text-page-style
Changes from f66c29158a57d687aaf48fb89f9b897563c0142e to e8875a0aa09cd1f352a41a5c164b5b2fdcdbe75b:
 public/profile/profile.html             |   2 +-
 public/v2/css/ask_options.css           |  17 ++++--
 public/v2/css/authorization.css         |  20 +++++--
 public/v2/css/input.css                 |   8 +--
 public/v2/css/layout.css                |  18 ++++---
 public/v2/css/media.css                 | 150 +++++++++++++++++++++++++++++++++++++++-------------
 public/v2/css/menu.css                  |   4 +-
 public/v2/css/profile.css               |   5 ++
 public/v2/css/tos.css                   |  38 ++++---------
 templates/v2/profile.html.ep            |  44 ++++++---------
 templates/v2/tariff/ask_options.html.ep |   2 +-
 templates/v2/tos/tos.html.ep            |   4 +-
 12 files changed, 195 insertions(+), 117 deletions(-)
Note: checking out 'e8875a0aa09cd1f352a41a5c164b5b2fdcdbe75b'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at e8875a0a Fix media queries for Profile Page
Rebasing (1/1)
704f068fc32b05e043d3ae7a2c06a853bcbaca85
[detached HEAD f85f0623] Fix message
 Date: Tue Sep 25 09:37:34 2018 +0300
 1 file changed, 1 insertion(+), 1 deletion(-)
 cpanfile                            |   4 -
 cpanfile.snapshot                   |  57 +----
 lib/App.pm                          |   2 +-
 lib/App/Controller/User.pm          |  43 +---
 lib/DbMapper.pm                     | 210 -----------------
 lib/DbMapper/Adapter.pm             |  12 -
 lib/DbMapper/Adapter/DBI.pm         |  90 -------
 lib/DbMapper/Adapter/DBI/Schema.pm  |  66 ------
 lib/DbMapper/Adapter/Echo.pm        |  17 --
 lib/DbMapper/Adapter/Echo/Schema.pm |  49 ----
 lib/DbMapper/Data.pm                | 179 --------------
 lib/DbMapper/DataSet.pm             | 459 ------------------------------------
 lib/DbMapper/Schema.pm              |  23 --
 lib/Mojolicious/Plugin/Auth.pm      |   1 -
 public/v2/css/authorization.css     |  11 +-
 public/v2/css/media.css             |  95 ++++++--
 public/v2/css/menu.css              |   4 +-
 public/v2/js/authorization.js       |   4 -
 t/DbMapper/create_data.t            |  22 --
 t/DbMapper/field_access.t           |  58 -----
 t/DbMapper/iterate.t                |  55 -----
 t/DbMapper/join.t                   | 223 ------------------
 t/DbMapper/lib/DSt/Role.pm          |   7 -
 t/DbMapper/lib/DSt/User.pm          |  31 ---
 t/DbMapper/lib/DSt/X1.pm            |  24 --
 t/DbMapper/lib/DSt/X2.pm            |   8 -
 t/DbMapper/update_data.t            |  15 --
 templates/v2/profile.html.ep        |  70 ++++--
 28 files changed, 153 insertions(+), 1686 deletions(-)
Successfully rebased and updated refs/heads/296_tos.
kes@work ~/s $ git tree
* f85f0623 (HEAD -> 296_tos) Fix message
* e8875a0a (origin/296_tos) Fix media queries for Profile Page
* 46a1c00b Fix media queries for screen less than 780px
* a562406d Bulk changes
* 177e2515 Bulk changes
* 934bbb31 Fix Profile Page
* 811d8812 Fix button's width on Authorization form
* 97ca9419 Fix Tariff Options page
* d5ec2336 Fix header on order page
* afcd49c1 Fix text appearance on TOS page

as you can see join.t is removed at all
