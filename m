From: Duy Nguyen <pclouds@gmail.com>
Subject: About refs refs/heads/+...
Date: Sun, 21 Dec 2014 17:58:13 +0700
Message-ID: <CACsJy8B8wVKAoqaKJxuyWbyDbFEofwctyfQoU=A0S_yUMc8bgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 11:58:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2eDp-0006mx-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 11:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbaLUK6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 05:58:45 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60765 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaLUK6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 05:58:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so2921313iec.5
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rzhOBx14RjOhJMBqGFiC22yY3S+iRbDnXAg2AJ7eCoo=;
        b=n78pNCzAj0WKzZNYB0och6OgOAsdI7CE+2UC2l75p/qxueE/2MZtvVMgjqEefbH+bI
         QwZXN4ZOwahUTnXnUoUXEt8GXbcYbMx5riYkaf1unVlB9HZt7XuKvNCJmROxJ6dveVzl
         nnKTtGMyJ+fpTGs7IL+bbIYVqQU+eCc0xxw+mc+xmZXWAh3dYyC6na59Q0bQU1Xr7BIT
         jziJ/kxCUxAHMHOMnkVUe6jY5MMvZhDetWEdHTHlkSijcHyHDT0uxldpHVO0qNvaX/1V
         4EQNg1tl4NJH00W3YrA9cMeulebsGAbk1P0S/cLDUkdKpj7dANDgO/SLLiLrV9qi3eDG
         M38g==
X-Received: by 10.50.79.202 with SMTP id l10mr11305017igx.24.1419159523962;
 Sun, 21 Dec 2014 02:58:43 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sun, 21 Dec 2014 02:58:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261612>

I accidentally created a branch whose name starts with  "+".
Everything went ok until I pushed it  because "+" is interpreted as
forced refspec (e.g. "git push somewhere +wip"). Using full ref names
would avoid ambiguity. The corner case of this is where the branch
name is simply "+". Then refspec "+:" will be interpreted completely
different from what the user wants. I wonder if we could do something
better:

 - forbid "/+" in ref names (too strong?)
 - some heuristics to detect "+:" and refuse it if ref "+" exists.
heuristics to hint the user about full ref name after we fail to match
refspec because we misinterpret "+"
 - improve refspec matching code to detect ambiguation and force using
full ref name.
-- 
Duy
