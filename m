From: Ilya Basin <basinilya@gmail.com>
Subject: merging bare repository
Date: Fri, 13 May 2011 14:51:32 +0400
Message-ID: <533718318.20110513145132@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 12:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpyO-0005FS-85
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778Ab1EMKvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:51:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51829 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344Ab1EMKvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:51:50 -0400
Received: by eyx24 with SMTP id 24so665897eyx.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-mailer:reply-to:x-priority
         :message-id:to:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=3deKYxSa0/6ETA2MdhYRDeXSzUcmuyvy2sJhxU9cNjc=;
        b=E0xrespRkAx4nEKW7z0ismSTbeLZPyoiA0h53ke2Xih/YM7gzxYG6YFCqk7yr8Ae3N
         Qf1S0LZVCYemBhk+CVKtCIW5oZrckQ/tMzfJy0hDrSrdpXs7C0jnCwsjIgOIPT3v6o7p
         8n5PjciS+pKgP+oAP/vuByUwpC7s0ldptrzh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        b=VfoC1/lHqwasXmWpt7vDEv74lKoIvpFu5/9fzRrvkWhy+cnbROamAVJu42uCChFiRP
         OaQfQCNmYluJODoFXoT7bmj//A2v0nD+htK1zER1oFnEyiiiTKwonKRhgMjuqqX1XzOf
         JhsVSGgAdfNBaluJ29C+UyRPTts8t+M4Y15xA=
Received: by 10.213.8.4 with SMTP id f4mr666899ebf.24.1305283909422;
        Fri, 13 May 2011 03:51:49 -0700 (PDT)
Received: from basin.reksoft.ru (gate.reksoft.ru [188.64.144.36])
        by mx.google.com with ESMTPS id r12sm1348279eeb.4.2011.05.13.03.51.47
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 03:51:47 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173527>

Hi list. Please suggest me a solution. There's a remote repository;
we're not allowed to push to. We have several committers.
So I want to create a local mirrror. We will push our changes to it.
Once in a while I want to sync this repo with upstream.

Here's what I do:

on server:
    [git@server]$ git clone --bare ssh://git@some.org/git/project.git /git/project.git

on workstation:
    [me@client]$ git clone ssh://git@server/git/project.git
    [me@client]$ cd project
    [me@client]$ touch aaa
    [me@client]$ git add aaa
    [me@client]$ git commit aaa -m abracadabra
    [me@client]$ git push

back on server:
    [git@server]$ git log
    commit e5c871122cadfa4ed4d2ab488852ecdb803b4bd8
    Author: Ilya Basin <>
    Date:   Fri May 13 13:39:39 2011 +0400

        abracadabra

I want to merge with upstream
    [git@server]$ git fetch
    [git@server]$ git merge origin
    fatal: This operation must be run in a work tree

I read this article:
http://www.pragmatic-source.com/en/opensource/tips/automatic-synchronization-2-git-repositories
The solution described there doesn't work

If I use --mirror instead of --bare to clone the repo, all local
commits discarded when I fetch.
