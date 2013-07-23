From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Tue, 23 Jul 2013 08:20:54 +0700
Message-ID: <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 03:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1RI9-0005d7-SG
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 03:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3GWBV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 21:21:26 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:48082 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3GWBVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 21:21:25 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8836275obc.40
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u30cnIGodyNAPt2CArz42DEZJemxuL76K9Ef7z/P4Fo=;
        b=UKeLURBHHvC/rG+pEC968wVFPmw8QfuGZYJa7oEm7ieAK1GmwpZC/IK2bYI5assEsa
         lTQT2aMZUXimq9sKz+e0MnTxMOpCL5CZDKOHvL9EuN+5mWz8TTyWhKY8CbWrvQYBZOuA
         6Hhrt2a4FbbWgBwgojkShRKcTE6XhxZPf3f6SXU0Tcljva+3RQVXub9juvezLZH6rY9O
         s9YRTH5lG7HbPcN4HmIUYbjyuGkUXEwjWziaJeIAhyHYL8YxLmFq3ZKqLVDuc4uzqcWn
         uwKROBX8unEY93d86tp01Wlbf0t3YcL8vZv7aNHnHqfx/jvuttlqCUB2NCDXTP7bnqhq
         UQWA==
X-Received: by 10.60.45.138 with SMTP id n10mr28103811oem.101.1374542484728;
 Mon, 22 Jul 2013 18:21:24 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Mon, 22 Jul 2013 18:20:54 -0700 (PDT)
In-Reply-To: <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231014>

On Tue, Jul 23, 2013 at 6:41 AM, Philip Oakley <philipoakley@iee.org> w=
rote:
> From: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> Subject: [PATCH v2 00/16] First class shallow clone
>
> It's nice to see that shallow can be a first class clone.
>
> Thinking outside the box, does this infrastructure offer the opportun=
ity to
> maybe add a date based depth option that would establish the shallow
> watermark based on date rather than count. (e.g. the "deepen" SP dept=
h could

I've been carefully avoiding the deepen issues because, as you see,
it's complicated. But no, this series does not enable or disable new
deeepen mechanisms. They can always be added as protocol extensions.
Still thinking if it's worth exposing a (restricted form of) rev-list
to the protocol..

> have an alternate with a leading 'T' to indicate a time limit ratherv=
 than
> revision count - I'm expecting such a format would be an error for ex=
isting
> servers).
>
> My other thought was this style of cut limit list may also allow a bi=
g file
> limit to do a similar process of listing objects (e.g. blobs) that ar=
e
> size-shallow in the repo, though it maybe a long list on some repos, =
or with
> a small size limit.

This one, on the other hand, changes the "shape" of the repo (now with
holes) and might need to go through the same process we do with this
series. Maybe we should prepare for it now. Do you have a use case for
size-based filtering? What can we do with a repo with some arbitrary
blobs missing? Another form of this is narrow clone, where we cut by
paths, not by blob size. Narrow clone sounds more useful to me because
it's easier to control what we leave out.
--
Duy
