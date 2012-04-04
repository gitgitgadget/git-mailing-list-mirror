From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Wed, 4 Apr 2012 19:20:47 +0700
Message-ID: <CACsJy8A+0GxePYPSJh9g_N83QXY8cf8HHGT65M_eNGBeAs-5uQ@mail.gmail.com>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch> <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
 <CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
 <CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
 <CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
 <20120402123146.GA24813@do> <CAKTdtZm4JFkWOq7D=tHC-t8C5yd=AG6MEkKD46z5D7fCRDEfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPDI-0002q0-OS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 14:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab2DDMVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 08:21:20 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52295 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2DDMVT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 08:21:19 -0400
Received: by wibhj6 with SMTP id hj6so525558wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AiOn/5qtSOFeoAPVGOdMdjrUqaEa2PgPVsGZAyjH+nE=;
        b=CWq06x0V0c5Je0+qgJ3/RE8QLD3HuiIB2hQXB8fy0EmHJXzxC3ndZ407Oc/FeCSpEi
         1Zl9FFXp8Sdc4aLVdfuwXVTjU1NLvqAwM1VjjCYAs96zV4+t1ldpVlkZGekEMZ4AiLwI
         O54WkS3QjZEwFtyalGmi6CQE11Lfr+MClIEx6e/WrilSOF0MhsQ9fCQu78WqbuWui4TG
         Vcil2ZGdvqnqWYdfC/36n7KjrpxClVtI+7+2oeD7OsN1SB9YwWrW8lWO6qVahdQP+ech
         osfo0iThleI5kQ56fWa83uoh4qNACNgpfOw7zY8hD/8hQaIgFz3phsy07uURPXFc3I+g
         5Ppw==
Received: by 10.216.135.20 with SMTP id t20mr1200963wei.99.1333542077851; Wed,
 04 Apr 2012 05:21:17 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 4 Apr 2012 05:20:47 -0700 (PDT)
In-Reply-To: <CAKTdtZm4JFkWOq7D=tHC-t8C5yd=AG6MEkKD46z5D7fCRDEfZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194694>

On Wed, Apr 4, 2012 at 3:26 PM, elton sky <eltonsky9404@gmail.com> wrot=
e:
> I am not sure how the trailer works.
> I assume there can be multiple trailers, each update will generate a
> new one. Every trailer will point to the root tree (i.e. all trailers
> point to the same block?). So if there are some changes to root, like
> rename, trailers all point to the latest root block?

Each trailer points to the whole new tree. Because trees are
immutable, changing in a tree meangs creating a new one and will also
make a new parent tree (to point to the updated tree because old
parent will always point to old tree). This eventually leads to root
tree change, recorded by the trailer.

> Is the index looks like :
> | HEADER | TREE BLOCKS | TRAILER | =C2=A0TREE BLOCKS | TRAILER | TREE
> BLOCKS | TRAILER | ...
>
> Blocks and trailers are interleaved. The index starts from a few
> blocks (git add file1 file2 file3 ..) and expands as it goes. If file=
1
> is updated, the tree block containing file1 is updated and appended.
> (At this point, 2 versions of tree blocks containing file is in index
> ?) How do you organize these 2 block in a tree ?

I leave them where they are. They will be indirectly referenced by two
different roots. At that point we have to new full trees, sharing many
subtrees except the one that contains file1 and its ancestors. This
makes it possible to access an old index version by traversing from an
older trailer. Heavy "add -p" users may like this.

> Appended blocks are also a tree or just a list. If it's a list, it
> needs O(n) read time. If it's like a sub tree, I assume it's small,
> because I guess there won't be many changes each time. If it's too
> small then lgn -> n, and in total read time -> n.

It's trees all the way down. I'm not sure why read time is related
here. You read it by traversing from root tree to leaves, no matter
old or new root. Appended trees may push trees farther away and
increase seek time. Other than that, I don't see significant read
performance degradation (really crowded trees may degrade a little bit
because we need to read trees in addition to leaves, but I don't think
it's a big problem).
--=20
Duy
