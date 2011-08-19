From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Why isn't the index a tree?
Date: Sat, 20 Aug 2011 09:05:29 +1000
Message-ID: <CAH3AnrqByE8vYJeyBL7oGyuk5k+8c=bbRpU+z-gAkpQs=nm+dQ@mail.gmail.com>
References: <4E4ED49C.6050405@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 01:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuYAr-0002lo-8a
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 01:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab1HSXFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 19:05:31 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35161 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1HSXFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 19:05:30 -0400
Received: by vxi9 with SMTP id 9so2970060vxi.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I6sLz415svX0ECIWhHl8DizKtDrPcnvxMNwd9JG6Qwo=;
        b=dCtwFWJ6DeeBKSYPZwmtfk4KJvcf2JlMOuKKjLaNx63LkzfIuUYcvHe0f5k7wGv594
         kexQJElT+52sXKgiPnnP3AuPhwa+5ik5S1GdTtgeD5RLvXApdTL3YDmwbDQgvHNVdip4
         GvxefrENYiwGnnbR+xiYQIQRrm8rE8RdvzdiY=
Received: by 10.52.88.227 with SMTP id bj3mr340374vdb.64.1313795129893; Fri,
 19 Aug 2011 16:05:29 -0700 (PDT)
Received: by 10.52.181.97 with HTTP; Fri, 19 Aug 2011 16:05:29 -0700 (PDT)
In-Reply-To: <4E4ED49C.6050405@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179743>

On Sat, Aug 20, 2011 at 7:24 AM, Richard Hansen <rhansen@bbn.com> wrote:
> I expected the index to be implemented something like a ref to a tree object
> (per stage) plus some stat()/assume-unchanged/etc. metadata. Instead, it
> appears to be a (sorted?) flat list of full paths with their associated
> SHA1s and metadata.
>
> Is there a reason why each stage in the index isn't implemented as a tree?
>

I think the answer is that there is meta data in the index
(particularly timestamps) needed for efficiently tracking changes to
the filesystem that isn't needed in a tree - forcing everything into a
tree early would necessitate creating SHA1 hashes for lots of trees
that will eventually not be needed.

So, the index is a data structure tuned for performance in ways that a
tree cannot be.

jon

| reposted from a MUA that doesn't insert HTML
