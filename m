From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: git-svn dcommit always uses my own name
Date: Wed, 16 Apr 2008 00:08:02 +0200
Message-ID: <cac9e4380804151508p688bd7b7o1eb413b4133dad57@mail.gmail.com>
References: <32541b130804151425o6cf7646co541fb7cc85115606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:08:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JltKf-0006ht-Lo
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762866AbYDOWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762697AbYDOWII
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 18:08:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:11570 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762353AbYDOWIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 18:08:06 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1653697wxd.4
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y5Gtgag6ixG7wzE79lolWusIKAuXp6DAzE+QNy9KSzE=;
        b=xVbN3dQPhH6c7KwpGHe9q2fF+QJUjL/u9fAJseXNVXFKDGd3n7te8HQ/qJsODrYB6/G6kAEJ/RGFMi8/VsEPojZKj1y8jNxZmmdxxzWnDFbsBP1v0+VFwn8Zrj7KvOq1U8dXfXY4BlWBrN7UAR52M6KeoLhoaIUa6/P0hJCqJQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O91eeEzQi5lQJMnrUHvVVXHeL9cUMo6p6T2t/QQgu+ykh5tXZZboGfKtGaLpfaqK3ZXvAPOvnmvqJY4Vuc17SH8HD6MIUTSTMGFkYPweMEKNuptaz8Smdo4E7lSN5yO6KZbU8WK5WRqoM0AwBqcEQsLAFwNue8IY52RJD3FMPGM=
Received: by 10.70.55.3 with SMTP id d3mr10365605wxa.79.1208297282690;
        Tue, 15 Apr 2008 15:08:02 -0700 (PDT)
Received: by 10.70.52.19 with HTTP; Tue, 15 Apr 2008 15:08:02 -0700 (PDT)
In-Reply-To: <32541b130804151425o6cf7646co541fb7cc85115606@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79636>

On Tue, Apr 15, 2008 at 11:25 PM, Avery Pennarun <apenwarr@gmail.com> wrote:

>  However, when I do this, all the commits to svn end up having *my*
>  userid attached, rather than the userid of the git user.  If I do "git
>  log" before "git-svn dcommit", it shows all the right authors, but
>  this information is lost when I dcommit.
>
>  Is there a way to not lose this information?
>

Subversion only remembers the user that made the commit; there's no
way to tell it that someone else wrote the patch and that you just
committed it. However, examining git-svn, there seems to be an
undocumented option. You can do this:

git svn dcommit --use-log-author

That uses the Signed-off-by: field in the commit message to extract
the author information. Of course it won't rescue the author field on
old commits, and you have to have Signed-off-by on any new ones to
gain any benefit.

regards,
Richard
