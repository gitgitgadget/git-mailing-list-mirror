From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 18:39:19 -0500
Message-ID: <AANLkTinRo5KxC9OQWyZMnqQP4WHi0sR5qqw6byr4V+3a@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<201101312244.10047.trast@student.ethz.ch>
	<AANLkTin2kTW85UC1r_1LUDVLiexcVDvt--9ndnXZ2ARS@mail.gmail.com>
	<7vd3nc4qr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 00:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk3LG-0003zz-1h
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 00:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab1AaXjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 18:39:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45618 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1AaXjU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 18:39:20 -0500
Received: by yxt3 with SMTP id 3so2216556yxt.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Li1V2qEfa1hnc162Xoiro8CyxUvLDbr9Si3CTRL7TKo=;
        b=Iq2/3xgdEWLtciAtLQX5PyCMAPrs/wm8dKFgetxW19Q5qIhhZEvuOXyn5Dm9TW5DQE
         H/dUzCk+EwCVxD7RRQBKrxWNEcf0c3iLKNM9XmPRili6h9PVqNVpSy5fUHVda4OxneFC
         1iUwNOuThr+30ndwIaCx/0AOWU0a5BqqeNrAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qFqpKzJSA02uIoDmDuSzd0DvN+hP8obtRj/GAiXicUA0D9ZjLmXTxQi+eYD5kV3T2O
         OnCCR6TI/D3IJu7ulNTwhBQr2psfEJFmgH7zub9pV3B/qGXSb7dWI9yjMvXWp1nyseeY
         W/5/KBJKXnHDNobO9hvmowsJ80xMpf3gQvyjk=
Received: by 10.146.167.13 with SMTP id p13mr10007859yae.1.1296517159994; Mon,
 31 Jan 2011 15:39:19 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Mon, 31 Jan 2011 15:39:19 -0800 (PST)
In-Reply-To: <7vd3nc4qr6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165776>

On Mon, Jan 31, 2011 at 6:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> IMHO there is no need to introduce the variable. If it will start
>> update both FETCH_HEAD and the remote-tracking branches since 1.8 it
>> will not break any code, because it is added functionality...
>
> Then you didn't understand the risks section, did you? =C2=A0Thomas c=
learly
> illustrated with an example where the script _expects_ origin/master =
to
> stay the same after "git fetch origin master".
>

I did understand what Thomas illustrated. I'm just thinking that the
range origin/master...FETCH_HEAD seems to be useful but in fact is
pretty useless, because you cannot guarantee the state of the
origin/master _before_ the fetch and therefore you cannot rely on the
results of range selections involving it.
By "guaranteeing the state" i mean that because of the current
implementation origin/master doesn't always mean/reflect the same
thing: it might be some _old_ and outdated push or it might be some
new state of the remote branch which are IMHO completely different
semantics.

That's exactly why it seems to me that it is important to always
update remote-tracking branches upon any related network operation. So
remote-tracking branch always represents the _same_ thing - the latest
state of the remote branch that you interacted with.


Thanks,
Eugene
