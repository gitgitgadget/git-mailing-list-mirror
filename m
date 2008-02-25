From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Mon, 25 Feb 2008 00:50:06 -0800 (PST)
Message-ID: <m3oda5betk.fsf@localhost.localdomain>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
	<20080225023634.GK8410@spearce.org>
	<7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?iso-8859-15?q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTZ35-0004Qt-Me
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYBYIuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbYBYIuL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:50:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:18640 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbYBYIuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:50:09 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2076295fkz.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=8mbZIUmchCSCW1WELq+cWIhDBqGpLvJccCi2cQMjslk=;
        b=Rqc6GRNV3ixPrzqfNKpuFCmoqbYjE/UuZvFegSDTUtiWGgpECJRJnEyA39dW/F6zB78BimU3PZJdaMMM591V4/nd0CHBfzcCjjuUayfd4Yk2De7TjuTu7fs4WeRAohtpH3j/fwo/+8pGNm9n9Os75iKBLfEsQ1+iINhIi0aQ4PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ivj9AgAQS3T1rCcTEnFI6zo43uMWpebJfnVWjIHFwDsA8UPXzvzLvAVZxMeivVEti5ZGkq0ukz6Fwv6HYWkgMkK91It0PKRZW1zD6y/ijyL4wAEyUJ+CyPmwhq4XTkU6lGFhO9hZj3090VIB2QE+WlLxYeEAl33xQjMuvEPuM2U=
Received: by 10.82.113.6 with SMTP id l6mr5248180buc.14.1203929407164;
        Mon, 25 Feb 2008 00:50:07 -0800 (PST)
Received: from localhost.localdomain ( [83.8.199.10])
        by mx.google.com with ESMTPS id c25sm8102935ika.9.2008.02.25.00.50.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 00:50:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1P8o0Bl032292;
	Mon, 25 Feb 2008 09:50:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1P8nxGj032289;
	Mon, 25 Feb 2008 09:49:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75016>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>>> +		else
>>> +			printf("%s-0-g%s\n", n->path,
>>> +				find_unique_abbrev(cmit->object.sha1, abbrev));
>>
>> Is this really that useful?  Where is having the tag and the commit
>> SHA-1 both useful?
> 
> I had the same question.  The only place that I find this could
> be useful is when you tag, build and install, and then find
> glitches before pushing the results out and rewind, rebuild and
> re-tag.  I unfortunately have this issue almost all the time.

Another place where it is useful is parsing git-describe output, for
example in .spec file for RPM, if you want to avoid hardcoding the
information about the form of tags in a project (tags can, and
sometimes do, contain '-'). If you always use --long form, it is easy
to separate number of commits from tag and shortened sha1 from the tag
itself, for example to put closest tag as version number, and make
number of commits and perhaps also shortened sha1 into release number.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
