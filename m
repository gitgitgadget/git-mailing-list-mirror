From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Fri, 14 May 2010 11:07:41 +0800
Message-ID: <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
	 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
	 <7veihh8y8b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 14 05:11:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OClJ9-0006bK-6q
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 05:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab0ENDHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 23:07:43 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:63147 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0ENDHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 23:07:43 -0400
Received: by yxe29 with SMTP id 29so737922yxe.4
        for <git@vger.kernel.org>; Thu, 13 May 2010 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E4mjzbS6SFAbSxJrkTPUOkxcVHEzqexKgknT6d1+oBM=;
        b=eH9IBw3xpyn3lHlFObCnd4y2XTsdhP64Ht8pB56+N0fXzATzgMuD2lckGsvbiPO9gP
         rdnuKo3w1CTahRlrVxaGv/VYSRAlr0O4PM03kCIMOGwirRWO2TQoiSMnV2O/d3WVhib5
         5FL3Bf3XZxVxRYldGtVGNDuOvQvAspJoHFuDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hyitiiIKPzTKXV77oGcNLQbbnovkmTN4tVOEIO0bJHzJen/4uN6fN+3IaS6kE+kYXa
         44skPsQ5pQVVJ54fOUJzxv42afw+6BP5pp3PWmAB8E+jfwKQ+dGswjv0vhL+9FgPZLB3
         lfdbVfC5bqxRrvC6hLjTfAxvxuVbSID1yEgxw=
Received: by 10.231.161.146 with SMTP id r18mr40571ibx.81.1273806461717; Thu, 
	13 May 2010 20:07:41 -0700 (PDT)
Received: by 10.231.13.194 with HTTP; Thu, 13 May 2010 20:07:41 -0700 (PDT)
In-Reply-To: <7veihh8y8b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147040>

Hi,

On Wed, May 12, 2010 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> After 9c00de5 (ls-remote: fall-back to default remotes when no remot=
e
>> specified), when no repository is specified, ls-remote may use
>> the URL/remote in the config "branch.<name>.remote" or the remote
>> "origin"; it may not be immediately obvious to the user which was us=
ed.
>
> I cannot convince myself that this is a good change, as I've always
> thought "ls-remote" output as something people want to let their scri=
pts
> read and parse. =A09c00de5 may have given an enhancement to these scr=
ipts in
> the sense that they can now respond to an empty input from the end us=
er,
> but this patch forces them to change the way they parse the output fr=
om
> the command.

in this patch, the remote url is printed to stderr, instead of stdout,
so existing scripts should be safe.

> I also think this patch is solving a wrong problem.
>
> When an end user does not know which remote ls-remote would be talkin=
g to
> by default, what else does he *not* know? =A0Probably which remote "p=
ull"
> would be fetching from and what branch it would be merging with? =A0D=
oesn't
> he have a better command to use to learn that information to reorient
> himself when he is lost that way?

I'm not sure if there's a command to determine the remote - I'd be
interested to know it, if there's one.

That aside, I believe this patch as an attempt at improving usability.

Compare (pre-patch):

  $ git ls-remote
  (scratch head)
  $ git-x # to determine which remote we listed refs from

with (post-patch):

  $ git ls-remote

The advantage is minor, but I feel there's some added convenience.

--=20
Cheers,
Ray Chuan
