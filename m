From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 11:52:58 -0800
Message-ID: <CAHOQ7J_mM8mO5gEn_-xtmReS86pSDRrVaCAMzbgJPnmpu3F=oA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@chromium.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOop-0003bQ-UL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbaBNTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:53:00 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:33994 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbaBNTw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:52:59 -0500
Received: by mail-oa0-f45.google.com with SMTP id i11so15050647oag.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WjHAAmxzOBnFSnZerrMB7Sht8aySCyG9t39elNd03ek=;
        b=nRapYMyvfogpAMUo0FvsY90glIKVX3AtfdWFcaUsjdfSzg31BmO6+L5oJqbqORtWor
         4Qr9YR7OceCr7VnExixoErB+sr8PMTF8cfUGqACwaNJQWD8TTJXhcxgSN02g3Ih7Rjoj
         bpN2wU8XM1Z4QygG/P5f/hs023CofxUkYTAG/STEegO5DtKn42ITz4BS8/f980QkTAbA
         P3/EBfQMHsye7Y5KbEY5zuAsJPIiZ7yOmWXjFHkB1A7Z3qCV74TroYGhWfuz6IXYY/9W
         ERDUhd/mvZ5jIQq7pKbBd21PQBft3elhrIprPLrD5BFx/hVBip4jbw/xy9KHFTIiNgCO
         GNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WjHAAmxzOBnFSnZerrMB7Sht8aySCyG9t39elNd03ek=;
        b=ZsQMOEVurd4V3ElCCHQKwO24nmwS1VTWFuEay6TqvyZ8W5tZQg/c/bnOeABhNaMI/F
         9aLjk9wUHKEqJ3fyvWdBaN2yc5kZiOFCg7tPb9+VsUDDpceiSJt4tdXU4XZzK+gXuDLb
         i8+tolohVUxxI5Tbl9BogqOPu8eri2kK67yZ7LKDz3gmPUSEgc/fO9PLMYzt+mJU7LlN
         +umrrgKJnJhSdT+/JnkG2w1fplJdCyd7w/YKFwrJOrgklETTUHlirTnVhpErJ1J9XhJq
         FkWmLmA6jOChNqE0LkDZswJ3RSPjKT4TJ/7X+zR5yLKOJHu6QPXxnXXkxpC2pVdWTGp2
         WuKQ==
X-Gm-Message-State: ALoCoQlu2l1wNYag3unEAsVrgpfQCTbxbVIhgq7nu/VfFGkHrSW96vYLS9aHS42qDq6pHogd9kBxy9GWTDuNt/cNUq1khsqzWe09fsaynfKPEAr582AyYQ7Ve1HXCql+VzFgp64A4uApY4EcM21vmnK7B9hbYp1Ut3PTTuIKY/rlBaWRB42GYsznvQFP+SOlR2gxjo1Zya0S
X-Received: by 10.60.229.4 with SMTP id sm4mr8289802oec.9.1392407578644; Fri,
 14 Feb 2014 11:52:58 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Fri, 14 Feb 2014 11:52:58 -0800 (PST)
In-Reply-To: <CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242138>

On Fri, Feb 14, 2014 at 11:15 AM, Zachary Turner <zturner@chromium.org> wrote:
> For the mixed read, we wouldn't be looking for another caller of pread()
> (since it doesn't care what the file pointer is), but instead a caller of
> read() or lseek().  In index-pack.c, I see two possible culprits:
>
> 1) A call to xread() from inside fill()
> 2) A call to lseek in parse_pack_objects()
>
> Do you think these could be related?  If so, maybe that opens up some other
> solutions?

>From my observations, it's not that simple.  As you pointed out to me
before, fill() is only called before the threading part of the code,
and lseek is only called after the threading part; and the lseek() is
lseek(fd, 0, SEEK_CUR), so it's purely advisory.

Also, here is the error output we got before you added ReOpenFile:

remote: Total 2514467 (delta 1997300), reused 2513040 (delta 1997113)
Checking connectivity... error: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
does not match index
warning: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
cannot be accessed
error: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
does not match index
warning: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
cannot be accessed
error: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
does not match index
warning: packfile
d:/src/chromium2/_gclient_src_a6y1bf/.git/objects/pack/pack-3b8d06040ac37f14d0b43859926f1153fea61a7a.pack
cannot be accessed
fatal: bad object e0f9f23f765a45e6d80863a8f881ee735c9347fe


The 'Checking connectivity...' message comes from builtin/clone.c,
which runs in a separate process from builtin/index-pack.c.  What this
suggests to me is that file descriptors for the loose object files are
not being flushed or closed properly before index-pack finishes.


> BTW, the version you posted isn't thread safe.  Suppose thread A and thread
> B execute this function at the same time.  A executes through the
> ReadFile(), but does not yet reset the second lseek64.  B then executes the
> first lseek64(), storing off the modified file pointer.  Then A finishes,
> then B finishes.  At the end, the file pointer is still modified.

Yes, that.  I would also point out that in our experiments, ReOpenFile
is not nearly as expensive as its name might suggest.  Since the
solution using ReOpenFile is pretty solidly thread-safe (at least as
far as we can tell), I'm in favor of using it unless or until we
properly root-case the failure.


Stefan
