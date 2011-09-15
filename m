From: David Michael Barr <davidbarr@google.com>
Subject: Re: git gc exit with out of memory, malloc failed error
Date: Thu, 15 Sep 2011 12:20:16 +1000
Message-ID: <CAFfmPPP58J90758TRB2sAj-Wr5HB=rQtaJipKovsHXyTcswuJQ@mail.gmail.com>
References: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 04:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41Yu-00047a-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab1IOCUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 22:20:19 -0400
Received: from smtp-out.google.com ([216.239.44.51]:7539 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab1IOCUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 22:20:18 -0400
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id p8F2KIw4023378
	for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:20:18 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1316053218; bh=ZlxoTYGy5OR6gaGuSH7bNRbL6bw=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=FGa3PnmYtUfXW+BfK2QWwcOSRfJt5mJP/lEGbWUkHI3MDR4abQUQUWIKAxJvNpm73
	 kx1lsP9rAYx6SKqQzKB+g==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=QLPzZ3p4jitG31/ZjD7G1eFBfEVDuZd5AJjv6cGN1IIoG1tBXFZq65u1aNabhl/8/
	KwFqN/raVpJgFpswgqaOQ==
Received: from qwi4 (qwi4.prod.google.com [10.241.195.4])
	by wpaz9.hot.corp.google.com with ESMTP id p8F2KGwJ022560
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:20:17 -0700
Received: by qwi4 with SMTP id 4so2910173qwi.15
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7bBbmywGvdol+WLrg/P4AUzX/jG+19sVj0wo0ca6Epc=;
        b=s5thwhI9rnzkH5lcc3N5A8jrX9o4FEGISZmQ6b0x84Vn5BGzIj8YgaE+1BOj28jyOY
         3N0UIeIlIkwD1gB81/nA==
Received: by 10.229.68.87 with SMTP id u23mr486394qci.8.1316053216675;
        Wed, 14 Sep 2011 19:20:16 -0700 (PDT)
Received: by 10.229.68.87 with SMTP id u23mr486384qci.8.1316053216164; Wed, 14
 Sep 2011 19:20:16 -0700 (PDT)
Received: by 10.229.8.13 with HTTP; Wed, 14 Sep 2011 19:20:16 -0700 (PDT)
In-Reply-To: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181426>

On Thu, Sep 15, 2011 at 11:33 AM, Alexander Kostikov
<alex.kostikov@gmail.com> wrote:
> I'm new to git and I'm getting the following out of memory error on g=
it gc:
>
> $ git gc
> Counting objects: 80818, done.
> Delta compression using up to 8 threads.
> fatal: Out of memory, malloc failed (tried to allocate 24359675 bytes=
)
> error: failed to run repack
>
> The only advice I found in the internet suggested to run repack with
> --window-memory parameter specified. But this call also fails:
>
> $ git repack -adf --window-memory=3D0
> Counting objects: 80818, done.
> Delta compression using up to 8 threads.
> warning: suboptimal pack - out of memory
> fatal: Out of memory, malloc failed (tried to allocate 24356363 bytes=
)
>
> How do I cleanup my repository?
>
> $ git version
> git version 1.7.6.msysgit.0
>
> OS: Windows Server 2008 R2 SP1 (x64)
> Physical memory: 24 GB
> The commands listed were executed under x64 console process.
>
> --
> Thanks,
> Alexander Kostikov
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi,

My understanding is that msysgit is a 32-bit build.
So if your existing pack is ~2GB, repack will fail.
Also, I think that setting window-memory to 0
means no limit, which is not what you want.
One value I have seen suggested is 256m.
In my experience, peak memory consumption of
repack is proportional to the value of --window,
so you might want to try tweaking that.
There are quite a few config parameters that
affect the memory consumption of repack.

--=20
David Barr
