From: Markus Hitter <mah@jump-ing.de>
Subject: Binary files in a linear repository
Date: Mon, 2 Nov 2009 16:08:25 +0100
Message-ID: <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 16:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4yc8-0003Ov-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZKBPOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbZKBPOW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:14:22 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:56356 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbZKBPOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:14:21 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2009 10:14:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	mime-version:in-reply-to:references:content-type:message-id:
	content-transfer-encoding:from:subject:date:to; q=dns/txt; s=
	beta; bh=e3kLUIjHOmf1MvjKTTzr6VMDgxQXshdjOvI+4urYRuI=; b=jIaD9Ao
	Vlbqz6yAUszxRfmoQxJ7pgD3QDW05SKXLFN4Y/nJ6BcmzSZcVP1hLGCLIJWCl/1+
	e+4WqK3lZkuSuabuGX1lAEEjEd+FUYv/i+pGS7CC7iyyM6vPgGseTt0R11Y5UFF3
	45htrrqB6v4X0BHRR9TYU7R9idmWXMPjQdAU=
Received: (qmail 17189 invoked from network); 2 Nov 2009 16:07:44 +0100
Received: from unknown (HELO ?10.0.0.50?) (ud03?291p1@95.208.144.124)
  by mail.ud03.udmedia.de with ESMTPA; 2 Nov 2009 16:07:44 +0100
In-Reply-To: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131912>


Hello all,

currently I'm planning a frontend tool which makes use of only a  
small subset of git. The repo's contents is all binary (think of  
pictures). Accordingly, I can't merge in a meaningful way, making  
branches of very limited use.

The situation I'm trying to solve is:

- A revision earlier than the latest one is checked out.

- Files of this earlier commit are modified.

- I want to record this earlier commit along with it's modifications  
as a new commit on top of master, ignoring intermediate commits:

com005  <-- master
com004
com003  <-- HEAD, files modified
com002
com001 (initial commit)

One solution to do this is to move all files somewhere else, check  
out master, deleting all checked out files, placing the moved away  
files back into place and committing the result as com006. Obviously,  
this is a pretty complex operation, just waiting to exploit coding  
mistakes. Additionally, this will be slow.

Now I'm thinking about a much simpler solution: Simply declare the  
current set of files as (a modified) master/com005 and commit them. A  
"cp $GIT_DIR/master $GIT_DIR/HEAD" followed by a commit would do it.

Now my question: Is it safe to tweak the files in $GIT_DIR this way  
or will this corrupt the repository?


Thanks for any opinions,
Markus
