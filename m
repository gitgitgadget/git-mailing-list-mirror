X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: n0dalus <n0dalus+redhat@gmail.com>
Subject: Using git-bisect to find more than one breakage
Date: Tue, 12 Dec 2006 15:04:29 +1030
Message-ID: <6280325c0612112034x373c8022q909ca192a866cfcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 04:34:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=AvKbvNpmjmaPYmTNeKsIe1lUHsO0bqVHUhUpFp4ptIOhVXV4D44M/sMB4OcmPpqOWOBbvRY7qtl7FpAbhVO0MfTgPFM1TyE1yN0Zt8JA4KkdtM15nIf1FBWxE7qePHcwUf0q+kdexBxcU6zefvpDLqYemq8KWj2EtEtFr+I55MQ=
Content-Disposition: inline
X-Google-Sender-Auth: 7a3705c50a19ec33
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34060>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtzLd-0007sU-9k for gcvg-git@gmane.org; Tue, 12 Dec
 2006 05:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751150AbWLLEea (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 23:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWLLEea
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 23:34:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:35744 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751150AbWLLEe3 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 23:34:29 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1780295wxd for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 20:34:29 -0800 (PST)
Received: by 10.70.75.14 with SMTP id x14mr13794174wxa.1165898069098; Mon, 11
 Dec 2006 20:34:29 -0800 (PST)
Received: by 10.70.129.20 with HTTP; Mon, 11 Dec 2006 20:34:29 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I am trying to find commits in the 2.6.18 linux tree that
cause/trigger problems for a program I use. I found the first commit
by using git-bisect. However, somewhere between that commit and master
there is at least one more commit that breaks things. I'm sure there
must be a way to find this, but the method I'm using doesn't seem to
work (I'm new to git).

This is what I tried to do:
- Make a branch ("working") at the bad commit
- Commit a patch to undo the bug-causing change from that commit
- Make a copy of the master branch
- git-rebase working
- (Then if that worked, use git-bisect to find the next breakage)

I expected git-rebase to just apply all the commits from the master
onto my working branch, possibly stopping in the case of a conflict to
the file I patched. Instead, it produces large conflicts with
unrelated files, on the very first commit it tries to apply. I even
get the conflicts if the commit I make before using git-rebase changes
no files at all (just adding an empty file 'test').

Is there something wrong with my method here? Is there another way to do this?

I am thinking for now I will just use git-bisect between the bad
commit and master, and apply my changes to every bisection.

Any help greatly appreciated,
