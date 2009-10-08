From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 8 Oct 2009 19:58:48 +0200
Message-ID: <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> 
	<fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com> 
	<20091008173900.GI9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net
X-From: git-owner@vger.kernel.org Thu Oct 08 20:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvxO8-0001La-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 20:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206AbZJHSAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2009 14:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758302AbZJHSAR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 14:00:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:50244 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZJHSAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 14:00:15 -0400
Received: by ey-out-2122.google.com with SMTP id 4so59109eyf.5
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1H4OHTqda14tYLuEQWP87ovC84OboaUaNnKHbQc8bCY=;
        b=qSdU4S+S7/Y4tijWd3ls7mn+8ai6G9ChVpiK8rNhEba1VSMKkjbq9A1Hn4bV3X+0wE
         J8jYtngIpOiucbePERSefz56a9+rizu1Z9HsCX+Kgr0ALnRZl8JB82bI1bfY1CUg8wDn
         pQXYwfruvGJ9eVuuORaYbLg5Cr27Ld+GZlzhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uCn2tcF0FqTOqOoSnTn8tYvaHO+8AsChr5i1tqzgWOGw7Ipq5vh96kIAk+WqLW1Qqh
         AVe7TKrAYWEtwZTi32I480GJBCgyjWnXPLwG8+tfodrNB7iCxlA5ccwGROF2QtzbEDnV
         5mehRKvzwxT9q5igXfUq/KCGaBZlFwfuwhTvA=
Received: by 10.216.89.138 with SMTP id c10mr512693wef.47.1255024748284; Thu, 
	08 Oct 2009 10:59:08 -0700 (PDT)
In-Reply-To: <20091008173900.GI9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129709>

Heya,

[edited Shawn's message somewhat to be more relevant to vcs-fast-import=
-dev]

On Thu, Oct 8, 2009 at 19:39, Shawn O. Pearce <spearce@spearce.org> wro=
te:
> IIRC my problem with options was we weren't enforcing them, and yet
> they were necessary for a successful import, e.g. import-marks or
> export-marks. =A0A minor error could cause a successful looking impor=
t
> that is wrong due to the marks being messed up, or not saved out.
>
> So I was leaning towards making these features, but then they
> aren't necessarily compatible with the other fast-import tools.
>
> I think we want to declare features for import-marks and export-marks=
:
>
> =A0feature import-marks=3Din.marks
> =A0feature export-marks=3Dout.marks
>
> and define these as paths to local files which store a VCS specific
> formatted mapping of fast-import mark numbers to VCS labels.
>
>
> Other options that are clearly git should be declared as:
>
> =A0option git max-pack-size=3D2048
>
> with the meaning of option being declared something like:
>
> =A0If the parsing VCS name appears as the first argument, the parsing
> =A0VCS must recognize and support the supplied option, and if not
> =A0recognized or not supported must abort parsing altogether.
>
> =A0If the parsing VCS name is not the first argument, it must entirel=
y
> =A0ignore the option command and not try to process its contents.

I think it makes to ignore options that are not for our vcs, as long
as options that change import behavior (such as marks, date-format)
are combined with, say, 'feature tool=3Dgit'. This way we can be sure
that when outputting out a vcs specific stream, it is only parsed by
that vcs.

Note: yes, I know that marks and date-format are features now, but
there's really no other suitable example that I could think of).

vcs fast import devs please ack this idea (and perhaps suggest
something other than "feature tool=3Dgit" if preferable) so that I can
reroll my gfi-options series :).

--=20
Cheers,

Sverre Rabbelier
