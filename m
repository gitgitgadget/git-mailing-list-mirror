From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Build error with 1.7.2 and 1.7.2.1 on PPC Mac OS X 10.4
Date: Thu, 29 Jul 2010 20:42:20 -0500
Message-ID: <20100730014220.GC2182@burratino>
References: <6E0EF82C-2938-4149-A277-D51BC046B4E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Melton Low <softw.devl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 03:43:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeedO-0000yH-5W
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 03:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758263Ab0G3Bnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 21:43:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55776 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab0G3Bnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 21:43:32 -0400
Received: by yxg6 with SMTP id 6so403778yxg.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bc6czwKrAazBm4C310uIDuhUDm+g2LDnakfVaKBtww8=;
        b=lLfnTKdQgMMoPMGxKDWbeQd4mLoQ01QSCo8Ow616pZD0zBNU3f/Ur9LTS7MNG+iPoB
         qmt5fti1n9ly4WPYB1MY+WFIULIUNJ6AZ0IieUH2sJ7bo5Vx4wd159wkQbQQVE7gT15y
         wmHMR9hv8iJl1bDXneN4XDin8EZfPDTiPwVrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mNeiFX7012KmZ5ntOzsx3w30habzzmD6exesI6e/Qs55BgozBBTc8SMVGZ044vGLGH
         r2knOfvevG1Qwh6DX0qQze/3HPGmfXlCTAbrX87SUq/DSVQ+VxjVVi6ZWc/PcOvUZ9J/
         SiDrVIY6BGKUl4MgM2jRl8AD2VOiaWgOebCqI=
Received: by 10.151.132.16 with SMTP id j16mr2147268ybn.21.1280454211605;
        Thu, 29 Jul 2010 18:43:31 -0700 (PDT)
Received: from burratino ([64.107.0.124])
        by mx.google.com with ESMTPS id u41sm1597867yba.22.2010.07.29.18.43.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 18:43:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6E0EF82C-2938-4149-A277-D51BC046B4E2@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152215>

Hi Mel,

Melton Low wrote:

> Error during build on 1.7.2.  I just tried building 1.7.2.1 with the
> same error.  A partial output from my attempt to build 1.7.2.1:
> 
>     * new build flags or prefix
>     CC fast-import.o
> powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
>     CC abspath.o
[...]

Looks like it worked, though loudly.

What does

	$ gcc -v
	$ echo '
#		include <pthread.h>

		int main(void)
		{
			pthread_mutex_t test_mutex;
			int retcode = 0;
			retcode |= pthread_mutex_init(&test_mutex,(void *)0);
			retcode |= pthread_mutex_lock(&test_mutex);
			retcode |= pthread_mutex_unlock(&test_mutex);
			return retcode;
		}

	' >pthreadtest.c
	$ gcc -pthread pthreadtest.c
	$ echo $?
	$ ./a.out
	$ echo $?

say?

Regards,
Jonathan
