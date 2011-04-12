From: "C. Scott Ananian" <cscott@laptop.org>
Subject: Re: precommit hook broken with "git commit <filename>"
Date: Tue, 12 Apr 2011 19:09:18 -0400
Message-ID: <BANLkTimm0CBP_vX1ZFoyLa7QR5qgnCgZKw@mail.gmail.com>
References: <BANLkTimB=TZ1gP-18ywbZUOZSbDamkRwCg@mail.gmail.com>
	<7vvcyjnpvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9mi5-0004ji-6h
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 01:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab1DLXJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 19:09:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39570 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab1DLXJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 19:09:19 -0400
Received: by pvg12 with SMTP id 12so22692pvg.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 16:09:18 -0700 (PDT)
Received: by 10.142.134.17 with SMTP id h17mr902976wfd.210.1302649758524; Tue,
 12 Apr 2011 16:09:18 -0700 (PDT)
Received: by 10.142.44.8 with HTTP; Tue, 12 Apr 2011 16:09:18 -0700 (PDT)
In-Reply-To: <7vvcyjnpvj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 2qq9zMgEfKASUZdCPehrZt5lscQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171427>

On Tue, Apr 12, 2011 at 5:04 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "C. Scott Ananian" <cscott@laptop.org> writes:
>
>> It appears that "git commit <filename>" breaks the git precommit hoo=
k.
>> =C2=A0Every other git command updates the index to make the
>> commit-about-to-be-made before running the precommit hook, and indee=
d
>> the 'pre-commit.sample' distributed with git assumes that the index
>> reflects the commit. =C2=A0However, in the case of "git commit <file=
name>"
>> the man page states "the commit will ignore changes staged in the
>> index, and instead record the current content of the listed files
>> (which must already be known to git)".
>
> Doesn't the command call the pre-commit hook with GIT_INDEX_FILE
> environment set to the temporary index used to create the (partial)
> commit? =C2=A0The sample pre-commit hook runs "diff --cached" between=
 that
> index and HEAD (or the empty tree), and should show the change about =
to be
> committed.

Thanks for the quick answer.  You're right, of course.  Our tests were
subtly broken.  Now that we understand how it's supposed to work,
everything looks fine.

Great work on git, btw.  Yet another case where something I think
might be broken turns out to be working correctly (and smartly) all
along, or was recently fixed, etc...
 --scott
