From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: standarize HTTP status codes
Date: Thu, 19 Jun 2008 15:37:35 -0700 (PDT)
Message-ID: <m3hcbpm4pe.fsf@localhost.localdomain>
References: <1213905801-2811-1-git-send-email-LeWiemann@gmail.com>
	<1213907110-5080-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Sm5-000461-9k
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYFSWhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYFSWhm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:37:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13326 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYFSWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:37:41 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1057114ugf.16
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=mrvyC6IiRoTX9st0HN+qt5opZM2ZCeQ5FzbEhwYQBQ8=;
        b=jgpaEedq+H8THIYEq09AVArT6K1YxB6T3FFWpb0CYC8WR6Ihb8XCioRicYVhQqWal9
         MDL4avPhAabRMkQ0nPTDm6B62DI6QQTTI5AF924EvfHDZzpRbvOe6RkBdQGNuxys2wK8
         lpmfybfiD54Yijrv2r7Lx5f4jhp6pgH72VJ94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=dquVC+d0dzix5scUh5heX4wlsSic23iUsDlcdRYAoaXIPyeNDIjcdafTHGlzUMQd2Z
         yUQkKT5KXmpeiJvY5rFrM2Xnz/CuKcnWVWEGq+BiqhKP775ePIsBXoQbtWKA4YaAmtvl
         Y1yTCFXCaB1mb4EZdxmn8BU2UCLrjea6/FajM=
Received: by 10.67.97.1 with SMTP id z1mr10930102ugl.11.1213915056349;
        Thu, 19 Jun 2008 15:37:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.161])
        by mx.google.com with ESMTPS id 24sm19562456ugf.62.2008.06.19.15.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 15:37:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5JMbZBB002691;
	Fri, 20 Jun 2008 00:37:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5JMbXEG002688;
	Fri, 20 Jun 2008 00:37:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213907110-5080-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85552>

Lea Wiemann <lewiemann@gmail.com> writes:

> Changes since v2: die_error now adds the reason strings defined by RFC
> 2616 to the HTTP status code; incorporated Jakub's other suggestions.
> Diff to v2 follows.

This address both of my concerns: first, that for someone examining
Mechanize-based gitweb test number like 403, or 500 would be magical
number without explanation (reason phrase) other than 'Error'.

Second, that for casual / accidental gitweb developer who has to add
or modify a bit of code with die_error(...) wouldn't know which of
"magic number" to use, if the case didn't fail into described
situation.  Now it is enough to example die_error(...) in addition to
similar code...
 
> I didn't use the HTTP_NOT_FOUND etc. suggestion because I found it too
> verbose and obtrusive.

I can agree with that.

> Just a friendly reminder, please remember that discussing fairly
> trivial changes in-depth might be not a good use of all participants'
> time [...]

Well, this was what I though was patch revies... :-/

> Anyways, I hope everyone is happy with this version of the patch.

FWIW:

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
