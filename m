From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [DONOTAPPLY PATCH 1/3] environment: set GIT_WORK_TREE when we
 figure out work tree
Date: Tue, 26 Mar 2013 13:16:43 -0700
Message-ID: <20130326201643.GK1414@google.com>
References: <20130326200851.GA22080@sigill.intra.peff.net>
 <20130326201140.GA22522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaJ3-0002cq-Si
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760158Ab3CZUQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:16:50 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:45580 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab3CZUQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:16:49 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so886266pbb.41
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WV9BJOj26wuoWHeXGZDsTYRGN/JGzHqNIfUHYNuEQ3o=;
        b=hoGopqh0O0qMLsCUhMgAI0z2KVfldOjoS/or49gdOtE/j4uGGAAAbcK9pfBfbYeFSc
         cXBaeEI9a3OvSQes1Pkx7CuuuUgHD2yqb+n97hNrvrtstay+qz0sMsqXvqP1WvCanmwL
         T/lKF9lVA7sKCI1B6/anKhclGkgRXIecu+aJaw1siJGkWSyWDFJWr/+l1SU94s6QyiSM
         K0Y8KjUSWkjtDJAxuqiNlU3Z2Bc0QXdnDn2whAY0c0f5xCP1XEquFR4i15vT3uwBRWd+
         XpopRUepRWTt4SP/KCgaeQkcoaBG2Ew7vzMwL1X/Y4kFGWsHu9CdUMOKQjlZRSDZLFUe
         xB8w==
X-Received: by 10.66.52.76 with SMTP id r12mr1136356pao.217.1364329008661;
        Tue, 26 Mar 2013 13:16:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id wi7sm20362508pac.9.2013.03.26.13.16.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 13:16:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130326201140.GA22522@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219199>

Jeff King wrote:

> --- a/environment.c
> +++ b/environment.c
> @@ -194,6 +194,7 @@ void set_git_work_tree(const char *new_work_tree)
>  	}
>  	git_work_tree_initialized = 1;
>  	work_tree = xstrdup(real_path(new_work_tree));
> +	setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1);
>  }

There's no rush, but I think this is a good change.  It makes the rest
of the codebase more resilient to running commands from a subdir of
the top level of the worktree.
