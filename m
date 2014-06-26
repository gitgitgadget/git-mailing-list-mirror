From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Thu, 26 Jun 2014 05:15:05 +0200
Message-ID: <53AB9039.8040809@web.de>
References: <20140625233429.GA20457@sigill.intra.peff.net> <20140625234000.GD23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 05:15:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X009j-0003mm-2S
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 05:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178AbaFZDPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 23:15:13 -0400
Received: from mout.web.de ([212.227.17.11]:50960 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbaFZDPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 23:15:12 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LoHgL-1WSaGt13Iv-00gKLQ; Thu, 26 Jun 2014 05:15:10
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140625234000.GD23146@sigill.intra.peff.net>
X-Provags-ID: V03:K0:FOi9QDMMZgP3ufc46uTQiCBcYG/AQPZigJySbVHNEKfsxkBS2gm
 az1p0OeGNU7YLP5Fc6SBl0hprZrEyVMG2BEOzuHJxxcYi97e+JcQgY6Bm5jrnkDPMmVm4c1
 nxCxrh/Rm6+OK+wwzmDM4AO+FKYjcNsOOa/r8GdW5VGyvHYlsEBUBnbq7WW/uNpy54Dfs5E
 NMVTdXeCscVj1vfxSC02g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252486>

On 2014-06-26 01.40, Jeff King wrote:
[]

> + */
> +static inline int bitset_sizeof(int num_bits)
> +{
> +	return (num_bits + CHAR_BIT - 1) / CHAR_BIT;
> +}
Just a general question about the usage of "int" here (and at other places):
Is there a special reason for new code to allow num_bits to be negative ?

To my knowledge all the size_t definitions these days are positive,
because a size can not be negative.

As a reader of the code I always wonder if there is a special meaning with
negative values, (as the result of read() to indicate an error) but there isn't.

Should we use
"unsigned" here ?
or "unsigned int" ?
or "size_t" (Which may use 64 bits, which feels like a overkill)
