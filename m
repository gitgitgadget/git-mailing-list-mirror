From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:32:20 +0530
Message-ID: <CALkWK0=UacRnjWJJCtJttk4W_8cbTXQbpQTDJ2+45S9CxXXzAw@mail.gmail.com>
References: <20130409231332.GZ30308@google.com> <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net> <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net> <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net> <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <20130410195256.GA24177@sigill.intra.peff.net> <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
 <20130410202105.GE24177@sigill.intra.peff.net> <CALkWK0nfJezWbd3+VfA+DMqUNbekSJJJ539AmhQT37kkap_qeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Ad-0006AA-7F
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab3DJVDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:03:02 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41514 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3DJVDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:03:01 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1162792iec.41
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mPN9r8AZgv1ASFh+2hg40o1HkXesxAWDiywxChbNcb4=;
        b=OYvpAJrwLNszPNntSfXxibFYIIne57QiYcTPmwfXWwYyar7jZ3puC3g8wMg13UqFzT
         VBqzUSTA3R+YL1s4NYdC0S+01ac980yTgAc9CGadZV+CLqsx4GuRT/8fCguhauxpxHdd
         EFQYHrSlhsnp+UAikMjy02nnj2OMK/n+VMN2Mr0C/Jtr8frQ+wMGZPUf5d4K1HhtqzT2
         NysiESCOflWQakoZHsyZMq3eZGXm3DxW6SPctohO42/e9cTiW+j2bpDoazlycBkgrV3f
         Qta2WImuJuaasj9yGnPc29u3H8OBmCKlfSbNMOAR75TS1nI9gS7n/OvKMjifgUBaslOg
         IUow==
X-Received: by 10.42.50.202 with SMTP id b10mr2294523icg.7.1365627780942; Wed,
 10 Apr 2013 14:03:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:02:20 -0700 (PDT)
In-Reply-To: <CALkWK0nfJezWbd3+VfA+DMqUNbekSJJJ539AmhQT37kkap_qeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220761>

Ramkumar Ramachandra wrote:
> Jeff King wrote:
>> If we are not going to break the existing behavior, I think it can be
>> argued that consistency and simplicity of the rules is important, so the
>> user can predict what will happen. But the more we discuss, the more I
>> think we should simply change the current behavior (to stop respecting
>> branch.* config with "matching"), which just seems wrong to me. Then we
>> can be simple and consistent, and do what the user probably intended.
>
> So there are some push.default options that respect branch.* config
> (ie. "current"), and others that don't (ie. "matching").  I would
> argue that push.default is badly designed to begin with, so the
> solution makes sense to me even if the patch is a bit of hack; we
> never guaranteed that the various push.default options respect the
> same configuration variables.

If we're going to break "matching" anyway, let's break it fully.  I
propose that we make it respect each individual branch's
branch.<name>.pushremote/ branch.<name>.remote and push the branch to
that remote.  That'll let us design a git push -- master
implicit-push; that actually makes sense.
