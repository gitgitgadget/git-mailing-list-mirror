From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: showing SHA1 of parent commit in tig [was Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 02:19:17 +0100
Message-ID: <2c6b72b30902111719r6fd25dc7uc22b471f7904bedc@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <20090206104946.GE7259@b2j>
	 <2c6b72b30902060629i2539ddds48ab858e83d4bb4@mail.gmail.com>
	 <slrngooljv.urh.sitaramc@sitaramc.homelinux.net>
	 <2c6b72b30902080207m4a1e14b7j4862f9a8b7ca32a9@mail.gmail.com>
	 <slrngp5tqk.u46.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQG1-0000Rh-Fv
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbZBLBTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757511AbZBLBTV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:19:21 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:33704 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbZBLBTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:19:20 -0500
Received: by fxm13 with SMTP id 13so1413411fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 17:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UT5dR8YveuneVy66JvxZrrzCDnHkdLJvCMQ9ysGqx4c=;
        b=WRrWVc7tOJ43nj2qnCC3X8l0XV4+y9kptQoqDD6hk7O7CvdDFdvXvfqO+v9zotXsGN
         5p61ak7B8i15HUoDlnhJ9O+uGQCuhz6SXy9IFGoU0Mcv3xqoNBDnE5IFyjYlHQJUhT4N
         8N+4SO92kYI1N/1jR9XhWaB1t3CsV5IKSXNww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wew/TtjfDfv90JGCYopjNVVydDszDOqJNeYyGaDeRA9lKNkDHTkpChYAjG7F9Re/nj
         AqF21jRTI8HVrj+M/i/b0XXk2Iw3QCTnrOK9rxBTaxGAQ/G5nyTkusLijCXEyqHcR7EL
         hzrvHWsPmXRVfPP/snXIJGn0HQF4+Btogqq0g=
Received: by 10.180.214.13 with SMTP id m13mr94248bkg.157.1234401557549; Wed, 
	11 Feb 2009 17:19:17 -0800 (PST)
In-Reply-To: <slrngp5tqk.u46.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109553>

On Wed, Feb 11, 2009 at 17:05, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Is there any way to see the sha1 of the parent commit in any
> of the displays, like gitk does?
>
> I know you're only parsing the 4 or 5 basic git commands,
> and none of those do, so I guess I know the answer :-( but
> it doesn't hurt to ask.

It is sort of possible by setting the TIG_DIFF_CMD environment
variable to something appropriate, for example using (and I don't know
if this will be formatted correctly):

export TIG_DIFF_CMD='git show -p --stat -C -M
--pretty=format:commit%x20%H%d%nAuthor:%x20%an%x20<%ae>%x20%ai%nParent:%x20%P%nSubject:%x20%s%n%n%b
%(commit)'

You need to avoid using space except for where it really separates
arguments, which is why the obscure %x20 is used. ;)

Another solution would be to create a script, which just expects the
commit SHA1 as its first argument and then do the formatting there and
then use:

export TIG_DIFF_CMD="/my/script %(commit)"

-- 
Jonas Fonseca
