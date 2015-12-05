From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] setup.c: re-fix d95138e (setup: set env
 $GIT_WORK_TREE when ..
Date: Sat, 5 Dec 2015 06:48:44 +0100
Message-ID: <CACsJy8BXy03EMLRcXNKnkAj_kxreEVZYRVRTqNz2EMNZ-bfYrA@mail.gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com> <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1449166676-30845-2-git-send-email-pclouds@gmail.com> <xmqqa8pqrlz0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 06:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a55ih-0007Hf-KB
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 06:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbbLEFtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Dec 2015 00:49:15 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36165 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbLEFtP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2015 00:49:15 -0500
Received: by lbblt2 with SMTP id lt2so31725300lbb.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 21:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Pxqmx3xKgSMSE8ZE9zcyWOfEyI5sNzE3N0VZVEXhAtc=;
        b=vHEpPWecAlgtuSL2TGWpwtQCXH8qkaWqkBH/rzWtC6Erh/oGQnHZs2O8WG5u7+AWlC
         oYvYQcQXrTDAx39G+3Urj7iqd5z1FYRyteytg9t7vfetKPTkcJW+3ECXz3Ewd8/DZtP9
         SehtXYbITlKWclk6sGHFyNj7SWhdHtOXBvu7Xdj8UAuxyP6Z0zSyK8NPJy+PIooEvBTj
         3IPQfLllCg8VGp2D/e5FQIizTnl/KIQ02h7cscgKgNVNoBphcEH7DbMo3eK0IzANRfDv
         26PCPbeHuvnSm5+iFuMw1AgSbR8DunXDTP7p3kWyBtGERVT2vo4/p9eY9hOf+Gml63R9
         7sWw==
X-Received: by 10.112.171.74 with SMTP id as10mr9236291lbc.137.1449294553756;
 Fri, 04 Dec 2015 21:49:13 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 4 Dec 2015 21:48:44 -0800 (PST)
In-Reply-To: <xmqqa8pqrlz0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282026>

On Fri, Dec 4, 2015 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> ... Now I conclude
>> that setup-messed-by-alias is always evil. So the env restoration is
>> done for _all_ commands  whenever aliases are involved.
>
> So a side effect of this is whenever an alias is involved, all
> commands are re-spawned, not just the external ones but builtins as
> well.

I missed that while re-reading c056261, but yes that's true. So
Windows folks will be grumpy anyway. Maybe we can avoid that in
certain (safe) cases, when we know the second setup_git_... will be
executed by the builtin command and won't have any side effects, which
is probably the common case. But let's see how it goes.
--=20
Duy
