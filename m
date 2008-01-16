From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 16 Jan 2008 13:13:35 -0800 (PST)
Message-ID: <m3y7aplbie.fsf@roke.D-201>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	<200801162147.33448.kumbayo84@arcor.de>
	<200801162158.26450.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFFaI-0007y1-TD
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 22:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYAPVNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 16:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYAPVNj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 16:13:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:48920 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbYAPVNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 16:13:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so263256ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=WQUBxt462M2FTJc1EHKHtE4/wx2N76J9FBCze9NRA/E=;
        b=UqsqRlJ5L/nIwgk5Vl9KQAOOZCRXPKbou1zBDn+im3jlkpbNMPJk2gA4oisu3a2ceFWNniseViURBpqnZaGlaAAmxRmfyo/adzKyLJPjJOKrQggdRuzLXmFL744I2Tr8HEyYZZ/nIaE5ajSZzM3zd7/I6XwTxEHYrQ6p8KudUmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=nFyziO2PNyMKz6VFw5vk4E31EswhzwvlW5TjSlccVcnNeM53bdiOYeQt7cRB4htLUQLIbWrQLSy5KvE3zBAIrmkwmGBOEY6og0WnINcMdSlAOtECBGihrUpewFfIOg3kSgqP9hK9+lbwZCfZaq30EDhS+Kx2JMr97DQahm/FCqY=
Received: by 10.67.29.20 with SMTP id g20mr2542966ugj.54.1200518016623;
        Wed, 16 Jan 2008 13:13:36 -0800 (PST)
Received: from roke.D-201 ( [83.8.213.34])
        by mx.google.com with ESMTPS id x26sm2190607ugc.61.2008.01.16.13.13.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 13:13:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0GLDWO9021817;
	Wed, 16 Jan 2008 22:13:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0GLDU2X021814;
	Wed, 16 Jan 2008 22:13:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <200801162158.26450.kumbayo84@arcor.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70748>

Peter Oberndorfer <kumbayo84@arcor.de> writes:

> "git repo-config" will be removed soon
> 
> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
> ---
> since i am not good at creating log messages, feel free to change it :-)
> built on top of kha experimental patch
> passes all testcases for me

> @@ -47,7 +47,7 @@ class GitConfig:
>          if self.__cache.has_key(name):
>              return self.__cache[name]
>          try:
> -            value = Run('git', 'repo-config', '--get', name).output_one_line()
> +            value = Run('git', 'config', '--get', name).output_one_line()
>          except RunException:
>              value = self.__defaults.get(name, None)
>          self.__cache[name] = value

Strange that StGIT didn't abstracted out reading git config, like
Git.pm and gitweb.perl did.

BTW. will StGIT be using libgit-thin + PyGit, or is it not ready yet?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
