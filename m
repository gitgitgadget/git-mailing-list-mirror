From: Dave Abrahams <dave@boostpro.com>
Subject: fast-import bug?
Date: Fri, 21 Jun 2013 02:21:47 -0700
Message-ID: <m2zjuj2504.fsf@cube.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 11:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpxXb-0004Gz-Ox
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 11:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999Ab3FUJVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 05:21:55 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:44671 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3FUJVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 05:21:54 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so1974492ghb.41
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type:x-gm-message-state;
        bh=jdMxmCfUtuUx7MOM0RLqX0tJEJBx50XJsUw0tPqsbd4=;
        b=mLDmUe21Q51SDxj/iFmCyfKOxmPY2QEcFb0SCgrYSYAE0m2yrdoXsoUOQ52V0Txm+L
         +X907AKVgoNYfabct3u1tIYx3pQL5r39PBjrJ0ILwpjfFRzWPo4CwyANM377I405vxUq
         QllBx24u0NLYjiViesqUJN2ryiP/ZTRM5Du+dPzbb9jmybcRBnTTRRY9daOAH97g1G30
         OyuTJOvJsVA2ubs/rbGoO1hWGfndmfgy+rQIVsCzB6A8G4klWYPxViGB5W9hwQdGi/yu
         4jbAKmW5pjVY7zx/wcdzZ7J4p3G51A+pP4o/F5nL1i+ALVqoNl7Dc9rizTPXCx3xJTv6
         MNRw==
X-Received: by 10.236.151.129 with SMTP id b1mr6949771yhk.253.1371806514036;
        Fri, 21 Jun 2013 02:21:54 -0700 (PDT)
Received: from pluto.boostpro.com (107-219-149-247.lightspeed.sntcca.sbcglobal.net. [107.219.149.247])
        by mx.google.com with ESMTPSA id l39sm6894513yhn.26.2013.06.21.02.21.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 02:21:53 -0700 (PDT)
Received: by pluto.boostpro.com (Postfix, from userid 501)
	id CC37C250707C; Fri, 21 Jun 2013 02:21:47 -0700 (PDT)
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.2.93 (darwin)
X-Gm-Message-State: ALoCoQkqqwN9u0+ta6PtM6iZT6jcY1hNkQ4IG2Q/oDwCGL2hM9vK+rftdkxj+STO7XQlrgpA0ssz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228586>


The docs for fast-import seem to imply that I can use "ls" to get the
SHA1 of a commit for which I have a mark:

       Reading from a named tree
           The <dataref> can be a mark reference (:<idnum>) or the full 40-byte
           SHA-1 of a Git tag, commit, or tree object, preexisting or waiting to
           be written. The path is relative to the top level of the tree named by
           <dataref>.

                       'ls' SP <dataref> SP <path> LF

       See filemodify above for a detailed description of <path>.

       Output uses the same format as git ls-tree <tree> -- <path>:

           <mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF

       The <dataref> represents the blob, tree, or commit object at <path> and
                                                   ^^^^^^
       can be used in later cat-blob, filemodify, or ls commands.

but I can't get it to work.  It's not entirely clear it's supposed to
work.  What path would I pass?  Passing an empty path simply causes git
to report "missing ".

TIA,
Dave

-- 
Dave Abrahams
