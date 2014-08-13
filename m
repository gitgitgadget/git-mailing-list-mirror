From: =?UTF-8?B?0KDQsNC00L7RgdC70LDQsiDQmdC+0LLRh9C10LI=?= 
	<radoslav.tm@gmail.com>
Subject: Undefined reference to __builtin_ctzll
Date: Wed, 13 Aug 2014 11:36:57 +0300
Message-ID: <CAAC8vw4EzaEM13TWzEW9QUuc-qdZFhPfEA9z1=KjCE0Brzotjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 10:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHU3N-0001IW-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbaHMIg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:36:59 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:43644 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaHMIg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:36:57 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so9464747igb.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XvvQS3MCoYnqUgaQqYRPsexi6gZ6AjlY/ed6iFd+23s=;
        b=cb+BEHrLY7ISgRk1DpPvRQA+yJf5fyk3HkMZNyz7Cvrs/7Zv1+2aZ4KI9V88aGCMf4
         y+DkONKuxifdyazuulS+5EWTwtYr2ew8cLmPJ1EH0w4Ts5cYvWaNZi+jMph07/oebAjI
         7W6Qbzm3YXl8QY1LK5cNl7fFVsDflwZl+0G6zl6TD/zbX/K4H+cVK5rlXSOEMEoJNMSc
         XvJJKoODqva6DLv5WdItl4ugQEwvNvQ2OGkyHgr3E+ikqhSQL0WQEYuYnrjtPjrsogNP
         7F6txzOF7jB5ThYb1SxNbVjfMxuFolVlzudwWofdn07BC1/DQ4zOnQHCWnrPfM2MeK18
         PvZw==
X-Received: by 10.42.84.76 with SMTP id k12mr4726035icl.18.1407919017089; Wed,
 13 Aug 2014 01:36:57 -0700 (PDT)
Received: by 10.42.65.9 with HTTP; Wed, 13 Aug 2014 01:36:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255190>

Dear GIT community,


I found myself in situation where I had to install GIT on Debian 3.1
sarge.  It comes with GCC 3.3.5. I tried to built from source but the
libgcc was not providing the ctzll function, thus I decided to put an
implementation.


I do not know how to post and do a nice patch (and whether somebody
will care), but I guess, for reference I can post my solution. Just
appended in compat/strlcpy.c the following:


int __builtin_ctzll (long long x)
{
        int i;
        for (i = 0; i < 8 * sizeof (long long); ++i)
                if (x & ((long long) 1  << i))
                        break;
        return i;
}


I guess that some ifdef macro can be used to detect compiler version
or missing __builtin_ctzll.


With best regards and hopes that this can help somebody in similar situation,
Radoslav.
