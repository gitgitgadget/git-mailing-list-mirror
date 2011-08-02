From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 10:11:28 +0530
Message-ID: <CALkWK0kvAaKdKT2Syzr2WdbHVShci+M-vHCJufWY0LDu5=ZGqA@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
 <201108020436.42148.chriscool@tuxfamily.org> <201108020447.02545.chriscool@tuxfamily.org>
 <201108020451.36617.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 06:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo6nj-00011E-D8
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 06:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab1HBElv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 00:41:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65273 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1HBElt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 00:41:49 -0400
Received: by wyg8 with SMTP id 8so2056646wyg.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 21:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XMvXvW8WGxV818Sd2bldl/ZvhU/33YLX3YA012VzTvs=;
        b=u3GWGdyf+XQDv7Bikd5ttARVc4Lym/APdZrnzY9Vo5cerHGL0C9JUe60FFXJ6+sCcd
         8bi0oxwvNLUbaa3KCKDRDYOaiigD674drbH/QHW+l3N648+anntCTXRvXmUpqMthSEX9
         yuWcqimSQSaAS4oWNqcM1iK3vkrhiwEWmeP1E=
Received: by 10.216.198.146 with SMTP id v18mr1304432wen.94.1312260108207;
 Mon, 01 Aug 2011 21:41:48 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 21:41:28 -0700 (PDT)
In-Reply-To: <201108020451.36617.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178439>

Hi Christian,

Christian Couder writes:
> On Tuesday 02 August 2011 04:47:01 Christian Couder wrote:
>> We can simplify this loop using strchrnul() like this:
[...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 1; *p; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit =
*commit =3D parse_insn_line(p, opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return error(_("Could not parse line %d."), i);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D commi=
t_list_append(commit, next);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strchrnu=
l(p, '\n');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0p++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Thanks for the valuable review.  I would have preferred to receive it
earlier in the development cycle than later- although I've queued this
along with other similar changes (error reporting/ stylistic changes;
not urgent), I'm not in favor of holding up the series.

Thank you.

-- Ram
