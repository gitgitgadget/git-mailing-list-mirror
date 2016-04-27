From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Wed, 27 Apr 2016 08:31:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270830220.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <xmqq7fflleau.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604260851390.2896@virtualbox> <20160426173853.GB7609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:32:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avJ11-00058l-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcD0Gb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:31:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:58956 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbcD0Gb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:31:57 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MS5QA-1b6oWt2pVi-00THBv; Wed, 27 Apr 2016 08:31:49
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160426173853.GB7609@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:sh2gN0kX+vh/eqgzzfkSoXurGi3WcCo6F/zQ0rDUZHqvabe5HjO
 M59MXLmLZuv+XBcAMFbxmCeE6x0DvhVoBIVe1RNusZOLNmQzqfZ214vf+BPQlA7yKlRIzeH
 Lqy/fDPQ/ZvQ96Q7/vjVz4NSo4Zq8mEF8mN3CeT9eVkpoE9WL+MmbAAXJ/sm/QluAtXT+jq
 cF4u9Wy+Q96ASNrJ5Y5Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ItudnpKHrKs=:w4LuelsAvrNN2YSgh8AJdv
 4urvPWbxBcbMpT0bTOagu5UdqzJMb4y8wbEBRwgXpX5r7pAmU2ogI/XU6b9qlXqsfjrfytJAH
 pU0twTpvfX8ptqumlvvAO3y9Yb2Y+7cCrj33kgaQFfimrW/Y4WuygSiKqEAfZV5DEvgBXM+J8
 Ft7W05hd5s3QpIefMSzVxRDh2mKO6xQhe956O5F4+uDPmy/E6bL84JeqmrCxXKgCmTIfmYv0w
 A5bAtd3TsjImk+BtqZdliQ3CrO4RPM4MjwWAV+4u7BKmDgudgMnG+/8AVBoHZ3tvufwwXYoIC
 R9lZdy/Ez7boPvZjuWI9S24H2CWYR6wMM7MmV8r8F5REWkuwoEZuU7/pxcI64AdFfRgO/GO2w
 fvqZsV7EJa3zFsmz4I0TX1GSTWZr5pE83LO+W9PIxr7RMGmjFskPthCWjWWY4s/6DU+d1Gn+8
 M3S8QrOMf7Ho+ToHEuqaghxttJHufDFMNrnHd7LGg3FWXkDc9h2In6QhIbMxw+T4LyP3D+vdb
 g/nArKUhhgbAxi+sAsjUcrlEVKBIbxgfF2p4zHhvwm1wfFqmEKUwgiZqexGfClkq8dI4g26lB
 uKEDHzKsbe01OWlyym4J0O3u+FLKJ6PHlLiIyfz5z32Psk9vnhupnNS1DUcccRGewCCFBa2+9
 Q5HdcuNYind/AZOo9201tIjLht0/rb+Vki6KIy5j9NJQCMpvHAkvdNgdnGh+60YGqTQqWPPQY
 f1aOXUMzWDXVS8LV9D1SJeEg14Qo2SdET57vMBLo5VOkzOIrRZuOcFfY/wdENGUdF6brNvtC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292708>

Hi Peff,

On Tue, 26 Apr 2016, Jeff King wrote:

> On Tue, Apr 26, 2016 at 05:33:33PM +0200, Johannes Schindelin wrote:
> 
> > Testing the headers? I dunno, do we have tests for that already? I thought
> > we did not: it requires an HTTP server (so that the headers are actually
> > sent) that we can force to check the header...
> > 
> > So I see we have some tests that use Apache, and one that uses our own
> > http-backend. But is there already anything that logs HTTP requests? I did
> > not think so, please correct me if I am wrong.
> 
> You can ask apache to check for specific headers. Like this:
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 9317ba0..de5a8fe 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -102,6 +102,12 @@ Alias /auth/dumb/ www/auth/dumb/
>  	SetEnv GIT_HTTP_EXPORT_ALL
>  	Header set Set-Cookie name=value
>  </LocationMatch>
> +<LocationMatch /smart_headers/>
> +	Require expr %{HTTP:x-magic-one} == 'abra'
> +	Require expr %{HTTP:x-magic-two} == 'cadabra'
> +	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> +	SetEnv GIT_HTTP_EXPORT_ALL
> +</LocationMatch>
>  ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
>  ScriptAlias /broken_smart/ broken-smart-http.sh/
>  ScriptAlias /error/ error.sh/
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 58207d8..e44fe72 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -282,5 +282,12 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
>  	test_line_count = 100000 tags
>  '
>  
> +test_expect_success 'custom http headers' '
> +	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> +	git -c http.extraheader="x-magic-one: abra" \
> +	    -c http.extraheader="x-magic-two: cadabra" \
> +	    fetch "$HTTPD_URL/smart_headers/repo.git"
> +'
> +
>  stop_httpd
>  test_done

That's pretty easy.

After sleeping over the issue, I realized, though, that the test can use
the very same method *I* used to verify that the headers are sent: using
GIT_CURL_VERBOSE.

I hope you do not mind that I used this method instead.

Thanks,
Dscho
