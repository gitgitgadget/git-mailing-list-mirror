From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [DONOTAPPLY PATCH 2/3] setup: warn about implicit worktree with
 $GIT_DIR
Date: Tue, 26 Mar 2013 13:21:42 -0700
Message-ID: <20130326202142.GL1414@google.com>
References: <20130326200851.GA22080@sigill.intra.peff.net>
 <20130326201208.GB22522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:22:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaNs-0000hQ-0z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759227Ab3CZUVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:21:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51435 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab3CZUVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:21:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo1so1074610pbc.19
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Rh80IO3e7RVhS3D4J19a9bElijLea7FDA95V4WoVhCs=;
        b=hcdHkiaxCtNG4LdqO9HAUxNOmrQauSp245X8b525JktD11N+U3ZDMfeCPuQjvOaFb2
         g/5tsG4mJAK9jQjBCD6NIf8TNxmJ+x6F/FKs+P45mhMi8FiZtp79qvhq5Nvcpd4HilXc
         FbAr+qxf6QRLuBvTekF77Iaof1tK55VmVJr2F5WgSg3t4hauEnibL9n+0GLNlIBRlehC
         wv+Xx1TBNd3hAJ6QgjASqm/Dl4UMP3BCi5c2o3051REFfMEpyeYCNtJH5SL55jO6f2vB
         XFvvv19zroyabovBXr/eNwNbbRvYVKFmKEx+BM5KXZRTd2zqQkwaYdgR1OBqWsC2ApKG
         mPew==
X-Received: by 10.68.195.161 with SMTP id if1mr24965878pbc.207.1364329306990;
        Tue, 26 Mar 2013 13:21:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id cy4sm18633195pbc.13.2013.03.26.13.21.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 13:21:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130326201208.GB22522@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219200>

Jeff King wrote:

> --- a/setup.c
> +++ b/setup.c
> @@ -437,6 +437,23 @@ const char *read_gitfile(const char *path)
>  	return path;
>  }
>  
> +static const char warn_implicit_work_tree_msg[] =
> +N_("You have set GIT_DIR (or used --git-dir) without specifying\n"
> +   "a working tree. In Git 2.0, the behavior will change

Please no.  I don't want git 2.0 to be delayed forever.

If we want this warning, would something like the following do?

	warning: You have set GIT_DIR without setting GIT_WORK_TREE
	hint: In this case, GIT_WORK_TREE defaults to '.'
	hint: To suppress this message, set GIT_WORK_TREE='.'

Thanks,
Jonathan
