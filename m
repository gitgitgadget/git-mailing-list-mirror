From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 5 Apr 2012 20:22:26 -0700
Message-ID: <CAJo=hJssfTvGqzQtaAj+Dk_R2oU5BwY=sQQuH3=SFTf+Zcp=3A@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <italyhockeyfeed@gmail.com>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 06 05:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFzlK-00012p-QL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 05:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2DFDWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 23:22:49 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:34673 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2DFDWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 23:22:48 -0400
Received: by dake40 with SMTP id e40so2305832dak.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4ExamRRAJgBMh4kH4ccd3E+kAF5EStsauz3uFZVC21g=;
        b=IYXdl6pfctlO2a7v4nQdAI7z7W29Ll2jwG9rFbsFSrcJXVCZU/zol6wOCalvE1Su4U
         7HW6AWu9X0i7XgfFT5XrJKkMkEjzX/TtN2XuCz+lUAkWPcmVlEjFCvGu2OmMtw0Px5wF
         odaDjVg8OSF/WXm2y4UndR+nplGDorORZ0uFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=4ExamRRAJgBMh4kH4ccd3E+kAF5EStsauz3uFZVC21g=;
        b=kBq226hJxrrGuTe9dRdbDBimxKH75uqz/0M6N7h7f1opaCEs643vMN8k4Jm+yuLW7k
         YGxtwiQRnoIy8GCW0v+G+rkfTPUnMwNpiMZkzAL+if9TLz3Iph8PtoWLk62SiyEp7zMt
         Ql/hWBaG04F3EQIDCvksOl2WEWrhtdm8dnOCtbjrtkEjbfdkX5CWIGiw5Px8mD9yqrkf
         dFIHGdHHCTcKHtvFs8aA2lK35FHW+mO7o9ZdEXYm3iSDvBOfaChtLYsqNZ2xLFXSaR/w
         +rCSU05Tu998x8hueKJ/GVJznOttkRdpTARNVNKwJvqDYkF+rqejw7/jZpO8NjKHulkw
         Qrqg==
Received: by 10.68.193.170 with SMTP id hp10mr9619242pbc.65.1333682566762;
 Thu, 05 Apr 2012 20:22:46 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Thu, 5 Apr 2012 20:22:26 -0700 (PDT)
In-Reply-To: <87r4w1vofu.fsf@thomas.inf.ethz.ch>
X-Gm-Message-State: ALoCoQkSdJ1rMqozapBTm134p8ZTxuttU6qJAFJ0bcclPfY0WxZpawSNdxg2NH/t9n5P1gQynNNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194842>

On Thu, Apr 5, 2012 at 14:49, Thomas Rast <trast@inf.ethz.ch> wrote:
> Thomas Gummerer <italyhockeyfeed@gmail.com> writes:
>
>> -- Proposed solution --
>> The proposed solution is to redesign the index to a B-tree based for=
mat. This
>> allows changes to the index in O(log(n)) time, with n being the numb=
er of
>> entries in the index.
>
>> -- Solutions that were also considered --
>> - Append-only data structure
>> - Database format
>> - Padded structure
>
> This is quite complete already, which I think is great, but it's stil=
l
> missing one "obvious" approach: a directory-tree based layout that us=
es
> "flat" storage. =A0That is, the entries grouped by directory and thus
> arranged into the "natural" tree, so as to allow parsing only part of
> it. =A0But not pulling any tricks to make it easy to change; a nontri=
vial
> change would mean a rewrite. =A0How good do you think that could be?

I have been wondering this myself. Aren't most updates to the index
just updating the stat information of an existing entry?

If so we could structure the index as flat lists for each directory
similar to a canonical tree, but with a wider field to hold not just
the SHA-1 but also the stat information of each file. If the entry is
just the component name ("foo.c" and not "src/foo.c") and the SHA-1
and stat data, you can probably protect the entire entry with a CRC-32
for each entry. Updates can be performed in place by taking the write
lock with index.lock as an empty file, then overwriting the SHA-1 and
stat field followed, by updating the CRC-32. Readers that see the
wrong CRC-32 for an entry can sleep for a short period, retry the
read, and fail after some number of attempts if they cannot get a
valid read of that entry.

Adding a new file or deleting an existing file from the index would
require a full rewrite.

Within a single tree/directory entry, it probably doesn't have to be
binary searchable. Canonical trees aren't. Linear scans through a
directory is OK, so long as the scans are broken up by the directory
tree structure just like they are in canonical trees.

Dealing with the conflict stages during merges (1, 2, 3) could be
handled by appending the conflict data at the end of the index file,
when conflicts are resolved this tail region could be truncated back
to the real end of the file. A bit could be set on the normal entry in
the trees to denote there is a conflict, and additional stage data is
expected in the tail region of the file.
