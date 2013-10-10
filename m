From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 1/3] test: use unambigous leading path (/foo) for mingw
Date: Thu, 10 Oct 2013 22:32:08 +0200
Message-ID: <52570EC8.3050207@gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com> <15724e27cbef5067902ebebb93aa77d3605402c8.1379644482.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 22:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUMuA-0002Jl-AD
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 22:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab3JJUcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 16:32:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61146 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904Ab3JJUcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 16:32:13 -0400
Received: by mail-bk0-f46.google.com with SMTP id 6so1197645bkj.19
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=acsuMqJ0bmcVYpu7UQwc0Yt5hL2ndfpVGjptNN6eEe0=;
        b=AYisFW89u4Y6Ef6ScVUlgElFzuxcXuvDJKRqwm2HfUoR6uOwauJm7KB75sMRzre3hx
         wR3BoHQq8ca515Fs1/WQfCiEBPDDKycTTqBGFuoT8ZD9lKFcco16lqokMZjpqSm1+NuA
         jJgcgp0cu3ecYFW2MmYLOwgzDA55MCdy4bZkJ5k4V909Qfkgi/nzfYvZ+FLG142Nn+ob
         54R4o39Wp4g0JdK8b+tjr6nBcvjCOC6WamOtuI6IXDoLZCDbPspWPKDVidgiiA4ZvGIv
         S+ODEh9Ehq/VQvgGn0UgMjxQN3wxsONbcsZ0el5lzzkgJcyHvgq6pdtaI1Nx0smiAcTc
         PfGQ==
X-Received: by 10.204.123.199 with SMTP id q7mr14605663bkr.10.1381437132194;
        Thu, 10 Oct 2013 13:32:12 -0700 (PDT)
Received: from [192.168.188.20] (p5DDB14BE.dip0.t-ipconnect.de. [93.219.20.190])
        by mx.google.com with ESMTPSA id jt14sm28358372bkb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:32:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <15724e27cbef5067902ebebb93aa77d3605402c8.1379644482.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235881>

On 20.09.2013 04:38, Jiang Xin wrote:

> In test cases for relative_path, path with one leading character
> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
> such DOS drive on MINGW platform. Use an umambigous leading path
> "/foo" instead.
 >
 > Also change two leading slashes (//) to three leading slashes (///),
 > otherwize it will be recognized as UNC name on MINGW platform.

Note that the path mangling comes from MSYS [1], not MinGW, so you 
should place "MINGW" with "MSYS" in several places. As a side-note, the 
official spelling is "MinGW", not "MINGW".

> -relative_path /a/b/c/	/a/b/		c/

> +relative_path /foo/a/b/c/	/foo/a/b/	c/

Wouldn't it have been more straight-forward to just replace "a" with 
"foo", "b" with "bar" and "c" with "baz" (or whatever)? So that the 
first line would say

relative_path /foo/bar/baz/	/foo/bar/		baz/

Thanks for the fix!

[1] http://www.mingw.org/wiki/Posix_path_conversion

-- 
Sebastian Schuberth
