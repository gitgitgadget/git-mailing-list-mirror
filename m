From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 07:17:35 +0900
Message-ID: <20091215071735.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 23:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJMM-0007ct-Ec
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbZLNWZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 17:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbZLNWZg
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:25:36 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55841 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661AbZLNWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:25:35 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1001211B80E
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 16:25:35 -0600 (CST)
Received: from 5408.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id Z4JE3JD6T2P8
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 16:25:35 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jjw46ywIaeoLJSBi4CTOoiG53PjtlIXp5YdlI7L6UD6kOctiP9W6vO7fnBmK4UI1Crkv30vM9xKlINXy0DAl48w0DuIQ9I2DM9QhLRFpENTQa0eV6TL15h1xpqK2bxJD41e/x3bh11Z1UPzfTRpNQIRbrekJq9phsWc+3GVmVN8=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135250>

Some text documents in my repository is encoded in EUC-JP 
and I have this line in my .gitattributes file.

	*.txt	diff=eucjp

and these two lines in my .git/config file.

	[diff "eucjp"]
		textconv = nkf-w

And I have ~/bin/nkf-w script that is executable.

	#!/bin/sh
	nkf -w "$@"

The command takes a (Japanese) text file and converts it 
into UTF-8 (it guesses the input encoding).

I need this extra script because setting 'nkf -w' for
textconv like this

	[diff "eucjp"]
		textconv = nkf -w

gives an error.

	% diff --git a/hello.txt b/hello.txt
	index 696acd7..f07aa1a 100644
	error: cannot run nkf -w: No such file or directory
	error: error running textconv command 'nkf -w'
	fatal: unable to read files to diff

Could you fix textconv so that it can be given parameters?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
