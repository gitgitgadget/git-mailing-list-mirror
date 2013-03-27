From: Jed Brown <jed@59A2.org>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 13:06:12 -0500
Message-ID: <874nfw4t0r.fsf@59A2.org>
References: <51531059.8000407@atechmedia.com> <7vsj3gn55b.fsf@alter.siamese.dyndns.org> <515331F2.3060703@atechmedia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@inf.ethz.ch>
To: Charlie Smurthwaite <charlie@atechmedia.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKukG-0001ce-9K
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab3C0SGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:06:15 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:50425 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab3C0SGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:06:15 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so7615040iak.32
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=J6bK3fzFtnWKCfNsf+WEMskscvj5J9xm8IUhVM78tds=;
        b=rcI3FGJqRm4Mu5ZMQCiD56lWZcGy5/lQHWQrQu5FR+jq5PKyf+ML2PrhiS3GRbTKDT
         Ftfi223j0/B5BXsbFVQ5MnJeQZcYGCnai9SWvThz9SjwH+r8O6U0nNGEmrjGbr1kDXb4
         iwWlk52Rv5jx0U8h2RhfoFVSvEaYQBvWeysCuvgCXba+BjAdsrnDXAKfkhHOVNPdA3Zq
         JKtH8XxFm1EAzdNsmPaSTElfaJ5aRbxRZLgUYARX1/pmWfCaMbkM34aHy35ySg6ATVdt
         aI5vPV30kS5hlMtD0qdV2kf1xo6g9sVCLcgqJXPfgu1vEr1C+8yUPai+dvOwH7jd26P7
         zPzQ==
X-Received: by 10.43.103.195 with SMTP id dj3mr12362604icc.3.1364407574891;
        Wed, 27 Mar 2013 11:06:14 -0700 (PDT)
Received: from batura (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id hi4sm8138655igc.6.2013.03.27.11.06.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 11:06:14 -0700 (PDT)
In-Reply-To: <515331F2.3060703@atechmedia.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219293>

Charlie Smurthwaite <charlie@atechmedia.com> writes:

> I am also using this to obtain a diff that would be applied if a merge 
> were to be run. Is there a better way to obtain this information that is 
> more commonly used?

You can do an actual merge using detached HEAD:

  $ git checkout --detach upstream-branch
  $ git merge topic-branch

This has the benefit that if there are conflicts, you can resolve them
here and commit the result so that rerere can auto-resolve them later.

Are you looking for something that can be run in a bare repo?
