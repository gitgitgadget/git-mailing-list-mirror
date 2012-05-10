From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Thu, 10 May 2012 08:53:03 +0200
Message-ID: <20120510065303.GA98491@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
 <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <CACsJy8CUC8AXYvDEH75NGC_r3HwLoaiq0qxn2EAC0Aq4VXVMag@mail.gmail.com>
 <CACsJy8DmhcFHOOToEWLoHNRJtXHe8EOnKfOn4+kOMBaW=tyWBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 08:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSNFU-0005tT-8U
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2EJGxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 02:53:11 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:41840 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2EJGxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:53:08 -0400
Received: by wibhm4 with SMTP id hm4so129530wib.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+YhH4LqiLVl5gYA1HiRBHVIp0haIGB/r9rsY8YrckU=;
        b=jGCd788DY0mx4JyKnePkv85bmWpVn0WUA776zxf0TcZzNL0tGI80sEoNfOnL0i3EBm
         cAYlzqTbtRYO021KU2CpmAmEfV0fj1DWJpu01CqV6BTSzkJZmHIjI/8e3MNKXQXBMM9T
         6yW9l0Owml57XxNzzImDF92Qlqluoj5kCHR6UTv5dkqsZfsVdcA9WnQQMM5cOyCrUowK
         zOkRsp/LOJHyk6KjDpl1ajxGNGnGKvtuua5GlEd/XjfYFVshRKN0wj8zU6CW/4BLKcdZ
         QjYUsXevhSCmSMOl9fX/w3Rd0ClVRu9sBj4VOi7guTI7gozTztLxnIRzUZ80VRDdAQBv
         d2EQ==
Received: by 10.180.109.229 with SMTP id hv5mr20475577wib.0.1336632786078;
        Wed, 09 May 2012 23:53:06 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id ff2sm2161512wib.9.2012.05.09.23.53.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 May 2012 23:53:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DmhcFHOOToEWLoHNRJtXHe8EOnKfOn4+kOMBaW=tyWBw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197548>



On 05/08, Nguyen Thai Ngoc Duy wrote:
> Sorry I replied too fast.
>=20
> On Tue, May 8, 2012 at 9:25 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
> > On Tue, May 8, 2012 at 9:11 PM, Thomas Gummerer <t.gummerer@gmail.c=
om> wrote:
> >>> * "160-bit object name for the object that would result from writ=
ing
> >>> =C2=A0 this span of index as a tree." =C2=A0Is this always valid?
> >>
> >> No, this is only valid if the entry count is not -1. It's clarifie=
d
> >> now.
> >
> > ..and..
> >
> >> The entry_count in the index is only valid, if the cache-tree is v=
alid,
> >> which is not always the case.
> >
> > I think your trees are the cache-trees already. For invalid
> > cache-trees, you can just use all-zero sha-1 as the indicator. Then
> > entry_count can go away.

How is it a cache-tree already? The subtree is covered, but the=20
entry_count is calculated recursively, while nfiles only keeps track of
the files directly in the directory, which is used for bisectability.

> Furthermore, in directory entry format:
>=20
>   The last 24 bytes (4-byte number of entries + 160-bit object name) =
are
>     for the cache tree. An entry can be in an invalidated state which=
 is
>     represented by having -1 in the entry_count field. If an entry is=
 in
>     invalidated state, the next entry will begin after the number of
>     subtrees, and the 160-bit object name is dropped.
>=20
> Dropping objname out of invalid (cache-)trees is a bad idea. When you
> generate tree objects (aka cache_tree_update), you'll need objname
> field again, which means structure change and directory entry rewrite=
=2E
> If objname is always there, you can just overwrite objname with new
> value. Though this may bring race condition issue back to directory
> entries. The same approach on file entries might be reused.

Yes you're right, at least the field for the object name (even if 0)
should always be there.
