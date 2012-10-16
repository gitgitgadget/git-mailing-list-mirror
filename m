From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push race
Date: Tue, 16 Oct 2012 12:15:21 +0700
Message-ID: <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com> <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com> <20121016045118.GA21359@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:16:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNzVb-0004wk-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 07:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab2JPFPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 01:15:53 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46007 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab2JPFPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 01:15:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5808090oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5rcrQFfOwGlLqUpEvmJNKx0YU5Sjl9/325IieoWplaM=;
        b=sNV8D3k2tc2DSqacHfOJ9z1ufPxCAPe8xzvFUegeb5ey4eX158TsK4GKGrJcL0VQms
         SjNlBv/XcdVcUETMn5avgqgC11vVQBKLAyekbhBHN+O5DR0v7kpIszzUlPd1Y2Hc1RK0
         19RwfT8LIt/onX9ItNu8C2BtlMvtXCuFTQhB9R+veVwxvcjC/+6wPiV39cGjEjPuS4K9
         yXBDC50+bkrlOlYDCOHQGPS+zJHibTZraPgKFWLRM3fo0iUSU4LBZuOk31J7aUj++ZCU
         61vxkFy8JdIZMHYnjdKAWUOEY99uMjQMsSiZjBTTf112YRAI88cSVkTWmFIlWVfDutq+
         yWKg==
Received: by 10.182.225.5 with SMTP id rg5mr11485508obc.49.1350364551685; Mon,
 15 Oct 2012 22:15:51 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Mon, 15 Oct 2012 22:15:21 -0700 (PDT)
In-Reply-To: <20121016045118.GA21359@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207801>

On Tue, Oct 16, 2012 at 11:51 AM, Jeff King <peff@peff.net> wrote:
>> Its worth nothing that a SHA-1 collision can be identified at the
>> server because the server performs a byte-for-byte compare of both
>> copies of the object to make sure they match exactly in every way. Its
>> not fast, but its safe. :-)
>
> Do we? I thought early versions of git did that, but we did not
> double-check collisions any more for performance reasons. You don't
> happen to remember where that code is, do you (not that it really
> matters, but I am just curious)?

We do. I touched that sha-1 collision code last time I updated
index-pack, to support large blobs. We only do that when we receive an
object that we already have, which should not happen often unless
you're under attack, so little performance impact normally. Search
"collision" in index-pack.c
-- 
Duy
