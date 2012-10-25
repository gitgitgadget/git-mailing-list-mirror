From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Where should git-prompt.sh be installed?
Date: Wed, 24 Oct 2012 17:51:06 -0700
Message-ID: <20121025005106.GA9112@elie.Belkin>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Danny Yates <mail4danny@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 02:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRBfT-0000LE-KE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 02:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab2JYAvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 20:51:15 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51008 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2JYAvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 20:51:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so746677pad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/uZCqYVpQh2zg5UGCzWc5q5NZQYC9KErNwKopnH8+Yo=;
        b=QK+uGqnPA/9OXXi3JbvhyuZ7Fcb+Ek2O0qbxBYaNDZN2WE9TFL41hUTJp3XxUvK0dd
         D2gNabDatq46O0/xT/ELnWZ9yoPBbelpwUYVecVw+tQ97NGJYSJW/cHknGQ3loZtg5wJ
         wFBCtxUb6HOu3KdbrN3U2cirCcj+71QD8zhz77fwVPRZH0nkG8cwIkGbV0UjEh44lkDH
         suLfYhKfhtRrbVVnUiXUu0Z+az7UZ3QgcgbRKywYMOKQcnHc3qkSfLwcPC4sh9ArlGEZ
         FG6qpSTK3J9QMzIt77e0tri2L6P8FpTsY2FQqNIk+Cau+BKOKRf1SmLdqaNPpYUr7EBw
         sTuw==
Received: by 10.66.86.42 with SMTP id m10mr49006580paz.3.1351126274279;
        Wed, 24 Oct 2012 17:51:14 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id f2sm10298133paz.25.2012.10.24.17.51.12
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 17:51:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208329>

Hi,

In olden days the admin would copy contrib/completion/git-completion.sh
to

        /etc/bash_completion.d/git

and mortals could source /etc/bash_completion or
/etc/bash_completion.d/git in their ~/.bashrc (possibly shared among
multiple machines) so that the bash completion and __git_ps1 helpers
could work.

With Git 1.7.12 __git_ps1 has been split into a separate file, to help
users who only want __git_ps1 to avoid the overhead of loading the
entire completion script (and allow the completion script to be loaded
by bash-completion magic on the fly!).  Now the sysadmin should copy
contrib/completion/git-completion.sh to

	/usr/share/bash-completion/completions/git

and contrib/completion/git-prompt.sh to

	/usr/share/git-core/contrib/?? (somewhere?)

Mortals source /etc/bash_completion in their ~/.bashrc (possibly
shared among multiple machines) and expect bash completion to work.
For __git_ps1, users should source that ?? path.

Questions:

 1) what path is appropriate for ?? above?
 2) is this documented anywhere?

Possible answers:

 1) Fedora uses /etc/profile.d/git-prompt.sh.  Gentoo uses
    /usr/share/bash-completion/git-prompt.  Maybe others use
    some other path.

 2) The scripts themselves suggest copying to ~/.git-completion.sh
    and ~/.git-prompt.sh.

Proposal:

  1) /usr/lib/git-core/git-sh-prompt
  2) git-sh-prompt(1)

Sensible?

Thanks,
Jonathan
