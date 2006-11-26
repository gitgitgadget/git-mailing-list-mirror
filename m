X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible BUG with git-rev-list --all in a StGit repository
Date: Sun, 26 Nov 2006 17:27:27 +0100
Message-ID: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 16:28:01 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fIuAyTfRIBoBxnP4nmZjz35EbukmuCjCOoM7l0bEauu9MIkTsbgbZOfXyHq7iN4G3whQodyPAez1mpKPXUaBJVwjJvW1A3xafPGaBmOus6EuvzyWjC4dWxMeLW1XYMOUB7DUGkYX7F+VPuzsarRySTuB8QQSt2obwWSDWp/Y9jA=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32355>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoMr1-0002v5-8x for gcvg-git@gmane.org; Sun, 26 Nov
 2006 17:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935434AbWKZQ1b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 11:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935435AbWKZQ1b
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 11:27:31 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:27989 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S935434AbWKZQ1a
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 11:27:30 -0500
Received: by py-out-1112.google.com with SMTP id a29so911105pyi for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 08:27:28 -0800 (PST)
Received: by 10.35.38.17 with SMTP id q17mr10971186pyj.1164558447866; Sun, 26
 Nov 2006 08:27:27 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sun, 26 Nov 2006 08:27:27 -0800 (PST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org

In a StGit repository the --all option causes a lot of spurious
revisions, possibly stgit related.

$ git branch
* master
  origin
  test

$ git rev-list master origin test -- src/settingsimpl.cpp | wc
     13      13     533

$ git rev-list --all -- src/settingsimpl.cpp | wc
     26      26    1066


The extra revisions have shortlogs of the kind of:

 push        a3bc76fd0bdd154149c26a3c208f0344e9cd873b
 new e7baf56544cd8b4f8601a35fad274b8de97fd558
refresh     8fa01a56a40b04ed9c6d006c669ca9d370176728

From qgit these are easily seen from file history tab of a file
modified by stgit patches or when filtering in main view on the same
file.

Shouldn't 'git-rev-list --all'  print  *the same output* of when the
list  with all branches is given in command line?

Thanks
Marco

P.S:
$ git version
git version 1.4.4.1.g7002
$ stg --version
Stacked GIT 0.11
git version 1.4.4.1.g7002
Python version 2.4.3 (#2, Oct  6 2006, 15:32:41)
