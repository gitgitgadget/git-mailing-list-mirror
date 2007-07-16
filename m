From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 14:04:35 +0200
Message-ID: <e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPJh-0006XB-5T
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbXGPMEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXGPMEi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:04:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:48216 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbXGPMEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 08:04:37 -0400
Received: by nz-out-0506.google.com with SMTP id s18so812418nze
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 05:04:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbAZRWqiI8br/Z4fixE13Le2OgFOjPZd9PFQTMBWVtl8STFCUljeJXtYA3H5f8yAsnke8n6dgVVygSAi9P+uxqhXn/G2lt8kDHqX0DSnK6ovhA6IMzKcOYhEffHw6gEE+y6vi8Hfnywua8K53htHXqccQ54SnUhbhTJG5GUYCTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aqvEyqBOiPMjpRTCQa6fCzCkFGeV2qmxbAwm+eW8Hzd62jP4CJLxrumWpEWUyN+Es2tjFzPqArjcygrXxk1/2BlQfu2iwZX4SOzrIBc8PZLethSMCXNv4C0ytXgdSLqUhswlCI6ZiFpyAmVPEjS5DDJjz66qViPAawq8N7Xvgpg=
Received: by 10.115.89.1 with SMTP id r1mr4096352wal.1184587475992;
        Mon, 16 Jul 2007 05:04:35 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 16 Jul 2007 05:04:35 -0700 (PDT)
In-Reply-To: <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52665>

On 7/14/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
>
> "size" is a bit vague here.  What if we later want to extend
> things so that you can ask for the entire log entry size
> including the patch output part (I am not saying that would be
> an easy change --- I am more worried about the stability of the
> external interface).  So is --show-"size".  "message-size" would
> have been a bit easier to swallow, but I sense the problem runs
> deeper.
>

I'm rewriting the patch + documentation cleaned up and with a
different option name (--show-log).

Currently the patch just include the log message because the diff
content (-p option) is not buffered but is written with a combination
of printf, puts, fputs, fwrite and putchar directly to stdout.

My question is, there is a way to get the quantity of bytes written to
stdout before they are printed? I'm not an expert of C stdio library,
so perhaps this is nonsense, but I was thinking of reading the size of
stout buffer before to fflush() (I don't know if it is possible).

If it is not possible I have to give up in extending the scope of this
'show me the size' patch to diff content and I will stick to the
proper name --show-log.

Thanks
Marco
