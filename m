From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date
 incorrectly
Date: Tue, 11 Jan 2011 19:54:53 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101111949230.856@debian>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org> <7v62u043ba.fsf@alter.siamese.dyndns.org> <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org> <7vk4ig7y0t.fsf@alter.siamese.dyndns.org> <7vaaja8sxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 01:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcozX-00076T-RU
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 01:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702Ab1ALAzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 19:55:04 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47146 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab1ALAzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 19:55:02 -0500
Received: by vws16 with SMTP id 16so32384vws.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 16:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=psbA/emGL609kjC23tCU+3ohauPvbQiTuNDCqnIDgUQ=;
        b=Couwft0D43AzIL7B2N1uwYKEQW+9JYGRPefmTxI+Z/2YT5SXGcJ8Xh+jbcf3+bMcWk
         a5+qa2+FORKVsdRrJ5CBeMHQAH2hugupBnjtjJGHYO3u6YbrOyyFhw9X61+Q/r5LYMdO
         RLNCrnTYzYIp+9DnX33+dYs5+AJ7WqhG13VQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Dybt/6VrI8i80EJccaIZdzEYymMyXm5MNbNB+7+k4E3Lfpp05dM9QLtCEE0bFUCyeZ
         oFoKYjaU9ryERvBqsv6YXDD+9jMU1SyVbsu411fl4/X/n/AQPA2wgtCr0yogkrv1ts3J
         wvuD4bR5yL6zMw72fenXAj8lXwGwZ123uRryk=
Received: by 10.220.170.78 with SMTP id c14mr77567vcz.205.1294793700296;
        Tue, 11 Jan 2011 16:55:00 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c8sm6912184vcc.9.2011.01.11.16.54.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 16:54:59 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vaaja8sxd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164999>

On Sat, 8 Jan 2011, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "git rev-list --no-walk ^HEAD~3 HEAD"?  Isn't it a nonsense?  If it is "no
> > walk", then why do you even list a negative one?
> 
> The above was my thinko.
> 
> When you explicitly give range to no-walk, you override that no-walk with
> "please walk".  This is primarily to help Linus who wanted to do "git show
> HEAD~3..HEAD"---see how his thinking changed over time by comparing
> aa27e461 and f222abde.

Just a quick note: I didn't know that 'git show' was supposed to
support that syntax, so I had try it out. When I ran 'git show
origin/master..' on my branch, which was not rebase on top of
origin/master, it seemed to print the history all the way back. It
seems to stop only if all the positive refences contain the negative
reference. Is this intended? Not that it matter much, since 'git log
-p' seems to do the same thing but stops where I expect...
