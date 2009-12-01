From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH 3/6] stg mail: make __send_message do more
Date: Tue, 1 Dec 2009 08:26:50 +0100
Message-ID: <b8197bcb0911302326w2fcda7dfi520159b25ecd18d0@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
	 <20091128195026.949.1772.stgit@bob.kio>
	 <b8197bcb0911291323l35cb3624td3cbc393bf4513b3@mail.gmail.com>
	 <20091130235935.GK12733@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 08:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFN8U-0005Sh-Kn
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbZLAH0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZLAH0r
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:26:47 -0500
Received: from mail1.space2u.com ([62.20.1.135]:63675 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZLAH0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:26:46 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB17QimU032507
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 1 Dec 2009 08:26:44 +0100
Received: by bwz27 with SMTP id 27so3188615bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 23:26:50 -0800 (PST)
Received: by 10.204.34.5 with SMTP id j5mr1832996bkd.123.1259652410433; Mon, 
	30 Nov 2009 23:26:50 -0800 (PST)
In-Reply-To: <20091130235935.GK12733@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134168>

On Tue, Dec 1, 2009 at 12:59 AM, Alex Chiang <achiang@hp.com> wrote:

> * Karl Wiberg <kha@treskal.com>:
>
> > You could consolidate the two dictionaries like this, to avoid
> > making the same choice twice and make the code more pleasant to
> > read:
> >
> > (build, outstr) = { 1: (__build_cover, 'the cover message'), 4: (__build_message, 'patch "%s"' % args[0]) }
>
> Hm, I don't think that's valid. I ended up doing something like
> this:
>
> d = { 'cover': (__build_cover, 'the cover message'), 'patch': (__build_message, 'patch "%s"' % args[0]) }
> (build, outstr) = d[type]

Duh. That's what I get for posting untested code. It should be

(build, outstr) = { 1: (__build_cover, 'the cover message'), 4:
(__build_message, 'patch "%s"' % args[0]) }[len(args)]

That is, we create a dictionary only to immediately use it once,
without ever explicitly storing a reference to it.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
