From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 09:22:21 -0500
Message-ID: <AANLkTi=uxRfsy2vG+4CBJv8Vhjrr2roVOXeNLvPA+6U+@mail.gmail.com>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com> <vpq4ob9qy6f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 22 15:23:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKXIN-0008Md-RI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 15:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab0KVOWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 09:22:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37579 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab0KVOWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 09:22:44 -0500
Received: by fxm13 with SMTP id 13so2663003fxm.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EzNEp1HBX9Q8XcjH5cs9lqG1PJHnVyV2bU7KickxxVg=;
        b=qLhdmrDN93lWiWxZ5zaIabMhoJ2sXL6kvrivwJVthni12Ckk8J2dGi3FZsjVAcQnQx
         u8n3LFukCpeVRwM10GuGln1q/uggR197PkoNTHinWH9XSG6bzNAt5V9rf1zwUuZ/Jjji
         buDYZJ0u1UJbtJZ5aavdeTzljZueVNNdeOGUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NtarAO/dtXJmkkdBwsO6HpawRMIolmEu+0nNQ3aqEn8wRBAPaFVnwMS5r09zNbIVJ4
         mgWzUAdUFWwsl8l2Fyx7KW+GmO4C1OhkwNdTFFZDyfVR+Z1snu2g5OAh+0hFv7XINP3D
         n3gZt4gyU1AvOtWAmDWyD2zO+DqvqbP6mvMRk=
Received: by 10.223.93.142 with SMTP id v14mr5165893fam.49.1290435761786; Mon,
 22 Nov 2010 06:22:41 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Mon, 22 Nov 2010 06:22:21 -0800 (PST)
In-Reply-To: <vpq4ob9qy6f.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161896>

On Mon, Nov 22, 2010 at 8:34 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Patrick Doyle <wpdster@gmail.com> writes:
>
>> I just checked in modifications to 1/2 dozen or so files in a single
>> commit and pushed them to my server.
>
>> So now I want to figure out which modification(s) in which file(s)
>> introduced the problem.
>
> 'didn't read all the details of your message, but the way I'd have
> done this would be with stash --keep-index:
>
> (untested)
>
> git checkout the-one-that-works # staging area and tree checked out.
> git reset the-one-that-doesnt =A0 # just change the staging area
> git add -p
> # pick some commits
> git stash --keep-index
> # run some tests
> # if test fail then
> =A0 # happy, "git diff --staged" tells you what.
> # else
> =A0 git commit -m "first modification"
> =A0 git stash pop
> =A0 # goto the git add -p step.
> # fi

That looks kinda scary to me.  The last time I played with git-reset,
I ended up losing(*) the commit at the head of my branch.  ((*) Well,
I didn't "lose" it in the sense of "it's gone forever", but I lost it
in the sense of "it doesn't show up in git log anymore".)

This looks like I would end up committing changes on top of the "the
one that works" commit and not on the more recent, already on the
server, "the-one-that-doesnt" commit.

--wpd
