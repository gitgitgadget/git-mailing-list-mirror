From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Thu, 2 Jun 2016 16:53:12 +0700
Message-ID: <CACsJy8DjKo-HcyG6sKhhvx8vtySn6VTTP-E6vX2uKNEJgjouZg@mail.gmail.com>
References: <574D382A.8030809@kdbg.org> <20160601104519.16563-1-pclouds@gmail.com>
 <xmqqshwwzyee.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 02 11:53:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8PK5-00017e-2z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 11:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbcFBJxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 05:53:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33457 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbcFBJxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 05:53:43 -0400
Received: by mail-io0-f193.google.com with SMTP id p194so5868163iod.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zPScbaOns0ndij4npbIVcEFZhF+n+6fTbWGHWtuElPo=;
        b=Voj1o6Qfrla9USEyGy4jcz98n3JYXEhP/REH0ooPqwVmL7z7lSDbUG21e5jR3WKbN/
         6JDtmrIa2gC9tn6KzWXpL3LO/6V6nCRXTtPINrbKnmFUhaN0bL9pi0O3Frc/P73v7ERq
         EoIP22uCinyks6p4IoaBdrhnzSiSrcKnWQzkd3KKI46OrOKOe6+dmyucTvKOM8cTmCRQ
         9oZmB5HkP+lu0pSJru9t9QKLa7UsmS+f0A1boLQt2GVWWZlj7l9Bei9wYHT/1i4xcx9t
         CYRMD2KhHCIJC7hFvAWntadDb6EalKPOlAP7ytyZLB62oVaOcez6vKFc1F8OUw/eY3Oh
         KY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zPScbaOns0ndij4npbIVcEFZhF+n+6fTbWGHWtuElPo=;
        b=mhNUh1DD5xBDcnW2Ep6BF6hrT/8E5muquMSBeYp/TRgrXoj3EW7fupwUCdNDK5VW2A
         4cfb/oKXfq0ASnCvEOhp7Rp2dA2cZQUMEcRMLSVWBpcdO33CbBWK2DhWD0P/6AwBBQMj
         J15y7NwKMwar5qf8bAjnJ3tV0bj6J/j+X6/mkz8JQUBdLXaX7HRyjlv3qYjEjD8POKvX
         mFNdrKBSGPFX8phtQuuQULrIoXybdXXD7GkrPsauHa99CeAg6ZXGtnxFznrm1DqyV3py
         7E8gkxycwKpnHHYVN6xNqgY38FRIKZXZsM+iAg6TNnTQq4QbW75TYYTKr1BLcZzC5Msr
         w7aA==
X-Gm-Message-State: ALyK8tLg/E146m8TSFhrH6ne2vK9q7ONPGGHJ0NPWV6FGhk8m8EUwTdfRzkWb7pzMRCPsbQsQst/7TUrBI5KaA==
X-Received: by 10.107.159.84 with SMTP id i81mr1976685ioe.29.1464861222354;
 Thu, 02 Jun 2016 02:53:42 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 02:53:12 -0700 (PDT)
In-Reply-To: <xmqqshwwzyee.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296192>

(from patch 4/4 mail)

On Wed, Jun 1, 2016 at 10:51 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
>> +     path =3D xstrdup(worktree_git_path(wt, "logs/refs/bisect"));
>> +     if (file_exists(path))
>> +             handle_one_reflog(path, NULL, 0, &cb);
>> +     free(path);
>> +}
>
> `refs/bisect` is not a single reference. It is a namespace that conta=
ins
> references with names like `refs/bisect/bad` and
> `refs/bisect/good-66106691a1b71e445fe5e4d6b8b043dffc7dfe4c`.

Yeah I missed that. I'm not going to write another directory walker to
collect all logs/refs/bisect/*. I didn't add pending objects for
refs/bisect/* of other worktrees either. At that point waiting for the
new ref iterator makes more sense...

On Wed, Jun 1, 2016 at 11:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This series makes sure that objects referenced by all worktrees are
>> marked reachable so that we don't accidentally delete objects that a=
re
>> being used. Previously per-worktree references in index, detached HE=
AD
>> or per-worktree reflogs come from current worktree only, not all
>> worktrees.
>
> I'll let this topic simmer on the list for now, instead of picking
> it up immediately to 'pu', as Michael in $gmane/296068 makes me
> wonder if we want to keep piling on the current "worktree ref
> iterations are bolted on" or if we want to first clean it up, whose
> natural fallout hopefully would eliminate the bug away.

So what should be the way forward? My intention was having something
that can fix the problem for now, even if a bit hacky while waiting
for ref iterator to be ready, then convert to use it and clean things
up, because I don't how long ref-iterator would take and losing data
is serous enough that I'd like to fix it soon. If we go with "fix soon
then convert to ref-iterator later", then I will drop the
logs/bisect/* check, checking logs/HEAD alone should be good enough.
Otherwise I'll prepare a series on top of ref-iterator.
--=20
Duy
