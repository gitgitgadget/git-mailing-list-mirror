From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Tue, 11 Aug 2009 23:14:26 -0400
Message-ID: <1250046867-13655-1-git-send-email-adambrewster@gmail.com>
References: <20090810083234.GA8698@dcvr.yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 05:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb4Ix-0003Pg-J6
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 05:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbZHLDO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 23:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbZHLDO7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 23:14:59 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:57619 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZHLDO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 23:14:58 -0400
Received: by qyk34 with SMTP id 34so3633258qyk.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=BG4EW4B41PsEvIxHMHgqbNwjKGalsRII7PHfaGG8kc4=;
        b=UmF9rF76iFC5xic0/6AxIQB0DADqhuSa3dKuEhuWHRZzqKs3024MYut1OYm9X+j8+W
         LlNArWnAUEmHyrBFXspol/UQcPHzjBwCzYZDj/l8CgvHb4kpIS3tqY10+63FveKBkT+8
         1sxJeTLfWim9YCepBQKNd+7SjPLB6vqEL+FMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fe9H9/p89axfDTl4noUJvAmoZ6it9ghyYxtbaEa7M22cvkM7q1bvIwJ+L2EYWdRlCY
         uwmQ5AqYhQR6jO6Fz5euUqt5NE5OC3BstLanbSOKFxmEkxFny15+5bdPbREtLIQ5wVMQ
         puelhzDwvIvnk/npj5LtyEE4ahi2m/zmNJr34=
Received: by 10.224.6.66 with SMTP id 2mr4483723qay.137.1250046899489;
        Tue, 11 Aug 2009 20:14:59 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 6sm349329qwd.18.2009.08.11.20.14.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 20:14:58 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id D50FF104911; Tue, 11 Aug 2009 23:14:27 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <20090810083234.GA8698@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125650>

Eric,

Any thoughts on the other patch?

Am I close or is there a better way to go about this?

I didn't really know what to do with .git/svn/*.  The easy answer is

  mkdir -p $GIT_DIR/svn/refs/remotes &&
  mv $GIT_DIR/svn/* $GIT_DIR/svn/refs/remotes

>From the comments in the Migration module, it seems like that's frowned
upon, so I came up with looking for .rev_map (or .rev_db) in both
locations (.git/svn/git-svn and .git/svn/refs/remotes/svn) and letting
it stay in whichever location it already exists.  (The next email has a
slightly improved version of the patch.)

This solution is particularly inelegant in it's handling of
unhandled.log, but as far as I know that file is unused.

There's also the problem of what to do if someone has a ref called
ref/remotes/refs/remotes/..., but that seems unlikely enough to not
cause concern.

Adam
