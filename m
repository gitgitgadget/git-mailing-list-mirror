From: Jay Soffian <jaysoffian@gmail.com>
Subject: Unexpected error: short SHA1 is ambiguous
Date: Sat, 26 Jun 2010 22:16:42 -0400
Message-ID: <AANLkTikSUBgySbxtKO1iB-GYFgxaL5lY0mfbb5f_xxMS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 27 04:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OShQp-0000Og-Es
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 04:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab0F0CQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 22:16:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53017 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0F0CQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 22:16:43 -0400
Received: by iwn7 with SMTP id 7so20167iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 19:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=TrItShGrTtweCxDu5qLPHxqBTcy/zvgaI9ZK/NLUjzQ=;
        b=uP+0N5db5OHLLrocQa/0/0pYG1KxX5mQnTjSixLoAYeVLLl923kdmxs3mvMASzdRvD
         DJc8BY5Yv/IR5VJl5O8Ja3KsBu7s2mNgRy1OklNe+qAM4B27fBcQgpFJkhyezkLQI5D7
         wbHvOqevG0wEksLabdO9i+7lOdZmHOUDNxqRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OlLUykA5jxPzo8ZAariaUQWPWmhKZ8oCawwCJTYzAXeuHOwYxEuiaLcMOcXg5sOyzt
         XRaeSt1RYqlibRA6G25UePY1SnI7LxlO8/tpEm0UKo0KPNAiHpQvnG/qpxVu0bVvgrE9
         /UvfymggNrYZL/ynv3iyIP+ULKLdGbThg8Ddk=
Received: by 10.231.10.137 with SMTP id p9mr1615097ibp.91.1277605002296; Sat, 
	26 Jun 2010 19:16:42 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Sat, 26 Jun 2010 19:16:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149786>

In my copy of git.git:

$ git rev-list aabb^0 --
error: short SHA1 aabb is ambiguous.
fatal: bad revision 'aabb'

$ git rev-list --all --objects | grep ^aabb
aabb2e515c334cbca9d9ae9873a188cef2c9b3ba
aabb9750fddbc28091c46780ccf7b835b62b04c7 Documentation/hooks.txt
aabb1bcbe2b8ce00ced1a749cbab5c1646e0e1f2 Documentation

So a couple things:

1. Since I restricted to commits with ^0, and there's only one such
commit, shouldn't rev-list give me what I want? (rev-parse similarly
fails).

2. Shouldn't rev-list spit out whatever matches, even if it's
ambiguous? (I can understand that rev-parse wouldn't, but rev-list,
well, I expect a list of SHA1s from it.)

j.
