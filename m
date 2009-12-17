From: Jay Soffian <jaysoffian@gmail.com>
Subject: diff attribute ignored by show and log -p
Date: Wed, 16 Dec 2009 23:46:56 -0500
Message-ID: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 05:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL8Hn-0002Uy-G5
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 05:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936746AbZLQErT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 23:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936748AbZLQErK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 23:47:10 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:63971 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936746AbZLQEq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 23:46:56 -0500
Received: by iwn1 with SMTP id 1so1224193iwn.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 20:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=6XyPABTnKFeyXWcUHtV0JeU7W66q45i2V4qGIPH1Cpw=;
        b=Av++oSRfhO9qE4rDgt2pbCcwy2vQGZkbwP/Mo/y7pDsJHeQUrV6hgxqa7pNrqD4luT
         jwU25LI1ylsqLMloX4qjqzJvnQXrtblFknTkOpHRthws9kqAEXq9gNVqE3UPfFCgMGFE
         r5K1dpR3ndI0T2r0emjjS+3XTZJBgxLzKV+H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fGyl6VKpCZepk1gfNCtd5BO19rF9ZN6bdNax+R5sXU1UoQhBFJdVU8Kd1nZGDvtZY/
         UwK+5nh3aAcziF3SRKrkqEI16VUuKAp8bl/sSMMlHfjXQeSJBUTcriNyFC+qWpqQqP1H
         9pNzTPkO0pSghCz0d0yuBZblLBqg0jz0deZaI=
Received: by 10.231.9.33 with SMTP id j33mr1873649ibj.37.1261025216128; Wed, 
	16 Dec 2009 20:46:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135356>

% cat .git/info/attributes
*.xib diff=xibdiff
% cat $(git config diff.xibdiff.command)
#!/bin/sh
trap "rm -f \"$2.tmp\" \"$5.tmp\"" 0 1 2 3 15
ibtool --all "$2" > "$2".tmp
ibtool --all "$5" > "$5".tmp
colordiff -u "$2.tmp" "$5.tmp"

Works great for things like:

% git diff <commit1> <commit2> -- /path/to/*.xib

But is apparently ignored by "git log -p" and "git show" which just
use internal diff. Is this behavior intentional?

j.
