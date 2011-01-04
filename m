From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] daemon: support <directory> arguments again
Date: Tue, 4 Jan 2011 13:42:58 +0100
Message-ID: <AANLkTi=+umAwVv5XUc8rng4dxr=1LfD=67=yS700zC4F@mail.gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
 <1288834524-2400-9-git-send-email-kusmabite@gmail.com> <20110104040446.GA3541@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 14:01:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa6Vf-0004aX-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 14:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1ADNBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 08:01:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43193 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1ADNA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 08:00:59 -0500
Received: by fxm20 with SMTP id 20so14030769fxm.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=gIdsukjgjXI+XUrWqLms3DadOu5sKiyh7htc8Ix/zik=;
        b=ihwUEOaXTBPmEa96Ui3AFz5or5sZ+IKEOPFI5m3AGBNf/gfJGB02vjUV6vcX0w8OBC
         HREmMJ5BqSZjTFjGKYqqPFBL4kfUWk2JhjKa+Fu3Ng5RCCAJxdvwqiseVryRXQD/0otY
         jCp59KCbfVFWEnq+A+qPOaU4xE6AlXlIAXjnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=aHnhBlbvSA22RdDcTyfGhpsNpFLapiFcLXXc4oT+HrgcKf0zGjGTQEE246uNhcSXHh
         L9YSPeHx4/tZ+gm7kCekrmPfdsKBts9NDx3uiAko4pZ1AdyJ6uiCP+0xenE3rWHYCPHI
         h9tzWCd1HBph3jilzHNlA2RSI0Mix+gq6DcyY=
Received: by 10.223.112.1 with SMTP id u1mr4036856fap.109.1294144998739; Tue,
 04 Jan 2011 04:43:18 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Tue, 4 Jan 2011 04:42:58 -0800 (PST)
In-Reply-To: <20110104040446.GA3541@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164488>

On Tue, Jan 4, 2011 at 5:04 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Ever since v1.7.4-rc0~125^2~8 (daemon: use run-command api for async
> serving, 2010-11-04), git daemon spawns child processes instead of
> forking to serve requests. =A0The child processes learn that they are
> being run for this purpose from the presence of the --serve command
> line flag.
>
> When running with <ok_path> arguments, the --serve flag is treated
> as one of the path arguments and the special child behavior does
> not kick in. =A0So the child becomes an ordinary git daemon process,
> notices that all the addresses it needs are in use, and exits with
> the message "fatal: unable to allocate any listen sockets on port
> 9418".
>
> Fix it by putting --serve at the beginning of the command line,
> where the flag cannot be mistaken for a path argument.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> On the client side:
>
> =A0$ git clone git://localhost/git/git.git
> =A0Cloning into git...
> =A0fatal: read error: Connection reset by peer
>
> On the server side:
>
> =A0# $git_src/bin-wrappers/git daemon --verbose --base-path=3D/var/ca=
che /var/cache/git
> =A0fatal: unable to allocate any listen sockets on port 9418
> =A0[3602] [3604] Disconnected (with error)
>
> Bisects to v1.7.4-rc0~125^2~8. =A0This patch seems to fix it. =A0Thou=
ghts?
>

Looks good to me. Thanks for finding and fixing it!
