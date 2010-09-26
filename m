From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH/RFC] rev-parse: stop interpreting flags as options to
 rev-parse once --flags is specified
Date: Mon, 27 Sep 2010 00:39:54 +1000
Message-ID: <AANLkTinQU3aoyBtD9-mSm_Oq5xiqNxmfJ-CncFgN1G07@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
	<AANLkTi=8gv5arpdOVGHvf7sjNd==G=a4HoBBTbizq=OK@mail.gmail.com>
	<AANLkTim0oxhgtgqbrqP-jDL29jj0y=h6BLssEAFzags9@mail.gmail.com>
	<7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 16:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzsOX-0006gJ-Rr
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 16:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab0IZOj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 10:39:57 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49481 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 10:39:56 -0400
Received: by qyk36 with SMTP id 36so3732943qyk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uwqrmBtCaQQQIhm1ctUNew4lZTsn7KiL32dZBcOdKy4=;
        b=EecwOKQBzNGJ8TM1ymcXgHc12YzbsoKM8L0d0kLM7UBXt6CZyU+lJdCkpIBD4RBKqg
         JfcthT/rbyBZPgJWEwINf5r60kRluwOkaFTASWrBSJgjSuzqXH7YX/+J0fdtcrHG51Gb
         ZWMlZTovSwnAJHfwmKSgQSGMrjaXg7GdMDY8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e2C3ep8zJ59szHtHYX828bvVBmPWtsEq39u4DSMf0IR54P2jKvosEZpeCLcF38mVsU
         49G4XaWM9tIwLdQjGRGYqLQdF+voar4KmDlqfntpiCbaI+FsSSs6WuwLBG9cWTIDali+
         /ePv9S29U1kxvRWJQyjgCwN4ldVBHDvO18qpA=
Received: by 10.229.89.146 with SMTP id e18mr4543748qcm.138.1285511995038;
 Sun, 26 Sep 2010 07:39:55 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sun, 26 Sep 2010 07:39:54 -0700 (PDT)
In-Reply-To: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157226>

On Sun, Sep 26, 2010 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Mmmm...almost certainly not going to regress anything, since there
>> does not seem to be a test or script that uses --flags. Ahem.
>
> I've already explained the historical background in a separate messag=
e; I
> realize that my message was missing the important part: conclusion.
>
> If there weren't rev-parse before and we were about to invent the com=
mand,
> I would agree that --flags should suppress output of HEAD. =C2=A0Also=
 I doubt
> anybody relies on --flags for the purpose of removing non-revision
> arguments. =C2=A0So in that sense, your change would not hurt people.
>
> But I do not think encouraging the use of rev-parse to pick "flags" i=
s a
> good idea in the longer term anyway, so I do not care too much about =
this
> issue. =C2=A0Unless you will teach "rev-parse --flags" about all the =
options
> all other git command take (e.g. it should know --ignore-submodule ta=
kes
> an optional option argument and be able to parse "--ignore-submodule =
all"
> out), which is fundamentally impossible (e.g. for some commands "-n" =
does
> not take argument, for some other "-n" takes an integer argument, and=
 the
> rev-parse command fundamentally cannot decide if it should report wha=
t
> follows "-n" as part of its "--flags" output).
>

Ok, so I have withdrawn the patch that makes --flags imply --no-revs.

v7 has 3 commits. The first commit documents existing behaviour more
accurately. The second commit adds a test suite for existing
behaviour.

I am offering the 3rd commit for discussion since your comments to
date have not directly addressed this commit. To recap, this commit
causes rev-parse to stop interpreting options once --flags is
interpreted.

=46or example, this would allow:

$ git rev-parse --flags --all
--all
$

whereas currently:

$ git rev-parse --flags --all
 .. list of revisions ..
$

As it stands, --flags really can't be used for any useful purpose. It
can't be used to output arbitrary flag or rev-like arguments
compatible with rev-list because it eats --all for itself. it can't be
used with any option that it also recognises (such as -q).

This being the case, one has to wonder whether we shouldn't just
deprecate --flags so that people don't waste time trying to use it.

jon.
