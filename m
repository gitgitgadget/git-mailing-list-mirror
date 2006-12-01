X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: selective git-update-index per diff(1) chunks
Date: Fri, 1 Dec 2006 14:23:14 +0300
Message-ID: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 11:23:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jzh/9lcHT7cJDWuSpnFU5R28nf+QYoCav3pg/dC58JSkeoG5CcxIANnJHR2YP1XQjfMyb+7yKHcugv0YqYNP+FiiN44Bc54NGE8kGTKfm4SOlKC6zezp2ElURgz7q2RCjv60FkzaoCST6VQ83aixiueZ+Kieu1LI7mLvjaYIQ2E=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32897>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6UV-0007L9-0l for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936457AbWLALXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936458AbWLALXQ
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:23:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:25069 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S936457AbWLALXP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:23:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3530330nfa for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 03:23:14 -0800 (PST)
Received: by 10.49.20.15 with SMTP id x15mr16951945nfi.1164972194122; Fri, 01
 Dec 2006 03:23:14 -0800 (PST)
Received: by 10.48.162.17 with HTTP; Fri, 1 Dec 2006 03:23:13 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Pretty often I end up with a file with two simple orthogonal fixes in it.
git-diff shows me both, that's OK.

Now I want to commit them as two separate commits. So far, it's
* getting full diff
* cp(1)
* hand-edit both diffs
* commit first
* commit second

Has anyone thought about aggregating this into git-update-index or
somewhere?

    git-update-index -C1,3    #chunks 1, 3
    git commit
    git-update-index -C1,3    # chunks 2,5 in original numbering
    git commit

