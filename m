From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] lessen the impression of unexpectedness on remote hangup
Date: Sun, 10 Jun 2012 13:44:10 -0500
Message-ID: <20120610184410.GA1115@burratino>
References: <20120610182310.GB2427@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdn7f-0002bk-Nq
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab2FJSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 14:44:20 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58943 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab2FJSoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 14:44:19 -0400
Received: by gglu4 with SMTP id u4so2106362ggl.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5X5Ydj2bcWAVd6Tyo0JTHfvkEiFBKKcdIsyOJTVjKtQ=;
        b=d46EXwNkjLnKOnOmmPzGTHPM0YTl6oCoKNU8qj/I3cU9a4fTgtaCVT921D+s5avfjI
         KxXzg0t2QMD2HFgpg06WHZ3cPXLHXs68SMtdT4eyClwjEEAel8f/6D6iGPlrh7ZypmlA
         ycJXi7tviQ00Ma4IxzQWiv1p4AiYmvxkg21n3QGMYPrntIhFI7UKXGrRdnH+8alOHXOO
         wNSqVY8holOqAUvce0YdJfOoD8m9ZnrshxdqRuLk5rMzVVMranE/FD2CcqplKvaCOsoh
         bC1cZ7aBSFDux6gOmfV2YFJl8h0SMWPhoE5fkHz9XsbkRTG4YDkRKi+GsjBUANoft6YS
         8TUQ==
Received: by 10.236.153.4 with SMTP id e4mr14447882yhk.89.1339353858750;
        Sun, 10 Jun 2012 11:44:18 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id e5sm21291721ani.18.2012.06.10.11.44.17
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 11:44:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120610182310.GB2427@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199619>

Hi,

Heiko Voigt wrote:

> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -141,7 +141,7 @@ static void safe_read(int fd, void *buffer, unsigned size)
>  	if (ret < 0)
>  		die_errno("read error");
>  	else if (ret < size)
> -		die("The remote end hung up unexpectedly");
> +		die("The remote end hung up");

Looks good.  Incidentally, maybe this would be a good excuse to
revisit [1].

If I remember correctly, the conclusion of that discussion was that
--informative-errors is a good default for the git daemon as long as

 - there is some warning when using it without --base-path
 - there is an easy way to turn it off
 - we communicate the change clearly and in advance

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/183604
