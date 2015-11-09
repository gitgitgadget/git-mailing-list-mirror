From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: how to check for uncommitted/unstaged changes on remote side
 before pushing
Date: Mon, 09 Nov 2015 10:38:20 +0100
Message-ID: <1447061900.5074.12.camel@kaarsemaker.net>
References: <20151108212320.GA18762@torres.zugschlus.de>
	 <1447057500.5074.8.camel@kaarsemaker.net>
	 <20151109093124.GB18762@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Marc Haber <mh+git@zugschlus.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 10:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZviuE-0003lB-GO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 10:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbbKIJiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 04:38:25 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36522 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbKIJiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 04:38:24 -0500
Received: by wmww144 with SMTP id w144so69445789wmw.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=Ky1jK+kfGEwwRqyLbOFnxw+nHN8qI9evlG0Ul3Vih0U=;
        b=R55wtkf0+pTCHHTFcUXDgh5W0YV6C+wiLTrQYcsT1rpoAFtZJvxuns14fwJEyQzcfL
         TpIXFXaHGyJf9UQ762ChfCvY2lvNqi+GXDdNhGv3Ts8MgWZLQy9MwFq3OtqT5Qo+rU7H
         6TwPaLKWZeAOZ9Grn3chhAT04QFqunSlFvNW7NFi/JDYMFS1axxfGfDvagOMN+mmoMAQ
         Kru+RidEuOB2mpDQfJHUbJ4Klp56nSUVRDfLeY7KHgx+V0Cw1txRTloW0G8DebZISRuV
         jVXivKKLw9wXrXaCWC218wbIU3YGENawcZwrMR5rur5TqTAeGMXBVBP58yvdBfmct6BN
         zyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Ky1jK+kfGEwwRqyLbOFnxw+nHN8qI9evlG0Ul3Vih0U=;
        b=PIV5G+VTlP1qjlsgNSc4d2jq/11Xdo/RZCDWEFRTn54GTUWguyuI02kCSaHFZKzpgX
         mq4LxrNiwQCfK9I1CuVDLjnzsaXzppC4/kw7YP+HXYv3InVLChYXFrCMPZnKkvzswlD1
         tQKGcuutI01GrbmEUHmpPFyXyqeHF/JHE1ZwhxpLF/DAjFrvAgO9y15q36dH9ocir1HR
         jDsLE6timvlw/+Y2vfFjJtQiz1wUz+EnAWS7X64NhuoqQcoWmf68PlHve1rXCVJvwfci
         ugz+K94y0muVLVAQK24lUAMjoLZuPEz8jYjniIHLdMGqrPzdlfRiz4JXLbQR030zXF13
         N61w==
X-Gm-Message-State: ALoCoQluc8pafv97UC/e2gJoIyCVPk6HG7iAiT4vbfqF7mp2buWBMCRjYHlE8E8a48Npsdi8v5kf
X-Received: by 10.28.132.13 with SMTP id g13mr23751972wmd.35.1447061903269;
        Mon, 09 Nov 2015 01:38:23 -0800 (PST)
Received: from spirit.local ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id l81sm13303931wmb.2.2015.11.09.01.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 01:38:22 -0800 (PST)
In-Reply-To: <20151109093124.GB18762@torres.zugschlus.de>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281047>

On ma, 2015-11-09 at 10:31 +0100, Marc Haber wrote:
> Abusing git here has the advantage that one can save local changes 
> and merge them, which is handy for the task at hand (which is 
> deploying my dotfiles to "my" servers).

For this I really like vcsh (https://github.com/RichiH/vcsh/) in
combination with a .bashrc.d snippet that updates dotfiles upon login
when possible (
https://github.com/seveas/dotfiles/blob/master/.bashrc.d/vcsh.sh)


-- 
Dennis Kaarsemaker
www.kaarsemaker.net
