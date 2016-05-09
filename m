From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 2/3] t5551: make the test for extra HTTP headers more
 robust
Date: Mon, 9 May 2016 10:13:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605091011420.4092@virtualbox>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de> <20160509080544.GB14383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 10:14:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azgKR-0001Cb-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 10:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbcEIIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 04:14:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:53430 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbcEIIOF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 04:14:05 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MbgWb-1bIaFi2gVh-00J3ED; Mon, 09 May 2016 10:13:47
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160509080544.GB14383@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KQiSIVN8vaFTvWIfUfB/NXrM7tsbq+HDHig/O9Izh8PnOrSUiDE
 fQYYFiSgpyNeMl44kurTd3+Mu3ocUmFjLs4AjVh9Fb+M6v7BkFLegWx35MOg2wRxcyQftwB
 QuGp4Qx+yG30rrHPQG0I5n9QVc5GdQS+LMM2NxM1MMlZvLMYpiDbDETojRWIDjikqZcUPwZ
 EhF9K4bmalqEuxVHU8vVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7AHy1cjUFMY=:qMN6vQqx0sVC/torJr+MOA
 gix5akBk9+HH6hYU6CMqrbER9mnQ5vxvvJcvZvLhQS7DvMRBvHXowVQu1iCpjwLE5RlF9T9HA
 cXUx4WfKoUfKmWvoLHm82CHNt/RGLs9LwWNgE9Kg4/12vnfxWahMTo6e/9m0Sra3p2EfYVzBd
 0lO2/aLg9rC2if039ZyjOhxZdwJO6HwCiEQCLBy5B0iBYriqnNnPBuIuyOLm0mZxDVwt7qa6t
 bdQK8qGPH9FX3GNyxL7Ikp9Y/8k786Vl0+rd6eRo4SyRmNhMbn1cDuCdQ0s28Ee5RPQ3VKx6b
 llXfTQtNlZuJw9K1yoGmKseZn5rITvJPrMwWbSEA0PJ/bT5C2OSDxqZmVYkok9UgTAvD9bcj+
 T2D/ZTbhFTD7AthT59N1ZKCeTMykH6VcbHAv1DC6OM3Nk8ondPRTGD9p4gQ6BTs4yieY1j9ga
 JSrWL0oZ/0++otMMXmtsZg6nre/B7905UFGaECHeyVeQDq0/XaddgVsbsQFnDsJqekdFJEo2d
 UDFxrY/zD8+yk6ZfAJ9lvww2trJe4tRK2mDVcBp8Qlc5B2nkkSl82s94ZjnN5HTMWuIe6TBbJ
 oQLNvwFIGltFa/8EkNFDsbQSBW2dedKAXgWK031PShr5w2wYAp94DOkDjG5D4luy16HaMbYPA
 9oK80iI8wh4LwqdwCbih3ybqciTmvcdMw4BpMPmYUgT+lVGfgzVDjcazZamIiBVLpnu0qqJCp
 xW35wE7bFNsdkLJznm0yUVfwJYujbCRHZFNVmxK7/jm1wEzxNI5ibo8DC80gcKB6qY43CKdc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293992>

Hi Peff,

do you sleep at all?

On Mon, 9 May 2016, Jeff King wrote:

> On Mon, May 09, 2016 at 08:19:00AM +0200, Johannes Schindelin wrote:
> 
> >  test_expect_success 'custom http headers' '
> > -	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> > +	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
> > +		fetch "$HTTPD_URL/smart_headers/repo.git" &&
> >  	git -c http.extraheader="x-magic-one: abra" \
> >  	    -c http.extraheader="x-magic-two: cadabra" \
> >  	    fetch "$HTTPD_URL/smart_headers/repo.git"
> 
> This loses the 0-header check, but I don't think that is particularly
> interesting to us (I had originally wanted to double-check that our
> apache config worked at all in the absence of this feature, but I think
> it is OK for the 1-header case to cover this; if our code is so buggy we
> accidentally send 0 headers in the first command, we'll catch that,
> too).

Yeah, a faulty Apache config will unfortunately *skip* the entire test, as
httpd refuses to start.

And I also considered testing 0-header and 1st header only. But as you
know, Git's test suite takes already 3.5h in a moderately sized Windows
VM, so I am really reluctant to add overly extensive tests.

> So looks good to me.

Thanks,
Dscho
