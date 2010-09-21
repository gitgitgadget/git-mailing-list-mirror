From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: more useful set-upstream
Date: Tue, 21 Sep 2010 18:55:08 +1000
Message-ID: <AANLkTi=c51u=pQ3TLt3YE54mbwy8AqRb2rcsatEVo2U5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 10:55:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxydW-0000v6-2t
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 10:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab0IUIzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 04:55:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34028 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab0IUIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 04:55:31 -0400
Received: by vws3 with SMTP id 3so4162791vws.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=xGuoLyhdYdGH4fGJdfGupPTbGXkBXf0uE3kGgMG8EXQ=;
        b=ST23UX5PsI2DpQwnpdN0b/MmqQaB8gLn3bcNiY1kX4LpWrdlCWrtccN5piZrKeA6z7
         ppt0YOnjrqV7TKQN5XqCsKKo99tYmxZcIuHwm/glFoaXGTSWHVbbrHSZZLUrI1D4LJpC
         IoN7cR42GNhwew46/3FLa3gc4s0yvAQt4z5Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=NI4ei1gEBZZnW/GLTNSph88z+UgcwgQNZnUPUV8D8RFd+SkJ3lviF35VS8o/r+ANZ1
         rIGZi8TRfGuLdgqoddOf9zuIq24H6UldQUdQM3f4vZakKN3lp/OGCJdkE6kswvGmbMVM
         y9QoUp09aQ1eOz02AgP6/zt2VwxFNxQfFrSoU=
Received: by 10.220.63.139 with SMTP id b11mr4954901vci.235.1285059330590;
 Tue, 21 Sep 2010 01:55:30 -0700 (PDT)
Received: by 10.220.181.65 with HTTP; Tue, 21 Sep 2010 01:55:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156698>

Is there a better way to achieve the functionality of this alias?

  set-upstream = "!sh -c 'current=$(git symbolic-ref HEAD); git branch
\"$current\" --set-upstream \"$1\"/$(basename $current)' -"

(forgive me if stupid gmail word wrapped that line)

This allows me to write

$ git set-upstream origin

instead of

$ git branch <current branch> --set-upstream origin/<current branch>

which is a pain to write for several reasons: I have to remember the current
branch name, that name might be long, and shell autocomplete doesn't know
about --set-upstream yet so won't complete the second occurrence.

Having a dedicated script (or git command) rather than an alias would allow
greater functionality like:
 - automatically pick the remote name if there's only one remote,
 - a flag to automatically set upstream on all branches (that having
   matching remotes)

I don't understand why all my branches haven't automatically had the right
upstream set anyway - am I missing some configuration of pull and push?
