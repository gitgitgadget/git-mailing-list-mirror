From: Gavin Beatty <gavinbeatty@gmail.com>
Subject: Problem creating commits/trees with commit-tree/mktree
Date: Mon, 11 Jan 2010 19:14:46 +0100
Message-ID: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 19:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUOnR-0007mv-07
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 19:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0AKSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 13:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448Ab0AKSPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 13:15:09 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:35752 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0AKSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 13:15:08 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1906991eye.19
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=mH46+TUWQgVg67HwqnVA5qvbvOApapNFrN6iWcm+kzY=;
        b=aGKoZQex6JA+TOqVNxgegN8RaWa5nLzoTsv2yo6uqoOCZgq6ToCGF5htFqLiNvjov4
         ibMXWpz6gBFp/XaCd6+yeedPLuFnjHQOQdEuDc+53fF735u/a3kSWBLT+8Ri3HT1/GWB
         7up4Dklqxl6zLYdGdNj1DLfAwkTGQM/49OdN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Sb2U2KaN98Pk+6mEeuIRmMURHWsDYeuo9wmxo8elv3INGbFsUrO49ymMxzskkI7yyN
         x3ylr9VTIhiGGcu2m08JkWem8LiG6IvDVlg3uvFzibtr1Vj65DD/K/+5VgQJCqJYhChV
         bNpQZgUiX8ti2aXuFNlmaGQlPnPbbZct9La1U=
Received: by 10.213.103.83 with SMTP id j19mr3735702ebo.30.1263233706801; Mon, 
	11 Jan 2010 10:15:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136649>

Hello,

I want to write commits to a branch without touching the index or
having a checkout (for a git subcommand I'm writing).

I can create new blobs and trees but can't figure out how to commit a
new tree/blob _with_ the old tree.

Currently, I do something a lot like:

objsha=$(echo 'contents' | git hash-object -w --stdin)
objtreesha=$(printf "100644 blob $objsha\tfile.txt\000" | git mktree -z)
newtreesha=$(printf "040000 tree $objtreesha\ttreefileisin\000" | git mktree -z)
echo 'commit msg' | git commit-tree $newtreesha -p $(git rev-parse
refs/heads/new)

I get a commit with treefileisin/file.txt. I haven't included the
other trees/files so they are gone in this commit. How do I include
them? Is commit-tree the wrong tool?

Is there some way to use git ls-tree that I don't know about?

Gavin

-- 
Gavin Beatty

SEMPER UBI SUB UBI
