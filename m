From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 9/9] diff: convert struct combine_diff_path to object_id
Date: Tue, 06 May 2014 17:08:35 +0200
Message-ID: <5368FAF3.6000909@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-10-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 20:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiV6-0008Jm-FM
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbaEFPIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:08:39 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43873 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755260AbaEFPIi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 11:08:38 -0400
X-AuditID: 1207440f-f79326d000003c9f-a0-5368faf5f044
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.E5.15519.5FAF8635; Tue,  6 May 2014 11:08:37 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46F8Zk3030826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 11:08:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-10-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqPv1V0awwa9PWhZdV7qZLNpm/mBy
	YPJYfvMvk8fnTXIBTFHcNkmJJWXBmel5+nYJ3BkdN+ezFvSwV6z89oyxgfExaxcjJ4eEgIlE
	e8s8NghbTOLCvfVANheHkMBlRolZSzYzQzjnmSRuvboN1sEroC1x5n0HE4jNIqAqcf/ZWbBu
	NgFdiUU9zUBxDg5RgSCJP2cVIcoFJU7OfMICYosIeEnMfzSDFaREWMBHYlWfEsT4CYwSXzb+
	BxvDKeAvsXT7AnaQGgkBcYmexiCQMLOAjsS7vgfMELa8xPa3c5gnMArMQrJhFpKyWUjKFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICVP+HYxd62UOMQpwMCrx8D54
	lREsxJpYVlyZe4hRkoNJSZR3wmegEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHehi9AOd6UxMqq
	1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBG/tT6BGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0txKknbe4IDEXKArReopRl+NCw4oWJiGWvPy8
	VClx3qk/gIoEQIoySvPgVsCS0itGcaCPhXkbQEbxABMa3KRXQEuYgJZwGaeDLClJREhJNTBa
	z9Gs8/BRMr/xRsI+hvWeU8/+ynsZ8ss5d8u9y/55bm9FwBzvn/p7H5aeb88/tehXyrrv9uu4
	Ta/e+yGby/rvZv4yvYhEC46lGcWLE+4/XOQdcrdl0bMvTi6zts5g/eC5p6szQanu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248203>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  combine-diff.c | 54 +++++++++++++++++++++++++++---------------------------
>  diff-lib.c     | 10 +++++-----
>  diff.h         |  5 +++--
>  3 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/combine-diff.c b/combine-diff.c
> index 24ca7e2..f97eb3a 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> [...]

This file also has two literal "40" constants in it that are probably
GIT_OID_HEXSZ.

FWIW, I glanced over all of the patches in this series (though without
systematically looking for other literal constants that should be
derived from GIT_OID_RAWSZ and GIT_OID_HEXSZ) and, aside from the
problems that I already noted, they looked OK to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
