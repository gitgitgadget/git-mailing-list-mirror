From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n
Date: Thu, 24 Feb 2011 04:27:12 -0600
Message-ID: <20110224102712.GC14115@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 11:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYPs-0006HU-1R
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1BXK1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 05:27:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60254 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1BXK1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 05:27:18 -0500
Received: by vws12 with SMTP id 12so285916vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 02:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bJj2bAhNC8Ll97yP82zHavhDAEPKYqEOwrIQSae1tsE=;
        b=NPZRZmg9xwlG0LbpHWGplbBxaBTsVNN1AGadGSbIm6ab/qBLmZmB9+HyGaHpxAjB5P
         tr+FrNpoRMtnBMkR/v7/AW9gKOGCqI1WR1F/ZY0cGgX51ClMv0bjU1e5SapGbvq1n0db
         aDl0vMbDTXPlqD0s79g1mRUPwSmyoy6nrDhbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=b6/capwNUKUcYI5AjwODnFSkjx9LMqQ/2ihseUB6VYU+jFepq6ZZMt8I+Y/w55oEaX
         rio+J/hy3Ik698EDhfoxvzikvkjNWUI9HA6YrEkvo42qXKhJy1a1qboMgyLn8LuZzDBy
         IuvebVw87mEQLsg+K7a5y18zhGC/19fYpj5G4=
Received: by 10.220.128.35 with SMTP id i35mr115782vcs.209.1298543237468;
        Thu, 24 Feb 2011 02:27:17 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id a6sm3632744vcm.46.2011.02.24.02.27.15
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 02:27:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167794>

Erik Faye-Lund wrote:

> I like the idea, but perhaps we could auto-generate a Pig Latin
> translation or something instead?

Sorry for the fuss.  If I understand correctly, the remaining
issues with the current ab/i18n branch in 'pu' are:

* The series is too long to read in one sitting.

  Suggested fix: deal with some arbitrary early subset (35 patches?
  I'd even prefer around 20) first.

* Patch 2 (add GETTEXT_POISON) is conceptually complicated since
  its arbitrary string is not arbitrary.

  Suggested fix: split it into two patches.  But I am still not sure
  if that's considered acceptable?

* Patch 2 squats on a valuable use_poison() identifier space.

  Suggested fix: rename it to gettext_poison().

* Patches 5 (i18n: git-init basic messages) and onward do not
  explain "we are marking strings for translation, in
  preparation for translating them later" in their commit messages.

  Suggested fix: use titles like =C2=ABi18n: mark some "git init" messa=
ges
  for translation=C2=BB.  Or ignore the problem --- it's not a big deal=
=2E

* We haven't run an automated tool to check that this is a no-op
  in the -UGETTEXT_POISON case.

  Suggested fix: build without debugging symbols and compare the
  binaries.  Or invent a tool to check patches.  Or just use our
  eyes, like we always have.

Does that sound like a fair summary?  I'd be happy to reroll the
first 30 or so patches following whatever approach is the consensus
for these things to move this forward.
