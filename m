From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 23:44:00 +0200
Message-ID: <20130731214400.GH19369@paksenarrion.iveqy.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
 <1375300297-6744-1-git-send-email-bcasey@nvidia.com>
 <1375300297-6744-2-git-send-email-bcasey@nvidia.com>
 <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
 <20130731212114.GG19369@paksenarrion.iveqy.com>
 <CA+sFfMfzHh5kbyv673e6V=Md14DZBqDaLFwspfcZNBGomZBV9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4e97-0006J3-L5
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634Ab3GaVlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 17:41:21 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52105 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab3GaVlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:41:20 -0400
Received: by mail-lb0-f181.google.com with SMTP id o10so974354lbi.40
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d3zWXtzR8r9dXn45viX2dOvlGcyXcmVp88PcvQxnH2k=;
        b=kc41JO2EVsed04OE/Ae116TGCoiNfDzI8VmqxZHVa9rDauECvK33x5+DdM4J/TEaQa
         fEoHFMjzk592M6046OQlfk1+3rYOFV+lOtR9cuaBhAunn8je0fntmOMc2KkrcDAsFGnc
         hHU6ycnN4/n244mogVxB6urER8IweqvZWVwjtM8UReGNdaKb7WG9rUun2wy+1CNIRihn
         x4ODsCO7jGSxWu7X6Am6D04eFy7mRZGwRtV+o+aWJGtjP39TQcgGyRID9uDlAzy3HH76
         p48XB1FhAjK3H+8i2A6WKOVMWG4z63m0niD8P/fy06VWCvJdgUKp8RLicSbreb023QLQ
         mgZQ==
X-Received: by 10.112.63.2 with SMTP id c2mr156515lbs.6.1375306878809;
        Wed, 31 Jul 2013 14:41:18 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id l10sm30980lbh.13.2013.07.31.14.41.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 14:41:18 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4eBc-00059B-MP; Wed, 31 Jul 2013 23:44:00 +0200
Content-Disposition: inline
In-Reply-To: <CA+sFfMfzHh5kbyv673e6V=Md14DZBqDaLFwspfcZNBGomZBV9g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231468>

On Wed, Jul 31, 2013 at 02:31:34PM -0700, Brandon Casey wrote:
> On Wed, Jul 31, 2013 at 2:21 PM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> > On Wed, Jul 31, 2013 at 11:08:21PM +0200, Antoine Pelisse wrote:
> >> On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com>=
 wrote:
> >> > ----------------------------------------------------------------=
-------------------
> >> > This email message is for the sole use of the intended recipient=
(s) and may contain
> >> > confidential information.  Any unauthorized review, use, disclos=
ure or distribution
> >> > is prohibited.  If you are not the intended recipient, please co=
ntact the sender by
> >> > reply email and destroy all copies of the original message.
> >> > ----------------------------------------------------------------=
-------------------
> >>
> >> I'm certainly not a lawyer, and I'm sorry for not reviewing the
> >> content of the patch instead, but is that not a problem from a leg=
al
> >> point of view ?
> >
> > Talking about legal, is it a problem if a commit isn't signed-off b=
y
> > it's committer or author e-mail? Like in this case where the sign-o=
ff is
> > from gmail.com and the committer from nvidia.com?
>=20
> It never has been.  My commits should have the author and committer
> set to my gmail address actually.

Oh, that's why the extra "From: " - field below the header is for.

>=20
> Others have sometimes used the two fields to distinguish between a
> corporate identity (i.e. me@somecompany.com) that represents the
> funder of the work and a canonical identity (me@personalemail.com)
> that identifies the person that performed the work.
>=20

In some contries your work when you're employed does not belong
to you but to your employer and when you're acting for your employer
you're representing the corporate legal person. Therefore two different
e-mails can be seen as two different (legal not physical) persons.

At least that's how I understand those "legal tips for developers" I've
got.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
