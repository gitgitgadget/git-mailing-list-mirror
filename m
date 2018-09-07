Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452571F404
	for <e@80x24.org>; Fri,  7 Sep 2018 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIGRbr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 13:31:47 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:58942 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbeIGRbr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Sep 2018 13:31:47 -0400
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2018 13:31:46 EDT
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1fyFvB-00057J-8x; Fri, 07 Sep 2018 14:31:33 +0200
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.org>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: 2.19.0.rc2.windows.1: stash fails with dirty submodule
Message-ID: <6e01daf2-5fb7-b6c0-2833-aa696241c609@virtuell-zuhause.de>
Date:   Fri, 7 Sep 2018 14:31:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1536324658;819a6a8c;
X-HE-SMSGID: 1fyFvB-00057J-8x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(reported at [1] already but reposting here as suggested)

I'm using git with stash and rebase builtins.

$ git --version --build-options

git version 2.19.0.rc2.windows.1
cpu: x86_64
built from commit: 425f414f8e04123eacb5597776d6a8de445a8d8b
sizeof-long: 4
sizeof-size_t: 8

With the following recipe

mkdir test
cd test
git init
echo 1 > file
git add file
git commit file -m "message"
git submodule add ./ mysubmod
git commit -m "Add submodule"
echo 2 > mysubmod/file
git checkout -b mybranch
git rebase -i --autosquash master

I get

Initialized empty Git repository in E:/projekte/test/.git/
[master (root-commit) 97c0108] message
 1 file changed, 1 insertion(+)
 create mode 100644 file
Cloning into 'E:/projekte/test/mysubmod'...
done.
[master 282a50f] Add submodule
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 mysubmod
Switched to a new branch 'mybranch'
M       mysubmod
fatal: Unexpected stash response: ''

and that used to work with older git versions.

Thanks for reading,
Thomas

[1]:
https://github.com/git-for-windows/git/issues/1820#issuecomment-419411808
