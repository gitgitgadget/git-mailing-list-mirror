X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: cache for copy/rename detection
Date: Sun, 26 Nov 2006 19:59:31 +0700
Message-ID: <fcaeb9bf0611260459t7afa68eerf4dc66d7eb7fdcc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 12:59:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X3tF89yPM/6PrsFMQXofDliN6Jt4MnRTunSRk2CvQitz5vt6NVoXJaSXZ34HpqNxhOIlsFCGPKnIHjtV/ls8VYXQoA87m2kzEIKEtMsqKy8ZKAvi6vrHwpteCm/FCTjzoeNSngqUalEWKos8WzggfqAeBj3sJzpfw7ySBWIQY+A=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32343>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoJbh-0000HU-EQ for gcvg-git@gmane.org; Sun, 26 Nov
 2006 13:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935381AbWKZM7d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 07:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935382AbWKZM7d
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 07:59:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:63848 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935381AbWKZM7d
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 07:59:33 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1862077nfa for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 04:59:32 -0800 (PST)
Received: by 10.78.127.2 with SMTP id z2mr12273010huc.1164545971428; Sun, 26
 Nov 2006 04:59:31 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Sun, 26 Nov 2006 04:59:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I thought about this lately. git's expensive copy/rename detection can
be run once and the results are kept somewhere in .git. Copy/rename
detection depends on tree objects and git detection algorithm. Tree
objects are immutable and git algorithm change rate is low IMO. So
cache invalidation is unlikely to happen.

Another thing I want to do with this cache is ability to manually
inject some hints to git. For example, I remove a file. Several
commits later, I revive that file in another place. I know that two
files are the same but can't tell git (and I don't think Git will
detect this pattern). With this cache, I can tell git this file is a
copy of that file.

What do you think?
-- 
