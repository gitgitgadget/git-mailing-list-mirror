Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C7C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAHJfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 04:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHJfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 04:35:37 -0500
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 01:35:34 PST
Received: from denver.dinauz.org (denver.dinauz.org [37.59.56.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7152EFD28
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 01:35:34 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by denver.dinauz.org (Postfix) with ESMTP id BFED060581
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 10:27:37 +0100 (CET)
Received: from denver.dinauz.org ([127.0.0.1])
        by localhost (denver.dinauz.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MMT8doI7IVQ4 for <git@vger.kernel.org>;
        Sun,  8 Jan 2023 10:27:37 +0100 (CET)
Received: from [192.168.1.6] (176.143-2-105.abo.bbox.fr [176.143.2.105])
        by denver.dinauz.org (Postfix) with ESMTPSA id 97CBE6047E
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 10:27:37 +0100 (CET)
Message-ID: <b1051e73-e663-82bf-bda6-015e64102248@trigofacile.com>
Date:   Sun, 8 Jan 2023 10:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Julien_=c3=89LIE?= <julien@trigofacile.com>
Subject: Ignored commits appearing in git blame
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm facing an issue with the use of "git blame" which shows commits marked to be ignored.

We have a .git-blame-ignore-revs file that can be retrievable at <https://github.com/InterNetNews/inn/blob/main/.git-blame-ignore-revs>.

The Git command line I'm using is:
     git blame --ignore-revs-file .git-blame-ignore-revs radius.c

Here is an extract where commit 36944f2b16 appears at line 59, though it should be ignored (present in .git-blame-ignore-revs):

8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int radport;
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char *lochost;
a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int locport;
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  54)     char *prefix, *suffix; /* futz with the username, if necessary */
9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int ignore_source;
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  57)     struct _rad_config_t *next; /* point to any additional servers */
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_config_t;
36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  59)
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef struct _sending_t {
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_req req;
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int reqlen;


When running git blame without ignoring revisions, commit 36944f2b16 appears at lines 54, 57 and 59:

8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int radport;
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char *lochost;
a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int locport;
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  54)     char *prefix, *suffix; /* futz with the username, if necessary */
9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int ignore_source;
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  57)     struct _rad_config_t *next; /* point to any additional servers */
8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_config_t;
36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  59)
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef struct _sending_t {
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_req req;
d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int reqlen;


Shouldn't 36944f2b16 have disappeared from the output at line 59?

It should have been d65e228465 which already had that line, as it can be seen in the commit (line 53 at that time):
   https://github.com/InterNetNews/inn/blob/d65e228465700ff044b75aecacb7062d2a1250f9/authprogs/radius.c


The result of that command is the same as the one GitHub shows; you can therefore find the whole ouput here:

     https://github.com/InterNetNews/inn/blame/main/authprogs/radius.c

Commit 36944f2b16 is mentioned at lines 59, 129, 144, 293, etc. though present in .git-blame-ignore-revs.
Yet, that very commit is correctly ignored at other places of the same file.

Other files and other commits in the project are also affected.  I can give more examples if needed.


Is it the expected behaviour of "git blame"?
Is there a reason for these commits to appear in some portions of the blame output?


Thanks beforehand,

-- 
Julien ÉLIE

« – Cet homme qui est sorti du palais, nous renseignera peut-être sur la
     façon d'y entrer. Suivons-le.
   – Mais… Il sait sortir d'accord, mais rien ne prouve qu'il sache
     entrer, et… » (Astérix)
