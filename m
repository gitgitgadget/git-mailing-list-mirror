From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Change git-rev-parse --show-cdup to output an absolute path
Date: Thu, 26 Apr 2007 10:20:29 +0200
Message-ID: <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com>
References: <20070425232829.GA15930@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "koreth@midwinter.com" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 10:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzDz-00071A-TX
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbXDZIUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933211AbXDZIUd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 04:20:33 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:37874 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbXDZIUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 04:20:30 -0400
Received: by an-out-0708.google.com with SMTP id b33so142893ana
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:20:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bBeBgxSWmtxX4zsvaYuljnphTq5EbiHj7apyRINA/Tu1HbfdF6mHe0mncBitZkN/Chs3JpeYLh0tWR9BIGaFQry8sgxyjHB9GcybKtTjSis2vneelv7GwqJQZm8kjDe5l5xaWUUi6nBOXIDVTs3UVCI560/55+cJC2z7VUupQzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b67K5+o/ha27e9YfIGufRWWBTnA2Gz3Nn4LTQli0l7LzwvwuH5sxIz5h8xFm6d5B5wA7Ibe2zgA509l/qJPUt1WSs6lAs8Q8X/Kb1clnsqanQAJAGPU149mYV72YqW3AZdho/RTl07rsvR/+hqtEpbtiwZwGOaGDYZdncMtY6bA=
Received: by 10.100.106.5 with SMTP id e5mr898925anc.1177575629953;
        Thu, 26 Apr 2007 01:20:29 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 26 Apr 2007 01:20:29 -0700 (PDT)
In-Reply-To: <20070425232829.GA15930@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45619>

On 4/26/07, koreth@midwinter.com <koreth@midwinter.com> wrote:
> I have a symlink pointing to a subdirectory of a repo of mine. If I cd
> to that symlink, some shell-script git commands don't work.  Shell scripts
> use the PWD environment variable as the working directory, and the chain
> of "../"s from git-rev-parse --show-cdup just peels entries off that
> variable. That's fine when PWD is a real path, but not so great when it's
> a reference to a symlink from an outside directory.

Your implementation will fail if cwd is longer than PATH_MAX.
Does not happen often, though.

> A typical failure case:
>
> $ git clone git://whatever.git foobar
> $ ln -s foobar/src/tools/misc/myapp myapp
> $ cd myapp

Which is a strange thing to do. What is that for?
myapp is kind of outside the git repo foobar.
