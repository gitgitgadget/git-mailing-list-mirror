From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t9010: Open backflow FIFO once to work around kernel
 race condition
Date: Tue, 26 Jun 2012 17:40:53 -0500
Message-ID: <20120626224053.GA7155@burratino>
References: <1340749806-22734-1-git-send-email-andersk@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeRa-0002J6-JE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab2FZWlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 18:41:04 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54770 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2FZWlD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 18:41:03 -0400
Received: by ghrr11 with SMTP id r11so464955ghr.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y8H1W/EiJForXT9sXPRg85Kf5zhMMCT4bv4MvK3n3VM=;
        b=DA7DaBQ9Pkjz+LPwS/VdFDIXLgejuSKeTAVeo9M+JXIC5MnVr5TK0jqMmAJ2o8LGhg
         C5oUH1f28VpvVLYd00AZuI5qGc4QYq4rk8LHppI6lLBRprIAYN8UI/64V5Vqk+EFnb6C
         u687B36ESKvxOHv4GeJ7ume5BJ2e6GogZR+U0BG0zD6rUdJZE0I+ut9jnKZcm15WGv7y
         wldWXSRAek51cbk0XqSGLZmZT7LeVJFXvIqzdH3ISwIOItR5F0hPlDSEuOgUl6dvo/mG
         ljprgIHxLnakEzk86z6ejGHCp5AVru5GwP5aixNE7CxSZAvVMTlfoqPf9MrXWoQzmw30
         z7rA==
Received: by 10.50.179.101 with SMTP id df5mr12896250igc.22.1340750461977;
        Tue, 26 Jun 2012 15:41:01 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vi7sm3396082igb.1.2012.06.26.15.41.01
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 15:41:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340749806-22734-1-git-send-email-andersk@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200696>

Hi,

Quick first impressions:

Anders Kaseorg wrote:

> Sidestep this problem by opening the backflow FIFO once for
> read+write.

Is that portable?

>             Also, replace the stream FIFO with a shell pipe so we
> don=E2=80=99t have to do manual process management.

Doesn't this mean we wouldn't notice if test-svn-fe crashes?

Maybe it would be simpler to make test-svn-fe launch fast-import as a
child, avoiding the fifos altogether.

Thanks again for tracking this down, by the way.
Jonathan
