From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] revert: report fine-grained error messages from insn parser
Date: Tue, 10 Jan 2012 20:54:35 +0530
Message-ID: <CALkWK0kepNnnBUvCyXMY5Da3nJ5P6F66g7yy=VmDxVZ060=e4Q@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-6-git-send-email-artagnon@gmail.com> <20120108200748.GJ1942@burratino>
 <CALkWK0mStgcb4EBB+ni9fisDJY=13cJZWCTEcgfyOUyAXbc=tA@mail.gmail.com> <20120108213318.GQ1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 16:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkdZO-00074l-Tf
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 16:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab2AJPY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 10:24:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65134 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2AJPY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 10:24:56 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr10so3171517wgb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VgsxJEwQg0fdl6Kbptrb+FCuaoE70CR+nW3qa8IHcA8=;
        b=HIlTRMDjxJnkDgc63000RR3TYlt55LpbYQtZsPoWDOEMwPcdm7f2JpxkQDZUehFNMr
         Qv8fLFqprN8/FOlDeD1NRP3I4h8I3Jwr4dKjmd2srTW+dKlCVzQNgX4cWkEJhOHzsm3v
         QaoBG2TaVjsYviInDgCusQSx3GT7R4HvzA9s8=
Received: by 10.180.77.200 with SMTP id u8mr12715173wiw.18.1326209096193; Tue,
 10 Jan 2012 07:24:56 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 07:24:35 -0800 (PST)
In-Reply-To: <20120108213318.GQ1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188254>

Jonathan Nieder wrote:
> My "alternatively" was bogus --- lookup_commit_reference takes a (raw=
)
> full commit name as its argument.
>
> I dunno. =C2=A0The question was not actually rhetorical --- I just me=
ant
> that it's worth thinking about these cases. =C2=A0There are a few cas=
es:
>
> =C2=A0- missing object
> =C2=A0- object is present but corrupt
> =C2=A0- object is a blob, not a commit
>
> In the second case, there's an error message printed describing the
> problem, but in the other two there isn't. =C2=A0The other callers te=
nd to
> say "not a valid <foo>" or "could not lookup commit <foo>, so I guess
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: .git/sequencer/todo:5: not a valid =
commit: 78a89f493
>
> would be fine.
>
> Except that this focusses on the .git/sequencer/todo filename which
> would leave the person debugging astray. =C2=A0It is not that
> .git/sequencer/todo contains a typo (that would have been caught by
> get_sha1), but that it referred to a bad object or non-commit. =C2=A0=
Maybe
> something in the direction of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: cannot pick 78a89f493 because it is=
 not a valid commit
>
> would be more helpful.
>
> Is this the right moment to report that error? =C2=A0Will the operato=
r be
> happy that we errored out right away before cherry-picking anything
> and wasting the human's time in assisting with that process, or will
> she be unhappy that inability to do something later that she might
> have been planning on skipping anyway prevented making progress right
> away? =C2=A0(I'm not sure what the best thing to do is --- I guess so=
me
> advice like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: to abort, use cherry-pick --abort
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: to skip or replace that commit, use =
cherry-pick --edit
>
> would help.)

Ignoring this in the re-roll: I'd be inclined to put these changes in
a separate series that begins with bolting on some advice
configuration to the sequencer.

Thanks for thinking about these things.

-- Ram
