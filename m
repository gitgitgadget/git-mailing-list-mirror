From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 12:48:25 +0000
Message-ID: <AANLkTi=z6rs5U8N_piUUzR=t6oSNNF02RxVCws-1YRS1@mail.gmail.com>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
	<20100819030237.GE18922@burratino>
	<4C6CE61F.7060305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 19 14:48:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om4Xt-0000D9-R6
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 14:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0HSMs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 08:48:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48609 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0HSMs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 08:48:26 -0400
Received: by fxm13 with SMTP id 13so979321fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XDLUEbd/bgHStz4p9vq4cXmvjYuLsb1mgHGDCFp3Loo=;
        b=dO/HmYXn0fIDSmypapLst/dhCzeY+67+yRA98TTPNJjBCCrL77SJLdFq5OfdefP+40
         Yobdvz2xOZZ8z+uHAauWxOFs5xFV5CPuyj0i5TZc8xSmhTKRT786Vs/RFTWIgdFt7KoO
         6wl4zdYWCx8g4R4W49J91GfYgSXMuCFwxVevo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wKx/rmcXbJXgzXfP9e5a91iLkPl3JLd25rvQRINJmRNhAfB/xzHbTPtx5FnoCQIvjZ
         VgyNpGRFk0luimnm4aj4RrySXydVyRl2B/F7S+IXUkrzs3T6JHnWBeJ62c2QRziqUwON
         +OY/gdxDSV6IoLVME897PpzavpKC5fTZ1RyLc=
Received: by 10.223.105.76 with SMTP id s12mr9211472fao.107.1282222105319;
 Thu, 19 Aug 2010 05:48:25 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 05:48:25 -0700 (PDT)
In-Reply-To: <4C6CE61F.7060305@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153919>

On Thu, Aug 19, 2010 at 08:06, Johannes Sixt <j.sixt@viscovery.net> wrote:

> and I see these warnings:
>
> In file included from compat/regex/regex.c:71:
> compat/regex/regex_internal.c: In function 're_string_reconstruct':
> compat/regex/regex_internal.c:696: warning: unused variable 'prev_valid_len'
> In file included from compat/regex/regex.c:78:
> compat/regex/regexec.c: In function 'check_arrival_add_next_nodes':
> compat/regex/regexec.c:3062: warning: unused variable 'err'
>
> This happens because RE_ENABLE_I18N is not defined by regex_internal.h. Is
> this how it is supposed to be?

I noted these in <1282015548-19074-1-git-send-email-avarab@gmail.com>,
although I was off by one.

I haven't read all the relevant code, but we almost definitely do not
want RE_ENABLE_I18N, since we aren't doing the relevant setlocale()
things (and doing so breaks git, see the fix in the ab/i18n series in
pu).

I was going to report this upstream once I got around to finding out
what upstream *is*, I don't *think* gawk itself is the canonical
upstream, they just copy it from somewhere else (again, I *think*).
