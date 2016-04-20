From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 19 Apr 2016 20:44:52 -0400
Organization: Twitter
Message-ID: <1461113092.5540.147.camel@twopensource.com>
References: <CACsJy8D_4KFjz6HefvzmWw-6Qqg0uguq8MXL6kLY0oMyVhPS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:45:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asgGJ-00042M-Io
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 02:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbcDTAo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 20:44:56 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36076 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbcDTAoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 20:44:55 -0400
Received: by mail-qg0-f46.google.com with SMTP id f52so20051553qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8FIpuV6M5WSArpfb20bpVcm1EefSKA8Cyfymrm8N8+M=;
        b=GyQjCkXEDWmLlVoixzo/EbWaxz2l0t+mg9c1yAmkdOErTQzaPVscHAQnYdA3ZMx/nL
         w95K+TsZEIQ7tHVutItbTmcjSxVIltf9Sc+5aw0I1V0jisMhc3h3Bub9ai49foKIqzm1
         xMEAs/e4VAaf/6A43jZ6Hjqh42M15a6sJllKm41w2eLeZp4in2wEnnvL7eqisgDXtEzD
         tX66Hz9x9MnwZH/p6HB3kBaAJCGLpbVNV4Aci2e4s+1KlS+7H8TCn/uLc8n6gFnYpsv0
         lhOtiu7mLfisKbmebk1ad8orGRgsaw6x1N8WtgWCz29JCbL53u4ouJ+5WfdHUXUm8LcD
         4DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8FIpuV6M5WSArpfb20bpVcm1EefSKA8Cyfymrm8N8+M=;
        b=NUCDN/IEhsbh4fB4cVnqR88i91fJLZ20hpf0ZGnM/2fenrnjSDVU0s1Ot3ITUrLtn4
         voNTDwWOnaT//rSzCqIPrDQDpuLrslAeg6BBnojiHY2y+tOL8rNwQ66HbwaqGJKEqXf4
         1lP/RuIXYNsaH/v7dakvgqvk1Cstf4FFAMRKOCH1fWiBne0NjudvuMR7ZNJzCh5gr2mo
         3Z1+2YmZ9fepJHobVdBNQMV5ceuh++o5ZUrrHeUn247+g3/kSZzy/4ERoq4pqvC4NkKj
         DoOM81ctWDyNPjdpz7qp/h4U5Z/8DzBskrjMrvGVZOBBld69gEaa+1M0yW7luhpSY6th
         oOvQ==
X-Gm-Message-State: AOPr4FWSuRiZpQOrZr+yZxDLbay5spQt3U9BBPmakOAc65qTcQKIyuyuLb2vyJAl51GD0A==
X-Received: by 10.141.2.9 with SMTP id e9mr7922788qhd.18.1461113094313;
        Tue, 19 Apr 2016 17:44:54 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm10674548qke.49.2016.04.19.17.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 17:44:53 -0700 (PDT)
In-Reply-To: <CACsJy8D_4KFjz6HefvzmWw-6Qqg0uguq8MXL6kLY0oMyVhPS0w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291974>

On Wed, 2016-04-20 at 07:31 +0700, Duy Nguyen wrote:
> On Wed, Apr 20, 2016 at 6:27 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Shared memory is done by storing files in a per-repository
> > temporary
> > directory.  This is more portable than shm (which requires
> > posix-realtime and has various quirks on OS X).  It might even work
> > on
> > Windows, although this has not been tested.
> 
> There's another option, but I'm not sure if it's too clever/tricky to
> do. Anyway, on *nix we can send file descriptors over unix socket
> [2],
> then mmap them back to access content. On Windows, it looks like
> DuplicateHandle [1] can do nearly the same thing. This keeps
> everything in memory and we don't have to worry about cleaning up
> shm-* files.
> 
> [1] http://lackingrhoticity.blogspot.com/2015/05/passing-fds-handles-
> between-processes.html
> [2] http://www.normalesup.org/~george/comp/libancillary/

It's possibly a bit simpler for the index, although more complex
overall since we still need to write temp files for the watchman data.

Will consider/try.
