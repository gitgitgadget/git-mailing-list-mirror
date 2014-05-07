From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 04:26:06 -0500
Message-ID: <5369fc2e2df7_2d8a92330813@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 11:37:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhyHf-0005wm-1V
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 11:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbaEGJgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 05:36:55 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:56457 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbaEGJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 05:36:52 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so854639obc.20
        for <git@vger.kernel.org>; Wed, 07 May 2014 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=BK1fkIT7lB9LdsLzfJNq+iCgy1+Bps94B7TL8vRV3FQ=;
        b=xLXWU3BVWh7/sw97o1S4smpYS0/pUjZhEPpbqdKpvlKVYMDkYocIVUsYH+0X+CMKWL
         blSMrbyXKMz2qh2DSG5pADBp2ODJb8v+EpjVJw+NkJWvuyXaxnKS9gWXxPmUtMLV3Hpk
         w6LzctCF6JomAERP0KZiAzicElIucq6slPrXoNRRtTHjKKLCKfqToVzuqMgfpXW5kMQC
         wQ/LoNIwqsVZvGpsrdG1m+dEefan5jR5DOON0sJ/31w8x2bZjHDGCFf5igG5nanWFfGm
         LgpD73E8QbhYyUV9WpG6KEq4N7WaPm54CXqNLfuI77deT3kHMN7dixa4qoSUDC/eQKM8
         o9rQ==
X-Received: by 10.60.132.12 with SMTP id oq12mr44574206oeb.42.1399455412459;
        Wed, 07 May 2014 02:36:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id mo5sm60818874oeb.4.2014.05.07.02.36.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 02:36:50 -0700 (PDT)
In-Reply-To: <20140507080558.GH23935@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248291>

John Keeping wrote:
> > I also think that there should be a way to make it really easy to
> > install these third-party tools to augment the installed version of
> > Git without having the source tree of Git.  We have ways for them to
> > ask us where things are expected to be, e.g.
> > 
> >     $ git --html-path
> >     $ git --man-path
> >     $ git --exec-path
> > 
> > but I am not sure if these are enough, or if it would help them to
> > add a bit more, then what these "a bit more" are.
> 
> I think this is enough - now I need to go and make git-integration's
> Makefile use them by default rather than just using the same defaults as
> git.git.

This is wrong. Subprojects should use /usr/bin/ and /usr/share/man/ and
not rely on the output of `git --exec-path` and so on.

For example if the user has installed Git in his $home, when building a
package the package manager would use ~/libexec/git-core, which is
wrong.

Moreover, if you are cross-compiling you won't be able to run the
target's `git` binary.

If anything, it should be `pkg-config --variable=exec-path git`.

-- 
Felipe Contreras
