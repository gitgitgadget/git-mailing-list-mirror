From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 10:11:36 +0200
Message-ID: <539960B8.1080709@virtuell-zuhause.de>
References: <cover.1402557437.git.jmmahler@gmail.com> <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 10:11:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv06t-0003Kg-LT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbaFLILn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 04:11:43 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55722 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbaFLILk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 04:11:40 -0400
Received: from p5ddc2b1f.dip0.t-ipconnect.de ([93.220.43.31] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Wv06j-0006Yy-Dk; Thu, 12 Jun 2014 10:11:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1402560700;e421a1c0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251401>

Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
> A common use case with strubfs is to set the buffer to a new value.
> This must be done in two steps: a reset followed by an add.
> 
>   strbuf_reset(buf);
>   strbuf_add(buf, new_buf, len);
> 
> In cases where the buffer is being built up in steps, these operations
> make sense and correctly convey what is being performed.
> 
>   strbuf_reset(buf);
>   strbuf_add(buf, data1, len1);
>   strbuf_add(buf, data2, len2);
>   strbuf_add(buf, data3, len3);
> 
> However, in other cases, it can be confusing and is not very concise.
> 
>   strbuf_reset(buf);
>   strbuf_add(buf, default, len1);
> 
>   if (cond1) {
>     strbuf_reset(buf);
>     strbuf_add(buf, data2, len2);
>   }
> 
>   if (cond2) {
>     strbuf_reset(buf);
>     strbuf_add(buf, data3, len3);
>   }
> 
> Add strbuf_set operations so that it can be re-written in a clear and
> concise way.
> 
>   strbuf_set(buf, default len1);
very minor nit: missing comma between default and len1.
