From: Johannes Sixt <j.sixt@viscovery.net>
Subject: gitk's back button broken (Refactor per-line part of getblobdiffline
 and its support)
Date: Mon, 16 Dec 2013 14:56:24 +0100
Message-ID: <52AF0688.3070104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 16 14:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsYew-0003eN-TR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 14:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab3LPN4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 08:56:30 -0500
Received: from so.liwest.at ([212.33.55.18]:34044 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab3LPN43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 08:56:29 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VsYen-0001xn-69; Mon, 16 Dec 2013 14:56:25 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E717416613;
	Mon, 16 Dec 2013 14:56:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239336>

To reproduce, start gitk in any repository, click a commit, then the
"back" button (left-pointing arrow button) or type Alt+Cursor-Left. The
error I get is this:

can't use non-numeric string as operand of "!"
can't use non-numeric string as operand of "!"
    while executing
"if {!$ateof} {
	set nlines [expr {[winfo height $ctext]
			  / [font metrics textfont -linespace]}]
	if {[$ctext compare "$target_scrollpos + $nlines ..."
    (procedure "maybe_scroll_ctext" line 5)
    invoked from within
"maybe_scroll_ctext ateof"
    (procedure "blobdiffmaybeseehere" line 6)
    invoked from within
"blobdiffmaybeseehere [eof $bdf]"
    (procedure "getblobdiffline" line 15)
    invoked from within
"getblobdiffline filef5ec60 5de460a2cfdd4acbadd41355a5b34dc69e93b89e"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)

After dismissing the error, gitk is still responsive, but does not show
diffs anymore.

The error bisects to 5de460a2c (gitk: Refactor per-line part of
getblobdiffline and its support) which is already merged downstream into git.

Could you please have a look?

-- Hannes
