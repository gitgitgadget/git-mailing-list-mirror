From: Alessandro Di Marco <dmr@ethzero.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 23 May 2013 13:58:20 +0200
Message-ID: <87r4gx3o2r.fsf@ethzero.com>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
	<CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 13:58:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfUA6-0006qr-NS
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 13:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab3EWL6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 07:58:22 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:59238 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758307Ab3EWL6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 07:58:21 -0400
Received: by mail-ea0-f181.google.com with SMTP id a11so1796998eae.40
        for <git@vger.kernel.org>; Thu, 23 May 2013 04:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=to:cc:subject:references:from:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=bf+A5Rx+tsS5rXFtUHxUKBtoJXO6wK2MXTBGZWFXbq8=;
        b=YeGxZCQPBNmCHr2tsICROojRLhEATHbBCuNiu6c7oI4CTPItVHldpNo+ewN7g2nIEk
         nZmXWG2KN471YCSaVYvPPxpX8eA7HFx2Skszymjg2SJQpgtn3ue9xF7iKJc23DLtAFD1
         ilBvfp2YDSY2F9Nxi6JGZ8tZ53ZNroM6x0rBYuL4984A4VhZKk0dBGeG3MHGP+lX3fS5
         bxX9m2nZq1FTzMMS8lXjRDKnUllXX4tL4PmuLXk8sL4waNMGpotbPNy8GGTlK6ov7Vd5
         eADauPhPCnLNFoapSI+aM6l7jKG+ChPbBgsXqExqSZPRgsM3mxdZwzIp0Ozo4H2yvLyb
         9Sxg==
X-Received: by 10.14.111.5 with SMTP id v5mr30706084eeg.27.1369310299818;
        Thu, 23 May 2013 04:58:19 -0700 (PDT)
Received: from ethzero.com (2-230-204-72.ip203.fastwebnet.it. [2.230.204.72])
        by mx.google.com with ESMTPSA id w43sm16368676eeg.14.2013.05.23.04.58.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 04:58:18 -0700 (PDT)
In-Reply-To: <CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
	(Antoine Pelisse's message of "Thu, 23 May 2013 11:52:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
X-Gm-Message-State: ALoCoQkZnxGKbD6T5ntG1Cgtni+kSMvZy1qeXaC5gUH9JptPOI7YrM9dxpxDqw2KKaI8tL1EUYXl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225242>

Antoine Pelisse <apelisse@gmail.com> writes:

   On Thu, May 23, 2013 at 10:45 AM, Ramkumar Ramachandra
   <artagnon@gmail.com> wrote:
   > Alessandro Di Marco wrote:
   >> this is a hack I made a couple of years ago in order to store my current
   >> location in git commits (I travel a lot and being able to associate a
   >> place with the commit date helps me to quickly recover what were doing
   >> at that time). Long story short, the screeenshot at
   >> http://tinypic.com/r/wars40/5 shows the new gitk interface once this
   >> patch has been integrated. Geolocation is controlled by two envvars
   >> GIT_AUTHOR_PLACE and COMMITTER_PLACE, respectively. You can set them via
   >> something like this:
   >
   > Obviously very interesting.  Now, how do we mainline (parts of) this
   > feature?  I'll raise some questions here:

   I think it could be nice to provide a simple shell script to build the
   location, callable from a post-commit hook, to construct a
   "geolocation" note. Gitk could be programmed to read the notes to get
   the location, but once again, I'm not sure it should be mainlined.

Well, I don't see how the file can be kept synchronized with the tree,
but in case it would be also suitable for the author/committer name,
email and date :-)

Seriously, this is just a hack; the other nice thing coming out from
this patch is what I called the Project's Patch Graph (or PPG), ie. a
DAG starting from the project founder location and spreading all over
the world (depending on the project of course!) IMHO it's an interesting
snapshot of how the project is evolving.
