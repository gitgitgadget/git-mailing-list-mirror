From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git send-email --notmuch expr
Date: Wed, 25 Nov 2009 02:16:52 -0800 (PST)
Message-ID: <m3hbsic3l5.fsf@localhost.localdomain>
References: <87d4375ne0.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEvl-0003RF-7C
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934054AbZKYKQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758500AbZKYKQt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:16:49 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58463 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758276AbZKYKQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:16:48 -0500
Received: by fxm5 with SMTP id 5so6767203fxm.28
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UUwjhnYRcN9yYj2CsbS7/Jx5cTTpnnK4xkVmwocCtUk=;
        b=naXM8waWZek5wjWvQ/9BsCLdSH4HC8cIxtR0AE/YOj6CBxUrAQy4kf3v8kffplFkPW
         +H4AcS0IXZ+sL3WbWDEnVR+70pYL4hQmLwNhbo4Ogvfh41IkRfJfkpLbJrbaXwGXucj2
         2hRyQqckyHeYD/p8xfD3poAaiAjMK9kFgBfCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=g4jok4HwCqtDhfyTWzPh5ScW2WSGRbz+aQK7MqGr6NOqxgQbIupvxZwUGwgxN8XW5/
         xSu/cqvCRkrau28jLboMRiWxcR+AhCfm/xLYmbPhhhs0DM8Y+JhQjyQfvJgZPhHVsof5
         1tEgzkBJiNWbklcjPoaNTKyIYOJbWg4idNqHM=
Received: by 10.103.78.31 with SMTP id f31mr3287223mul.24.1259144213608;
        Wed, 25 Nov 2009 02:16:53 -0800 (PST)
Received: from localhost.localdomain (abwj137.neoplus.adsl.tpnet.pl [83.8.233.137])
        by mx.google.com with ESMTPS id u9sm1945563muf.37.2009.11.25.02.16.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 02:16:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAPAGDwE008022;
	Wed, 25 Nov 2009 11:16:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAPAFp8Z008018;
	Wed, 25 Nov 2009 11:15:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87d4375ne0.fsf@59A2.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133624>

Jed Brown <jed@59A2.org> writes:

> 	} elsif (/^(?:To|Cc|Bcc):/i) {
> 		print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
> 		next;
> 	}
> 
> This regex doesn't match these headers (is the leading ?: a typo?) so
> there is no warning.

(?: ... ) is in Perl non-capturing grouping

>From perlre(1)

  "(?:pattern)"
  "(?imsx-imsx:pattern)"
       This is for clustering, not capturing; it groups subexpressions
       like "()", but doesn't make backreferences as "()" does.

So it is not a bug, and it definitely should match... unless implicit
variable $_ (the default input and pattern-searching space) got
mangled.  It would be better to use explicit form:

   $variable =~ /pattern/

-- 
Jakub Narebski
Poland
ShadeHawk on #git
