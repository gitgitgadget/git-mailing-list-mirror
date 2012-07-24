From: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
Subject: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Tue, 24 Jul 2012 12:01:30 -0700
Message-ID: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 21:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StkMU-0006A7-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab2GXTBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:01:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33359 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2GXTBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:01:32 -0400
Received: by pbbrp8 with SMTP id rp8so31921pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        bh=vYQaBPejWMJW/bLF3b6vinTWHmrUIUEZxoK7s57sKu8=;
        b=YYiIjXR60Ayy6fD4Fg8+vWsnG35D3uQt8iIjQVKAcaZUpLJCJs5gUBfLkd+t68u/hs
         DcIqr5QwaJ5iTEYNiz//wQq+RqKaokNPPXNXHcBXtweNqGoaGD9LX4CFf9Y6VctTMkwy
         m3l6GTZjIJDYVt5jvGc1FhgLxFRMcYmA/bOij0YIzUzrZ5Xvwe6NzkcNsC6hISdZJNwb
         ubt76NsVJcQRZRTrGxbVHMNiebWEQxjKIYk6yj9p36hKN8Cs6B9ZskABSjhxavbqGFu4
         J7h5h8WkX/Vpq47tkz3f2WFXdpg3u2r8UYQevsSBYEcqR2/Aqaw877TfwhSgRXFQJTh5
         VpEg==
Received: by 10.68.125.228 with SMTP id mt4mr46815371pbb.21.1343156492386;
        Tue, 24 Jul 2012 12:01:32 -0700 (PDT)
Received: from [10.168.1.100] (c-24-16-145-254.hsd1.wa.comcast.net. [24.16.145.254])
        by mx.google.com with ESMTPS id ru10sm12670808pbc.50.2012.07.24.12.01.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:01:31 -0700 (PDT)
X-Mailer: sparrow 1.6.2 (build 1143.6)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202053>

This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git-33) and 1.7.11.3.

Steps:
 1. Create or clone a repository to an absolute path that contains spaces.
 2. Add a submodule to the repository, if it does not already have one.
 3. Within that submodule, attempt to add another submodule.

The result is an error "fatal: Not a git repository", followed by the relative path to the submodule directory within .git/modules of the top-level repository.

Similarly, using "git submodule update --init --recursive" in a freshly-cloned repository that matches the above configuration will fail with the same error. "git clone --recursive" does not seem to suffer from the same problem at clone time, but will still fail to add recursive submodules.

-- 
Justin Spahr-Summers
