From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] clone: support atomic operation with --separate-git-dir
Date: Sun, 6 Jan 2013 01:16:42 -0800
Message-ID: <20130106091642.GA10956@elie.Belkin>
References: <50E74145.4020701@gmail.com>
 <7vzk0osjli.fsf@alter.siamese.dyndns.org>
 <50E83224.2070701@web.de>
 <50E83DAE.1080500@web.de>
 <50E88A40.9010904@web.de>
 <7vfw2eq0a0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dbe1+e4-XjB+S=kvXyi_Hdt4CQ6K1Z1V-4sqaYekKPWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrmMT-0002qL-9g
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab3AFJQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 04:16:52 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:40584 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3AFJQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 04:16:51 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so8162786dae.31
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 01:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vhHRQo4+nvR8ACYmJfrZDQOiYy0RY/hj3OJod+tT1NI=;
        b=pP7mROPRfC30cu2yVsaGr74r3ZjdR214QlFGyTlzJYTyzdpb0Qy3Ym73R8QAMzfbTL
         ZUMlUMi2PKn0Lsaq0r9SAj2hvgMOOJbz7gYT4D4pg8CwDoa5tn97yyia8tskpTjFN6P5
         ZnfQO/MdtGI0UVfQmdLSHuHkc+rxxvBewrYTYSEMhFlmrwQts7gkalBq2zHPIKCYbkW+
         bHHA1U2UzHzWuJWXx0d5pojpvgILYcUHMdHl7nFTJ+GJcSkbOdBnA0zxgMUgcA6nzY03
         lqNF/kjvXhKKcCedkiNF9m+o/DxjhPtnt936bpuzy0LxvNX2l9r24WeS4l9xRpR9E2m8
         oimg==
X-Received: by 10.66.81.199 with SMTP id c7mr156446450pay.39.1357463810896;
        Sun, 06 Jan 2013 01:16:50 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id s7sm36555286paz.7.2013.01.06.01.16.48
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 01:16:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Dbe1+e4-XjB+S=kvXyi_Hdt4CQ6K1Z1V-4sqaYekKPWw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212787>

Duy Nguyen wrote:

>                                                               And
> because junk_work_tree is not set up for --bare, I guess we still need
> to fix "--bare --separate-git-dir" case, or forbid it because i'm not
> sure if that case makes sense at all.

Forbidding it makes sense to me.  If some day we want a git command to
create a .git file, I don't think it should be spelled as "git clone
--bare --separate-git-dir <repo>".  In the meantime,

	printf '%s\n' 'gitdir: /path/to/repo' >repo.git

works fine.
