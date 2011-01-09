From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Mon, 10 Jan 2011 00:48:28 +0700
Message-ID: <AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <alpine.LFD.2.00.1101061956470.22191@xanadu.home> <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
 <AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
 <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
 <AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com> <AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 19:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbzZu-000310-IB
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 19:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab1AISBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 13:01:12 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44340 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1AISBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jan 2011 13:01:10 -0500
Received: by wyb28 with SMTP id 28so18825650wyb.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W8bD9hC/Eqy1dC0R++38vxVn2sj4Af0bjCikIIXUYPk=;
        b=LWgSv27I6gDlwGVl+RMc3Dp7NfrYM5KwFmoOKTMPnjOIe+YTuvyD62Ow3msMWG0qfQ
         0pZMHAwhaD0Ta3po5GcOjoOQKGkaFrC97zZXZEKHjf8a7UqdvZ5hj/gDLloSyxjx7QX7
         EAGfpYjQPPxEboLzB1kELaQfjZpRuc0tF44+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eVVEhyXhOoGDQaqGkljQd5JsjifAPClasf4WdYXSOGl1ARnkwVC6xY613GZJVcYf5J
         0OygObfEUEIdi9z8qC2+Uv3HVZXNu2RbKWFiX9TvXq1kcik6+f4x4JzAqKhyTomVpQw4
         POYMujj13+2WjLxTOBEQwwmS4SViNdnUylc+k=
Received: by 10.216.169.71 with SMTP id m49mr5668764wel.4.1294595402509; Sun,
 09 Jan 2011 09:50:02 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Sun, 9 Jan 2011 09:48:28 -0800 (PST)
In-Reply-To: <AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164855>

On Sun, Jan 9, 2011 at 8:55 PM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> =C2=A0you still have to come up with a mapping from "chains" to "piec=
es".
> in the bittorrent protocol the mapping is done *entirely* implicitly
> and algorithmically.

Given a commit SHA-1, the mapping can be done algorithmically because
the graph from the commit tip is fixed. Perhaps not mapping all at
once, but as you have more pieces in the graph, you can map more.

> the "meta" info in the .torrent contains
> filenames and file lengths. =C2=A0stack the files one after the other=
 in a
> big long data block, get a chopper and just go "whack, whack, whack"
> at regular piece-long points, that's your "pieces". =C2=A0so, reassem=
bly is
> a complete bitch, and picking just _one_ file to download rather than
> the whole lot becomes a total pain.

Well, there won't be .torrent files. Torrent files serve as checksums
for file pieces (let's forget the tracker part). We do sha-1 checksum
on every objects in git. The object graph without real content _is_
"info" part in .torrent files. Instead of passing around torrent
files, I only need to pass around the sha-1 of the commit tip(s). That
should be enough for any peer to discover the rest.

Reassembling, in its simplest way, is to just dump loose objects to
$GIT_DIR/objects. But it's been six years since git's birth now, I'll
pack them instead.

> =C2=A0that's hard work and you're now into "unproven" territory. =C2=A0=
the
> successful R&D proof-of-concept code that i wrote i _deliberately_
> stayed away from "adapting" a proven bittorrent protocol, and as a
> result managed to get that proof-of-concept up and running within ...
> i think it was... 3 days. =C2=A0most of the time was spent arseing ab=
out
> adding in a VFS layer into bittornado, in order to libratise it.
>
> i mention that just to give you something to think about. =C2=A0if yo=
u're
> up to the challenge of writing your own p2p protocol, however, GREAT!
> you'll become a world expert on _both_ peer-to-peer protocols _and_
> git :)

Maybe I have gone insane ;) But I have another aim for this work: to
adjust narrow clone area (pretty much path-based clones). So while it
may not become real torrent for git (i.e p2p exchanging, depends on my
needs), restartable clone from multiple sources is still worth it.
--=20
Duy
