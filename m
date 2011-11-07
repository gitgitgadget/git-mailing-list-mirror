From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 7 Nov 2011 16:21:09 -0600
Message-ID: <20111107222109.GA22693@elie.hsd1.il.comcast.net>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <20111107194912.GA12469@elie.hsd1.il.comcast.net>
 <7vlirr1vi5.fsf@alter.siamese.dyndns.org>
 <20111107213219.GA13537@elie.hsd1.il.comcast.net>
 <7vd3d31u4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 23:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNXZE-0007eF-2A
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 23:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab1KGWVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 17:21:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55517 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1KGWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 17:21:18 -0500
Received: by qao25 with SMTP id 25so1097642qao.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bHrz+3zLmkl8nkFJn+B1xM+ZxuC/Ne8Vx0MlOl+cdIw=;
        b=krQURkiIjJhimaUJL65zYkH9bgvMUHiMEX/d8RTW899ssMQvbw8g0K/+K8eYmUlt2e
         oKIkNnoLHkbnSRKR4+3E2mYYNTjvuzCUEjTHrjJIUJf9CqmSZC8aMB4w0+B/VYd7MeAk
         VM6pPmYHZW0xSAANvgaWX+MVWZXhcJUb/+hEA=
Received: by 10.50.161.131 with SMTP id xs3mr47323582igb.23.1320704477302;
        Mon, 07 Nov 2011 14:21:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fu10sm19346907igc.6.2011.11.07.14.21.15
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 14:21:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd3d31u4e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185041>

Junio C Hamano wrote:

> With the removal of the check, you _have_ to rely on static analyzers to
> do the _right thing_, but if you have static analyzers that do the right
> thing, you do not have to have such a workaround to begin with.

No, automatic static analyzers will not help you avoid using an
uninitialized enum value here (well, I guess they could, but I don't
believe gcc or clang is nearly smart enough for that).  The only
replacement for the check is (1) humans and (2) valgrind.

In this particular case, as you mentioned before, (1) seems to be
quite sufficient.
