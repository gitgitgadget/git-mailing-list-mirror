From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Fri, 22 May 2015 17:05:36 +0700
Message-ID: <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net> <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Fri May 22 12:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvjqM-0005oG-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 12:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314AbbEVKGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 06:06:11 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35911 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059AbbEVKGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 06:06:07 -0400
Received: by igbpi8 with SMTP id pi8so31637090igb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z+tzI+MV3HKJ2myzcAZ4M8V4e9XzaRxSuhaBhOXqULs=;
        b=k4cE2+oJt9B2GkXZbUq6tCokvxP2ql89SOAR0uemHuAglSmGzF3W0xvWNdPx8RUUWD
         7XxwvyHWoBwr4GpyATjAo4ISPkkRyBPyXT19qoUwYzYHOx5Ld6Zyz20bVNd2JDPQj+SG
         xzlst+shD721BPOe35ONdc7zEZQsgFRbDriCq9NFqLm1lfU63cNX5NHkoZoz1Q9AOVtJ
         WNKjVuaFkgKEk6Vsvpbo6gRR7n/ET5GGZgYjUcdujR+fkFJnCBy+3tcwOPSWhjPXXwoM
         Hx42N7CCh57MGeRE8wEf+AcsXqR2Lp8LXFozUjGLWF5Tp6pdE5iKL6QnrrhraThYE5RF
         cohQ==
X-Received: by 10.107.15.149 with SMTP id 21mr4402047iop.44.1432289167075;
 Fri, 22 May 2015 03:06:07 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Fri, 22 May 2015 03:05:36 -0700 (PDT)
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269703>

On Fri, May 22, 2015 at 3:35 PM,  <steve.norman@thomsonreuters.com> wrote:
> Tested this change on a couple of versions, first of all on the revision
> where things go wrong for me:
>
> ...
>
> ~ $ time git clone https://github.com/git/git test
>
> real    0m8.263s
> user    0m10.550s
> sys     0m3.763s
>
> ~ $ time git clone https://github.com/git/git /sami/test
>
> real    1m3.286s
> user    0m12.149s
> sys     0m9.192s
>
> So the patch isn't reducing the time taken when cloning to NAS.

Strange. Maybe there is something else... Anyway some numbers from me.
This is nfs3 hosted by Raspberry Pi, accessed over wireless. I just
run index-pack on git.git pack instead of full clone.

 - v1.8.4.1 34s
 - v1.8.4.2 519s (oh.. wireless..)
 - v1.8.4.2 without has_sha1_file() in index-pack.c 33s
 - v1.8.4.2 + Jeff's mtime patch 36s
-- 
Duy
