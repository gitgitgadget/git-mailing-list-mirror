From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Sat, 7 Aug 2010 10:21:31 +1000
Message-ID: <AANLkTinFQan-kdaW-wQ5Ca6WATgpDQzhA68w7WODeEFE@mail.gmail.com>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
	<AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com>
	<AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com>
	<AANLkTingdhx5osnbiLVMyWaauCf1TRiMzcSC76gQRp9B@mail.gmail.com>
	<AANLkTimEFjRuuO+GnAV7PGe0oPi-Qh37iLS6o3Q8Undw@mail.gmail.com>
	<20100807001829.GQ25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:21:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhXAQ-000401-Co
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0HGAVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 20:21:34 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47743 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0HGAVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 20:21:32 -0400
Received: by wwf26 with SMTP id 26so421058wwf.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MXkU3KoMIKLuLnajzA3nAo6LK90xUgStOjqjKklOGL8=;
        b=Ia7dxmXT8PDSjXB4JwqFbt37WBk78DgprmCb1XgAE/Z3t2bYMHpRlprLQk3+yDI1o6
         OOM/okKfSogKYzNjn3xlWd40Vr6O5jgLwlU7TzKWuZfltrRuGXcQKPQa4uiNdTD+DRfO
         +dYOc4ZG+3EWUjIZX/7aj/nonW3vJENgSqN1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ffdSw3FeupQbvu10S3ToDEAW7ECbfYRv7GVL1AHRYeGJs98ffPdqeUPDNFFd5+pM3d
         U/XWRZIwLxGvk8J6xng7VAR0vQcdwQJym8dWR7QLI771n9B2nmgscgpOYkStQQxKOGEr
         Zc3/0bYbAtgFb4cLarvVgN1txwQYhv0cQqwCc=
Received: by 10.216.87.18 with SMTP id x18mr6598607wee.31.1281140491144; Fri, 
	06 Aug 2010 17:21:31 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 6 Aug 2010 17:21:31 -0700 (PDT)
In-Reply-To: <20100807001829.GQ25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152831>

On Sat, Aug 7, 2010 at 10:18 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>> Ah, by packing it tighter using bitfields. There are two fields that
>> act as boolean, but they use at least one byte each. And enum
>> object_type, I recall, uses 4 bytes (int), while it only needs 5 bit=
s
>> (4 bits is enough if OBJ_BAD is not counted). No downsides I know of=
=2E
>
> Actually, object type is 3 bits in the pack file. =C2=A0So unless its
> using some additional magical values, 4 bits is sufficient to get
> you 3 bits and the -1 bad value.

Right. Obviously I miscounted.
--=20
Duy
