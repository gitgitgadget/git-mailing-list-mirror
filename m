From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] {fetch,upload}-pack: allow --depth=0 for infinite depth
Date: Wed, 25 Aug 2010 08:12:06 +1000
Message-ID: <AANLkTimqwXmRYVZLkYtGLd5=e1B0hKKePA0XzOYPrifd@mail.gmail.com>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
	<1282565304-3122-3-git-send-email-pclouds@gmail.com>
	<20100824135341.GA6457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uQ-00030j-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab0HXWXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37323 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab0HXWXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 18:23:31 -0400
Received: by eyg5 with SMTP id 5so3822632eyg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=99uKXdL2LW96FfRznjA+7oJ6Zy2X23wjxN08UIwI2eA=;
        b=dQrINnp37Jgmxf1kevYqj8YaaNJMroSX1uLnx4VaeYgADQ9V+B4YHEAraAJyqgI39d
         fnMTHpGOyevNO8Peqh8tNbv3XDIRxoq+lVxzdEnfXyIVVsUXxfQYqiZJ6sHp6d1hNX36
         nALBWT0DlB6Csk/Dq8GGKLSEzSV1ht61RmAQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AxZQpUkrBEQ41Yb7v8vAKtrOB1AOXAQUT6zLQ1scXBNTOoZBGXLFU3QQ4B5h4REsdw
         FLSWpxymdM41iMe2eFixi252ViJBcvh5IEYByWg8CH2aSHpc5t00cfDW4GdjdGbtqhlO
         VHXJoivNOOI9m/kwvlu3T5RjlUyrH+upnzzKU=
Received: by 10.216.1.17 with SMTP id 17mr16641wec.99.1282687927199; Tue, 24
 Aug 2010 15:12:07 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 15:12:06 -0700 (PDT)
In-Reply-To: <20100824135341.GA6457@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154368>

On Tue, Aug 24, 2010 at 11:53 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 23, 2010 at 10:08:24PM +1000, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> Users can do --depth=3D2147483648 for infinite depth now. It just lo=
oks
>> ugly. So make "0" special (i.e. infinite depth) at plumbing/protocol
>> level.
>
> What happens if I connect to an older server? Shouldn't "I understand
> depth=3D0 is infinite" be a server capability, and we hack around it =
by
> sending depth=3D2^32-1 when we have a modern client but an older serv=
er?

Older servers won't accept depth=3D0, dying with "Invalid deepen"
message. I don't really want to send a large number as a workaround,
it just does not feel safe. Users can either play around with
--depth=3D2^32-1, or upgrade servers.

And in case of modern server and old client, old fetch-pack would
never send "deepen 0", so it's safe too, at least for current
fetch-pack.
--=20
Duy
