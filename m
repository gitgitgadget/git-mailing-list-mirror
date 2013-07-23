From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Tue, 23 Jul 2013 23:33:22 +0100
Organization: OPDS
Message-ID: <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley> <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 00:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1l8c-0003yZ-4e
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 00:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934922Ab3GWWcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 18:32:52 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:15515 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934583Ab3GWWcv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jul 2013 18:32:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYNAC0E71FZ8YYB/2dsb2JhbABbgwaEDoU+uBQBAwGBExd0gh8FAQEFCAEBGQ8BBR4BASELAgMFAgEDDgMEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwGHbQMTpm6IWg2IXoEoi2qBNCAtaoJmM24Djn+Gd44QhSaDFTuBLQ
X-IPAS-Result: AvYNAC0E71FZ8YYB/2dsb2JhbABbgwaEDoU+uBQBAwGBExd0gh8FAQEFCAEBGQ8BBR4BASELAgMFAgEDDgMEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwGHbQMTpm6IWg2IXoEoi2qBNCAtaoJmM24Djn+Gd44QhSaDFTuBLQ
X-IronPort-AV: E=Sophos;i="4.89,731,1367967600"; 
   d="scan'208";a="417274342"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip04ir2.opaltelecom.net with SMTP; 23 Jul 2013 23:32:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231066>

=46rom: "Duy Nguyen" <pclouds@gmail.com>
Sent: Tuesday, July 23, 2013 2:20 AM
> On Tue, Jul 23, 2013 at 6:41 AM, Philip Oakley <philipoakley@iee.org>=
=20
> wrote:
>> From: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com=
>
>> Subject: [PATCH v2 00/16] First class shallow clone
>>
>> It's nice to see that shallow can be a first class clone.
>>
>> Thinking outside the box, does this infrastructure offer the=20
>> opportunity to
>> maybe add a date based depth option that would establish the shallow
>> watermark based on date rather than count. (e.g. the "deepen" SP=20
>> depth could
>
> I've been carefully avoiding the deepen issues because, as you see,
> it's complicated. But no, this series does not enable or disable new
> deeepen mechanisms. They can always be added as protocol extensions.
> Still thinking if it's worth exposing a (restricted form of) rev-list
> to the protocol..

Interesting idea.
>
>> have an alternate with a leading 'T' to indicate a time limit rather=
v=20
>> than
>> revision count - I'm expecting such a format would be an error for=20
>> existing
>> servers).
>>
>> My other thought was this style of cut limit list may also allow a=20
>> big file
>> limit to do a similar process of listing objects (e.g. blobs) that=20
>> are
>> size-shallow in the repo, though it maybe a long list on some repos,=
=20
>> or with
>> a small size limit.
>
> This one, on the other hand, changes the "shape" of the repo (now wit=
h
> holes) and might need to go through the same process we do with this
> series. Maybe we should prepare for it now. Do you have a use case fo=
r
> size-based filtering? What can we do with a repo with some arbitrary
> blobs missing? Another form of this is narrow clone, where we cut by
> paths, not by blob size. Narrow clone sounds more useful to me becaus=
e
> it's easier to control what we leave out.

In some sense a project with a sub-module is a narrow clone, split at a=
=20
'commit' object. There have been comments on the git-user list about th=
e=20
problem of accidental adding of large files which then make the repo's=20
foot print pretty large as one use case [Git is consuming very much=20
RAM]. The bigFileThreshold being one way of spotting such files as=20
separate objects, and 'trimming' them.

It doesn't feel right to 'track files and directories` as paths for=20
doing a narrow clone - it'd probably fall into the same trap as trackin=
g=20
file renames. However if one tracks trees and blobs (as a list of sha1=20
values, possibly with their source path) then it should it should be=20
possible to allow work on the repo with those empty directories/files i=
n=20
the same manner as is used for sub-modules, possibly with some form of=20
git-link file as an alternate marker.

The thought process is to map sub-module working onto the other object=20
types (blobs and trees). The user would be unable to edit the trimmed=20
files/directories anyway, so its sha1 value can't change, allowing it t=
o=20
be included in the next commit in the branch series.

Philip

> --
> Duy
> --
