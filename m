X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: gitk broken or user error?
Date: Mon, 13 Nov 2006 14:38:57 -0800
Message-ID: <m2y7qfezum.fsf@ziti.local>
References: <m2irhkr467.fsf@ziti.local>
	<17752.60467.854884.206737@cargo.ozlabs.ibm.com>
	<m27ixzgex4.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 22:39:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Er4W8zS3oqUpoa5t6cqcY+nXqeRuBQxr7/a3ZNS6hCwTkZlvvgRiAvWlxHthmnFL6rMOXsiQLXOim6xx6vzMBjBVXRxn6zI6nearP+TRab2+d6J/jS+VpiSkbSJzI3z0rzmqJriyv5bIGM/iwf3PAOJyLx+HQS8fItwiEoCrO/c=
In-Reply-To: <m27ixzgex4.fsf@ziti.local> (Seth Falcon's message of "Mon, 13 Nov 2006 14:28:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31326>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjkSK-0003qF-K0 for gcvg-git@gmane.org; Mon, 13 Nov
 2006 23:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933092AbWKMWjF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 17:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933093AbWKMWjE
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 17:39:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:16286 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S933092AbWKMWjC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 17:39:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so34837nfa for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 14:39:01 -0800 (PST)
Received: by 10.49.12.4 with SMTP id p4mr218395nfi.1163457540796; Mon, 13 Nov
 2006 14:39:00 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 o53sm280604nfa.2006.11.13.14.38.59; Mon, 13 Nov 2006 14:39:00 -0800 (PST)
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> writes:
> I tried this patch:

And then I used grep :-)

This patch seems to get the view menu items working.  The only strange
thing I see now is that if I create a new view and then try to delete
it, it stays around in the menu.

+ seth

diff --git a/gitk b/gitk
index ab383b3..d9df0a3 100755
--- a/gitk
+++ b/gitk
@@ -1632,8 +1632,8 @@ proc showview {n} {
 
     set curview $n
     set selectedview $n
-    .bar.view entryconf 2 -state [expr {$n == 0? "disabled": "normal"}]
-    .bar.view entryconf 3 -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf "Edit*" -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf "Delete*" -state [expr {$n == 0? "disabled": "normal"}]
 
     if {![info exists viewdata($n)]} {
        set pending_select $selid
@@ -6305,8 +6305,8 @@ if {$cmdline_files ne {} || $revtreeargs
     set viewargs(1) $revtreeargs
     set viewperm(1) 0
     addviewmenu 1
-    .bar.view entryconf 2 -state normal
-    .bar.view entryconf 3 -state normal
+    .bar.view entryconf "Edit*" -state normal
+    .bar.view entryconf "Delete*" -state normal
 }
 
