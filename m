From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Finding leaf nodes.
Date: Mon, 13 Apr 2015 12:32:05 -0400
Organization: PD Inc
Message-ID: <4657569730954D20A9498BDCA66E1C30@black>
References: <038FFBDD688D4EC6B0B42A339DF246B0@black> <552BD154.6040609@drmicha.warpmail.net>
Reply-To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	  <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "'Michael J Gruber'" <git@drmicha.warpmail.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhhHW-0001uE-8D
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 18:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbbDMQcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 12:32:13 -0400
Received: from mail.pdinc.us ([67.90.184.27]:45888 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455AbbDMQcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 12:32:11 -0400
Received: from black (112.sub-174-236-193.myvzw.com [174.236.193.112])
	(authenticated bits=0)
	by mail.pdinc.us (8.14.4/8.12.11) with ESMTP id t3DGW624019092;
	Mon, 13 Apr 2015 12:32:06 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdB19Wg8eYuohi00T26eSQ34gx7K9AADfa7Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <552BD154.6040609@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267094>

> -----Original Message-----
> From: Michael J Gruber 
> Sent: Monday, April 13, 2015 10:23
> 
> Jason Pyeron venit, vidit, dixit 12.04.2015 06:04:
> > I am trying to find all the unmerged commits [5].
> 
> "Unmerged" to which branch?

All. I was atempting to describe a leaf node.

> 
> It's not clear to me which commits you are looking for. By 
> "leaf node" I
> would describe a commit without child commits. "unmerged" can only be

That is exactly what I meant.

> understood relative to a specific branch.
> 
> Maybe you are looking for commits from remote refs which are 
> not on any
> local branch?

Anywhere, that I know about. If the commit does not have a child, then that commit needs to be in the list, I do not care about the branches.

> 
> > I can find, as a human, all the commits by git log 
> --oneline --graph --all [1] but I am looking for a scripted way.
> > 
> > But git show-branch  -a --independent misses some [2]
> 
> This finds refs which are not "contained in" (can be reached from) any
> of the other refs. If a remote ref is contained in another 
> remore ref it
> is not listed.

Your description is logical, but how can a commit be included in "another remote ref"?

> 
> > find .git/refs/ -type f -exec cat '{}' ';' | sort -u; finds 
> too much [3].
> 
> This finds all refs.

I know, the issue is I do not know how to filter it.

> 
> > The closest I get is with refs=`git show-ref -s`; git log 
> --format=%H $refs --not $(echo "$refs" | sed 's/$/^/') but it 
> too [4] gives me extra, but I am really not sure why. 
> 
> This finds all commits which are on some ref (branch/tag/..), 
> excluding
> those which are next to the tip or higher up from those refs.
> 
> > 
> > * | a54a4fb 
> > * | a0d2e63 
> > * | dd4400d 
> > | | *   68ea2c8
> > | | |\
> > | |/ /
> > |/| |
> > | | * c74d3c5 ??? Why is this the only extra commit listed ???
> 
> Because it is not "next to the tip", more specifically: not a first
> parent (foo^) of a referenced commit, and neither a 
> predecessor of one.

I need to think on what you just said for this one.

> 
> > | |/
> > |/|
> > * | 9c87570 
> > * | 717e33d 
> > * | 159799f 
> > 
> > 
> > What should I do to automate this?
> > 
> 
> Please try and restate what you mean by "unmerged commits". 
> Maybe remote
> commits not on any local branch, or remote commits not on master?

Regardless of branch references, I need to list all commits which do not have any child commits.

> 
> > 
> > 
> > 1:

See: yellow lines at http://client.pdinc.us/git-leaf-nodes-334e98c075877ce78b1ef959cb1155f7.html

> > 
> > 2:
> > 4d0579c438e9d750f158124284bd740a5a0e0e26
> > 68ea2c83978a7c023d76ebe438dd7d98fb1fd074
> > 982243cfde0dc6dfb1733d8e95748b7e687f57b8
> > C4bc3c4eb0015c73b50ea280a4a380e3cffc5160
> > 
> > 3:
> > 00ea00e8e6a23a4243316f860aa07ed59203ab97
> > 144eb9f673f14010c600766762b99cba1a64cc6e
> > 2250af4ad29b92b07365320c5ccb7a22c17f588e
> > 26bdfdfe71f7ceb4e0954bc5ab6c198481a280ae
> > 283be0f77477fcd8c8bc878c602538f8a3451403
> > 2f47330df8fb0357ef4e4d605d5c402150892a18
> > 3ec60ab0dbdc63760429187605ede4549d7b2bad
> > 43813b0fc44f7c41d2cdd4573145dbeb1aae1aee
> > 4d5b52d440d3a64953a6d7ef3cbb81c8d289e392
> > 556a5c2d759b51080e3bfe07a89b67e927749328
> > 6fe0b6db2718625e5eeb3cbadeb58aa858ab4f1b
> > 717e33d67ad3297a15cb432d3f70f7c12d353fa3
> > 7587a45658aa689cc774d7253007be3feb2eec23
> > ad9b5fa90c8f52b3ca31dd433c2c4b408e5f2a8f
> > b3d7623b74dd75cc4f965d6b37dc461d2786f912
> > c19fc45c87de85122952d63d28a0c7d3a18b79d5
> > e8529e95d89d3f519a31ef7de5bd7f0d0d318e8c
> > f2e86371e7fe3391023adccd61856d088db773dd
> > fceca0050ceee8c4996a5740f7122e96c4948dd8
> > 
> > 4:
> > c74d3c5cda60d8be7f38f1ec89c554a1346d57f8
> > 
> > 5: My remotes:
> > https://github.com/CipherShed/CipherShed.git
> > https://github.com/pdinc-oss/CipherShed.git
> > https://github.com/discnl/CipherShed.git
> > https://github.com/eaglgenes101/CipherShed.git
> > https://github.com/erkinalp/CipherShed.git
> > https://github.com/GigabyteProductions/CipherShed.git
> > https://github.com/jeffallen/CipherShed.git
> > https://github.com/kaydiechii/CipherShed.git
> > https://github.com/srguglielmo/CipherShed.git

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
