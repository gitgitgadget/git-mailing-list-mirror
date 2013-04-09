From: Oj W <ojwlists@gmail.com>
Subject: gitweb commitdiff page - binary files with ampersands in filename?
Date: Tue, 9 Apr 2013 18:03:33 +0100
Message-ID: <CAKzCUUH4m8Hn_zcE_eHB9YBjDQWPAiX17HCOVZ80f+Tx5EVdOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 19:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbxK-0003LB-O2
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3DIRDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:03:34 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:56425 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab3DIRDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:03:33 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so6371497iaa.7
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=eJOAhKUdeQu4H0i7ENkAGvDLu765C1NWWeIeuPZqFf4=;
        b=HMtyRgBEmDwHBob66UhYR8vL/lmBUSOdeFEXwEnleiWk6szTR12lcrlW6iqnzV5yzM
         JfYc3Z/ABxfk4BXq+hiWXsW8QwAwprnP1jmRlan2sCFWocqE9nGdLsYWhoAZHyEiWZce
         oTtFqLD2RBJ8v/5ypjs+Gad+vslTjHBlNOyGl+IO11eTf5/YG2Pys9hmZOmsm3JnKdSX
         aGrx8H4iQd1WqFMuaVZbMkQxoHTg01DhwLdyfynEQJNzuFzEIyihNN/hlBTb2/2jXnyX
         fnOjW8FPha7yk/gO6+k4VI3D045fYon0lQ7hW9C0RkDIyP4LQz4xflc89EVmjiWAgk7Y
         rOYA==
X-Received: by 10.50.140.5 with SMTP id rc5mr10782897igb.78.1365527013254;
 Tue, 09 Apr 2013 10:03:33 -0700 (PDT)
Received: by 10.64.129.168 with HTTP; Tue, 9 Apr 2013 10:03:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220587>

Change a binary file whose filename contains an ampersand, then view
the commitdiff page in gitweb.

Git outputs a message like "Binary files a/b&w.dll and b/b&w.dll differ"

Gitweb format_diff_from_to_header() doesn't notice anything in that
output which needs escaping, and writes it directly to the XHTML 1.0
Strict output.

Then gitweb's output is invalid XML, meaning that browsers such as
Firefox will refuse to display the page.

(tested with v 1.7.9.5, but I can't see anything in latest
https://github.com/git/git/blob/master/gitweb/gitweb.perl#CL2158 which
is looking for text like "Binary files ... differ")
