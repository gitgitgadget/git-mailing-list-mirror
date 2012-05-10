From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Index format v5
Date: Thu, 10 May 2012 18:06:13 +0700
Message-ID: <CACsJy8Dx9jrC+8yC6eSsYbg2Yu6Xk+gkc-9Xe-iAy6+Uv_EoyA@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <CACsJy8CUC8AXYvDEH75NGC_r3HwLoaiq0qxn2EAC0Aq4VXVMag@mail.gmail.com>
 <CACsJy8DmhcFHOOToEWLoHNRJtXHe8EOnKfOn4+kOMBaW=tyWBw@mail.gmail.com> <20120510065303.GA98491@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 13:06:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSRCw-0005X0-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab2EJLGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 07:06:47 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38281 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932196Ab2EJLGq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 07:06:46 -0400
Received: by lahd3 with SMTP id d3so970026lah.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hftH9X1mUP36Xmyk7Ji5eruROO3rdgKHrA0BFKiyPXw=;
        b=zhgofHsFuAloa/q5FFmnMk5nnM3BQTtz/Z1KBYuN3O/1SUbEejY9lQama7UGMZd/2G
         NLofn8TJJVsg1mdoatxFiFFIi8v7Ql/w7VbKlb3BhsSbhn8Nuaiv4x+UjaCtEI0l1lO8
         EWW3w8XKgQI5Msm8JsUQVdCD3+p/XpdQLBQtSqtZUy1g7lY62FUC6kKKsGr5KCwoFbdc
         zHUtLTD3qj25N3Q3WhmBqpfHuS7DX1RFYErosHiBza1OsXGuxFEYEYx/IcP9Yo97bfOG
         2doy2QwCC46JG/lU/bztQjEuOPXHoI043UZiFJLGG17bpAJaOprFutL1h8LWhf2PYz2U
         9/1w==
Received: by 10.112.45.230 with SMTP id q6mr1546897lbm.103.1336648004738; Thu,
 10 May 2012 04:06:44 -0700 (PDT)
Received: by 10.112.17.167 with HTTP; Thu, 10 May 2012 04:06:13 -0700 (PDT)
In-Reply-To: <20120510065303.GA98491@tgummerer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197554>

On Thu, May 10, 2012 at 1:53 PM, Thomas Gummerer <t.gummerer@gmail.com>=
 wrote:
>
>
> On 05/08, Nguyen Thai Ngoc Duy wrote:
>> Sorry I replied too fast.
>>
>> On Tue, May 8, 2012 at 9:25 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> > On Tue, May 8, 2012 at 9:11 PM, Thomas Gummerer <t.gummerer@gmail.=
com> wrote:
>> >>> * "160-bit object name for the object that would result from wri=
ting
>> >>> =C2=A0 this span of index as a tree." =C2=A0Is this always valid=
?
>> >>
>> >> No, this is only valid if the entry count is not -1. It's clarifi=
ed
>> >> now.
>> >
>> > ..and..
>> >
>> >> The entry_count in the index is only valid, if the cache-tree is =
valid,
>> >> which is not always the case.
>> >
>> > I think your trees are the cache-trees already. For invalid
>> > cache-trees, you can just use all-zero sha-1 as the indicator. The=
n
>> > entry_count can go away.
>
> How is it a cache-tree already? The subtree is covered, but the
> entry_count is calculated recursively, while nfiles only keeps track =
of
> the files directly in the directory, which is used for bisectability.

Cache-tree maintains the information that what part of the index
already has corresponding tree objects (and what sha-1). If a tree is
changed, the tree all the way up must be invalidated (i.e. throw out
the old sha-1 of trees). You have trees and objname for each tree.
Invalidating a tree is simply erasing objname. Before performing a
commit, we just need to traverse the trees from leaves up, generate
tree objects for trees that do not have valid objname yet.
--=20
Duy
