X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: gitk broken or user error?
Date: Sun, 12 Nov 2006 09:00:16 -0800
Message-ID: <m2irhkr467.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 17:00:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=hr8MXA6fkIJhmfKbpsDV+HqBsoa5XlGiZd9uTOl43zs9w4NqdvC99+/dp+Q9HXXjkLcjZ27IebL/a+gqremZJdKjxqOZFA8RGwrl9Dmizzx6WVXFb09yHapVo24sB3DS5OcKrNsX8ZTOtPc6azN7HEtJ6yQegEwhZr23IAg+t00=
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31266>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjIh3-0008PA-BV for gcvg-git@gmane.org; Sun, 12 Nov
 2006 18:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932953AbWKLRAW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 12:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbWKLRAV
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 12:00:21 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:21347 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1755133AbWKLRAV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 12:00:21 -0500
Received: by nz-out-0102.google.com with SMTP id l1so595094nzf for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 09:00:20 -0800 (PST)
Received: by 10.65.242.10 with SMTP id u10mr6500329qbr.1163350819898; Sun, 12
 Nov 2006 09:00:19 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 f17sm5281581qba.2006.11.12.09.00.18; Sun, 12 Nov 2006 09:00:19 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I get the following error when invoking gitk with any command line
argument, for example, 'gitk --all':

    ziti:~/proj/R-devel seth$ gitk --all
    Error in startup script: unknown option "-state"
        while executing
    ".bar.view entryconf 3 -state normal"
        invoked from within
    "if {$cmdline_files ne {} || $revtreeargs ne {}} {
        # create a view for the files/dirs specified on the command line
        set curview 1
        set selec..."
        (file "/Users/seth/scm/bin/gitk" line 6298)

I tried a certainly incorrect thing; just commenting out the offending
lines:

diff --git a/gitk b/gitk
index ab383b3..a6c0a9f 100755
--- a/gitk
+++ b/gitk
@@ -6305,8 +6305,8 @@ if {$cmdline_files ne {} || $revtreeargs
     set viewargs(1) $revtreeargs
     set viewperm(1) 0
     addviewmenu 1
-    .bar.view entryconf 2 -state normal
-    .bar.view entryconf 3 -state normal
+#    .bar.view entryconf 2 -state normal
+#    .bar.view entryconf 3 -state normal
 }
 
 if {[info exists permviews]} {

And now gitk _seems_ to work.  No error message, and I can pass
argument to gitk like --all (wow, very useful).

I posted about this in October [*1*], but didn't get any response.
I'd like to be able to use gitk without my must-be-wrong patch.  This
is on OS X ppc (git version 1.4.4.rc1.g73347) with Tcl & Tk at 8.4.7.
Can I provide more info?  Have I missed a configuration step?

Thanks,

+ seth


