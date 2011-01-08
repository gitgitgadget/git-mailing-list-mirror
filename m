From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sat, 8 Jan 2011 17:21:47 +0000
Message-ID: <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>
	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 18:23:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbcW2-0006L7-Uo
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 18:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab1AHRVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jan 2011 12:21:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57104 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab1AHRVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 12:21:48 -0500
Received: by qwa26 with SMTP id 26so18687868qwa.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SioemU5UuboIeBHIpBtCybhskfrhf+a0aNjJ2wyuE84=;
        b=O+iKWnNaw77tK9TDCXgfSk0pqTufzf36NTD7cQa1FaxBwCxR042/SogRTlVBVL2oxt
         DZMrjHolLaZ2lkanIJ6/u4b9QWsRtzqbBR+XLAwn/RdUQoT3iTqhmo4vmHt8197n6tyM
         CNUkqxr51D0zfOmWHcCmMxjI2597ilGVesHBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C8fmsW58aypQ3Nch5+vPn6GBtv6UQghspmr0V6hIKNWoTWzgkFobSCNxkdzdGwL75x
         UGJQL/ERQbCTVEHyTETBwc3DlDQ/p4ZKbZ0OnvmJcdJPFzkGYEbOn3ak6erde2oMxMEx
         m68adf7tehuYJ7u91+yNul/mFuO1Ro/s2oj+E=
Received: by 10.229.98.131 with SMTP id q3mr18261768qcn.236.1294507307461;
 Sat, 08 Jan 2011 09:21:47 -0800 (PST)
Received: by 10.220.190.203 with HTTP; Sat, 8 Jan 2011 09:21:47 -0800 (PST)
In-Reply-To: <AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164833>

On Sat, Jan 8, 2011 at 2:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Fri, Jan 7, 2011 at 10:59 PM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> =C2=A0bottom line: my take on this is (sorry to say, nguyen) that i =
don't
>> believe bittorrent "pieces" map well to the chains concept, unless t=
he
>> chains are perfectly fixed identical sizes [which they could well be=
?
>> am i mistaken about this?]
>
> there are a few characteristics of bittorrent pieces that i see:
> verifiable, resumable, uniquely identifiable across peers and
> reasonbly small in count.
>
> The fixed size helps peers uniquely identify any pieces by splitting
> the whole transfer equally and indexing them in 1-dimension.

 ok - you haven't answered the question: are the chains perfectly
fixed identical sizes?

 if so they can be slotted into the bittorrent protocol by simply
pre-selecting the size to match.  with the downside that if there are
a million such "chains" you now pretty much overwhelm the peers with
the amount of processing, network traffic and memory requirements to
maintain the "pieces" map.

 if not then you now need to modify the bittorrent protocol to cope
with variable-length block sizes: the protocol only allows for the
last block to be of variable-length.

 also, it's worth pointing out that the entire code-base of every
single bittorrent client that you will ever be able to find revolves
around the concept of reassembly of files from "pieces".

 bottom line: the bittorrent protocol and the available bittorrent
source code libraries, both of which save you a great deal of time in
getting something up-and-running, is _not_ the right fit for the
concept of placing the proposed "chains" into bittorrent "pieces".

 translation: if you wish to pursue the "chains" concept, either a
heavily-modified bittorrent protocol and client _or_ an entirely new
peer-to-peer protocol is far more appropriate.

 orrr, doing what i initially suggested, which is to leave the
bittorrent protocol as-is and to open one .torrent per "chain".
especially if these "chains" vary considerably in size (k to gb)

l.
