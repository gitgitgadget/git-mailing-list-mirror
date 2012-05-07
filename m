From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 7 May 2012 11:35:08 +0200
Message-ID: <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com> <4FA7952C.90702@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 07 11:35:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKME-0003rX-RY
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab2EGJfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 05:35:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32948 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab2EGJft convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 05:35:49 -0400
Received: by pbbrp8 with SMTP id rp8so6455361pbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=m0Lns0Cfwl/co8vBC4aZcuwqDufccuGpaRifcSSvOBs=;
        b=BjrC0vpVG3C6gPh+JotfV5QytDQ+4RYN2tvdGRjn8irzoBsGoYRYjGqhAvdCile+Mr
         ueLJtHlXf+WHk4f9tis7GUthNN7Btxnp43RS0Ug64ihlyOKuwj3MCTrnxwoZ+sjH6JLN
         ms0d4QGorV8K9mVzeL/p85rk9tshzkZbWWr40mjdRlvMW9xMok0QAGnB/YVJGzGgwyE6
         v6VMnSZaCt41xK2TaK9TjaPkHu3Qw/cMPPWD9sffpxXiYfy4zzOQCyf/monuDzcqUAgr
         ccNKlmdkRyrq1VSroRac5rpcytpls+1QRx482I7hI5UzcflzdPLsi6Nx3oL9ohxwVkiw
         z7Pw==
Received: by 10.68.233.2 with SMTP id ts2mr6116523pbc.27.1336383348756; Mon,
 07 May 2012 02:35:48 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Mon, 7 May 2012 02:35:08 -0700 (PDT)
In-Reply-To: <4FA7952C.90702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197248>

On Mon, May 7, 2012 at 11:26 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 5/7/2012 11:09, schrieb Erik Faye-Lund:
>> When cloning a large repository over a local file-system
> ...
>> $ git clone some-repo.git some-other-repo
>> Cloning into 'some-other-repo'... =A0 =A0<happens instantly>
>> done. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
<hangs for minutes>
>> $
> ...
>> I asked git
>> to clone, and it told me it finished, only to hang around for
>> several minutes while, judging by the output, doing nothing.
>
> We have a nice "Checking out files" progress indicator. I wonder why =
you
> do not see it.
>

That's a very good point, I forgot about that one. I'll investigate
that part. Just to be clear, I'm seeing this problem on version
1.7.10.1.457.g8275905 (junio's 'master' as of right now, AFAICT) on
CentOS. I've built with:
NO_OPENSSL =3D YesPlease
NO_CURL =3D YesPlease

"git config -l" does not reveal that any progress related
config-options are set.

> At any rate, it's better to write "done" only after we're really done=
=2E

Well, perhaps, but at the same time perhaps not: We only write it for
local clones, because the remote-clones are quite chatty to begin
with, and the remote-stuff seems to inform about it's actions by
printing "<performing task x>...done!". Moving the final
"done."-printing to the very end might be a step in making these
outputs even less consistent. But it might not be important.
