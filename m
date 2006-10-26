X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: StGit-enabled bash-prompt
Date: Thu, 26 Oct 2006 23:17:29 +0200
Organization: Dewire
Message-ID: <200610262317.30209.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 21:17:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30262>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdCaS-0005Y7-Nh for gcvg-git@gmane.org; Thu, 26 Oct
 2006 23:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423675AbWJZVQY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423677AbWJZVQY
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 17:16:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:43834 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1423675AbWJZVQX (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 17:16:23 -0400
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 756DE802C09 for <git@vger.kernel.org>; Thu, 26 Oct
 2006 23:13:08 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 15607-10 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 23:13:08 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 32ACC802677 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 23:13:06 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I added the following snippet to my .bashrc to help me keep track of what 
patch I'm working on.  I got annoyed at typing stg top/stg series all the 
time.

This changes the bash prompt to include the current git branch and the top 
stgit patch to the prompt.

Of course you will read and understand this code. I don't know how good an 
idea it is to use the DEBUG trap this way.

NO WARRANTY (as always)

-- robin

if [ "$PS1" ]; then
    function stgtag
    {
        br=$(stg branch 2>/dev/null)
        top=$(stg top 2>/dev/null)
        if [[ -n "$br$top" ]];then
            echo " [$top@$br] "
        fi
    }
    trap 'PS1="\u@\h$(stgtag)\w]\$ "' DEBUG

