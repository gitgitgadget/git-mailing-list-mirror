Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0DAE1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeA2TN7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 14:13:59 -0500
Received: from mout.perfora.net ([74.208.4.197]:58526 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeA2TN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 14:13:58 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jan 2018 14:13:58 EST
Received: from [192.168.1.104] ([194.237.255.67]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mfoeo-1eRrBM2A56-00NAqb
 for <git@vger.kernel.org>; Mon, 29 Jan 2018 20:08:56 +0100
To:     Git Mailing List <git@vger.kernel.org>
From:   H <agents@meddatainc.com>
Subject: Location limits on development, staging and production environments
Message-ID: <baf15388-adb4-ddce-889f-3e71b1574044@meddatainc.com>
Date:   Mon, 29 Jan 2018 20:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K0:/EBTJYY+hnPRMuOkvmKQ2Z++lHtxo2W6N9UVBqYAELCZAhCaRdP
 hLZz988mNiKiOk522bBYT19syjjspanpQvcNGCrPpqDUehEFiAGb49kynTYqBGMTDD8nFdK
 iNu3b+vf9Kn2Pa8vNIIbOIp5fnOYCBRsiVbjnAHDEH04xJdp3aO8oVYh05FCujQ6FxOida5
 GAJSARKPsFVwzxH9cpVBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mO82UGfwD9o=:hedd1pFDE2n3CtMc6zmEUu
 LsPbW50lQHQjLycNP07P/tXcweN6ZSDWkkexS4X17O9XACQyR7qtSVe45abW1bF/4CSz0WjDB
 x+/KeZBYLsvmbEImvDOcOALlC4PRXRrIXnI8dIo0VrGxWiXT8BDOMied6REQ90LFgF1+13Weq
 I8TzJVjAixgJIzOPre3h213wRUzwxUnl3ZwRZH0lNMEXrACMs0lwi1RMzdZD3iVes/uJxWbJ0
 aqM5Pe3317FT1+EJsLDn2OkLdfyart3St3+ylVBUTbZzsxjykRShX3Eclj+82HghTq3CSE6EB
 lM7WwzQpA/uwlz91AE7SDacLS8ztVPm/2FFkPyJr9fNAUjmYwW5H48/EM85H2tQJyGarlg9A5
 Phx7dtbkhbY3JoCG21zmeZbovk1kPqjiCK6pHfhqw/c9jlGHznsSp03GCslubEZh9sHNusm3A
 s/e3AJJWmKq/aZa3NcDFGD5Dwc+uOLQ/FG3Nc34cmLn+16/O6uIxofVJ+k6t1uWmeMDbcIANx
 PEIugebrSwgg7ZWXqqbImOXIHki0ys55usfszIdIgFSShwSRhWNXxgpcwBRIwRsY29hOE+nAk
 EaW8kxpmb2MJTCalBNFoDE5gcBXZaHCmEGUp8ANdr+VoHcPCA9U7u9mULLC6Ya4rsVwUSFgrA
 MQ1vTq4fMZF6dPCqkxZv/m1fIT6H3OijEop7v6EHvhOEKZknctZuvpa/nqeqC3ME2j+2Ae1ct
 BQ7lXdRaNkRs1R0PFIyy3jIFWGwvjK5SdcOTDKl15iZ7cfX8ZjAGhHMcayc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am a newcomer to git looking to set up a web development environment where individual computers are used for development, the development.git, staging.git and production.git repositories are stored on an external server reachable by password-less ssh and the staging and production websites are on yet another server, also reachable by password-less ssh from the git-server (and the development machines).

Locating the three git repositories on an external server works fine but I have not been able to have the staging and production deployment files on another server. I believe this is what is referred by GIT_WORK_TREE and based on what I found on the web I created a post-receive hook of staging.git with the two lines:

#!/bin/sh
GIT_WORK_TREE=user@1.2.3.4:/var/www/html/dev.whatever git checkout -f master

I believe this should deploy the files from the development work tree.

The above, however, fails. Should it work? I am running git 1.7.1 on CentOS 6.

