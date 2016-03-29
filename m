From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Mon, 28 Mar 2016 22:23:12 -0400
Organization: Twitter
Message-ID: <1459218192.2976.4.camel@twopensource.com>
References: <cover.1459087958.git.k@rhe.jp>
	 <39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
	 <xmqq4mbqze65.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kazuki Yamaguchi <k@rhe.jp>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:23:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjJR-00009c-1j
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbcC2CXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 22:23:16 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33830 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbcC2CXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 22:23:15 -0400
Received: by mail-qk0-f180.google.com with SMTP id x64so930112qkd.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8nA6/hsEEWCHXDqyUHMQzN6lVtH5a7BfqktuucYL91s=;
        b=Hfyj9yyPKqnLJM0LJxYlepIbZXygCgFHxwj04SZOAhekn0zQeIn72rmBdqkWwvVain
         c6KnrxvQy2ANONKLTXOthBRIocBg3F0hxzhKYSxXnwtsP01RIAvkMCGPkiYQ1zI3Wbum
         ouPpyKj4XPiNnXvib3oOJVr6x4nqt8U9eCvTtAyqktWycc94r2rGORrgV3PTjGSEgzEn
         uPfCjJ2rdlT/oHZVYMRJ4A5uc6rGQd4i7JXc/sGe/Y9FniVJ/YdxqRNcOIayOcmVqUuq
         wBTzwBry4N81blIJkr3PxiuwXK4g9y/lhQhiowYgtsFPmvUZehpZi3oo1obQ2Pmup9Kr
         iicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8nA6/hsEEWCHXDqyUHMQzN6lVtH5a7BfqktuucYL91s=;
        b=m72oIoSDOb4Qs08hzgF6kKTvCUoW9DaRGnh1TOcfmXPqQODQwl09xKO8FQa9v+jiwb
         bCaKkMA5NTdEpQqBlG+eIQYTcUdGLcSP23FHhgpSE/aAOo+3T9T5wGgS410G707gzQtV
         8eToLHn6h9ONnVbDCrScAsEoxL/BSG4Sc4ZELwifFBvYmRHSl1dEcouaivbrve/UIS9J
         o2AvTKn3ZfWZlu4m6bKH/oc7xz+wVJ7s2qzcf7ZryXPBkYb7N1EN1tkme0F/cpbh0r6+
         3B3rlQltUG8ioQy9yL8L5lcwa0ZcVRkEgd2skuf6QPwl0LkkWOSvGQwwk8fbic0C9RNM
         rJ8Q==
X-Gm-Message-State: AD7BkJLewpponTwttCaeRKDsM0rS5bbbH+DUU/4n7fA6hTmPSN0X3YZgzoCN2w9j+0Blow==
X-Received: by 10.55.80.136 with SMTP id e130mr39606289qkb.28.1459218194453;
        Mon, 28 Mar 2016 19:23:14 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id m103sm5624821qkh.40.2016.03.28.19.23.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 19:23:13 -0700 (PDT)
In-Reply-To: <xmqq4mbqze65.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290094>

On Mon, 2016-03-28 at 10:48 -0700, Junio C Hamano wrote:
> Kazuki Yamaguchi <k@rhe.jp> writes:
> 
> > Add a new function set_worktree_head_symref, to update HEAD symref
> > for
> > the specified worktree.
> > 
> > To update HEAD of a linked working tree,
> > create_symref("worktrees/$work_tree/HEAD", "refs/heads/$branch",
> > msg)
> > could be used. However when it comes to updating HEAD of the main
> > working tree, it is unusable because it uses $GIT_DIR for
> > worktree-specific symrefs (HEAD).
> > 
> > The new function takes git_dir (real directory) as an argument, and
> > updates HEAD of the working tree. This function will be used when
> > renaming a branch.
> > 
> > Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> > ---
> 
> I suspect that this helper function should be in the common layer
> (refs.c) to be redirected to specific backend(s).
> 
> David & Michael, what do you think?

HEAD is a per-worktree ref, so it's always handled by the files
backend.  So this looks fine to me.

> > +/*
> > + * Update HEAD of the specified gitdir.
> > + * Similar to create_symref("relative-git-dir/HEAD", target,
> > NULL), but this is
> > + * able to update the main working tree's HEAD wherever $GIT_DIR
> > points to.


nit: "able to update the main working tree's HEAD regardless of where
GIT_DIR points to" would be clearer.
