From: =?UTF-8?B?QmVub8OudCBCb3VyYmnDqQ==?= <benoit.bourbie@gmail.com>
Subject: git gui crashes ( v 1.8.5.2)
Date: Mon, 13 Jan 2014 18:14:24 -0600
Message-ID: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 14 01:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2red-00053i-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 01:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaANAOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 19:14:48 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:45567 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaANAOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 19:14:46 -0500
Received: by mail-we0-f179.google.com with SMTP id w62so2081577wes.38
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 16:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=e8Xhpr1kN7NEvlND01TSX9MXmcpv97moE/8frAsiZRo=;
        b=M7o4N36b1GLSvgcEqDWlX6J0NziqcDukH7nr/KcWUPCtqMHABezbahCzIoA00A1+/A
         6cEs6npNbwqAxXrgpih75Ks3FJZj7APDZxt062+Q259Xx/qPAWt+vZbOOiZcmjl0Hgvb
         AS+okp1lLSrd8myVAK3pL3/xhfxIc10zqQQ9iHRsQMDhLoSawxr7FvyqBz56glL5pyLj
         JXS4CidlMSwemmVneQYfwZctcNdEKt8xUwVqiRfjWYJJvzD/1RcYZvoRWjAbWpTbEzZx
         3tOyE7H/AZiVF4cSTnPWuUkSzDZnRxdGGJdgIB+YAoYZYgtLQFN7bSVNMPBkJaVStgVO
         /yKw==
X-Received: by 10.194.61.3 with SMTP id l3mr24113163wjr.18.1389658484448; Mon,
 13 Jan 2014 16:14:44 -0800 (PST)
Received: by 10.194.28.3 with HTTP; Mon, 13 Jan 2014 16:14:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240380>

Hello,

git gui crashes on my Linux machin since I updated it to 1.8.5.2.

I had the message
Error in startup script: unknown option "-stretch"
    while executing
".vpane.lower paneconfigure .vpane.lower.diff -stretch always"
    invoked from within
"if {$use_ttk} {
.vpane.lower pane .vpane.lower.diff -weight 1
.vpane.lower pane .vpane.lower.commarea -weight 0
} else {
.vpane.lower paneconfigure..."
    (file "git/libexec/git-core/git-gui" line 3233)

So, I reverted the change that has been made in git-gui/git-gui.sh
(Diff and Commit Area)

I replaced

${NS}::panedwindow .vpane.lower -orient vertical
${NS}::frame .vpane.lower.commarea
${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height 500
.vpane.lower add .vpane.lower.diff
.vpane.lower add .vpane.lower.commarea
.vpane add .vpane.lower

by

${NS}::frame .vpane.lower -height 300 -width 400
${NS}::frame .vpane.lower.commarea
${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
pack .vpane.lower.diff -fill both -expand 1
pack .vpane.lower.commarea -side bottom -fill x
.vpane add .vpane.lower
if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}

and now, git gui works as expected.

Regards,

Benoit
