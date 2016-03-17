From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 19/19] hack: watchman/untracked cache mashup
Date: Wed, 16 Mar 2016 20:56:05 -0400
Organization: Twitter
Message-ID: <1458176165.9385.9.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-20-git-send-email-dturner@twopensource.com>
	 <CACsJy8DGEQJmhxZpX3Zd=tGk_9T0n+ZhcaaEahaqFuh6NRvgSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 01:56:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agMEk-0006rl-QT
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 01:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935306AbcCQA4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 20:56:09 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34360 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbcCQA4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 20:56:07 -0400
Received: by mail-qg0-f44.google.com with SMTP id w104so59312368qge.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=w6DdPL9M45pClpCXqLHL+5x4ecStzHL/yPBmRUvtafM=;
        b=e8MPoFzWq4BkkKY3/Iai0yC39O1E8NKmhU/7OyMg3QH9kcUeVHjGpDskEJZSIZsrf9
         qUf29NN/FqjnzkFgpe9DHfZbxHTgFRbHW8KddqQVAfO99bZ+TM/AWw4UfoDtIuTYRrL4
         SHkM/T+pGNZyXevn1R+tLRIoIIv/gpElfelNgql1e8i7H9qYnnuGpsSmO+7fz3Q2+lfv
         D0CoMHK6N+ySHmZRisnyjL6bZrnKA7UXT+CXOKlbUKRhJrzm47JTpqYtjbfgT5z6PqKT
         SsDvNWsvSXu5BCFgs9E6Fnx5EbGCOU5Dx/Dxr9H8pidBRKqjgBZLRHCyr3uDj75YY/8i
         WBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=w6DdPL9M45pClpCXqLHL+5x4ecStzHL/yPBmRUvtafM=;
        b=nMjwivw2d1xwVfMggZwgbLrt2iXeVDTsdAqrj2nIboniGhss759vTd7TGlClaE1Hbx
         awR+zgoFzEpKHqMrRLDmWvjT6YI5ew4M54riHYDUC7un1oL+xojyagkQ9XqLG7TLK3yi
         XcxIxfFNvIaDeh0DQwVzjjfYFfptyff8HvKXvNB9EMns0sYc7AWit6GNsEHuBQlgk+ye
         5t39mUJZ9UseeyisWZCfiWnRJcLaS2zj41H0YNg8JCJg5japWPW2Y1sYGGR7LHwycJ8I
         qqKMxeOB0vE1PifRo3CQ4krR9syH/IpMZb9dTrWfbmXgCPJI8nSSepqU9HeqAMUhnHGf
         OVPw==
X-Gm-Message-State: AD7BkJKUi1X1Ihe4z4d6r5appmslEiC8TKsolPsBQhcS4rb576FCDu0E8CdiYcxw31JlXg==
X-Received: by 10.140.28.135 with SMTP id 7mr808369qgz.72.1458176166560;
        Wed, 16 Mar 2016 17:56:06 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 103sm2703543qgm.42.2016.03.16.17.56.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2016 17:56:05 -0700 (PDT)
In-Reply-To: <CACsJy8DGEQJmhxZpX3Zd=tGk_9T0n+ZhcaaEahaqFuh6NRvgSQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289065>

On Tue, 2016-03-15 at 19:31 +0700, Duy Nguyen wrote:
> On Thu, Mar 10, 2016 at 1:36 AM, David Turner <
> dturner@twopensource.com> wrote:
> >  static struct watchman_query *make_query(const char *last_update)
> > @@ -60,8 +61,24 @@ static void update_index(struct index_state
> > *istate,
> >                         continue;
> > 
> >                 pos = index_name_pos(istate, wm->name, strlen(wm
> > ->name));
> > -               if (pos < 0)
> > +               if (pos < 0) {
> > +                       if (istate->untracked) {
> > +                               char *name = xstrdup(wm->name);
> > +                               char *dname = dirname(name);
> > +
> > +                               /*
> > +                                * dirname() returns '.' for the
> > root,
> > +                                * but we call it ''.
> > +                                */
> > +                               if (dname[0] == '.' && dname[1] ==
> > 0)
> > +                                       string_list_append(&istate
> > ->untracked->invalid_untracked, "");
> > +                               else
> > +                                       string_list_append(&istate
> > ->untracked->invalid_untracked,
> > +                                                          dname);
> > +                               free(name);
> > +                       }
> >                         continue;
> > +               }
> 
> So if we detect an updated file that's not in the index, we are
> prepared to invalidate that path, correct? We may invalidate more
> than
> necessary if that's true. Imagine a.o is already ignored. If it's
> rebuilt, we should not need to update untracked cache.

Yes, that's true.  But it would be true with the mtime system too. This
is no worse, even if it's no better.  In-tree builds are a hard case to
support, and I'm totally OK with a system that encourages out-of-tree
builds.

We could check if it's ignored, but then if someone changes their
gitignore, we could be wrong.

Or we could suggest that people make their watchmanignore match their
gitignore.


> What I had in mind (and argued with watchman devs a bit [1]) was
> maintain the file list of each clock and compare the file list of
> different clocks to figure out what files are added or deleted. Then
> we can generate invalidation list more accurately. We need to keep at
> least one file list corresponds to  the clock saved in the index.
> When
> we get the refresh request, we get a new file list (with new clock),
> do a diff then save the invalidation list as an extension. Once we
> notice that new clock is written back in index, we can discard older
> file lists. In theory we should not need to keep too many file lists,
> so even if one list is big, it should not be a big problem.
> 
> I have a note with me about race conditions with this approach, but I
> haven't remembered exactly why or how yet.. My recent thoughts about
> it though, are race conditions when you do "git status" is probably
> tolerable. After all if you're doing some I/O when you do git-status,
> you're guaranteed to miss some updates.
> 
> [1] https://github.com/facebook/watchman/issues/65

I think it would be possible to just check the UNTR extension and only
add a dir to it if that dir doesn't already contain (untracked) the
file that's being modified.  Or is that also racy?
