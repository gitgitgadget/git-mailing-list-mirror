From: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 09:33:25 -0700
Message-ID: <426532D5.3040306@tupshin.com>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org> <20050419104252.GA28269@abridgegame.org> <Pine.LNX.4.58.0504190749030.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Roundy <droundy@abridgegame.org>, darcs-devel@darcs.net,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:30:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNvc0-00034i-Gm
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDSQdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 12:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDSQdg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 12:33:36 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]:34321
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S261621AbVDSQdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 12:33:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 7F8443A0161;
	Tue, 19 Apr 2005 09:38:43 -0700 (PDT)
Received: from bastard.smallmerchant.com ([127.0.0.1])
	by localhost (mail.smallmerchant.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 23234-02-3; Tue, 19 Apr 2005 09:38:39 -0700 (PDT)
Received: from [172.16.1.197] (unknown [172.16.1.197])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 7BF093A0160;
	Tue, 19 Apr 2005 09:38:39 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504190749030.19286@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at smallmerchant.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>(In other words: if it looks like something a careful human _could_ have
>written, it's certainly ok. But if it looks like something a careful human
>would have used a script to generate 40 entries of, it's bad).
>
>		Linus
>  
>
This is the way that darcs would currently represent a "darcs replace 
foo bar" on 15 files, which is obviously exactly what you are objecting to:
[global foo to bar
tupshin@tupshin.com**20050419155539] {
replace ./dir1/file1 [A-Za-z_0-9] foo bar
replace ./dir1/file2 [A-Za-z_0-9] foo bar
replace ./dir1/file3 [A-Za-z_0-9] foo bar
replace ./dir1/file4 [A-Za-z_0-9] foo bar
replace ./dir1/file5 [A-Za-z_0-9] foo bar
replace ./dir2/file1 [A-Za-z_0-9] foo bar
replace ./dir2/file2 [A-Za-z_0-9] foo bar
replace ./dir2/file3 [A-Za-z_0-9] foo bar
replace ./dir2/file4 [A-Za-z_0-9] foo bar
replace ./dir2/file5 [A-Za-z_0-9] foo bar
replace ./dir3/file1 [A-Za-z_0-9] foo bar
replace ./dir3/file2 [A-Za-z_0-9] foo bar
replace ./dir3/file3 [A-Za-z_0-9] foo bar
replace ./dir3/file4 [A-Za-z_0-9] foo bar
replace ./dir3/file5 [A-Za-z_0-9] foo bar
}

I see two possible complementary ways to address this:
1) allow something akin to the above form in git free-form comments as a 
*technical* solution, while leaving it up to the individual repository 
owner whether to accept such patches on aesthetic grounds.
2) explore adding a different format to darcs that would allow a files 
affected to be represented more compactly.


I suspect that any use of wildcards in a new format would be impossible 
for darcs since it wouldn't allow darcs to construct dependencies, 
though I'll leave it to david to respond to that.

At a minimum, something like:
replace ./dir1/[file1|file2|file3|file4|file5] [A-Za-z_0-9] foo bar
replace ./dir2/[file1|file2|file3|file4|file5] [A-Za-z_0-9] foo bar
replace ./dir3/[file1|file2|file3|file4|file5] [A-Za-z_0-9] foo bar
should be pretty feasible.

I don't believe, however, that it would ever be 100% reliable to try to 
look at a one line replace description and combine it with the actual 
changes and end up with a correct darcs replace patch.

-Tupshin
