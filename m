From: Jason Paller-Rzepka <jasonpr@google.com>
Subject: Multiple fetches when unshallowing a shallow clone
Date: Mon, 30 Nov 2015 14:35:04 -0500
Message-ID: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 20:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UED-00060N-U5
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbbK3TfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:35:07 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37758 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbK3TfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:35:06 -0500
Received: by igcto18 with SMTP id to18so78946512igc.0
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mOC0uIobhTAr+ITt7ikVGI8jEdfRIO9SUjXugbXQy4Q=;
        b=pWAlZw459KvMEKzHzx1sK1uD9U1xiJmxqOZDyX8EuF119nPBsTZRQq7m/5587EeaPv
         tgXBGWfBdZhzDwvdVuByPTThqMFHVfbJDxdQ8YncggPRpL9TcL7WkPP5TuB6LRvlZ5Xq
         NUIK3J7TJ8YYN7zzelXdf7seMqbOMpt6pJvxv06AiG0D9VkiIufi+mzVyu7u6+W3M4OU
         cwxsl93GWx+YdA7SwB4+51usAMJccoA1PiH1B1sG3fU0hkkz96dutIfhNx6Mqj2aTa8V
         ITblA4oL43LJm/qCOR9SOyoDLHqJ3PHpA/dhDZRd6UQouk8s12noBrf5Y1zK0PwBrRo1
         iSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=mOC0uIobhTAr+ITt7ikVGI8jEdfRIO9SUjXugbXQy4Q=;
        b=HWcz9/IRXlmlhczmFfUW2wrTjy9peZpnntBvrnOOFaZdhHgfQPh+GoQexrCGbgwZ+N
         LHQwiyaqu9/Gzs/jMTboKLEx7q5Z23gMELykObFsoA72PG6KEzlQPl0ZHAzU0oqJ2eSF
         RL1XTCLl9k2dG07KBuT1Ga346MJ9LUzaQK2z96oKfzp5NlxWzBgOK3Wn7/n3ON6rEuJ9
         OmaCVPPPqYWcKd9IR25YQX5vbFUQ5nxtdof+OGY6KOqTaj2TM7iJu3VgX+QcTmtUNWPd
         AlKGuKbIHld9Qx6Z9XhV5xwG3SCtG54TzJgpgFpvi+ADXkNskMWhxfdf0f9GZMQr7y6M
         NDJg==
X-Gm-Message-State: ALoCoQlVp2+LMwIXn5DEkmm13A8XZFOrP7vYCq6Myv0ifDGcv8lNAK4hAW9viVpyZWrHAQJtk3nL
X-Received: by 10.50.150.37 with SMTP id uf5mr24045454igb.10.1448912104920;
 Mon, 30 Nov 2015 11:35:04 -0800 (PST)
Received: by 10.36.19.74 with HTTP; Mon, 30 Nov 2015 11:35:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281818>

Hi all,

Would anyone be willing to help me understand some shallow-clone
behavior?  (I found a bug in Dulwich, and I'm looking for some context
so I can determine how to fix it.)

I learned that cgit sometimes performs two fetches for a `git fetch
--unshallow`: one with depth 'infinity', and a subsequent one with
depth zero.

Could anyone answer:
1) What is the purpose of the second fetch?
2) What does this depth of zero mean? Is it the same as a depth of
infinity?  (I assume not... but, since I thought the smallest
meaningful depth was 1, I don't know what else it might mean.)

Thank you!
Jason
