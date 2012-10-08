From: Dun Peal <dunpealer@gmail.com>
Subject: core.autocrlf=true replaces LF with CRLF on Linux
Date: Mon, 8 Oct 2012 10:03:19 -0700
Message-ID: <CAD03jn41w814XqdFq=PK+AAOQcXZtm0kQrGpobPfA-YULTpkPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 19:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGjr-0000O6-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab2JHRDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 13:03:22 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41243 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab2JHRDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:03:20 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so2925122eek.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Pcm9A7q9I6B9PmWyYRKfjZqNFWKsp7EXdglWWiT62vc=;
        b=Xus0GZP1fc+glxjZIe0dCM0Fs9T6HqcvwG82YAhF8Ri0BMFzV+j4huFVWF0qTXq09u
         pVLsHAiyucMPgeVqGrox7FXXqGdAfhKYaAfU1dJjz1Ztrf5x+takHcs8P5JUB8n6kAw7
         MUNHf/YGxdHpnVk1LT0K6u/GYtGEzjTCOE/pz6yrquv/SQLPY9sIjtYHx+Ei9hNia7ks
         tTUQv7w/8eRSna2r1+kcAnWo5iFRqtDlYYzV+kTsSkE7VIEnlxmiOnOe4jW0mgwlunSU
         MaAxAZ7VRYbX7YjGtkVU4BRBSQZTH5EiR+RhInbOI8A8jHOyIP6wtxweMtVSSELMrHGv
         Usag==
Received: by 10.14.201.73 with SMTP id a49mr23496755eeo.39.1349715799647; Mon,
 08 Oct 2012 10:03:19 -0700 (PDT)
Received: by 10.14.183.73 with HTTP; Mon, 8 Oct 2012 10:03:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207242>

The docs indicate that core.autoccrlf=true will only replace LF with
CRLFs if the runtime platform native line-endings are CRLF, since
core.eol defaults to native. I have gone a step further on my box and
set core.eol to "lf", and still get the same result: conversion of LFs
to CRLFs on a newly created file. Full reproduction:

$ cat /etc/redhat-release; git --version
Fedora release 17 (Beefy Miracle)
git version 1.7.11.2
$ git config -l
core.autocrlf=true
core.eol=lf
$ rm -rf test; mkdir test; cd test; git init; echo bar >foo.txt; git add foo.txt
Initialized empty Git repository in /tmp/test/.git/
warning: LF will be replaced by CRLF in foo.txt.
The file will have its original line endings in your working directory.
