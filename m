Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9011F453
	for <e@80x24.org>; Tue,  6 Nov 2018 10:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeKFT5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 14:57:19 -0500
Received: from mx.gfi-bremen.de ([62.159.158.133]:18734 "EHLO mx.gfi-bremen.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387472AbeKFT5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 14:57:19 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 14:57:18 EST
X-Virus-Scanned: amavisd-new at gfi-bremen.de
Received: from mx.gfi-bremen.de ([127.0.0.1])
        by localhost (mail.gfi-bremen.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jdEWTw7KRNOa for <git@vger.kernel.org>;
        Tue,  6 Nov 2018 11:23:40 +0100 (CET)
Received: from mail.gfi-bremen.de (mail.gfi-bremen.de [192.168.11.81])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.gfi-bremen.de (Postfix) with ESMTP
        for <git@vger.kernel.org>; Tue,  6 Nov 2018 11:23:40 +0100 (CET)
Received: from [192.168.6.236] (unknown [192.168.6.236])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by mail.gfi-bremen.de (Postfix) with ESMTP id 376B413F675
        for <git@vger.kernel.org>; Tue,  6 Nov 2018 11:23:40 +0100 (CET)
To:     git@vger.kernel.org
From:   Georg Tsakumagos <g.tsakumagos@narz-avn.de>
Subject: Bug: git-svn clone --preserve-empty-dirs fail - couldn't truncate
 file at /usr/share/perl5/Git.pm line 1337.
Message-ID: <80d343b0-7cac-eafa-f393-a5408ce51807@narz-avn.de>
Date:   Tue, 6 Nov 2018 11:23:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, i am in the middle of a migration project. Almost over 60 projects 
(aprox 1/3) suffer from this behaviour. I was able to create a svn 
repository dump (8MB) of a small project thats provoke that failure. The 
failure do not occur if the option "--preserve-empty-dirs" is omitted. 
Also no problem if the svn dump is filtered with "svndumpfilter 
--drop-empty-revs" before load into a fresh repo.

I'll be able to provide the dump for further investigations. I would 
send it on demand. I'm able to reproduce the failure with the dump. It 
seemed many others had suffered from this bug.

Used Version:   1:2.17.1-1ubuntu0.3
OS:                       Ubuntu 16.04.5 LTS
Commandline: /usr/bin/git svn clone --prefix= --preserve-empty-dirs 
--authors-file=/mnt/migration/authors.txt --stdlayout https://host/repo 
/mnt/migration/repos/TEST/plausiweb

r37895 = bf620e85ad1ac0d42298cb01cb0dab594958d1e1 (refs/remotes/trunk)
         A       release-pom.xml
         A       plausiweb-report/release-pom.xml
         M       plausiweb-report/pom.xml
         A       plausiweb-web/release-pom.xml
         M       plausiweb-web/pom.xml
         M       pom.xml
r37896 = 9420d7081b44797825aa7a19bb508ef2533a3356 (refs/remotes/trunk)
Found possible branch point: https://scm/svn/git/java/plausiweb/trunk => 
https://scm/svn/git/java/plausiweb/tags/plausiweb-18.06.1, 37896
Found branch parent: (refs/remotes/tags/plausiweb-18.06.1) 
9420d7081b44797825aa7a19bb508ef2533a3356
Following parent with do_switch
couldn't truncate file at /usr/share/perl5/Git.pm line 1337.


-- 

Best regards from Bremen

Georg Tsakumagos

