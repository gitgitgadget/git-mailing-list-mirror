From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH 1/3] Move Git::SVN::get_tz to Git::get_tz_offset
Date: Wed, 16 Jan 2013 20:16:55 +0000
Message-ID: <CAP30j164UD9gNRbZ=uCQjgpDODWnGtYmHcWES2P=YPryL=FbZA@mail.gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
	<1358291405-10173-2-git-send-email-bdwalton@gmail.com>
	<7vehhlyw90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: esr <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZQE-0002i0-BF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab3APUQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:16:58 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:45384 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab3APUQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:16:57 -0500
Received: by mail-lb0-f170.google.com with SMTP id j14so1345212lbo.29
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=R6KaOXiFMuTE5UX5z+bku2K/n51shW0+y1jvGWlVH24=;
        b=KeOjLFVQ48gCtq5imuWqJcdqzxbXQCOXe+un/LP4vljic0eR8jocH/2IiLlsMXIngW
         iR4e5BYj341O5di31HslhT/Zr3DT6pVq0eMle3NE5zJNkyjZ687LE80M1bgvBp1OndVB
         rZebOW2nkwE8HTbRnSg0GuiIQe56+92J/MaEfS2BtLQUSa/8cE6x+oe8hoATw8vzxmUl
         CE0d1s2k0jrkkTowSFLlECmMjTWze9mVZ87XMLvycK6oxI4j3d2y/6YIvTYnRu7+TwmC
         Nt3LyyXenWjENDkqN+NYuuu+LleAGoWjILZWEbw+ahaVS755+eO9TPPI18Xb+8pb4GaR
         ccpg==
X-Received: by 10.152.113.6 with SMTP id iu6mr2375534lab.43.1358367415900;
 Wed, 16 Jan 2013 12:16:55 -0800 (PST)
Received: by 10.114.29.129 with HTTP; Wed, 16 Jan 2013 12:16:55 -0800 (PST)
In-Reply-To: <7vehhlyw90.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213809>

On Wed, Jan 16, 2013 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Walton <bdwalton@gmail.com> writes:
>
>> +sub get_tz_offset {
>> +     # some systmes don't handle or mishandle %z, so be creative.
>
> Hmph.  I wonder if we can use %z if it is handled correctly and fall
> back to this code only on platforms that are broken?

That would be perfectly acceptable to me.  The reason I set it up to
always run through this function here is that when I originally added
this function for git-svn, I'd made it conditional and Eric Wong
preferred that the function be used exclusively[1].  I opted to take
the same approach here to keep things congrous.

If it were to be conditional, I think I'd add a variable to the build
system and have the code leverage that at runtime instead of the
try/except approach I attempted in 2009.

Thanks
-Ben

[1] http://lists-archives.com/git/683572-git-svn-fix-for-systems-without-strftime-z.html
--
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
