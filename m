From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/14] revert: Don't create invalid replay_opts in
 parse_args
Date: Wed, 6 Jul 2011 04:20:09 -0500
Message-ID: <20110706092009.GF15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOHN-0007p5-Tp
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab1GFJUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 05:20:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55151 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1GFJUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 05:20:14 -0400
Received: by iyb12 with SMTP id 12so5928400iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BQFwxarjldeX+c0BoAlMs4mj8v6AlTlaS1q8oyaUHCM=;
        b=gTswJjvDQ8yaOUhBRrpM0MF4wB+AMbgIyOJLUq1dwEYvsnBN/QPK7B4cCReQPEqdUv
         jundlV5IcqShdRAvjfQYfFD37BAQgPuppdJUQ7EO+QuneCT9XJmaAlhP2h0K3rd1VzIi
         byemHlamclpB4u9bbipqpeAYYCIWzznh6K5Vc=
Received: by 10.42.18.194 with SMTP id y2mr1230741ica.184.1309944013710;
        Wed, 06 Jul 2011 02:20:13 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id my4sm4760872ibb.37.2011.07.06.02.20.11
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 02:20:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-10-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176669>

Ramkumar Ramachandra wrote:

> The "--ff" command-line option cannot be used with four other
> command-line options.  However, when these options are specified with
> "--ff" on the command-line, parse_args will still parse these
> incompatible options into a replay_opts structure for use by the rest
> of the program.  Although pick_commits checks the validity of the
> replay_opts strucutre before before starting its operation, this is
> inelegant design; pick_commits is currently the gatekeeper to the
> cherry-pick machinery, but this will change in future.  To futureproof
> the code and catch these errors in one place, make sure that an
> invalid replay_opts structure is not created by parse_args in the
> first place.  Also ensure that regressions in maintaining this
> invariant are caught in the future by adding an assertion in
> pick_commits.

Agh!  The above seems totally convoluted, and worse, I can see some of
my own words in there so I feel I am to blame.  Could you please
explain, simply, as though I am just an ordinary person, what the idea
of this patch is?  I've heard you talk before.  You are quite capable
of explaining things clearly.

The patch itself looks good.
