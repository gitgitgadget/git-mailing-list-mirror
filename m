From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 8/8] git_remote_helpers: push all refs during a non-local export
Date: Tue, 7 Jun 2011 19:32:22 +0200
Message-ID: <BANLkTimQ9ORrhLm7SAETYa+f8ov81wzUaw@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172129.GG22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU09N-00075n-3t
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390Ab1FGRdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 13:33:05 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51567 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451Ab1FGRdD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 13:33:03 -0400
Received: by qyg14 with SMTP id 14so2632552qyg.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=uMhHddRj7EMdMD5tVGj7kdmPZttxw9oJek7cchpkGPU=;
        b=vKrF+aN3Ecodzw0aVq649xIzqJ4iDylM0ihx3KzA6qyU8cCpbOjUORL/MamG6adJ/t
         vB+KXRgLlkpz6UuHgZBQNKII9InsGsEA0DnxSMvnqL1h+ZouVfQtoJgQd/Rkc1XTpWBX
         gEjM6PEezA58iWNYZCCE3K5FvBnvfyQ/WLr3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GN7peR4EOPoZxehpDvNfjXy5cyjtnumjkqI/8OVDV+EuTNhA6G59Mftoy8eLHRHABb
         w30CkNSKEAl8OGMeLaDyRW076O5nlw+lSnEr6LrqA8/yvmGhDLtiuzHHWBbCc45LTUom
         Px5jTRrf2xBH+w+uswutbGsa4g4DvoeuuOYHQ=
Received: by 10.229.127.99 with SMTP id f35mr4752209qcs.91.1307467982157; Tue,
 07 Jun 2011 10:33:02 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:32:22 -0700 (PDT)
In-Reply-To: <20110607172129.GG22111@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175233>

Heya,

On Tue, Jun 7, 2011 at 19:21, Jeff King <peff@peff.net> wrote:
> When a remote helper exports to a non-local git repo, the
> steps are roughly:
>
> =C2=A01. fast-export into a local staging area; the set of
> =C2=A0 =C2=A0 interesting refs is defined by what is in the fast-expo=
rt
> =C2=A0 =C2=A0 stream
>
> =C2=A02. git push from the staging area to the non-local repo
>
> In the second step, we should explicitly push all refs, not
> just matching ones. This will let us push refs that do not
> yet exist in the remote repo.

That repo is re-used though. Wouldn't this break for:

$ git push branch-a
$ # make commits on branch-a that shouldn't be pushed yet
$ git push branch-b

--=20
Cheers,

Sverre Rabbelier
