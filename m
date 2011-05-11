From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: warn if git authorship won't be retained
Date: Wed, 11 May 2011 08:50:13 +0100
Message-ID: <BANLkTinn5E29gLr89srxypEx9aauiL4h7Q@mail.gmail.com>
References: <1305055653-5133-1-git-send-email-luke@diamand.org>
	<1305055653-5133-2-git-send-email-luke@diamand.org>
	<7vhb92i2yu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCOW-0005Gd-F2
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab1EKQgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 12:36:06 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42432 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1EKQgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 12:36:03 -0400
Received: by qyk7 with SMTP id 7so2417384qyk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:36:03 -0700 (PDT)
Received: by 10.229.37.144 with SMTP id x16mr41945qcd.22.1305100213159; Wed,
 11 May 2011 00:50:13 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Wed, 11 May 2011 00:50:13 -0700 (PDT)
In-Reply-To: <7vhb92i2yu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173410>

On Tue, May 10, 2011 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:


<snip>

>
>> + ...
>> + =C2=A0 =C2=A0 p4_check_commit_author usernamefile3 alice &&
>> + =C2=A0 =C2=A0 cd "$TRASH_DIRECTORY" &&
>> + =C2=A0 =C2=A0 rm -rf "$git" && mkdir "$git"
>> +'
>
> When the commands in the && chain fails after 'cd "$git"' near the to=
p but
> not before 'cd "$TRASH_DIRECTORY"' near the end, you would end up sta=
rting
> the next test from somewhere different from "$TRASH_DIRECTORY".
>
> Do it like this instead:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"$GITP4" clone --dest=3D"$git" //depot &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd "$git" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr "$git"
>

Thanks - that might explain a few oddities I had when testing.

There's a few others of those in the earlier tests; I'll resend this
patch, and send a second patch to fix those if that's ok.

Regards!
Luke
