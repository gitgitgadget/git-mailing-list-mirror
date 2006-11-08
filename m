X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] Better unquoting of git quoted filenames; esc_path to escape pathnames for display
Date: Wed, 8 Nov 2006 11:47:52 +0100
Message-ID: <200611081147.52952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 10:49:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e5ErUekdeoIMrAk0eEJmDplCAZcRMzH5ZN+m7F4RDtfimwvheCzIaYG/5nmblnpBo3P/ng4M65mIqYvH1d4ehAAtZr/07RChP9G6h7R0mHiaB87D7FZIBrIHhd1zYdfZREYccjiQXIfbi95uR6YP3uwnAg1oK6iye7iFxqEQOwA=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31135>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghkzz-0001gj-56 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 11:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753194AbWKHKtc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 05:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbWKHKtc
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 05:49:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:36304 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752917AbWKHKtc
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 05:49:32 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1476056ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 02:49:30 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr10627538ugm.1162982970455; Wed,
 08 Nov 2006 02:49:30 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm7626498uge.2006.11.08.02.49.29; Wed, 08 Nov
 2006 02:49:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This series fixes unquote so that it can deal with alphabetic escape
sequences like '\n' and '\t', and escaped literal characters like '\"'
and '\\', and adds esc_path do deal with the fact that unquoted 
filenames can now contain control characters, not suitable for HTML.
Previous version of unquote was broken in that it did only octal
escape sequence unquoting, and could leave filename only partially
unquoted.

First patch adds minimal esc_path, second improves esc_path to final
version.

Shortlog:
 [PATCH 1/2] gitweb: Better git-unquoting and gitweb-quoting of pathnames
 [PATCH 2/2] gitweb: Use character or octal escape codes (and add span.cntrl) in esc_path

Diffstat:
 gitweb/gitweb.css  |    7 ++++
 gitweb/gitweb.perl |   95 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 83 insertions(+), 19 deletions(-)

-- 
Jakub Narebski
