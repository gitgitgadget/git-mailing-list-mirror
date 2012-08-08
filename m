From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Wed, 08 Aug 2012 07:32:04 +0200
Organization: Debian
Message-ID: <5021F9D4.1010700@debian.org>
References: <1343856397-6536-1-git-send-email-robert@debian.org> <20120802104421.GA13271@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 07:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyyyV-0005US-OU
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 07:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab2HHFi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 01:38:26 -0400
Received: from master.debian.org ([70.103.162.29]:48279 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab2HHFiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 01:38:25 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1SyyyO-0004zj-Hl; Wed, 08 Aug 2012 05:38:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id B26C6E41C5;
	Wed,  8 Aug 2012 07:32:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.5) Gecko/20120624 Icedove/10.0.5
In-Reply-To: <20120802104421.GA13271@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203062>

Eric Wong wrote:

Hi,

> 
> A few minor comments inline...
> Please ensure all error messages and code are readable in
> 80-column terminals.
> Also, keep opening "{" on the same line as the if/unless.
> Backticks don't nest properly, nowadays, we prefer:
> 	N=$(expr $N + 1)
>> +		cp auto_updated_file auto_updated_file_saved
> Need "&&" to check for failure on cp
>> +		sed -i 1d auto_updated_file && git commit -am "commit change $N.3" &&
> I don't believe "sed -i" is portable enough for this test.


Many thanks for the comments! I've fixed all of the above and will send
updated patch in next e-mail. Please let me know if you have any further
comments.



>> +		echo "PATH=\"$PATH\"; export PATH" >> $hook
>> +		echo "svnconf=\"$svnconf\"" >> $hook
>> +		cat >> "$hook" <<- 'EOF2'
>> +			cd work-auto-commits.svn
>> +			svn up --config-dir "$svnconf"
> 
> That doesn't seem to interact well with users who depend on
> svn_cmd pointing to something non-standard.  Not sure
> what to do about it, though....

I have no idea how to change it either. I've tried to source the
lib-git-svn.sh file inside the hook, but it sources test-lib.sh, and the
latter script doesn't work well if it is sourced by non-test script.
Anyway I the part of my original patch unchanged.

Regards,
robert
