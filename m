From: Dmitry Gryazin <dosagc@gmail.com>
Subject: git-grep colouring bug with -w option.
Date: Wed, 20 May 2009 22:38:57 +0400
Message-ID: <4A144E41.4010303@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090509040705070608060405"
Cc: rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 20:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qhh-0007oJ-B5
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbZETSjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbZETSjL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:39:11 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62718 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985AbZETSjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:39:09 -0400
Received: by bwz22 with SMTP id 22so585678bwz.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type;
        bh=50UsOLmdY6+oqagTHXJ8RDZUu3LwNUxRAJQEO5nnru4=;
        b=LagtUHpvQBaGnnpSuVWLMU76165V829+nGNHuycfgXLSL+Ru8HVlRwUK9oWi5NiFN3
         Csq3ft9vO0THbmVIITiYi4eqDKz6T1wEfhFGZEGAziWNXJzRJQhG4iBNm5GVUM5dnzxR
         ggzaVSLNdem68TG+XBKJrOsTJvwvhNQKzjRNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type;
        b=WojeSgbJ4nuYIOhshzGc/d5re0okbLfa+CX3/eMMSadAckT0t7oLRKgiXHiuGGww32
         7PK83ATIogIIN0n6QFsua8lhsw/Kqe4QxPpYMu8/J57wDv6pT7Rg/OMNkYGK30fWSmtE
         j3C7zOiDCxZLJUvxT7cMMfevw8bKfc9k6dJew=
Received: by 10.103.215.15 with SMTP id s15mr854127muq.118.1242844749984;
        Wed, 20 May 2009 11:39:09 -0700 (PDT)
Received: from ?10.206.120.194? ([77.241.45.26])
        by mx.google.com with ESMTPS id s11sm1964675mue.50.2009.05.20.11.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 11:39:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119630>

This is a multi-part message in MIME format.
--------------090509040705070608060405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've found that "git-grep --color -w VirtualKeybord" works not correct 
for string like:

vkbd = RVirtualKeyboard(main_window, "VirtualKeyboard")

My script in attachment reproduces this bug.

--------------090509040705070608060405
Content-Type: application/x-sh;
 name="git_grep_colouring_bug.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_grep_colouring_bug.sh"

#!/bin/sh

echo "This script requires git >= 1.6.3"
mkdir git_grep_bug
cd git_grep_bug
git init --quiet
echo "vkbd = RVirtualKeyboard(main_window, \"VirtualKeyboard\")" > bug.py
git add bug.py
git commit --message="Introduce git-grep colouring bug with -w option." \
           --author="Dmitry Gryazin <dosagc@yandex.ru>" \
           --quiet
echo "git-grep with --word-regexp option:"
git grep --word-regexp --color VirtualKeyboard
echo "git-grep without --word-regexp option:"
git grep --color VirtualKeyboard

--------------090509040705070608060405--
