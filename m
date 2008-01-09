From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] - Added recurse command to git submodule
Date: Wed, 9 Jan 2008 11:42:40 +0100
Message-ID: <8c5c35580801090242g3f755814pa56e896d0a8723bb@mail.gmail.com>
References: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
	 <7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCYP7-0002Nk-SV
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYAIKmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYAIKmm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:42:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:17316 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbYAIKmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:42:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so331841wah.23
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tZOygm2Fprv51Zb/oiPdyCxWw2KlqzXZGOf37S6T3cw=;
        b=sExdZfOvJTmO9nj6pcz5QtohrvR3rBUe8kWdQu0GSGHgzIDpB43wTJiVfMXenMODmT9+RSLQfXyyhfx3IabWThGlT5vxeGw3+Nk8rDaLskCZFXnBpCK6VkKyWOan8uffNvkLX1O6FL2Jnl6jSJvWxNtPrwJn07vyno+gcUtRF7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZaVpQW2UN0gf+4YoVRfCJ9I569QgAWWgqHMsHyBsR8TcUOut+JFjdXI7sdoXUdDIlKoiKAmFVUPmZ1IrqLhvB4z65yegLSeKLrktAWAKaZizCx//QEn/2oMD4mGErZ4+S1qmov8aO42X+xk9/B0wEmzlcv6qVZfUDrj4Gs/D8U4=
Received: by 10.114.190.6 with SMTP id n6mr668820waf.51.1199875360172;
        Wed, 09 Jan 2008 02:42:40 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Wed, 9 Jan 2008 02:42:40 -0800 (PST)
In-Reply-To: <7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69979>

On Jan 9, 2008 9:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not still convinced that a subcommand other than init,
> which is started recursively, should initialize and update
> submodules that are uninitialized.

I very much agree; this behaviour would break the current 'usage model'.

> I suspect that it might be a saner approach to:
>
>  - allow "git submodule recurse init [-d depth]" (although I am
>    not sure if limit by depth is so useful in practice -- only
>    experience will tell us) to auto-initialize the uninitialized
>    submodules;

A possible extension is to specifiy "inter-submodule" paths to the
init subcommand, i.e. for a possible KDE layout:
  git submodule -r init kdelibs kdelibs/admin

This should then recursively initialize the kdelibs submodule and the
admin-submodule (in the kdelibs submodule).

Btw: from my reading of the code, the git-command specified for
'recurse' will be done top-to-bottom: I guess that's what you want for
something like 'git submodule recurse diff', but not for something
like 'git submodule recurse commit' (but IMHO the latter one should
never be executed ;-)

--
larsh
