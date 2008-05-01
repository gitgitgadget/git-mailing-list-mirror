From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:27:34 -0400
Message-ID: <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:28:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrai5-0003oN-0B
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761555AbYEAP1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761899AbYEAP1j
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:27:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:16073 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760389AbYEAP1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:27:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so583908fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=R4zUgPhxWsE6nc36O4c86Pgvt3SDs7FOSdSW82xptHA=;
        b=ltN2bBpwxCwhkQCo7FYk1zLfA1tz8jvLT0YoiRjOZwbsKF/wcZQZeMupVHo1A7tb76IS1wQTYfyZTDnm0tRqrz2RgewXfbWt2dPz938uOrq26YzxJD6ao7TlGT+Cazd+DxQq8eT+/FxDo8IMFm3M7zYeo1GUplcfDogGt5ZMmN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbSHiPFD8KJ8PV1/JUv9o1tidrAwLCBQuYfQyHlyMqLZlAXV88/sNaPzA7x3IQXbaQeNXcb6dnlxQ/IWpRKcrhhcv2EfxuWTARncfYy83VmD0mHues26EFvpWNtpTpzdxIXS4mIujIqnHLX48OmB1cFjUubxFee9rtFgfOfD2k0=
Received: by 10.82.105.13 with SMTP id d13mr250933buc.10.1209655655014;
        Thu, 01 May 2008 08:27:35 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 1 May 2008 08:27:34 -0700 (PDT)
In-Reply-To: <4819D98E.1040004@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80920>

On 5/1/08, Ittay Dror <ittayd@tikalk.com> wrote:
> Also, would anyone like to comment on:
> http://www.markshuttleworth.com/archives/123 (Renaming is
> the killer app of distributed version control
> <http://www.markshuttleworth.com/archives/123>)?

One of the comments linked to this:
http://automatthias.wordpress.com/2007/06/07/directory-renaming-in-scm/

Which points out that git doesn't really handle directory renames at
all.  If someone creates file A/X then renames A to B, then merges
with someone who both added the file A/Y and modified A/X, git will
produce a tree containing (modified) B/Y and (new) A/Y.

Technically this is "correct" in that no data is lost and there are no
conflicts, but it is obviously not what was "intended", which was that
the new file Y should have ended up in folder B.

Before you say this is not a realistic use case, I've personally had
this exact problem:

- I had a project with all of my work in a folder "src"
- I decided that the 'src' folder was redundant, so I moved it all to
the root folder
- Someone else was working on an old maintenance branch which still had 'src'
- When I merged from that person, some new files were created under
'src', and of course didn't work.

Since the maintenance branch was long-lived, this problem happened
repeatedly.  That said, it's also pretty easy to work around, so it's
not the end of the world.

Have fun,

Avery
